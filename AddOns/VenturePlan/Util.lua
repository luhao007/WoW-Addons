local U, _, T = {}, ...
local EV = T.Evie
local L = newproxy(true) do
	local LT = T.LT or {}
	getmetatable(L).__call = function(_, k)
		return LT[k] or k
	end
end
T.Util, T.L, T.LT = U, L, nil
local HAVE_CANNED_GROUPS, CANNED_GROUPS = {}

U.FOLLOWER_XP_ITEMS = {
	[188655]=1,
	[188656]=1,
	[188657]=1,
}

local overdesc = {
	[ 25]={L"Inflicts {} damage to all enemies in melee, and increases own damage dealt by 20% for three turns.", "dp"},
	[120]={L"Increases all damage dealt by a random enemy by {}% for two turns.", "dom"},
	[194]={L"Buffs the closest ally, increasing all damage dealt by {1} and reducing all damage taken by {2}% for two turns. Inflicts {3} damage to self.", "dop", "dim", "dp"},
	[242]={L"Heals the closest ally for {1}, and increases all damage taken by the ally by {2}% for two turns.", "hp", "dim"},
	[223]={L"Debuffs all enemies, dealing {1} damage during each of the next {2} turns. Multiple applications of this effect overlap.", "eDamage", "duration1"},
	[300]={L"Debuffs all enemies, dealing {1} damage during each of the next {2} turns. Multiple applications of this effect overlap.", "eDamage", "duration1"},
	[227]={L"Every other turn, a random enemy is attacked for {}% of their maximum health.", "dh"},
	[301]={L"Every other turn, a random enemy is attacked for {}% of their maximum health.", "dh"},
}
local nonPassiveZeroCD = {[303]=1, [313]=1}
local CLOCK_ICON do
	local ai = C_Texture.GetAtlasInfo("auctionhouse-icon-clock")
	CLOCK_ICON = ("|T%s:0:0:0:-0.5:%d:%d:%d:%d:%d:%d:%%d:%%d:%%d|t "):format(ai.file, 2048, 2048, ai.leftTexCoord*2048, ai.rightTexCoord*2048, ai.topTexCoord*2048, ai.bottomTexCoord*2048)
end
local SPC = {} do
	local m = {}
	function m:__index(k)
		if type(VP_SPC) == "table" then
			return VP_SPC[k]
		end
	end
	function m:__newindex(k,v)
		if type(VP_SPC) ~= "table" then
			VP_SPC = {}
		end
		VP_SPC[k] = v
	end
	setmetatable(SPC, m)
end
local function acqTable(t, k, ...)
	if k == nil then
		return t
	elseif type(t[k]) ~= "table" then
		t[k] = {}
	end
	return acqTable(t[k], ...)
end
local MS_TIER = {} do
	for i, x in ("01027a152637482716493817394a2829183a4b4c2a3b19"):gmatch("()(..)") do
		MS_TIER[tonumber(x,16)] = (i+1)/2
	end
end
local torghastCompanions, torghastCompanionIDs = 10, {1213, 1214, 1215, 1216, 1217, 1220, 1221, 1222, 1223, 1257, 1267, 1268, 1269, 1277, 1278, 1279, 1280, 1281, 1282, 1306, 1307, 1308, 1309, 1310, 1311, 1325, 1326, 1327, 1328, 1329, 1330, 1331, 1332, 1333} do
	local r = {}
	for i=1,#torghastCompanionIDs do
		r[torghastCompanionIDs[i]] = 1
	end
	torghastCompanionIDs = r
end

local GetMaskBoard do
	local b, u, om = {}, {curHP=1}
	function GetMaskBoard(bm)
		if om == bm then
			return b
		end
		om = bm
		for i=0,12 do
			b[i] = bm % 2^(i+1) >= 2^i and u or nil
		end
		return b
	end
	U.GetMaskBoard = GetMaskBoard
end
local function GetTargetMask(si, casterBoardIndex, boardMask)
	if not (si and casterBoardIndex) then
		return 0
	end
	local board, tm, isForked = GetMaskBoard(boardMask), 0, false
	for i=si.h and 0 or 1,#si do
		local ei = si[i] or si
		local eit = ei and ei.t
		if eit then
			isForked = isForked or T.VSim.forkTargetMap[eit]
			local ta = T.VSim.GetTargets(casterBoardIndex, T.VSim.forkTargetMap[eit] or eit, board)
			for i=1,ta and #ta or 0 do
				tm = bit.bor(tm, 2^ta[i])
			end
		end
	end
	return tm + (isForked and tm > 0 and 2^18 or 0)
end
local GetBlipWidth do
	local blipMetric = UIParent:CreateFontString(nil, "BACKGROUND", "GameTooltipText")
	blipMetric:SetPoint("TOPLEFT")
	blipMetric:SetText("|TInterface/Minimap/PartyRaidBlipsV2:8:8|t")
	blipMetric:Hide()
	function GetBlipWidth()
		local _, sh = GetPhysicalScreenSize()
		blipMetric:SetText("|TInterface/Minimap/PartyRaidBlipsV2:8:8|t|TInterface/Minimap/PartyRaidBlipsV2:8:8|t")
		local w2 = blipMetric:GetStringWidth()
		blipMetric:SetText("|TInterface/Minimap/PartyRaidBlipsV2:8:8|t")
		local w1 = blipMetric:GetStringWidth()
		return (w2-w1+select(2,blipMetric:GetFont())*(sh*5/9000-0.7))/0.64*UIParent:GetScale()
	end
end
local function FormatSpellPulse(si)
	local t = si.h
	local bm = "|TInterface/Minimap/PartyRaidBlipsV2:8:8:0:0:64:32:0:20:0:20:%s|t"
	local on, off = bm:format("255:120:0"), bm:format("80:80:80")
	if t == "heal" or t == "nuke" or t == "nukem" or (si.d and si.d <= 1 and si.e) then
		if si.e then
			return on .. (off):rep(si.e-1) .. on
		end
	elseif t == "aura" then
		local r, p = si.p and (si.dp1 and bm:format("255:220:0") or off) or on, si.p or 1
		for i=2, si.d do
			r = r .. (i % p == 0 and on or off)
		end
		return r
	end
end
local FormatAbilityDescriptionOverride do
	local overdescUnscaledKeys = {dh=1, dom=1, dim=1}
	local function getSpellData(si, vk)
		local vv = si and si[vk]
		for i=1,si and not vv and #si or 0 do
			vv = vv or si[i][vk]
		end
		return vv
	end
	local function getSpellValue(si, vk, atk, ms)
		if vk == "eDamage" and ms and si.cATKb and si.cATKa and si.dp then
			return math.floor((si.cATKa+si.cATKb*ms)*si.dp/100)
		elseif vk == "duration1" then
			local vv = getSpellData(si, "d")
			return vv and (vv - 1)
		end
		local vv = getSpellData(si, vk)
		if vv then
			return overdescUnscaledKeys[vk] and (vv < 0 and -vv or vv) or atk and math.floor(vv*(atk or -1)/100)
		end
	end
	local repl = {}
	local function getReplacement(k)
		return repl[k ~= "" and (k+0) or 1]
	end
	function FormatAbilityDescriptionOverride(si, od, atk, ms)
		for i=2, #od do
			local rv = getSpellValue(si, od[i], atk, ms) or "??"
			repl[i-1] = rv
		end
		for i=#repl, #od, -1 do
			repl[i] = nil
		end
		return (od[1]:gsub("{(%d*)}", getReplacement))
	end
end

do -- Tentative Groups
	local groups, followerMissionID = {}, {}
	local autoTroops = {["0xFFFFFFFFFFFFFFFF"]=1, ["0xFFFFFFFFFFFFFFFE"]=1}
	local healthyCompanions = {}
	function EV:GARRISON_MISSION_NPC_CLOSED()
		groups, followerMissionID = {}, {}
	end
	function EV:GARRISON_MISSION_STARTED(_, mid)
		local g = groups[mid]
		if g then
			for i=0,4 do
				followerMissionID[g[i] or 0] = nil
			end
			groups[mid], followerMissionID[0] = nil
			EV("I_TENTATIVE_GROUPS_CHANGED")
		end
	end
	local function GetFollowerInfo(fid)
		local fi = C_Garrison.GetFollowerInfo(fid)
		fi.autoCombatSpells = C_Garrison.GetFollowerAutoCombatSpells(fid, fi.level)
		fi.autoCombatantStats = C_Garrison.GetFollowerAutoCombatStats(fid)
		return fi
	end
	local function StopBoardAnimations(board)
		local as, af = board.socketsByBoardIndex, board.framesByBoardIndex
		for i=0, 12 do
			local f, f2 = as[i], af[i]
			f.EnemyTargetingIndicatorFrame:Stop()
			f2.EnemyTargetingIndicatorFrame:Stop()
			if f.FriendlyTargetingIndicatorFrame then
				f.FriendlyTargetingIndicatorFrame:Stop()
			end
			for _, v in pairs(f.AuraContainer) do
				if type(v) == "table" and v.FadeIn then
					v.FadeIn:Stop()
				end
			end
		end
	end
	function U.SetMissionBoard(g)
		local MPB = CovenantMissionFrame.MissionTab.MissionPage.Board
		for i=0,4 do
			if MPB.framesByBoardIndex[i]:GetFollowerGUID() then
				CovenantMissionFrame:RemoveFollowerFromMission(MPB.framesByBoardIndex[i], false)
			end
		end
		for i=0, g and 4 or -1 do
			local fid = type(g[i]) == "table" and g[i].id or g[i]
			if fid then
				CovenantMissionFrame:AssignFollowerToMission(MPB.framesByBoardIndex[i], GetFollowerInfo(fid))
			end
		end
		StopBoardAnimations(MPB)
	end
	function U.ShowMission(mid, listFrame, overGroup)
		local mi, mi2, g = C_Garrison.GetMissionDeploymentInfo(mid), C_Garrison.GetBasicMissionInfo(mid), groups[mid]
		if mi and mi2 then
			for k,v in pairs(mi2) do
				mi[k] = mi[k] or v
			end
			mi.missionID = mid
			mi.encounterIconInfo = C_Garrison.GetMissionEncounterIconInfo(mid)
			PlaySound(SOUNDKIT.UI_GARRISON_COMMAND_TABLE_SELECT_MISSION)
			for i=0, g and 4 or -1 do
				followerMissionID[g[i] or 0] = nil
			end
			groups[mid], followerMissionID[0] = nil
			CovenantMissionFrame.MissionTab.MissionPage:Show()
			CovenantMissionFrame:ShowMission(mi)
			listFrame:Hide()
			U.SetMissionBoard(overGroup or g)
		end
	end
	function U.StoreMissionGroup(mid, gt, disbandGroups)
		if gt and next(gt) ~= nil then
			local gn = {}
			for k, v in pairs(gt) do
				U.ReleaseTentativeFollower(v, disbandGroups, true)
				gn[k] = v
				if not autoTroops[v] then
					followerMissionID[v] = mid
					healthyCompanions[v] = nil
				end
			end
			groups[mid] = gn
			EV("I_TENTATIVE_GROUPS_CHANGED")
		elseif gt == nil and groups[mid] then
			for _, v in pairs(groups[mid]) do
				followerMissionID[v] = nil
			end
			groups[mid] = nil
			EV("I_TENTATIVE_GROUPS_CHANGED")
		end
	end
	function U.ReleaseTentativeFollower(fid, disbandGroup, doNotNotify)
		local mid = followerMissionID[fid]
		local g = groups[mid]
		if not g then
			return
		end
		for k,v in pairs(g) do
			if disbandGroup or v == fid then
				g[k], followerMissionID[v] = nil
			end
		end
		if next(g) == nil then
			groups[mid] = nil
		end
		if g and not doNotNotify then
			EV("I_TENTATIVE_GROUPS_CHANGED")
		end
	end
	function U.ReleaseTentativeFollowerForMission(fid, mid, disbandGroup, doNotNotify)
		local omid = followerMissionID[fid]
		if omid and omid ~= mid then
			U.ReleaseTentativeFollower(fid, disbandGroup, doNotNotify)
		end
	end
	function U.MissionHasTentativeGroup(mid)
		return groups[mid] ~= nil
	end
	function U.GetTentativeMissionTroopCount(mid)
		local g, r = groups[mid], 0
		for i=0, g and 4 or -1 do
			r = r + (autoTroops[g[i]] and 1 or 0)
		end
		return r
	end
	function U.FollowerHasTentativeGroup(fid)
		local mid = followerMissionID[fid]
		return groups[mid] and mid
	end
	function U.DisbandTentativeGroups()
		groups, followerMissionID = {}, {}
		EV("I_TENTATIVE_GROUPS_CHANGED")
	end
	function U.HaveTentativeGroups()
		return next(groups) ~= nil
	end
	function U.SendTentativeGroups()
		for mid, g in pairs(groups) do
			U.SendMissionGroup(mid, g)
		end
	end
	function U.SendTentativeGroup(mid)
		local g = groups[mid]
		if g then
			U.SendMissionGroup(mid, g)
		end
	end
	function U.GetTentativeGroup(mid, into)
		local g = groups[mid]
		if g then
			into = type(into) == "table" and wipe(into) or {}
			for i=0,4 do
				into[i] = g[i]
			end
			return into
		end
	end
	local function nextTent(_, k)
		local mid, g = next(groups, k)
		if mid then
			local nt, zeroHealth = 0, false
			for i=0,4 do
				local fid = g[i]
				if autoTroops[fid] then
					nt = nt + 1
				elseif fid and not zeroHealth then
					if healthyCompanions[fid] or C_Garrison.GetFollowerAutoCombatStats(fid).currentHealth ~= 0 then
						healthyCompanions[fid] = true
					else
						zeroHealth = true
					end
				end
			end
			return mid, nt, zeroHealth
		end
	end
	function U.EnumerateTentativeGroups()
		return nextTent
	end
end
do -- startQueue
	local startQueue, startQueueLength = {}, 0
	function EV:GARRISON_MISSION_STARTED(_, mid)
		if startQueue[mid] then
			startQueueLength, startQueue[mid] = startQueueLength - 1, nil
			EV("I_MISSION_QUEUE_CHANGED")
			PlaySound(44323)
		end
	end
	function EV:GARRISON_MISSION_NPC_CLOSED()
		startQueue, startQueueLength = {}, 0
	end
	local function startMissionGroup(mid, g)
		local mi = C_Garrison.GetBasicMissionInfo(mid)
		for j=1,mi and mi.followers and #mi.followers or 0 do
			for b=0,4 do
				C_Garrison.RemoveFollowerFromMission(mid, mi.followers[j], b)
			end
		end
		local ok = mi and mi.canStart
		for i=0,mi and 4 or -1 do
			ok = ok and (g[i] == nil or C_Garrison.AddFollowerToMission(mid, g[i], i))
		end
		return ok and (C_Garrison.StartMission(mid) or true) or false
	end
	local function queuePing()
		if next(startQueue) then
			C_Timer.After(0.5, queuePing)
		end
		local oc = startQueueLength
		for mid, g in pairs(startQueue) do
			if not startMissionGroup(mid, g) then
				startQueueLength, startQueue[mid] = startQueueLength-1, nil
			end
		end
		if oc ~= startQueueLength then
			EV("I_MISSION_QUEUE_CHANGED")
		end
	end
	function U.IsStartingMissions()
		return startQueueLength > 0 and startQueueLength
	end
	function U.StopStartingMissions()
		startQueue, startQueueLength = {}, 0
	end
	function U.IsMissionInStartQueue(mid)
		return startQueue[mid] ~= nil
	end
	function U.SendMissionGroup(mid, g)
		local ng, oql = {}, startQueueLength
		for i=0,4 do
			ng[i] = g[i]
			local acs = g[i] and C_Garrison.GetFollowerAutoCombatStats(g[i])
			if acs and acs.currentHealth == 0 then
				return
			end
		end
		startQueue[mid], startQueueLength = ng, oql + (startQueue[mid] and 0 or 1)
		if oql == 0 then
			queuePing()
		end
		EV("I_MISSION_QUEUE_CHANGED")
	end
end
do -- delayStart
	local delayedStart, delayTime = {}, nil
	local stickHandle, stickLast, stickNext
	local function checkStart()
		local now = GetTime()
		if delayTime and now >= delayTime then
			delayTime = nil
			for k in pairs(delayedStart) do
				U.SendTentativeGroup(k)
				delayedStart[k] = nil
			end
			EV("I_DELAYED_START_UPDATE")
		elseif delayTime then
			C_Timer.After(math.max(0.005,delayTime-now), checkStart)
		end
	end
	local function tick()
		if not (delayTime and stickNext) then
			return
		end
		local now = GetTime()
		if stickNext > now then
			C_Timer.After(math.max(0.005, stickNext-now), tick)
		else
			stickHandle, stickLast = nil
			local wp, h = PlaySoundFile(1064507)
			if wp then
				stickHandle, stickLast = h, now
			end
			stickNext = nil
		end
	end
	local function cancelTicking()
		if stickHandle and stickLast and GetTime()-stickLast < 1 then
			StopSound(stickHandle)
			stickHandle, stickNext = nil
		end
	end
	local function startTicking(now)
		cancelTicking()
		stickNext = now
		tick()
		stickNext = now+1
		C_Timer.After(1.01, tick)
	end
	function U.HasDelayedStartMissions()
		return not not delayTime
	end
	function U.ClearDelayedStartMissions()
		wipe(delayedStart)
		cancelTicking()
		delayTime = nil
		EV("I_DELAYED_START_UPDATE")
	end
	function U.StartMissionWithDelay(mid, g)
		local mi, now = C_Garrison.GetBasicMissionInfo(mid), GetTime()
		if mi then
			U.StoreMissionGroup(mid, g, true)
			if mi.offerEndTime and (mi.offerEndTime-now) <= 4 then
				U.SendTentativeGroup(mid)
			else
				delayedStart[mid], delayTime = true, now+2
				C_Timer.After(2.01, checkStart)
				startTicking(now)
				EV("I_DELAYED_START_UPDATE")
				return true
			end
		end
	end
	function U.ClearDelayedStartMission(mid)
		delayedStart[mid] = nil
		if next(delayedStart) == nil then
			delayTime = nil
			cancelTicking()
		end
		EV("I_DELAYED_START_UPDATE")
	end
	function U.RushDelayedStartMissions()
		cancelTicking()
		delayTime = GetTime()-1
		return checkStart()
	end
	function U.IsMissionStartingSoon(mid)
		return not not delayedStart[mid]
	end
	function EV:I_TENTATIVE_GROUPS_CHANGED()
		local changed = false
		for k in pairs(delayedStart) do
			if not U.MissionHasTentativeGroup(k) then
				changed, delayedStart[k] = true, nil
			end
		end
		if changed then
			if next(delayedStart) == nil then
				delayTime = nil
			end
			EV("I_DELAYED_START_UPDATE")
		end
	end
	function EV:GARRISON_MISSION_NPC_CLOSED()
		if delayTime then
			delayTime = nil
			for k in pairs(delayedStart) do
				delayedStart[k] = nil
			end
			EV("I_DELAYED_START_UPDATE")
		end
	end
end
do -- completeQueue
	local curStack, curState, curIndex
	local completionStep, lastAction, delayIndex, delayMID
	local xpTable
	local function After(t, f)
		if t == 0 then
			securecall(f)
		else
			C_Timer.After(t, f)
		end
	end
	local delayOpen, delayRoll do
		local function delay(state, f, d)
			local function delay(minDelay)
				if curState == state and curIndex == delayIndex and curStack[delayIndex].missionID == delayMID then
					local time = GetTime()
					if not minDelay and (not lastAction or (time-lastAction >= d)) then
						lastAction = GetTime()
						f(curStack[curIndex].missionID)
						After(d, delay)
					else
						After(math.max(0.1, d + lastAction - time, minDelay or 0), delay)
					end
				end
			end
			return delay
		end
		delayOpen = delay("COMPLETE", C_Garrison.MarkMissionComplete, 0.4)
		delayRoll = delay("BONUS", C_Garrison.MissionBonusRoll, 0.4)
	end
	local function delayStep()
		completionStep("GARRISON_MISSION_NPC_OPENED")
	end
	local function delayDone()
		local os = curState
		if os == "ABORT" or os == "DONE" then
			curState, curStack, curIndex, delayMID, delayIndex, xpTable = nil
			EV("I_COMPLETE_QUEUE_UPDATE", os)
		end
	end

	local function whineAboutUnexpectedState(msg, mid, suf)
		local et = msg .. ": " .. tostring(mid) .. tostring(suf or "") .. " does not fit (" .. curIndex .. ";"
		for i=1,#curStack do
			local e = curStack[i]
			et = et .. " " .. tostring(e and e.missionID or "?") .. (e and e.skipped and "S" or "") .. (e and e.failed and "F" or "")
		end
		return et .. ")"
	end
	local function addFollowerInfo(mi, followers, didWin)
		local xpGain = mi.xp or 0
		local fa = {}
		for i=1, didWin and mi.rewards and #mi.rewards or 0 do
			xpGain = xpGain + (mi.rewards[i].followerXP or 0)
		end
		for i=1,#followers do
			local fi = C_Garrison.GetFollowerMissionCompleteInfo(followers[i].followerID)
			local xp = (fi.currentXP or 0) + xpGain
			if not fi.isTroop and (fi.maxXP or 0) > 0 and xp >= fi.maxXP then
				xpTable = xpTable or C_Garrison.GetFollowerXPTable(123)
				local nl = fi.level
				while (xpTable[nl] or 0) ~= 0 and xp >= xpTable[nl] do
					nl, xp = nl + 1, xp - xpTable[nl]
				end
				fi.newLevel, fi.xpToNextLevel = nl, (xpTable[nl] or 0) ~= 0 and (xpTable[nl]-xp) or nil
			end
			fa[i] = fi
		end
		mi.followerInfo = fa
	end
	function completionStep(ev, ...)
		if not curState then return end
		local mi = curStack[curIndex]
		while mi and (mi.succeeded or mi.failed) do
			mi, curIndex = curStack[curIndex+1], curIndex + 1
		end
		if (ev == "GARRISON_MISSION_NPC_CLOSED" and mi) or not mi then
			curState = mi and "ABORT" or "DONE"
			After(... == "IMMEDIATE" and 0 or 0.1, delayDone)
		elseif curState == "NEXT" and ev == "GARRISON_MISSION_NPC_OPENED" then
			EV("I_COMPLETE_QUEUE_UPDATE", "NEXT")
			if mi.completed then
				curState, delayIndex, delayMID = "BONUS", curIndex, mi.missionID
				C_Garrison.RegenerateCombatLog(delayMID)
				delayRoll(... ~= "IMMEDIATE" and 0.2)
			else
				curState, delayIndex, delayMID = "COMPLETE", curIndex, mi.missionID
				delayOpen(... ~= "IMMEDIATE" and 0.2)
			end
		elseif curState == "COMPLETE" and ev == "GARRISON_MISSION_COMPLETE_RESPONSE" then
			local mid, cc, ok, _brOK, followers, acr = ...
			if mid ~= mi.missionID then return end
			if not (acr and acr.combatLog and #acr.combatLog > 0) then
				C_Garrison.RegenerateCombatLog(mid)
				return
			elseif cc == false and ok == false then
				local bi = C_Garrison.GetBasicMissionInfo(mid)
				if not (bi and bi.completed) then
					return
				end
				cc, ok = true, acr.winner
			end
			addFollowerInfo(mi, followers, acr.winner)
			if ok then
				curState = "BONUS"
			else
				mi.failed, curState, curIndex = cc and true or nil, "NEXT", curIndex + 1
			end
			if ok then
				delayIndex, delayMID = curIndex, mi.missionID
				delayRoll(0.2)
			else
				-- Awkward: need other GMCR handlers to finish before a certain IMCS handler runs
				C_Timer.After(0, function()
					EV("I_MISSION_COMPLETION_STEP", mid, false, mi)
				end)
				After(0.45, delayStep)
			end
		elseif curState == "BONUS" and ev == "GARRISON_MISSION_BONUS_ROLL_COMPLETE" then
			local mid, ok = ...
			if mid ~= mi.missionID then
				securecall(error, whineAboutUnexpectedState("Unexpected bonus roll completion", mid, ok and "K" or "k"), 2)
			elseif ok then
				mi.succeeded, curState, curIndex = true, "NEXT", curIndex + 1
				EV("I_MISSION_COMPLETION_STEP", mid, true, mi)
			end
		end
	end
	EV.GARRISON_MISSION_NPC_OPENED, EV.GARRISON_MISSION_NPC_CLOSED = completionStep, completionStep
	EV.GARRISON_MISSION_BONUS_ROLL_COMPLETE, EV.GARRISON_MISSION_COMPLETE_RESPONSE = completionStep, completionStep

	function U.IsCompletingMissions()
		return curState ~= nil and (#curStack-curIndex+1) or nil
	end
	function U.StartCompletingMissions()
		curStack = C_Garrison.GetCompleteMissions(123)
		curState, curIndex = "NEXT", 1
		completionStep("GARRISON_MISSION_NPC_OPENED", "IMMEDIATE")
	end
	function U.StopCompletingMissions()
		if curState then
			completionStep("GARRISON_MISSION_NPC_CLOSED", "IMMEDIATE")
		end
	end
end
function U.InitiateMissionCompletion(mid)
	local cm = C_Garrison.GetCompleteMissions(123)
	for i=1, cm and #cm or 0 do
		local ci = cm[i]
		if ci.missionID == mid or mid == "first" then
			ci.encounterIconInfo = C_Garrison.GetMissionEncounterIconInfo(ci.missionID)
			return CovenantMissionFrame:InitiateMissionCompletion(ci)
		end
	end
end

function U.GetTimeStringFromSeconds(sec, shorter, roundUp, disallowSeconds)
	local h = roundUp and math.ceil or math.floor
	if sec < 90 and not disallowSeconds then
		return (shorter and COOLDOWN_DURATION_SEC or INT_GENERAL_DURATION_SEC):format(sec < 0 and 0 or h(sec))
	elseif (sec < 3600*(shorter and shorter ~= 2 and 3 or 1.65) and (sec % 3600 >= 1 or sec < 3600)) then
		return (shorter and COOLDOWN_DURATION_MIN or INT_GENERAL_DURATION_MIN):format(h(sec/60))
	elseif sec <= 3600*72 and not shorter then
		sec = h(sec/60)*60
		local m = math.ceil(sec % 3600 / 60)
		return INT_GENERAL_DURATION_HOURS:format(math.floor(sec / 3600)) .. (m > 0 and " " .. INT_GENERAL_DURATION_MIN:format(m) or "")
	elseif sec <= 3600*72 then
		return (shorter and COOLDOWN_DURATION_HOURS or INT_GENERAL_DURATION_HOURS):format(h(sec/3600))
	else
		return (shorter and COOLDOWN_DURATION_DAYS or INT_GENERAL_DURATION_DAYS):format(h(sec/84600))
	end
end
function U.SetFollowerInfo(GameTooltip, info, autoCombatSpells, autoCombatantStats, _mid, boardIndex, boardMask, showHealthFooter, postStatsLine)
	local mhp, hp, atk, level
	autoCombatantStats = autoCombatantStats or info and (info.followerID and C_Garrison.GetFollowerAutoCombatStats(info.followerID) or info.autoCombatantStats)
	local aa = info.auto or info.autoCombatAutoAttack and info.autoCombatAutoAttack.autoCombatSpellID
	if info then
		level = info.level and ("|cffa8a8a8" .. UNIT_LEVEL_TEMPLATE:format(info.level)) or ""
		if info.followerID and aa == nil then
			local _, faa = C_Garrison.GetFollowerAutoCombatSpells(info.followerID, info.level or 1)
			aa = faa and faa.autoCombatSpellID
		end
	end
	if autoCombatantStats then
		mhp, hp, atk = autoCombatantStats.maxHealth, autoCombatantStats.currentHealth, autoCombatantStats.attack
	end
	
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine(info.name, level or "")

	local atype = U.FormatTargetBlips(GetTargetMask(T.KnownSpells[aa], boardIndex, boardMask), boardMask, " ")
	if atype == "" then
		atype = aa == 11 and " " .. L"(melee)" or aa == 15 and " " .. L"(ranged)" or ""
	else
		atype = "  " .. atype
	end
	GameTooltip:AddLine("|A:ui_adv_health:20:20|a" .. (hp and BreakUpLargeNumbers(hp) or "???") .. (mhp and mhp ~= hp and ("|cffa0a0a0/|r" .. BreakUpLargeNumbers(mhp)) or "").. "  |A:ui_adv_atk:20:20|a" .. (atk and BreakUpLargeNumbers(atk) or "???") .. "|cffa8a8a8" .. atype, 1,1,1)
	if postStatsLine then
		GameTooltip:AddLine(postStatsLine)
	end
	if info and info.isMaxLevel == false and info.xp and info.levelXP and info.level and not info.isAutoTroop then
		GameTooltip:AddLine(GARRISON_FOLLOWER_TOOLTIP_XP:gsub("%%[^%%]*d", "%%s"):format(BreakUpLargeNumbers(info.levelXP - info.xp)), 0.7, 0.7, 0.7)
	end

	for i=1, autoCombatSpells and #autoCombatSpells or 0 do
		local s = autoCombatSpells[i]
		GameTooltip:AddLine(" ")
		local si = T.KnownSpells[s.autoCombatSpellID]
		local pfx = si and "" or "|TInterface/EncounterJournal/UI-EJ-WarningTextIcon:0|t "
		local cdt = (s.cooldown ~= 0 or nonPassiveZeroCD[s.autoCombatSpellID]) and (L"[CD: %dT]"):format(s.cooldown) or SPELL_PASSIVE_EFFECT
		GameTooltip:AddDoubleLine(pfx .. "|T" .. s.icon .. ":0:0:0:0:64:64:4:60:4:60|t " .. NORMAL_FONT_COLOR_CODE .. s.name, "|cffa8a8a8" .. cdt .. "|r")
		local dc, guideLine = 0.95, U.GetAbilityGuide(s.autoCombatSpellID, boardIndex, boardMask)
		local od = U.GetAbilityDescriptionOverride(s.autoCombatSpellID, atk)
		if od then
			dc, guideLine = 0.60, od .. (guideLine and "|n" .. guideLine or "")
		end
		GameTooltip:AddLine(s.description, dc, dc, dc, 1)
		if guideLine then
			GameTooltip:AddLine("|cff73ff00" .. guideLine, 0.45, 1, 0, 1)
		end
	end

	if showHealthFooter and info and info.status ~= GARRISON_FOLLOWER_ON_MISSION and autoCombatantStats and autoCombatantStats.currentHealth < autoCombatantStats.maxHealth and autoCombatantStats.minutesHealingRemaining then
		local t = " " .. U.GetTimeStringFromSeconds(autoCombatantStats.minutesHealingRemaining*60, false, true, true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine("|cffffd926" .. CLOCK_ICON:format(255, 0.85*255, 0.15*255) .. ADVENTURES_FOLLOWER_HEAL_TIME:format(t):gsub("  +", " "), 1, 0.85, 0.15, 1)
	end

	GameTooltip:Show()
end
function U.AddCombatantSimInfo(GameTooltip, boardIndex, sim)
	if not (sim and sim.res and sim.res.isFinished) then return end
	if not sim.board[boardIndex] then return end
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine("|TInterface/Icons/INV_Misc_Book_01:0:0:0:0:64:64:4:60:4:60|t " .. ITEM_QUALITY_COLORS[5].hex .. L"Cursed Adventurer's Guide")
	local lo, hi, dlo, dhi = sim.res.min[boardIndex], sim.res.max[boardIndex], sim.res.min[19+boardIndex], sim.res.max[19+boardIndex]
	GameTooltip:AddDoubleLine(RAID_HEALTH_TEXT_HEALTH .. HEADER_COLON, (lo ~= hi and lo .. " - " .. hi or lo) .. " / " .. sim.board[boardIndex].maxHP, 1,1,1, 1,1,1)
	if dlo ~= math.huge then
		local h = (L"Turns survived: %s"):format(""):gsub("%s+$", "")
		local hs = ""
		if hi > 0 then
			hs = " - "
		elseif dhi ~= dlo then
			hs = " - " .. (dhi-1)
		end
		GameTooltip:AddDoubleLine(h, (dlo-1) .. hs, 1,1,1, 1,1,1)
	end
end
function U.FormatTargetBlips(tm, bm, prefix, ac, padHeight)
	local isForked = tm >= 2^18
	tm = tm - (isForked and 2^18 or 0)
	ac = ac and ac .. "|t" or (isForked and "200:50:255|t" or "120:255:0|t")
	local r, xs, bw = "", 0, GetBlipWidth()
	local yd = bw/2
	if tm % 32 > 0 then
		local xo = 0
		for i=2,4 do
			local t, p = tm % 2^(i+1) >= 2^i, bm % 2^(i+1) >= 2^i
			r = r .. "|TInterface/Minimap/PartyRaidBlipsV2:8:8:" .. (xo .. ":" .. yd).. ":64:32:0:20:0:20:" .. (t and ac or p and "160:160:160|t" or "40:40:40|t")
			if i < 4 then
				i, xo = i - 2, xo - bw/2
				t, p = tm % 2^(i+1) >= 2^i, bm % 2^(i+1) >= 2^i
				r = r .. "|TInterface/Minimap/PartyRaidBlipsV2:8:8:" .. (xo .. ":" .. -yd).. ":64:32:0:20:0:20:" .. (t and ac or p and "160:160:160|t" or "40:40:40|t")
				xo = xo - bw/2
			end
		end
		xs = -bw
	end
	if tm >= 32 then
		local xo = xs
		for i=5,8 do
			local t, p = tm % 2^(i+1) >= 2^i, bm % 2^(i+1) >= 2^i
			r = r .. "|TInterface/Minimap/PartyRaidBlipsV2:8:8:" .. xo .. ":" .. -yd .. ":64:32:0:20:0:20:" .. (t and ac or p and "160:160:160|t" or "40:40:40|t")
			i, xo = i + 4, xo - bw
			t, p = tm % 2^(i+1) >= 2^i, bm % 2^(i+1) >= 2^i
			r = r .. "|TInterface/Minimap/PartyRaidBlipsV2:8:8:" .. xo .. ":" .. yd  .. ":64:32:0:20:0:20:" .. (t and ac or p and "160:160:160|t" or "40:40:40|t")
		end
	end
	if prefix and r ~= "" then
		r = prefix .. r
	end
	if r ~= "" and padHeight ~= false then
		r = r .. "|TInterface/Minimap/PartyRaidBlipsV2:19:1:0:0:64:32:62:63:0:2|t"
	end
	return r
end
function U.GetAbilityGuide(spellID, boardIndex, boardMask, padHeight)
	local si, guideLine = T.KnownSpells[spellID]
	if not (si and si.h ~= "nop") then
		return
	end
	if si.firstTurn then
		padHeight = true
	end
	local tm = GetTargetMask(si, boardIndex, boardMask)
	if tm > 0 then
		local b = U.FormatTargetBlips(tm, boardMask, nil, nil, padHeight)
		if b and b ~= "" then
			guideLine = L"Targets:" .. " " .. b
		end
	end
	if si.hp or si.dp or si.healPerc or si.dh then
		local p = FormatSpellPulse(si)
		if p then
			guideLine = L"Ticks:" .. " " .. p .. (guideLine and "    " .. guideLine or "")
		end
	end
	if si.firstTurn then
		guideLine = (L"First cast during turn %d."):format(si.firstTurn) .. (guideLine and "|n" .. guideLine or "")
	end
	return guideLine
end
function U.GetAbilityDescriptionOverride(spellID, atk, ms)
	local si = T.KnownSpells[spellID]
	if si and si.h == "nop" then
		return L"It does nothing."
	end
	local od = overdesc[spellID]
	if type(od) == "table" then
		od = FormatAbilityDescriptionOverride(si, od, atk, ms)
	end
	return od
end

function U.GetInProgressGroup(followers, into)
	into = type(into) == "table" and wipe(into) or {}
	for i=1, #followers do
		local fid = followers[i]
		local ii = C_Garrison.GetFollowerMissionCompleteInfo(fid)
		into[ii and ii.boardIndex or -1] = fid
	end
	into[-1] = nil
	return into
end

function U.GetNumMissingTorghastCompanions(followers)
	local c = 0
	for i=1,#followers do
		local fid = followers[i].garrFollowerID
		if torghastCompanionIDs[fid] then
			c = c + 1
		end
	end
	return torghastCompanions - c
end

function U.FollowerIsFavorite(id)
	local f = SPC.Favorites
	return f and f[id] or false
end
function U.FollowerSetFavorite(id, nv)
	local f = SPC.Favorites or {}
	f[id] = nv or nil
	SPC.Favorites = next(f) ~= nil and f or nil
end

function U.GetMissionEnemies(mid, skipEnv)
	local en = C_Garrison.GetMissionDeploymentInfo(mid).enemies
	for i=1,#en do
		local eni = en[i]
		local a = eni.autoCombatAutoAttack
		eni.auto, eni.autoCombatAutoAttack = a and a.autoCombatSpellID
	end
	local eei = skipEnv ~= true and C_Garrison.GetAutoMissionEnvironmentEffect(mid)
	return en, eei and eei.autoCombatSpellInfo or nil
end

function U.GetPoolTroopBase(idOnly)
	local pool, troops = {}, C_Garrison.GetAutoTroops(123)
	if troops[1].garrFollowerID > troops[2].garrFollowerID then
		troops[1], troops[2] = troops[2], troops[1]
	end
	for i=1,#troops do
		local fi = troops[i]
		if idOnly then
			pool[#pool+1] = fi.followerID
		else
			local spells, auto = C_Garrison.GetFollowerAutoCombatSpells(fi.followerID, fi.level)
			pool[#pool+1] = {
				stats=C_Garrison.GetFollowerAutoCombatStats(fi.followerID),
				spells=spells,
				auto=auto.autoCombatSpellID,
				id=fi.followerID,
				oid=fi.garrFollowerID,
				troop=true,
			}
		end
	end
	return pool
end
function U.GetPoolCompanion(fid, rewardXP, idOnly)
	if idOnly then return fid end
	local ii, willLevel = C_Garrison.GetFollowerInfo(fid or 0), nil
	if not ii then
		return
	elseif rewardXP then
		willLevel = not ii.isMaxLevel and ii.xp and ii.levelXP and (ii.xp + rewardXP) >= ii.levelXP
	end
	local acs = C_Garrison.GetFollowerAutoCombatStats(fid)
	local spells, aa = C_Garrison.GetFollowerAutoCombatSpells(fid, ii.level)
	return {id=ii.followerID, oid=ii.garrFollowerID, stats=acs, auto=aa.autoCombatSpellID, spells=spells, willLevel=willLevel}
end
do -- U.GetShuffleGroup(pool, gid)
	local pt = {}
	function U.GetShuffleGroup(pool, gid, skipMask)
		local g, ntroop, wmask, p, adv = {}, 0, 0
		for i=0,4 do
			pt[i] = i
		end
		for i=0, #pool-3 do
			p, adv = gid % (5-i), pool[3+i]
			p, gid = i+p, (gid - p) / (5-i)
			p, pt[p] = pt[p], pt[i]
			g[p], pt[i], wmask = adv, p, wmask + ((skipMask or adv.willLevel) and 0 or 2^p)
		end
		for i=#pool-2, 4 do
			p = gid % 3
			gid, adv = (gid - p) / 3, pool[p]
			if adv then
				g[pt[i]], ntroop = adv, ntroop + 1
			end
		end
		return g, ntroop, wmask
	end
end
do -- U.GetPartyID(b0, b1, b2, b3, b4)
	local GetTroopMap do
		local cco, tm
		function GetTroopMap()
			local ac = C_Covenants.GetActiveCovenantID()
			if cco ~= ac or tm == nil then
				local t = C_Garrison.GetAutoTroops(123)
				local t1, t2 = t[1].garrFollowerID, t[2].garrFollowerID
				cco, tm = ac, {[t1 < t2 and t1 or t2]=1, [t1 < t2 and t2 or t1]=2, [0]=0}
			end
			return tm, ac-1
		end
	end
	local sc = {}
	function U.GetPartyID(b0, b1, b2, b3, b4)
		local tm, aco = GetTroopMap()
		local ret, rmul, fret, nc, cl = 0, 1, 0, 0, 0
		for i=0,9 do sc[i] = i % 5 end
		for r=0,4 do
			local ch, ci = math.huge
			for i=0, 4 do
				local b = select(1+i, b0, b1, b2, b3, b4)
				if b and tm[b] == nil and b > cl and b < ch then
					ch, ci = b, sc[5+i]
				end
			end
			if ci == nil then break end
			sc[ci], sc[5+sc[r]] = sc[r], ci
			nc, cl, ret, rmul = nc + 1, ch, ret + rmul*(ci-r), rmul * (5-r)
			fret = fret and ch > 1200 and ch < 1456 and (fret*256 + ch-1200)
		end
		for i=nc,4 do
			i = select(1+sc[i], b0, b1, b2, b3, b4)
			ret, rmul = ret + rmul*tm[i or 0], rmul * 3
		end
		return ret, fret and aco >= 0 and aco < 4 and ((fret*1024 + ret)*8+aco*2) or nil
	end
	function U.GetPartyIDC(fgid)
		return (fgid - (fgid % 8192))/8192
	end
	function U.GetPartyIDS(fgid)
		return (fgid % 8192 - fgid % 8)/8
	end
end
do -- Saved Groups
	do
		local gf, co
		function U.GetFollowerIDByID(fid)
			local ac = C_Covenants.GetActiveCovenantID()
			if gf == nil or ac ~= co or gf[fid] == nil then
				gf, co = {}, ac
				for j=1,2 do
					local fa = C_Garrison[j == 1 and "GetFollowers" or "GetAutoTroops"](123)
					for i=1,#fa do
						gf[fa[i].garrFollowerID or 0] = fa[i].followerID
					end
				end
				gf[0] = nil
			end
			return gf[fid]
		end
	end
	function U.SaveMissionGroup(mid, b0, b1, b2, b3, b4)
		local ac = C_Covenants.GetActiveCovenantID()
		if (ac or 0) < 1 or ac > 4 then return end
		local _, fgid = U.GetPartyID(b0, b1, b2, b3, b4)
		if not fgid then return end
		local fr = U.GetPartyIDC(fgid)
		local ug = acqTable(SPC, "UsedGroups", mid*4+ac-1)
		local p, i = fgid, 1 repeat
			ug[i], p, i = p, ug[i], i+1
		until not p or U.GetPartyIDC(p) == fr or i == 10
	end
	function U.GetSavedGroupPool(fgid, rewardXP, idOnly)
		local ac = (C_Covenants.GetActiveCovenantID()-1)*2
		if ac ~= fgid % 8 then return end
		local pool = U.GetPoolTroopBase(idOnly)
		local fg, nc, r = U.GetPartyIDC(fgid), 0
		repeat
			r = fg % 256
			fg, pool[#pool+1], nc = (fg - r)/256, U.GetPoolCompanion(U.GetFollowerIDByID(r + 1200), rewardXP, idOnly), nc + 1
		until fg == 0
		return #pool == nc+2 and pool
	end
	function U.GetSavedGroupCompanions(fgid)
		local fg, r, c1,c2,c3,c4,c5 = U.GetPartyIDC(fgid)
		repeat
			r = fg % 256
			fg, c1,c2,c3,c4,c5 = (fg - r)/256, U.GetFollowerIDByID(r+1200), c1,c2,c3,c4
		until fg == 0
		return c1, c2, c3, c4, c5
	end
	function U.GetSavedGroup(fgid, rewardXP, idOnly)
		local pool = U.GetSavedGroupPool(fgid, rewardXP, idOnly)
		return pool and U.GetShuffleGroup(pool, U.GetPartyIDS(fgid))
	end
	local function HaveAllCompanions(fgid)
		local fg, r = U.GetPartyIDC(fgid)
		repeat
			r = fg % 256
			if not U.GetFollowerIDByID(r+1200) then break end
			fg = (fg - r)/256
		until fg == 0
		return fg == 0
	end
	function U.HaveSuggestedGroups(mid)
		local k = mid*4 + C_Covenants.GetActiveCovenantID() - 1
		if HAVE_CANNED_GROUPS[k] or (type(SPC.UsedGroups) == "table" and type(SPC.UsedGroups[k]) == "table" and #SPC.UsedGroups[k] > 0) then
			return true
		end
		local a = CANNED_GROUPS and CANNED_GROUPS[k]
		for i=1,a and #a or 0 do
			if HaveAllCompanions(a[i]) then
				HAVE_CANNED_GROUPS[k] = true
				return true
			end
		end
	end

	local cmpGroupHint do
		local info, prefSaved
		local function _cmpGroupHint(a,b)
			local ia, ib = info[a], info[b]
			local ac, bc = ia.rank, ib.rank
			if ac and bc then
				return ac < bc
			elseif ac or bc then
				return not bc
			end
			if prefSaved then
				ac, bc = not ia.saved, not ib.saved
				if ac ~= bc then
					return bc
				end
			end
			ac, bc = ia.readyAt, ib.readyAt
			if ac == bc then
			elseif ac and bc then
				return ac < bc
			elseif ac or bc then
				return not ac
			end
			ac, bc = ia.numTent, ib.numTent
			if ac ~= bc then
				return ac < bc
			end
			ac, bc = ia.useScore, ib.useScore
			if ac and bc and ac ~= bc then
				return ac < bc
			end
			ac, bc = ia.numTroop, ib.numTroop
			if ac ~= bc then
				return ac < bc
			end
			ac, bc = ia.numComps, ib.numComps
			if ac ~= bc then
				return ac < bc
			end
			ac, bc = ia.saved, ib.saved
			if ac and bc then
				return ac < bc
			elseif ac or bc then
				return not bc
			end
			return ia.uq < ib.uq
		end
		function cmpGroupHint(it, ps)
			info, prefSaved = it, ps
			return _cmpGroupHint
		end
	end
	local function updateSortProps(uc, i, r)
		local k = r.ord[i]
		r.info[k].rank = i
		for _,v in pairs(r.groups[k]) do
			if not v.troop then
				uc[v.id] = (uc[v.id] or 0) + 1
			end
		end
		for j=i+1, #r.ord do
			local k2, us = r.ord[j], 0
			for _,v in pairs(r.groups[k2]) do
				if not v.troop then
					us = us + (uc[v.id] or 0)^2
				end
			end
			r.info[k2].useScore = us
		end
	end
	local function addGroup(r, uh, fgid, now, saved)
		local fg = U.GetPartyIDC(fgid)
		local g = uh[fg] == nil and U.GetSavedGroup(fgid)
		if g then
			local ntent, ntroop, ncomp, maxMTL = 0, 0, 0, nil
			for _,v in pairs(g) do
				if v.troop then
					ntroop = ntroop + 1
				else
					local mtl = C_Garrison.GetFollowerMissionTimeLeftSeconds(v.id)
					maxMTL = maxMTL and mtl and mtl > maxMTL and mtl or maxMTL or mtl
					ntent, ncomp = ntent + (U.FollowerHasTentativeGroup(v.id) and 1 or 0), ncomp + 1
				end
			end
			uh[fg], r.ord[#r.ord+1], r.groups[fgid] = 1, fgid, g
			r.info[fgid] = {readyAt=maxMTL and maxMTL+now or nil, numTent=ntent, numTroop=ntroop, numComps=ncomp, saved=saved, uq=#r.ord}
		end
	end
	function U.GetSuggestedGroups(mid, limit, ownPrefLimit)
		local r, uh, mk = {ord={}, groups={}, info={}}, {}, mid*4 + C_Covenants.GetActiveCovenantID() - 1
		local now, t = GetTime(), type(SPC.UsedGroups) == "table" and SPC.UsedGroups[mk]
		for k=1,2 do
			for i=1,t and #t or 0 do
				addGroup(r, uh, t[i], now, k == 1 and i or nil)
			end
			t = CANNED_GROUPS and CANNED_GROUPS[mk]
		end
		local uc = {}
		for i=1,math.min(#r.ord, limit or #r.ord) do
			table.sort(r.ord, cmpGroupHint(r.info, ownPrefLimit and ownPrefLimit >= i))
			updateSortProps(uc, i, r)
		end
		cmpGroupHint()

		for i=#r.ord, (limit or #r.ord)+1, -1 do
			local k = r.ord[i]
			r.ord[i], r.groups[k], r.info[k] = nil
		end
		return r
	end
end

do
	local msc, runQueue = {}, {}
	local function getMissionCache(mid)
		local cmi, bmi = msc[mid], C_Garrison.GetBasicMissionInfo(mid)
		if not bmi then
			msc[mid] = nil
			return
		elseif not (cmi and bmi and bmi.missionScalar == cmi.scalar) then
			local en, es = U.GetMissionEnemies(mid)
			cmi = {scalar=bmi.missionScalar, enemies=en, espell=es, h={}}
			msc[mid] = cmi
		end
		return cmi
	end
	local function isDone(res)
		return res.isFinished or (res.hadLosses and res.hadWins)
	end
	local function getPartyHealth(g)
		local h, m = 0, 0
		for i=0,4 do
			local v = g[i]
			if v then
				h, m = h + v.stats.currentHealth, m + v.stats.maxHealth
			end
		end
		return h, m
	end
	function U.GetMissionPrediction(mid, party, fgid)
		local cmi = getMissionCache(mid)
		local cp, oh, ocp = cmi[fgid], cmi.h[fgid]
		if party then
			local ch, mh = getPartyHealth(party)
			if cp then
				if oh.maxHealth ~= mh then
					cp = nil
				elseif oh.curHealth ~= ch then
					cp, ocp = nil, isDone(cp.res) and cp or nil
				end
			end
			if not cp then
				cp = T.VSim:New(party, cmi.enemies, cmi.espell, mid, cmi.scalar)
				cp.dropForks = true
				cmi[fgid], cmi.h[fgid] = cp, {o=ocp, maxHealth=mh, curHealth=ch}
			end
		end
		if cp and not isDone(cp.res) then
			if not runQueue[cp] then
				runQueue[#runQueue+1] = cp
				runQueue[cp] = 1
				EV("I_MPQ_ITEM_ADDED")
			end
			ocp = ocp or cmi.h[fgid].o
		else
			ocp = nil
		end
		if ocp then
			return ocp.res, ocp, false
		end
		return cp.res, cp, true
	end

	local rqdeadline
	local function rqinterrupt(root)
		return debugprofilestop() > rqdeadline or (root.res.hadLosses and root.res.hadWins)
	end
	function U.FlushMissionPredictionQueue()
		if next(runQueue) ~= nil then
			runQueue = {}
		end
	end
	function U.RunMissionPredictionQueue(ms)
		rqdeadline = debugprofilestop() + (ms or 5)
		local s = runQueue[1]
		while s and debugprofilestop() <= rqdeadline do
			s:Run(rqinterrupt)
			if isDone(s.res) then
				s, runQueue[s] = runQueue[2], nil
				for i=1,#runQueue do
					runQueue[i] = runQueue[i+1]
				end
				EV("I_MPQ_ITEM_FINISHED")
			end
		end
		return s == nil
	end
	
	function EV:GARRISON_MISSION_NPC_CLOSED()
		if next(msc) ~= nil then
			msc, runQueue = {}, {}
		end
	end
end

function U.GetShiftedCurrencyValue(id, q)
	if id == 1889 and q and C_Covenants.GetActiveCovenantID() == SPC.ccsCoven then
		local s = SPC.ccsDelta
		q = q - (type(s) == "number" and s <= q and s or 0)
	end
	return q
end
function U.SetCurrencyValueShiftTarget(id, s)
	local c, co = C_CurrencyInfo.GetCurrencyInfo(id), C_Covenants.GetActiveCovenantID()
	if id ~= 1889 or not c then return end
	if SPC.ccsCoven ~= co then
		SPC.ccsLV, SPC.ccsLH = nil, nil
	end
	SPC.ccsCoven, SPC.ccsDelta = co, s and (c.quantity-s) or 0
	EV("I_UPDATE_CURRENCY_SHIFT", id)
end
function U.ObserveMissionShift(t, q)
	local c = C_Covenants.GetActiveCovenantID()
	local b, l, h = math.ceil((t-3)/4), 0, 0
	if b > 0 then
		l, h = (b-1)*4, b*4 - (b == 5 and 0 or 1)
	end
	if (q or h) <= h then return end
	if b == 0 or ((SPC.ccsLV or -5) == (q-1) and (SPC.ccsLH or 10) < l and SPC.ccsCoven == c) then
		SPC.ccsCoven, SPC.ccsDelta = c, q-l
		EV("I_UPDATE_CURRENCY_SHIFT", 1889)
	elseif U.GetShiftedCurrencyValue(1889, q) > h then
		SPC.ccsCoven, SPC.ccsDelta = c, nil
	end
	SPC.ccsLV, SPC.ccsLH = q, h
end
function EV:I_OBSERVE_AVAIL_MISSIONS(ma)
	for i=1,#ma do
		local t = MS_TIER[ma[i].missionID-2173]
		if t then
			local cv = C_CurrencyInfo.GetCurrencyInfo(1889)
			U.ObserveMissionShift(t, cv and cv.quantity)
			break
		end
	end
end

CANNED_GROUPS = {
[8764]={1174664, 269496384, 48712360, 141676608, 126890048, 269601336, 122694144, 126994984, 122800800, 271699448, 1050192, 494680},
[9276]={31437483888, 1174568, 1050568, 1025992, 1059640, 469056, 494752, 486560, 616120, 476888, 1166496, 550584, 584864, 182304, 576672},
[8768]={1173480, 124898048, 68991168368, 32372699296, 39998050432, 12475019240, 11424247936, 12472815744, 32475566056, 30762086560, 40025313320, 30871236584, 31823245440, 12500086912, 37850566816},
[9280]={122807696, 31947091384, 12644904928, 11434848424, 40000155496, 38951579816, 41071800464, 31974354992, 11323699024, 38278394024, 37877837992, 38926413872, 31831748656, 36667781288, 69016350888},
[8772]={122810056, 269611072, 120712800, 263319136, 124907208, 127004256, 298971200, 45215432, 150072952, 296873656, 271707768, 160558712, 12500201456, 37737328568, 11969622000},
[9284]={122808552, 122259712, 69016349136, 31263410632, 30898514384, 31410211272, 41099061712, 3198948591800, 12468726192, 476752, 150071552, 2898837751960, 36126714320, 32483944904, 269609704},
[9288]={122808552, 122259712, 69016349136, 31263410632, 30898514384, 31410211272, 41099061712, 3198948591800, 12468726192, 476752, 150071552, 2898837751960, 36126714320, 32483944904, 269609704},
[8780]={122810432, 470104, 494680, 552024, 584800, 486496, 1051736, 1173144, 609416, 616120, 601176, 568448, 183024, 575520, 1059408},
[9292]={476864, 30898516064, 37877838040, 38414708952, 69553221728, 32509128800, 3200584378672, 160548896, 30871136368, 31835932784, 38815147960, 11434838360, 41065392240, 41071790216, 36665683952},
[8784]={31408124000, 31410221240, 485416, 1157152, 1051384, 1058848, 1173536, 476856, 190096, 608248, 1166272, 174792, 467592, 492168, 557704},
[8788]={122809960, 69553221416, 32511225656, 30871252776, 67378474808, 41073897272, 31974354744, 12644904744, 30728646440, 11545997112, 36269322040, 40534929208, 32475574072, 30864961336, 12080770872},
[8792]={122809120, 160444608, 45214496, 122695264, 296872736, 124906272, 49408680, 152170592, 156364896, 150073440, 143781984, 269611200, 160559136, 271706792, 469072, 493648},
[9312]={476864, 30898516064, 37877838040, 38414708952, 69553221728, 32509128800, 3200584378672, 160548896, 30871136368, 31835932784, 38815147960, 11434838360, 41065392240, 41071790216, 36665683952},
[9320]={122807696, 31947091384, 12644904928, 11434848424, 40000155496, 38951579816, 41071800464, 31974354992, 11323699024, 38278394024, 37877837992, 38926413872, 31831748656, 36667781288, 69016350888},
[8812]={1174624, 609376, 477576, 175200, 183024, 469024, 486128, 493600, 550944, 568408, 575520, 583712, 600816, 625400, 1026080},
[9324]={122807552, 269611072, 30873350328, 32511225656, 40528638168, 3193068186272, 38387445832, 11395002584, 9661800638736, 9248437299688, 32370716856, 38924316744, 30898516152, 67380572344, 8283004988120},
[8816]={122808512, 296872736, 11396985048, 160557856, 31263305912, 269609784, 143782080, 49408704, 156363552, 152170688, 124906272, 45214400, 271705472, 1050728, 1157224},
[9328]={1173544, 477176, 1157160, 269496392, 160549536, 44511296, 48720576, 263203496, 156241992, 48728744, 151620288, 124897952, 45068352, 147861088, 120164416},
[8820]={122807552, 69016350424, 41071800056, 592632, 1166432, 476864, 1157760, 1051384, 1172104, 1059408, 468312, 492168, 550472, 566856, 575048},
[9332]={122808992, 269602880, 263319624, 122695744, 124899392, 120590400, 127003448, 48713800, 124783296, 141683512, 122245184, 269496392, 158460728, 44519496, 296872736},
[8824]={122808512, 1173144, 1049576, 609008, 616120, 492520, 599736, 1157160, 468664, 181944, 550584, 575160, 583352, 1164984, 1058456},
[9336]={122810432, 269611072, 31265402872, 120713280, 40564287896, 67405738168, 41101160664, 39998058232, 32362328248, 30726549688, 37844283608, 69553221328, 11543900376, 12468744408, 32353939440},
[8828]={122810112, 1051376, 1026800, 1166424, 486496, 1158240, 470104, 625760, 1172464, 478336, 609008, 494720, 617240, 183424, 552064},
[9340]={122808552, 122259712, 69016349136, 31263410632, 30898514384, 31410211272, 41099061712, 3198948591800, 12468726192, 476752, 150071552, 2898837751960, 36126714320, 32483944904, 269609704},
[8832]={122810440, 31944994912, 31408009280, 41099063512, 40025321568, 11543900224, 31972257888, 32481865944, 69553221728, 12617642200, 11571163208, 37850575064, 38387445976, 41071800384, 39998058592},
[9344]={476864, 30898516064, 37877838040, 38414708952, 69553221728, 32509128800, 3200584378672, 160548896, 30871136368, 31835932784, 38815147960, 11434838360, 41065392240, 41071790216, 36665683952},
[8836]={122808056, 296874048, 122261568, 269611072, 122220608, 45215808, 122802240, 120713280, 122687552, 127004736, 122794048, 160559168, 120016968, 298970720, 124792904, 147828808},
[9348]={122808552, 122259712, 69016349136, 31263410632, 30898514384, 31410211272, 41099061712, 3198948591800, 12468726192, 476752, 150071552, 2898837751960, 36126714320, 32483944904, 269609704},
[8840]={1173176, 485408, 1058568, 1165904, 191416, 609176, 174672, 557656, 582232, 623920, 1048856, 1156400, 180752, 467472, 475656},
[9352]={476864, 30898516064, 37877838040, 38414708952, 69553221728, 32509128800, 3200584378672, 160548896, 30871136368, 31835932784, 38815147960, 11434838360, 41065392240, 41071790216, 36665683952},
[9356]={122809984, 269609760, 124906176, 127004864, 263319744, 150073536, 298971208, 160559296, 120713312, 296872736, 45214496, 156363456, 145877784, 141683480, 1059960, 486520},
[8848]={122808992, 31972258008, 11396984904, 41071800504, 31408009280, 11399196856, 31410204856, 31835943128, 31298957376, 69016350936, 11571163200, 31263305792, 31944995000, 41099063368, 41073897656},
[9360]={122807072, 296872640, 122694304, 48712360, 160557856, 122243744, 271706816, 44519496, 122261088, 1166024, 484936, 1050176, 1025720, 493240, 591552},
[8852]={1171664, 478336, 607848, 616040, 468704, 1057904, 1156832, 493160, 599656, 575200, 583392, 181864, 550504, 1164904, 485088},
[9364]={1173216, 469784, 494360, 584472, 1050176, 552064, 1166464, 1026840, 576280, 1156832, 485088, 476896, 617200, 181984, 173792, 624352},
[8856]={122807552, 69553220176, 31944995032, 11545997320, 41099063368, 12617642200, 31802388696, 69555319000, 39998058712, 12644905176, 30873350328, 36776833240, 67380572344, 41071800536, 38926413496},
[9368]={122808840, 124783272, 127004736, 122695744, 120713288, 122802240, 269609632, 122122312, 120016960, 124906272, 122687560, 624720, 1027208, 1157200, 583760},
[8860]={122810440, 10240037874464, 12470841088, 2926245439568, 31408124016, 31435386976, 31299072216, 31265517360, 31401832640, 31263420632, 31286489280, 31288586432, 31284392128, 30724452448, 31292780336},
[9372]={31435386464, 12470839960, 31263418960, 31410219160, 31299071704, 31437482616, 30724452424, 31408123968, 11397099256, 31288586304, 31401832512, 31290683576, 31294877880, 31284391600, 31282294968},
[9376]={122809112, 31435387064, 11397099736, 31410221080, 31263420600, 31286489152, 12470840120, 31437484216, 31299072184, 31282294968, 31408124088, 31288586424, 31294877880, 32370716456, 8003290933840},
[9380]={1173080, 122693920, 48712256, 122802176, 158339248, 120033488, 47310144, 124899536, 271691952, 126455984, 149950624, 141681984, 156356816, 44536016, 147853472},
[8872]={122807560, 271705376, 45214376, 49408672, 124906152, 160557736, 269611072, 296872616, 298971208, 263319616, 120713288, 156364864, 127004744, 152169240, 143780544},
[9384]={31410221240, 31408123968, 31263420600, 31435386944, 31299072064, 11397099592, 8008238229696, 8010385713344, 3192506149064, 8011459455168, 8009848842512, 8009311971600, 8011996326160, 8008775101160, 2917628242120},
[8876]={1173176, 1059968, 470144, 476736, 494720, 1027200, 1050696, 609408, 173072, 181104, 188936, 484328, 549544, 574320, 582512},
[8880]={477216, 263318176, 269496384, 124899392, 120711360, 160436296, 127002816, 269594688, 47311520, 49287240, 141682880, 45092936, 150073416, 124784712, 147974816},
[8884]={1173224, 122694448, 1157184, 624704, 485440, 175224, 1058520, 608080, 189088, 616032, 558688, 575072, 583264, 591456, 493152},
[8888]={122807552, 269611072, 271708232, 296874056, 124898912, 120033352, 478344, 1051744, 160444480, 48721992, 263303232, 156356672, 126414920, 120123464, 45101120},
[8892]={1174264, 1050304, 493248, 583360, 485056, 609008, 469744, 1157880, 617200, 551664, 576240, 1166072, 174120, 559144, 624680},
[8896]={1174664, 1050296, 494680, 486496, 469024, 1156800, 624680, 1058848},
[8900]={122808512, 69553221848, 8149972150568, 9690279963280, 8315890428560, 10514913683776, 31263305912, 45215336, 269611072, 49410120, 263319616, 143781952, 120713280, 298971200, 156364864},
[8904]={31410219648, 31944995032, 31437484096, 31265517640, 12470841416, 30724452416, 31408123976, 40537017648, 31802378832, 11543785688, 41071685848, 32481857520, 68991168576, 156363456, 31263411896},
[8908]={122809000, 269611080, 30728646848, 32475574368, 30726549720, 32372814040, 149957288, 296864416, 1051784, 48713800, 44624544, 124897952, 160444480, 122245184, 150055592},
[8916]={1172128, 477288, 607160, 615112, 467656, 492232, 598728, 180936, 549576, 574152, 582344, 1163856, 565960, 484280, 1049168},
[8920]={122809472, 120713280, 127004736, 263319616, 269611072, 145878728, 124907584, 271708224, 141684808, 158461640, 150073416, 298971208, 147976264, 154267720, 47312968},
[8924]={1172464, 477096, 1158240, 609216, 1166264, 173000, 189024, 467904, 623560, 1024960, 1049536, 1057048, 180864, 483968, 492160},
[8928]={122807672, 31944986808, 271706904, 31264952504, 12506369840, 31833837360, 296874056, 31298956976, 11399073984, 120711960, 30723772488, 40537018128, 38918024808, 38276173616, 30724436160},
[8944]={1172032, 1060000, 609160, 616032, 468576, 493152, 599648, 181856, 550496, 575072, 583264, 1164896, 1049168, 566880, 484960},
[8948]={122808992, 296874056, 31294763072, 160559176, 31263305792, 45215816, 31282178720, 12617642176, 31290568768, 124907584, 75997769792, 11396983464, 38278393952, 31408007840, 40027418688},
[8952]={1174664, 583400, 616488, 575208, 493648, 468712, 1164872, 599736, 182312, 551672, 1050704, 608288, 486488, 1059928, 1158232},
[8956]={122810432, 31802378832, 68991168608, 11952721624, 41065508448, 31802241008, 31294877880, 12617625792, 31938695352, 41071685816, 11397099736, 38414708928, 32366399496, 39998050008, 31282294968},
[8960]={122809120, 271706816, 67407835200, 69016350784, 32372814008, 12468744408, 37315801296, 11543900376, 37877837552, 32511225920, 41065509080, 11395002584, 38389543096, 38924316744, 12647002328},
[8964]={122807216, 160559200, 31408009368, 296874080, 31410212960, 12472938688, 31410204880, 11401293896, 12611350600, 37204652216, 30726549688, 11424362648, 36267225272, 12468744264, 32372814008},
[8968]={31408123928, 31437484080, 1173216, 494360, 468704, 1025760, 617136, 584472, 183424, 552064, 484960, 1051296, 1166104, 476896},
[8972]={122809024, 3192506140872, 269611080, 31944986808, 41099063488, 31294763192, 32362328128, 31944880312, 12470276168, 11537608920, 122802240, 36267225272, 12470153288, 36667781184, 31290568888},
[8976]={31284391720, 31280197416, 31437482880, 11933970232, 31294877440, 31292780328, 31296974632, 31265517352, 31286488872, 31288586024, 31410220856, 12470839648, 31435386952, 31299072072, 31408123896},
[8984]={1173184, 476864, 124899392, 269602888, 191176, 608968, 1058328, 173032, 181224, 467584, 492160, 549504, 558056, 567696, 573968},
[8988]={1174264, 608928, 191416, 493120, 550464, 1050296, 468904, 1058336, 484928, 584672, 617480, 1025960, 601216, 182192, 575400},
[8992]={122806704, 263319616, 122122304, 269611072, 122794048, 271706784, 122245184, 298971200, 48713800, 120712800, 44519496, 127003296, 122261568, 141682880, 122212416},
[8996]={122810112, 269611088, 32511225640, 67407834920, 30900612904, 36269322024, 269496224, 120598592, 49287080, 271699880, 269602760, 1174384, 158445648, 147427408, 477232},
[9000]={122809000, 269495072, 31833837552, 269593376, 11434848448, 31262740576, 12611227864, 36667781304, 31435378872, 30757884088, 32364425400, 31263305944, 38276295256, 11422142560, 31265509592},
[9004]={122810432, 269611072, 41099063512, 11399196864, 69553221848, 39998058592, 31974355008, 11434848472, 32481865944, 31947092064, 40025321568, 12617642080, 31835943008, 11571163352, 38387445976},
[9008]={31944994912, 31299072184, 2924632730200, 31410221240, 36776833240, 8148925671640, 9799264758376, 12470841560, 2120998464905360, 11399196768, 2621449157337328, 3192380320408, 2924496415320, 2084163103613808, 68991185080},
[9012]={122810440, 124906144, 269609632, 296872576, 160557728, 45214376, 156363456, 37844283608, 30900613184, 32362328256, 12074479832, 36118327360, 40564289336, 37194164912, 30728646752},
[9016]={11543900272, 8178451466032, 37741521184, 32481848016, 8148898399504, 7865422177952, 41071790824, 9384125130352, 2898835548864, 8282459727288, 8148923565808, 8010272466552, 2924068480848, 7872401499632, 8003943254840},
[9020]={8177916700360, 45213920, 124357312, 269592640, 143780160, 124316352, 269494608, 147974464, 124899392, 45091016, 263317824, 124889792, 127002944, 44526368, 158460240},
[9024]={122807552, 269609752, 296874176, 12508588656, 11399196744, 40027418216, 31827553888, 12498104336, 36667781208, 32511225920, 11422265496, 38274199760, 31833845496, 40425877688, 11401293560},
[9028]={1173584, 1058984, 190632, 1165480, 468944, 616040, 607848, 1156832, 493160, 599656, 575200, 583632, 181864, 550504, 485328},
[9032]={122809056, 68991184744, 31408009160, 11573260128, 12647001456, 30873349992, 41071800232, 32483962728, 31944994808, 38389542760, 11543900168, 67380572008, 32481865640, 37852671848, 30871252976},
[9036]={122810432, 1174256, 477936, 122801840, 122695848, 122130576, 122687632, 48713896, 122212016, 120016584, 122662576, 122245264, 122220208, 122122384, 122187440},
[9040]={31408123688, 8184896022744, 2402336004760112, 11543900376, 8009200822904, 2918192376088, 10514913684088, 3192390806168, 8284724652688, 8145704446248, 31296974632, 17248885532952, 2120446563705528, 2050215680008552, 2924068596016},
[9056]={122807552, 271708224, 296872608, 160558712, 269611072, 486136, 609016, 174840, 191224, 470104, 592632, 494328, 1051416, 1059576, 625400},
[9060]={31435386864, 124792904, 1174264, 160444000, 271691848, 494680, 576608, 584800, 1166424, 183024, 551664, 1051776, 469784, 175200, 191584},
[9064]={31437484096, 31410221120, 12470841416, 2898688862840, 8008802363984, 3192533412040, 32481865800, 8148923574792, 9799239592584, 7874555275664, 2918037187096, 8286763084488, 69553220208, 9798163753576, 8147849833064},
[9068]={1172464, 477976, 149958800, 269496488, 271691920, 120598672, 608328, 1025600, 568448, 494720, 601216, 617240, 183424, 552064, 576640},
[9072]={1173064, 475784, 1156672, 1059704, 190312, 606736, 1165160, 172680, 467472, 483856, 492048, 549392, 557584, 573968, 582160},
[9076]={12470840120, 31294877760, 31410219624, 31435386584, 11397099736, 31408124120, 31437484216, 31299072184, 31263420600, 31265517664, 31401832544, 30724452424, 31290683576, 31282294848, 31288586424},
[9080]={122807552, 45215808, 122687552, 49409640, 122802240, 124907104, 156364408, 160558688, 271707744, 296873568, 143781952, 152170104, 120713280, 147976256, 150073408},
[9088]={1173600, 493256, 1049112, 1025616, 550480, 615704, 599632, 573976, 582168, 181840, 1164880, 607880, 467840, 484952, 566864},
[9092]={1174616, 120016968, 271707904, 122662976, 150073416, 122687552, 160559168, 296873888, 45215808, 147976264, 49410112, 143781960, 298971208, 145877816, 127003448},
[9096]={122809960, 11545997064, 12644905152, 31974355008, 41073897224, 75997769792, 12472938688, 40000155448, 41101160512, 11323699264, 31972257864, 11571163208, 31947091720, 12619738848, 69553221376},
[9100]={1172096, 477576, 470112, 1027168, 1051384, 1059928, 1166432, 608696, 172552, 180864, 188936, 483848, 492160, 549504, 557696},
[9104]={1173424, 608336, 477616, 493648, 470152, 182312, 583720, 485456, 617568, 576648, 601184, 1051016, 550992, 1166432, 1026440},
[9108]={122809472, 124783272, 160559176, 44519496, 271708224, 296873576, 298969760, 49410112, 152170568, 263318176, 141683360, 127003296, 120711840, 147974936, 143780632},
[9112]={122807552, 31947092040, 3237093697808, 11545997528, 31944994880, 2898726611576, 69553221816, 8147851929896, 3197900024472, 68991183504, 8149999413464, 3201121249584, 41073897688, 8145704446248, 2898862926456},
[9116]={122807552, 269610592, 122794048, 122261568, 122802240, 609376, 175200, 183032, 191216, 468664, 485416, 493608, 552032, 560224, 568416},
[9124]={1174256, 190120, 476520, 1058152, 173776, 468688, 485072, 493264, 550608, 558800, 575184, 583376, 591568, 624336, 1025744},
[9128]={122807696, 269609776, 11545997328, 12508590168, 67407835288, 40025321624, 30751715416, 36778930328, 30749618328, 12644905048, 11434848408, 38926413976, 12611350736, 11571163288, 41065509072},
[9132]={122807552, 269609632, 12619739320, 31972257864, 11434848440, 38387445976, 31827554496, 30898516032, 40000155864, 39889006808, 36239962328, 31819165768, 11545997496, 12644905056, 38924316888},
[9136]={122807496, 296873576, 269611072, 191464, 609016, 173752, 183392, 468664, 485048, 493600, 550944, 559864, 568416, 575520, 583712},
[9140]={1173120, 478320, 607632, 172960, 189344, 468888, 484616, 494024, 558480, 574864, 583056, 591248, 623520, 1025304, 1049880},
[9144]={1173544, 269494944, 124897952, 156250176, 49285800, 296864416, 124357288, 122694304, 160549536, 269593256, 45101120, 156240552, 143667264, 152055872, 269602880},
[9148]={11397099592, 11933970024, 12470839960, 31263420480, 31282294848, 31284391632, 31286489152, 31288586304, 31290683576, 31292780608, 31294877760, 31296974912, 31299072064, 31401832032, 31410219640},
[9152]={122809112, 31410221240, 31265517632, 31408123968, 30724452424, 31401832512, 31299072184, 31435387064, 31286489152, 31288586304, 12470841560, 31280197696, 31437484096, 31263420608, 31284391600},
[9164]={11397099704, 31944995000, 31299072096, 68991185112, 31435386976, 69016350936, 31288586432, 41071800512, 31265517760, 11543900352, 30724452448, 31410221272, 31263420512, 31408124120, 124897952, 271691848},
[9168]={122807200, 269496384, 296874048, 122120984, 160559168, 48712504, 269611072, 122694424, 124907584, 122686232, 175200, 1158240, 625760, 485456, 1050304},
[9172]={122807672, 122694456, 31972257976, 41071800536, 31401824352, 11401293896, 31294861376, 12470292696, 30871253088, 11399196888, 12470825176, 31802388696, 31294329016, 38414708920, 11397083352},
[9176]={1173544, 476856, 470104, 1165904, 608256, 191176, 172920, 180864, 483968, 492160, 549504, 558056, 566248, 574080, 582272},
[9184]={31435387096, 31408124088, 31263420600, 608296, 493608, 583720, 1164992, 1058856, 600104, 576608, 550952, 182312, 175200, 624720, 190504},
[9188]={31263420600, 31408123968, 31294877880, 1050664, 1173544, 493512, 550856, 575432, 583624, 624584, 1165256, 174024, 1157064, 1058760, 559048},
[9192]={122808512, 31947075776, 160557848, 12470276312, 11543900344, 31294763104, 36659392584, 31263404128, 38278393928, 12470726848, 37850574912, 31262855352, 11418071104, 12470825176, 67378475072},
[9196]={122808992, 296872608, 269611072, 160557728, 124906176, 271706816, 45214488, 156363456, 1173544, 493608, 1026088, 591912, 1165352, 190504, 559144},
[8688]={1173184, 476864, 583360, 624680, 1025720, 1050296, 1157160, 493240, 470104, 1058848, 173760, 607968, 485016, 181944, 190016},
[9200]={122807072, 122687552, 69553221696, 31835943008, 12470276312, 31401824352, 11571163232, 122694424, 30871253056, 12470243544, 36667781184, 11399196744, 31294869568, 32481865824, 12470251736},
[9204]={122807672, 31944995032, 11571163232, 41071800536, 31974355008, 68991185080, 31802388696, 39998058712, 31972257888, 38924316888, 12617642200, 36776833240, 30871253184, 67378475104, 11543900376},
[9208]={1172464, 122694448, 48712504, 30873342144, 31294861496, 41073889472, 11323003072, 67380564160, 11859873984, 68991176896, 12470153432, 69553213536, 12470161624, 122800920, 12470218968},
[9212]={122807192, 271706784, 269611072, 127003304, 296872728, 156363576, 143780664, 49408792, 124906296, 160557848, 45214488, 152169240, 124897952, 120016968, 269594208},
[9216]={1173536, 48713800, 269496384, 122802240, 122244704, 122121824, 44519496, 120016968, 122130496, 122261088, 122662976, 122212416, 122220608, 122793568, 122695744},
[9220]={12470841560, 30724452424, 31265517632, 31284390480, 31286489152, 31288586304, 31299072184, 31401832512, 31408123968, 31410221240, 31437484216, 31435387064, 11933970616, 31263420600, 31294877880},
[9224]={122807248, 269610912, 122694304, 120713280, 122219168, 263319616, 122792608, 127003448, 122800800, 160559176, 48712360, 44518056, 271708104, 122122304, 296873896},
[9228]={31299072072, 31974355008, 69016350792, 11543898784, 31435387096, 31835941688, 31972258008, 41071800384, 31944995000, 49295264, 156248400, 44649240, 49400320, 149956696, 156354752},
[9232]={122807704, 30873350216, 41071800536, 31972258008, 12619739352, 11543900376, 31835943128, 67380572232, 12617642200, 12472938680, 38389542984, 69016350784, 32483961488, 31944995032, 11545997528},
[9236]={122807664, 271708224, 127003296, 269611080, 31972258008, 39889006688, 12647000696, 30751715512, 11399196856, 37879935192, 67378475192, 36804096096, 12504395960, 11434848352, 38381154520},
[9240]={122806704, 271708064, 298971200, 160559168, 296874048, 120713280, 269611072, 263319616, 127004736, 141684800, 47312960, 158462016, 150073408, 147976256, 145879104},
[9244]={122807072, 296872736, 271706904, 41101160520, 12468744256, 38387445832, 11401293896, 67407835208, 30726549720, 37850575064, 40425877568, 12498104384, 36806193224, 32481865792, 30749618392},
[8736]={1173176, 477976, 1059048, 1049816, 607768, 470144, 494720, 617240, 552064, 1166464, 183064, 576280, 584472, 600736, 567968},
[9248]={31290683456, 31408124120, 31437484216, 31263420600, 31410221120, 12470841416, 31284391920, 31401832432, 31288586224, 31265517552, 31286489072, 31296974832, 31280197616, 625400, 1059816},
[8740]={122810432, 269611072, 1027208, 470152, 478104, 1050664, 1173544, 608656, 172920, 182112, 189304, 484216, 492408, 549872, 557944},
[9252]={31284388840, 11397099704, 12470841528, 30724452448, 31265515912, 31286488872, 31288586336, 31292780328, 31401832544, 31408122248, 31410220856, 31435385184, 31437483816, 31296974632, 11933970232},
[8744]={1173120, 478200, 1059152, 609392, 625736, 1050960, 173656, 181848, 190040, 468568, 484952, 493144, 550488, 558680, 567992},
[8752]={122810432, 1172456, 478336, 607928, 493120, 1050176, 616120, 575040, 583232, 599656, 484968, 1058488, 1025600, 181864, 550584},
[8756]={1172464, 609016, 470152, 494360, 617200, 1051776, 600096, 183064, 551704, 576288, 584480, 1166104, 568408, 486032, 1157736},
[8760]={31435386864, 31437484016, 12470841352, 31410221040, 31284391920, 31408123888, 31265517352, 31296974632, 31401832432, 31299071984, 31263420400, 30724452360, 1174384, 551664, 576240},
[9272]={122807552, 269609752, 31294763072, 32511225656, 31288471616, 31972258008, 31298957376, 30864961728, 11323699384, 31410204856, 30760104128, 31401717824, 31827554400, 12110129880, 32360231096},
[8765]={36745338, 16944794, 36737226, 17967354, 16918578, 1199258, 1189506, 165482, 141250},
[9277]={1198066, 165514, 83674, 132826, 1091530, 469658, 142314, 68290, 412354, 76410, 117370, 1190594, 125634, 445090, 1084042},
[8769]={4868688514, 280119602, 36743754, 43142690, 120737314, 30558514, 114445858, 263343650, 32655666, 278022450, 106055986, 17975602, 108153138, 307390802, 110250290},
[9281]={5403463258, 1246357513482, 1952342754618, 1108138403130, 1381646878746, 1245576619274, 1242599417098, 2363416003642, 1385432237434, 1932772123914, 1242435724874, 1857853474090, 1932771362106, 1244237292730, 5403355434},
[8773]={1108918551842, 1247993284314, 1244581217354, 2132756546938, 1108681573666, 1245109699578, 1108406846418, 1244730115146, 2819951314298, 1107842713850, 1245820634402, 1242356139378, 1935188051354, 1110527068410, 1932503696794},
[9285]={22163602, 9232861290, 4874979978, 5648829050, 8626784890, 5137124874, 4331818506, 4866591370, 9432092034, 5405558858, 21442626, 19286058, 43134642, 22057026, 19343402},
[9289]={22163602, 9232861290, 4874979978, 5648829050, 8626784890, 5137124874, 4331818506, 4866591370, 9432092034, 5405558858, 21442626, 19286058, 43134642, 22057026, 19343402},
[8781]={67178, 115250, 1081906, 140794, 75730, 419434, 1092538, 1197682, 468586, 1191042, 410162, 435818, 1204786, 84970, 134122},
[9293]={85010, 43134882, 105328554, 34746274, 17969058, 32649210, 110243834, 263335930, 120729594, 20080698, 21417890, 43143162, 105943034, 27398050, 19016218},
[8785]={165450, 1190570, 1091098, 116298, 140826, 1083314, 1198674, 67106, 82850, 108026, 123442, 132002, 410530, 427274, 442930},
[8789]={116330, 1082986, 140906, 68218, 411722, 444490, 75370, 1189842, 124882, 165490, 83522, 132714, 419434, 1026122, 1197634},
[8793]={1092626, 68618, 132322, 85090, 141954, 76418, 117410, 1206914, 1190530, 1198722, 109186, 427954, 453250, 166530, 412650},
[9313]={85010, 43134882, 105328554, 34746274, 17969058, 32649210, 110243834, 263335930, 120729594, 20080698, 21417890, 43143162, 105943034, 27398050, 19016218},
[8809]={1091186, 84650, 1197682, 142354, 116298, 1082954, 66058, 74298, 131602, 410130, 418362, 434746, 451090, 467474, 1024530},
[9321]={5403463258, 1246357513482, 1952342754618, 1108138403130, 1381646878746, 1245576619274, 1242599417098, 2363416003642, 1385432237434, 1932772123914, 1242435724874, 1857853474090, 1932771362106, 1244237292730, 5403355434},
[8813]={140874, 67138, 83490, 132642, 75378, 411210, 468546, 1025602, 1091178, 1189442, 1205834, 1197642, 124482, 165442, 427634},
[9325]={1246120519378, 354069867807202, 282719557927298, 283410137497738, 318867778970258, 494653836247434, 282722785337442, 318042975388282, 282720088506506, 319006662861106, 600954276823674, 282722770657378, 318061935739378, 282739428442258, 283410164760802},
[8817]={36743330, 21106242, 110243754, 16853154, 22179298, 34008546, 35819098, 114337946, 27692514, 105949346, 31600186, 34744842, 21081570, 110260258, 36679114},
[9329]={83570, 33697250, 43141154, 110259682, 34744354, 36859362, 33998890, 43150786, 36851170, 31590434, 305294914, 35817506, 16910370, 307392066, 34580522},
[8821]={140914, 1189850, 165450, 134162, 1198762, 83930, 1083354, 116458, 1091586, 66466, 123810, 411210, 420882, 436146, 468594},
[9333]={8633067866, 5111959394, 5411842394, 4338108762, 9169938778, 4874971362, 11017529658, 22056594, 19001274, 19009138, 16854666, 108144850, 20074138, 32647234, 42364562},
[8825]={116330, 140874, 67138, 1084066, 125962, 166562, 445450, 1190922, 75338, 419442, 1197642, 468554, 411202, 436898, 1205874},
[9337]={1247993283578, 283545967936026, 282719479300874, 323598710620778, 710905439600762, 282720016474850, 283745709081394, 319024922772394, 460216788467866, 282721097122730, 288418633499442, 282721096507810, 711180317508074, 319022917895082, 283608270127482},
[8829]={1189842, 165482, 67178, 468586, 83570, 132722, 124522, 411242, 444010, 116290, 1082946, 140874, 1090458, 75330, 419394},
[9341]={22163602, 9232861290, 4874979978, 5648829050, 8626784890, 5137124874, 4331818506, 4866591370, 9432092034, 5405558858, 21442626, 19286058, 43134642, 22057026, 19343402},
[8833]={33720354, 22171106, 8316398394, 4331063186, 4862291626, 33966122, 28224678114, 5646625530, 9169217882, 4327615834, 7630637402, 4941983146, 8695998666, 11000753682, 5404788938},
[9345]={85010, 43134882, 105328554, 34746274, 17969058, 32649210, 110243834, 263335930, 120729594, 20080698, 21417890, 43143162, 105943034, 27398050, 19016218},
[8837]={165482, 32647202, 17975546, 36122202, 42387490, 106057714, 263335842, 17207322, 29485786, 36679258, 280119890, 33720362, 278014682, 17221882, 36064858},
[9349]={22163602, 9232861290, 4874979978, 5648829050, 8626784890, 5137124874, 4331818506, 4866591370, 9432092034, 5405558858, 21442626, 19286058, 43134642, 22057026, 19343402},
[8841]={21097930, 42354730, 32648642, 22171074, 22064578, 32665026, 22163482, 115978, 141114, 1083074, 66218, 131554, 74978, 419042, 435466},
[9353]={85010, 43134882, 105328554, 34746274, 17969058, 32649210, 110243834, 263335930, 120729594, 20080698, 21417890, 43143162, 105943034, 27398050, 19016218},
[9357]={165514, 84674, 132746, 124514, 1189474, 1198722, 68250, 76418, 412346},
[8849]={84610, 132682, 140514, 116298, 1090186, 1083074, 1198074, 66066, 76730, 123442, 164402, 410162, 426546, 442930, 453202},
[9361]={117418, 141354, 1084074, 67138, 1092178, 75730, 1188770, 1205154, 107426, 426874, 125962, 166922, 82490, 131642, 420522},
[8853]={116298, 68618, 1082954, 412682, 75370, 140194, 1189842, 166922, 1198346, 1091794, 419794, 467866, 435818, 1205146, 443290},
[9365]={116650, 67138, 141226, 75330, 1084026, 419754, 1197994, 468546, 411202, 436138, 443970, 1189442, 1207266, 109538, 124482},
[8857]={120737218, 19017274, 280121330, 36843098, 32657394, 35819098, 17976986, 36064858, 43143154, 36744794, 16920122, 36851170, 29804794, 21106146, 263227466},
[9369]={68226, 132722, 165450, 411210, 445058, 1189490, 124650, 1206954, 1026690, 83570, 420546, 76482, 1083018},
[8861]={17976794, 43134970, 20074426, 280128114, 21384930, 29494754, 36735602, 32649370, 17246474, 114339410, 19007738, 21089858, 36859466, 105943058, 17206794},
[9373]={1246357505938, 353916320621474, 318610458321130, 282857999311786, 605035542233922, 282720087753658, 494945868858282, 565766119367610, 323837081313298, 284250707370178, 354073623806786, 318454371599274, 353914003268538, 710725940061026, 282719479546002},
[9377]={1246357505386, 1383259587946, 318867609100786, 370057373966698, 318041288220778, 319479836984154, 283882585997794, 318886596731258, 318042365002474, 282921077465466, 318888205238890, 319006853709962, 283745711186298, 318061960905562, 318867778969778},
[8869]={83570, 132722, 1197682, 141274, 67178, 165482, 115250, 1082594, 1091938, 409802, 467146, 1024202, 1188042, 74258, 418354},
[9381]={36851234, 4864387178, 17975442, 9169160210, 4874873338, 114444434, 9247533218, 110251554, 8086759410, 67386886314, 4331030514, 7009881578, 8089906642, 120735890, 9241143466},
[8873]={5405559130, 8897325250, 8626784570, 117378, 67266, 1082994, 412354, 76482, 1090130, 1190594, 125634, 166594, 445122, 469698, 109250},
[9385]={5403453754, 1246384776874, 283407822135842, 1242347750762, 2228831266058, 605352325439602, 1242435725042, 2226144822970, 353777298334546, 282718943355298, 2227218564794, 353839575359538, 1245576578410, 282879172166458, 319436350440282},
[8877]={4868581642, 67138, 411202, 468546, 1025602, 1189442, 1197674, 124482, 165442, 443970, 116714, 142346, 75370, 1081906, 82482},
[8881]={43132962, 116330, 140874, 1082986, 67098, 134082, 1025562, 75330, 83530, 411202, 419434, 435818, 452170, 468546, 1091178},
[8885]={8626677978, 1198066, 84634, 140898, 132746, 116722, 1083498, 67690, 1206258, 428018, 75882, 419946, 107090, 452594, 411514},
[8889]={43132962, 16861394, 263333922, 16853242, 16944610, 17967722, 34752546, 120621218, 29485122, 36857898, 105302050, 108047954, 33982506, 19312098, 21425730},
[8893]={67178, 468586, 1190946, 166890, 75370, 1198722, 412650, 444370, 132682, 1027082, 124882, 140938, 1206914, 84610, 428674},
[8897]={67178, 19015714, 106055714, 29806170, 305294914, 43036098, 21106594, 31927754, 19900458, 105287234, 17862202, 36097626, 43142722, 34746306, 32665146},
[8901]={1246357505386, 1383257491130, 1246187529818, 1107062572026, 1247993284538, 1995856569746, 1245577258666, 1383794362042, 1104376121042, 7218536801682, 1383821625018, 1104464201426, 2347477649434, 2226683790674, 1247798248810},
[8905]={8895221298, 4866591058, 43133090, 18960106, 32647234, 21104706, 19040306, 20074658, 22163450, 34754578, 34744442, 19007538, 20064306},
[8909]={31600074, 19040290, 4575086730, 67414150674, 4331030666, 10858048986, 5401357770, 4314286202, 7796313642, 8087808314, 4867902810, 11044808930, 4331040202, 7547816250, 27123657050},
[8917]={115242, 1081898, 139818, 65946, 1091794, 1198106, 74282, 418346, 467498, 410154, 434730, 442922, 1188394, 1204778, 107050},
[8921]={21104682, 116210, 140506, 1090674, 1083066, 1197170, 67018, 75250, 410842, 419314, 435698, 451842, 468226, 1025282, 1189122},
[8925]={115218, 140954, 1082906, 1196882, 67018, 82410, 131562, 1089738, 74258, 410122, 418354, 434706, 451090, 467466, 1024522},
[8929]={1244746892626, 2208455353930, 2072599742346, 1242429433706, 1932778415658, 1383794362274, 2227245835850, 1104379282626, 1795574244802, 1242425345746, 1401513190666, 2070479529538, 1952342755338, 1246120413890, 1383093912962},
[8945]={141018, 1198026, 116362, 1083018, 66074, 1092530, 75722, 419426, 468458, 411114, 435810, 443882, 1189354, 1205898, 124394},
[8949]={21114314, 280120802, 110250018, 35817506, 22177834, 28462562, 22063138, 21401026, 307392066, 36851170, 22169634, 116298, 1082954, 67026, 123442},
[8953]={67186, 116698, 1084194, 420842, 75858, 140906, 412650, 1197674, 468474, 1190890, 125930, 437258, 444730, 1204786, 1091178},
[8957]={8096196730, 4313966938, 11000752498, 8087644202, 10851854706, 8163306298, 5400332330, 10845563274, 8089905498, 8096204834, 4874971194, 8159111970, 8096090146, 8633068994, 7011970778},
[8961]={141954, 67210, 76418, 412290, 469994, 1027050, 1190530, 1198722, 125570, 166890, 428674, 445418, 116362, 419466, 1084090},
[8965]={142018, 411634, 1189874, 166890, 68226, 469994, 125570, 1026690, 445418, 1198066, 1205898, 1091570, 108170, 427658, 116322, 1082978},
[8969]={68218, 76770, 116290, 167002, 1191042, 142306, 1197994, 411562, 468906, 444330, 1084410, 124842, 420610, 1026682, 435778},
[8973]={1247968118122, 1383016310138, 283470269137458, 1383096001794, 283838396908458, 1383089710338, 282721334223106, 2072627005122, 500074059809354, 1242352985450, 284251443585130, 1242354034026, 494713940623946, 284250906714218, 1383016212034},
[8977]={116290, 1082946, 140866, 67138, 469066, 412442, 445210, 75330, 1189602, 125602, 165602, 428066, 133154, 419394, 1025762},
[8985]={43036106, 116290, 140834, 1082946, 66186, 74290, 82482, 131634, 410130, 418362, 435466, 453202, 467474, 1024530, 1188402},
[8989]={116290, 1082946, 139826, 67138, 76930, 419554, 1198882, 411202, 435938, 443970, 1207074, 1189442, 468586, 109698, 124482},
[8993]={67178, 140914, 83530, 124522, 132682, 165482, 411242, 444010, 468586, 1025642, 1189482, 1197682, 1205874, 75370, 427634},
[8997]={36850274, 20073210, 43141154, 17975330, 120727802, 34637946, 29772394, 21416202, 18999530, 263334138, 36743242, 17198666, 120745546, 29526274, 263229002},
[9001]={5403453754, 4338101706, 1245820634474, 5402405058, 1245847905962, 8633067746, 5403461946, 32648642, 21137442, 43134410, 33967682, 22163450, 16910546, 33720354, 21104674},
[9005]={68258, 1190570, 125610, 133802, 166530, 84650, 411210, 76450, 1026730, 1083122, 444010},
[9009]={318886594626394, 318061960905162, 5402406338, 5674003186, 1245646465594, 2227218573746, 1382485730714, 1245576578802, 1402614213050, 2070294963586, 1242347759626, 1247993284538, 1381940373738, 7224979253690, 1245818431946},
[9013]={5403461946, 34745794, 34647618, 21106114, 34754114},
[9017]={5403463890, 8626777930, 5673996306, 5402405194, 8895220338, 5403455690, 16911954, 22161634, 33720546, 33966146, 34754018, 21104970, 34744546},
[9021]={22179298, 16920138, 34744386, 8096204946, 22065202, 26960087858, 4874227290, 34762306, 4322371914, 28195311594, 4324452562, 5478853306, 4874972762, 8626612546, 71709124754},
[9025]={280121362, 35819066, 21106242, 19040418, 307392562, 36843538, 16943266, 34752578, 21112898, 42356194, 20074554, 33695810, 43132994, 22171666, 19017634},
[9029]={1090714, 116450, 66098, 1082026, 1199010, 74770, 139946, 418474, 467506, 410162, 434858, 1204906, 442930, 1188402, 107178},
[9033]={20073042, 29501586, 32647306, 34646586, 42355290, 278022770, 16918650, 263334490, 18959922, 31623770, 108153458, 36080346, 19008082, 17968690, 43035194},
[9037]={5111959130, 8089905930, 4338108506, 8087808682, 4874872922, 26957990026, 9247533882, 4409411674, 4867655802, 4401023066, 4331809562, 8159119498, 4868680386, 7559334026, 4942089818},
[9041]={283683432055602, 1245046777122, 1104364570074, 2072599733514, 1242354042114, 1110357190426, 1104380315818, 2070437570450, 1242352985370, 2072627005002, 1104915089138, 1383259579650, 1104365635594, 2210024007562, 1107607823314},
[9057]={165610, 1197682, 83570, 132722, 1189490, 116290, 142290, 1083266, 66058, 125906, 412626, 1090842, 75754, 108522, 420898},
[9061]={21104674, 67178, 1206234, 445450, 1189482, 124522, 165482, 1197682, 1025642, 470026, 140914, 411602, 427634, 75370, 83530},
[9065]={318592901071370, 318930081170226, 318043172528586, 319435251532314, 318867806249098, 318611691553290, 319439009628698, 318104885412322, 282720797344266, 318041534644706, 319066958086626, 318929519133154, 319022934671858, 318592364200458, 318043145257402},
[9069]={36743690, 116290, 1082946, 66058, 1027082, 1189962, 166922, 75330, 419394, 1198394, 468546, 410842, 435778, 443970, 1206586},
[9077]={141274, 67146, 444378, 75378, 1189490, 124890, 165490, 83530, 132682, 1091186, 1197642, 411250, 468594, 1205834, 117442},
[9081]={132722, 83930, 68290, 411242, 1189490, 124522, 165482, 468586, 75866},
[9085]={141250, 132698, 1091642, 1190586, 1197658, 165466, 124506, 83546, 443994, 115954, 1082250, 66082, 74274, 410146, 418338},
[9089]={116666, 142010, 67162, 1083322, 1199258, 412698, 445466, 1191058, 125978, 166938, 1027098, 76474, 469082, 437394, 419578},
[9093]={5111957642, 4575086938, 116338, 140794, 1082986, 410890, 468194, 1025290, 1189130, 83562, 132714, 419434, 435786, 452202, 1205866},
[9097]={280129554, 116346, 85034, 134186, 67194, 140882, 1083010, 75386, 468602, 411258, 444386, 1198170, 1189498, 124538, 165458},
[9101]={1198762, 116362, 165450, 67186, 1189490, 468594, 411250, 140634, 1082834, 74250, 82442, 131594, 418354, 434738, 451082},
[9105]={36851170, 117730, 1084386, 66818, 410882, 443650, 75738, 1189122, 124162, 165122, 1025282, 83930, 134162, 420522, 468554},
[9109]={126082, 1191042, 68618, 167042, 412682, 1027082, 444330, 468586, 1198762, 76450, 1083370, 140914, 435818, 429218, 419570},
[9113]={5111959594, 1383016310018, 1952342755578, 1246120519210, 1383286859458, 1246355302834, 2070479521466, 1242356026162, 1951269013714, 1171222849706, 1242354033922, 1108681574098, 1244500470178, 1857853475050, 1242348792306},
[9117]={140874, 68618, 116330, 75378, 411250, 1189490, 1205874, 1197642, 124530, 165450, 427634, 444018, 468594, 132722, 1025650},
[9125]={116290, 1083346, 142370, 1091482, 412706, 1190946, 1199138, 166946, 68410, 445450, 75730, 1207330, 125962, 429090, 85002},
[9129]={2208430179738, 1402586940826, 43132986, 4864486978, 21106258, 4867903050, 4325525610, 4874225778, 22162034, 9404721258, 8632289346, 7779536458, 71174353058, 34744946, 5405567042},
[9133]={8870054202, 4313984746, 5399267642, 9169938778, 8087809474, 71147080498, 4313974714, 4874971482, 5398202682, 4331712114, 5648828730, 4338100154, 8625998146, 4854008154, 7796312882},
[9137]={140866, 1082994, 68226, 117410, 75338, 83530, 132674, 411210, 419442, 435826, 452170, 468546, 1025610, 1091138, 1189442},
[9141]={116674, 141930, 1082970, 66066, 76394, 82570, 131722, 411186, 453226, 1090786, 1189426, 1206890, 419418, 435802, 468570},
[9145]={22171106, 34754018, 21114434, 21106146, 116418, 1083074, 1091458, 66786, 410490, 467834, 1024930, 1188730, 1207314, 123770, 164490},
[9149]={20074074, 43034810, 21104826, 17976874, 114337978, 120735930, 32549050, 263235770, 43141306, 34754106, 120629434, 17868986, 114444474, 263342266, 32655546},
[9153]={132722, 165450, 116298, 140994, 1082954, 1091098, 67138, 82450, 123410, 410130, 1188410, 75338, 108106, 419402, 427594},
[9165]={21106114, 5405559098, 8870047170, 5399267642, 4865534178, 8633067834, 5648836834, 8700184890, 5474658618, 8626030786, 4317137242, 8867950026, 4852952410, 8870062274, 5397170490},
[9169]={132682, 83570, 165490, 32648642, 36081122, 19318826, 17188898, 307392066, 114337826, 263335866, 19017666, 16902178, 105285794, 19968050, 106065354},
[9173]={83530, 132682, 1205874, 165450, 427634, 443978, 124490, 68258, 116298, 140514, 1092538, 1082954, 75018, 107746, 410850},
[9177]={115250, 140754, 1081906, 66058, 131554, 74290, 82442, 410122, 418354, 434698, 452050, 467466, 1024522, 1090058, 1188362},
[9185]={140914, 68266, 1198762, 134162, 412290, 445098, 1206954, 1190570, 125570, 165490, 428714, 85010, 1026730, 1091186, 115218, 1082594},
[9189]={116298, 1084426, 139794, 68258, 1092290, 1198906, 445242, 76938, 125754, 166674, 132354, 83202, 412690, 1191050, 420874},
[9193]={33697218, 22171082, 280128994, 110242314, 19009082, 21082018, 43134402, 36105698, 280120802, 20082242, 16910370, 21401058, 35819098, 305295266, 34580522},
[9197]={133802, 1190570, 166570, 84642, 68258, 1206954, 109226, 427634, 412290, 444018, 124530, 76482, 469666},
[8689]={165482, 411250, 68226, 84650, 132722, 116338, 140874, 1082994, 468506, 1025562, 1190490, 75370, 419434, 435818, 452170},
[9201]={5405559098, 4862291626, 8897325250, 4874971482, 5402405090, 4338108762, 5111950682, 9169938778, 8867957050, 5676099778, 4874872722, 7550947066, 5399267642, 4952574298, 8626784570},
[9205]={4866591538, 1383794255554, 2072627005146, 1244509808306, 2270197606066, 1381942470298, 2072599733978, 1104449520978, 1383016212034, 1266204951914, 2072601830762, 1244500469394, 1381646878394, 2226708957258, 1246357513474},
[9209]={4868686802, 7796321074, 4572989754, 7559228170, 5405559010, 5109754610, 7796305490, 9232861530, 4952574298, 5399161114, 4864493914, 5405454050, 7550945594, 9404723330, 4937894234},
[9213]={34745826, 9406925114, 5411858466, 4946282554, 7550158986, 5646626474, 9169938626, 4602358458, 4941983626, 8086759546, 5478952514, 71174351546, 7549913402, 4867935786, 5474658362},
[9217]={9406926578, 4862397970, 28197408298, 7550946098, 5648829994, 7553042770, 71711223234, 71709116562, 27123665234, 7259442730, 11017537874, 67388983634, 8333183314, 30881761594, 29271148882},
[9221]={140874, 117410, 67178, 412322, 468586, 445058, 1198722, 1189482, 125570, 165482, 1026722, 76458, 133762, 83570, 1084066},
[9225]={43141154, 21104682, 280112610, 16918562, 105328074, 21415978, 20073954, 32647202, 42371106, 120565218, 277917746, 29771986, 33998890, 19015890, 16894194},
[9229]={21114426, 280129450, 36851138, 21401178, 307392426, 36744642, 22171266, 36859482, 133826, 28454850, 105311834, 29789946, 18984538, 116535322, 277917898},
[9233]={1245820634474, 1933315188314, 1401511102170, 1242352985690, 1935188051674, 1108916349458, 1264982312658, 1935162893674, 2227245827802, 4853902010, 1108945823402, 1932841231962, 1445563885234, 1264074237290, 1796111222458},
[9237]={9406925618, 4874971066, 5403461666, 4862396994, 8897325178, 11017538330, 5405560370, 4315040194, 7796314154, 8895220474, 4874980906, 8626784378, 5648830018, 7550946098, 4868688322},
[9241]={9406924458, 5403453474, 4862396730, 4331710354, 11044808898, 4952467346, 4331808658, 8331086138, 7550838674, 5402405538, 28195309882, 4946175890, 8360454898, 4861341034, 5648837290},
[9245]={117442, 1083018, 142098, 68626, 76818, 412322, 1198034, 85002, 420546, 470034, 1189850, 436906, 125970, 166562, 429074},
[8737]={83922, 115970, 1082626, 142266, 66418, 1027202, 1191042, 167042, 75010, 419074, 1197434, 468186, 411746, 435418, 444154},
[9249]={84650, 133802, 1190530, 166530, 125610, 469634, 67146, 116322, 140874, 1082954, 1091506, 1197562, 75338, 108106, 411210},
[8741]={140914, 411250, 1197682, 165450, 124490, 67194, 1189490, 132722, 443978, 468554, 117498, 1084154, 74298, 83410, 109106},
[9253]={36744770, 35818954, 19017282, 36842954, 36079778, 84674, 68258, 133826, 1199082, 1206954, 469666, 109226, 1091210, 1190530, 427994},
[8745]={36849946, 43133026, 20072730, 117786, 1083090, 67162, 83546, 132698, 411226, 435922, 452306, 468570, 1025626, 1091282, 1205850},
[8753]={67138, 75330, 116290, 1082946, 141226, 420994, 1199234, 1191042, 166922, 411722, 445450, 1091658, 1206946, 435778, 468546},
[8757]={4331816850, 9406924922, 9434196090, 116650, 1083354, 75730, 419794, 468586, 411242, 436178, 443970, 1188402, 164402, 124482, 427994},
[8761]={17976802, 116714, 75738, 141266, 1083370, 83922, 468586, 419794, 411210, 444010, 1205866, 1191066, 1091538, 67178, 1198034},
[9273]={20073954, 7552010586, 4575079218, 5403461978, 9169160386, 4952467346, 8331086138, 5405567178, 4338100154, 5095073682, 7630637402, 5402405090, 8159119674, 7559227282, 8626776386},
[8766]={632868, 526972, 1043244, 699484, 534084, 665156, 673348, 689732, 1025660, 1033796, 1123908, 1132100, 1140292, 542276, 715444},
[9278]={527372, 1042540, 633644, 1132276, 707748, 698100, 543396, 650404, 1141924, 683172, 1025780, 658596, 715940, 1035428, 642212},
[8770]={1043612, 527028, 1133356, 534628, 665700, 699180, 1141916, 1124452, 1034340, 543900, 469804, 632452, 715564, 1025668, 722676},
[9282]={665316, 135260236, 135342156, 170912500, 135252204, 134860428, 134752332, 134883404, 673364, 689788, 1140308, 1123948, 534244, 1033852, 640636},
[8774]={527012, 666356, 699484, 1043588, 633948, 1141852, 543836, 1133660, 1125508, 469788, 1035396, 1027204, 658588, 683140, 535708},
[9286]={526436, 535220, 690868, 699060, 715444, 1026740, 1125044, 1141428, 1034932, 469684, 1043468, 1132276, 633868, 665700, 673892},
[9290]={526436, 535220, 690868, 699060, 715444, 1026740, 1125044, 1141428, 1034932, 469684, 1043468, 1132276, 633868, 665700, 673892},
[8782]={527492, 135344204, 134885452, 631788, 535524, 542276, 640940, 690092, 699004, 722540, 1025964, 1042348, 1132460, 1141732, 1034156},
[9294]={666764, 526412, 267464772, 136982596, 170905668, 162148420, 170913860, 170995780, 543724, 674556, 690220, 683108, 1133660, 469036, 641108},
[8786]={470108, 525900, 534092, 542756, 632396, 640708, 657444, 665164, 682020, 689740, 698044, 722868, 1026084, 1042356, 1124028},
[8790]={134918220, 134860908, 170569796, 135254124, 120066124, 135245892, 134885484, 533484, 543116, 631428, 690788, 1041388, 1123188, 1131500, 650212},
[8794]={525540, 1041988, 666236, 640628, 673396, 632396, 534132, 689780, 1123908, 542284, 1033796, 1140300, 1132100, 706116, 648788},
[9314]={666764, 526412, 267464772, 136982596, 170905668, 162148420, 170913860, 170995780, 543724, 674556, 690220, 683108, 1133660, 469036, 641108},
[9322]={665316, 135260236, 135342156, 170912500, 135252204, 134860428, 134752332, 134883404, 673364, 689788, 1140308, 1123948, 534244, 1033852, 640636},
[9326]={134918220, 134762572, 34625023940, 665644, 1125476, 1133708, 633996, 470156, 699484, 1043596, 527372, 1141892, 543884},
[8818]={526012, 665164, 632508, 1123908, 1033964, 1043620, 534252, 698044, 468548, 641660, 656964, 673348, 689852, 723580, 1025604},
[8822]={34522344028, 534084, 690812, 697924, 1026684, 1041988, 1132100, 542276, 658044, 715388, 665156, 723004, 706476, 681540, 1141372},
[9334]={135344196, 134885476, 632556, 1043236, 699484, 535652, 1026092, 542764, 1133668, 642148, 658532, 1140780, 1035364, 724068, 469076},
[8826]={525892, 535644, 632508, 665276, 722980, 1041996, 1132580, 542756, 657444, 714788, 1025724, 690212, 682020, 469028, 699364},
[9338]={30736903948, 699132, 632908, 526020, 470148, 1133700, 1027204, 1141900, 665644, 543884},
[8830]={1125476, 527452, 170913868, 134918220, 170569804, 135254084, 134910020, 134884972, 632628, 1025004, 1131500, 468548, 534084, 542276, 640580},
[9342]={526436, 535220, 690868, 699060, 715444, 1026740, 1125044, 1141428, 1034932, 469684, 1043468, 1132276, 633868, 665700, 673892},
[8834]={665684, 527500, 135342284, 135352396, 134852684, 135360588, 135254116, 134752964, 134918220, 134761132, 134908612, 1042116, 683100, 1027164, 641060},
[9346]={666764, 526412, 267464772, 136982596, 170905668, 162148420, 170913860, 170995780, 543724, 674556, 690220, 683108, 1133660, 469036, 641108},
[8838]={526012, 699484, 1043588, 665636, 633956, 1125476, 1035364, 543876, 1027204, 1141532, 1133340, 470148, 658564, 534164, 640700},
[9350]={526436, 535220, 690868, 699060, 715444, 1026740, 1125044, 1141428, 1034932, 469684, 1043468, 1132276, 633868, 665700, 673892},
[9354]={666764, 526412, 267464772, 136982596, 170905668, 162148420, 170913860, 170995780, 543724, 674556, 690220, 683108, 1133660, 469036, 641108},
[9358]={526012, 1043620, 1125468, 665636, 1141924, 543908, 1035428, 1133732, 470180, 699556, 1027236, 683172, 634020, 658596, 534092, 640700},
[8850]={134884012, 135342756, 43754008764, 34522261860, 534052, 542244, 640548, 673316, 689700, 698172, 1034044, 1140540, 468548, 648772, 656964},
[9362]={526012, 633596, 665324, 267463332, 467948, 533124, 541676, 639620, 648860, 656004, 673116, 680580, 688772, 696964, 706196},
[9366]={525892, 632388, 697924, 1043548, 666716, 542276, 1140292, 1025604, 1123908, 706172, 469668, 722540, 534564, 648828, 1132140},
[8858]={526012, 534084, 542396, 632428, 640700, 657084, 665196, 673468, 681660, 689852, 697924, 714788, 722620, 1025724, 1033916},
[9370]={527092, 633956, 1043556, 699132, 1133668, 543844, 658532, 724068, 535652, 665324, 683108, 690260, 1026132, 1124316, 642148},
[8862]={135342124, 134883372, 34532747412, 34625023940, 632388, 1140292, 699004, 1026684, 1133180, 542276, 690812, 534092, 706484, 469628, 641660},
[9374]={134852676, 134885444, 134918212, 34625023268, 34622926116, 34498817356, 34627202380, 30736903468, 34627219244, 34528554756, 34522261860, 34539040036, 34499194788, 34530651428, 10901343266708, 7880458724660},
[9378]={34627202860, 665644, 526372, 1125476, 170569804, 136981156, 267463460, 162146500, 179384388, 170912428, 170993868, 265375964, 699532, 120066124, 134762564},
[9382]={1043572, 527148, 665700, 699180, 633644, 1025788, 1132284, 542460, 657148, 714732, 673892, 1141548, 469804, 690276, 534628},
[9386]={1125516, 134884012, 135252772, 170994348, 135342764, 534572, 632516, 1140820, 690260, 640748, 1035044, 665636, 526012},
[8890]={526372, 666716, 633948, 1043596, 1125468, 699484, 535644, 470156, 1141860, 1027212, 1035364, 543884, 642148, 658572, 674956},
[8894]={1043548, 698468, 633948, 542396, 526972, 724060, 470108, 1026084, 1132580, 658524, 683100, 1140772, 689860, 665276, 715868},
[8898]={633948, 1043548, 527452, 535644, 1125468, 1027164, 543836, 1133660, 658524, 683100, 1141852, 470108, 1035356, 699484, 642140},
[8902]={527092, 632868, 665276, 1124028, 1043196, 1133660, 543836, 1027164, 534564, 699484, 1141852, 470108, 1034276, 690212, 674916},
[8906]={1125516, 1042516, 526020, 665164, 699172, 1140460, 543884, 1133708, 469076, 682068, 657492, 535692, 641108, 1026132, 633996},
[8910]={699132, 1141900, 470156, 527452, 632868, 658524, 722980, 1027164, 1042468, 1133660, 535644, 543836, 715868, 665276, 682020},
[8930]={525900, 632516, 698412, 1027172, 1035364, 1043596, 1124036, 543844, 666604, 470116, 1141860, 535692, 642188, 658572, 691340},
[8950]={526012, 666724, 1124396, 631796, 468668, 534084, 542276, 640700, 657084, 673348, 681660, 689852, 698044, 706484, 714788},
[8954]={527452, 633948, 699004, 1043428, 1027044, 535644, 1133540, 658404, 543716, 691292, 723940, 1141732, 707676, 469988, 642140},
[8958]={1043596, 543836, 699404, 1141852, 470156, 1035404, 682068, 642188, 657492, 1133660, 1125468, 715916, 666604, 535692, 691340},
[8962]={526020, 631428, 664964, 1041796, 534084, 542276, 640580, 673348, 689732, 699004, 714308, 722500, 1025604, 1033796, 1123908},
[8966]={526020, 533852, 632036, 664804, 1041796, 1123796, 1131908, 543356, 640580, 673348, 689732, 706116, 1025604, 1033796, 648772},
[8970]={1042028, 665156, 527372, 1026740, 699060, 543412, 657020, 534124, 1141428, 1033796, 1123908, 689772, 681596, 1132156, 715564},
[8974]={135344204, 134885476, 699492, 543884, 1141860, 665284, 1124036, 526020, 633996, 1027212, 1043612, 470156},
[8978]={34625024108, 534084, 632388, 640620, 665156, 673388, 689732, 697924, 707676, 722980, 1026004, 1123908, 1132100, 1141732, 543836},
[8994]={525892, 632868, 665276, 699484, 1042148, 1125108, 1133660, 543836, 1027164, 470108, 534572, 691300, 642148, 1034996, 658524},
[8998]={1043604, 527388, 534084, 542332, 632404, 665156, 673348, 690812, 697980, 1026860, 1034876, 1123908, 1133236, 658404, 723756},
[9002]={527452, 699484, 1124028, 665636, 1140820, 642188, 1035404, 683148, 543884, 1133668, 658572, 1026132, 1043596, 535692, 691340},
[9006]={526372, 1026684, 1141372, 1041988, 542276, 632388, 1132100, 640940, 691292, 699004, 722860, 1123908, 706476, 657324, 673708},
[9010]={526372, 170993964, 135252172, 134752460, 134858956, 134883532, 135342284, 171003980, 288450756, 179384388, 170560172, 170592940, 139537060, 170896044, 175188164},
[9014]={526252, 665156, 1123908, 534564, 690212, 632508, 698284, 1025724},
[9018]={526324, 698356, 1124460, 1132652, 1141924, 543908, 1026156, 470180, 683172, 658596, 1043620, 665708, 641132, 1035428, 535716},
[9022]={43754025180, 525892, 632388, 1123908, 697924, 534204, 689852, 640700, 1132220, 681596, 1025724, 1033980, 673364, 542332, 714364},
[9026]={665668, 534084, 640580, 1124268, 1042052, 689732, 1033796, 1141372, 542276, 525700, 1132100, 673708, 707676, 650332, 681540},
[9034]={526436, 699548, 170913964, 135352012, 162181292, 134885508, 170569900, 135262380, 134917796, 535204, 542820, 657508, 691212, 1026148, 1125044},
[9038]={525956, 534268, 543476, 632452, 665340, 699004, 1043188, 1124092, 1133300, 658164, 469748, 724060, 1027164, 1141492, 689916},
[9042]={43754008652, 2262428510314764, 2260777120654068, 11178456736756, 11177382978548, 2262426388095452, 2262426362831804, 8977285982868, 8839847044964, 2333368489418772, 2720374570689316, 2720396582395908, 42592186172, 288452676, 135344196},
[9058]={527452, 665636, 1125468, 690940, 699132, 1035004, 1133340, 535292, 631788, 1025004, 469628, 542636, 640580, 657324, 673348},
[9062]={526620, 534204, 543836, 632508, 640700, 665276, 689852, 724060, 1026084, 1042108, 1124268, 1132220, 658524, 715868, 699484},
[9066]={527500, 170912508, 135350956, 267462868, 135360588, 41518362404, 134762572, 10628700924388, 135342764, 135260364, 171004004, 137439932, 139554932, 170569924, 166801492},
[9078]={525292, 535284, 633588, 665276, 691292, 699484, 1027164, 1042468, 1124028, 1133300, 1035356, 543836, 642140, 1141852, 469028},
[9082]={525892, 535284, 665276, 699484, 1043188, 1124028, 691292, 1033916, 633588, 469028, 543884, 658572, 1027212, 1132260, 1141900},
[9090]={1042532, 632932, 699180, 665700, 526436, 1122828, 534084, 715444, 722556, 1025620, 542332, 689732, 1133236, 657020, 706132},
[9098]={135260508, 664556, 469628, 534084, 542276, 632388, 640580, 648772, 656964, 673348, 681540, 689732, 697924, 706116, 714308},
[9110]={526012, 632868, 1043548, 1124028, 666716, 1140412, 1133660, 1035356, 690932, 697964, 542276, 1027164, 469028, 706636, 657484},
[9114]={525892, 1042044, 666356, 1124028, 542292, 1033916, 534204, 689852, 1140820, 699484, 1133732, 641108, 682068, 469076, 657516},
[9126]={526076, 665340, 533004, 541924, 631428, 640684, 657068, 673452, 680940, 688772, 697324, 721900, 1024644, 1033900, 1041388},
[9130]={526036, 1124412, 699548, 469092, 534268, 542460, 632892, 640724, 665340, 682084, 689916, 1025788, 1033940, 1042132, 1132284},
[9134]={526012, 666724, 1125476, 699124, 1027164, 1042108, 1033916, 534452, 1141492, 689852, 470108, 543476, 633948, 642140, 1133660},
[9138]={527372, 666716, 1125468, 633956, 162524812, 533020, 639516, 673228, 688668, 697324, 1025004, 1033460, 1131420, 468548, 542276},
[9150]={524932, 534084, 542756, 632428, 641060, 665156, 690092, 698404, 722980, 1026084, 1034156, 1041996, 1123908, 682020, 1132580},
[9154]={135344228, 633236, 664964, 1041396, 469748, 534092, 542284, 640588, 650332, 657084, 673356, 681548, 689740, 697932, 706596},
[9166]={1125516, 527500, 666724, 135252652, 171010852, 134860876, 134910028, 135352396, 120066116, 134754380, 134762572, 135360108, 134883532, 632516, 698412},
[9170]={525900, 534212, 665164, 1123916, 633956, 640708, 1140460, 698452, 470156, 1133708, 1027212, 1035404, 543884, 673356, 681548},
[9174]={526372, 665644, 1125468, 699484, 633716, 534084, 640580, 689772, 722508, 1025612, 1033796, 1041996, 1132108, 543716, 657324},
[9186]={135342764, 34522263300, 689852, 665156, 1034156, 543356, 534204, 640580, 714668, 1025964, 682980, 1132460, 673708, 723580, 698284},
[9190]={135342764, 34530651908, 697924, 542276, 722860, 1141372, 1132100, 1025604, 632388, 640580, 534084, 689732, 657324, 714668, 1033796},
[9194]={526252, 665636, 1124388, 1140772, 697924, 1041988, 542276, 534084, 632388, 640580, 656964, 673348, 681540, 689732, 714308},
[9198]={526252, 665636, 1124388, 542276, 468548, 534084, 632388, 640580, 656964, 673348, 689732, 697924, 714308, 722500, 1025604},
[9202]={526012, 162146980, 534572, 542404, 640708, 689860, 1027172, 1033924, 1042116, 1123916, 1140420, 698412, 1133668, 470116, 682068},
[9206]={527500, 534212, 632868, 666364, 698412, 1042476, 1125116, 689860, 1140772, 640708, 470116, 542764, 658572, 683148, 715916},
[9210]={525980, 1041884, 632444, 665644, 542764, 1124396, 656820, 696740, 714164, 722356, 1024420, 468316, 533132, 640364, 648668},
[9214]={526372, 1125468, 665644, 468548, 534564, 542276, 632388, 640700, 657444, 682020, 690212, 697924, 714788, 722980, 1025604},
[9218]={525932, 1042516, 665276, 698044, 1124028, 1132220, 632548, 469028, 542756, 1140412, 1026084, 1033916, 706244, 534204, 681596},
[9222]={525892, 542756, 632508, 658524, 665276, 683100, 698404, 715868, 724060, 1027164, 1042108, 1132580, 470108, 534564, 1124028},
[9226]={526340, 665164, 1124036, 1034284, 1042516, 470116, 632908, 699532, 1027212, 534572, 542644, 641060, 658524, 673828, 683100},
[9230]={134884156, 135342428, 170912540, 533124, 1132348, 468548, 542276, 632388, 640580, 657084, 673348, 681540, 689732, 697924, 707316},
[9234]={135260868, 134883524, 135342764, 135254116, 633956, 1140780, 543884, 699532, 534212, 665644, 1124396, 1042476, 1033924, 526012, 470156, 1133700},
[9238]={526372, 1125516, 666764, 170913868, 139079748, 162148420, 136982596, 171003980, 470108, 698404, 1027164, 1141852, 1035404, 642188, 691340},
[9242]={526012, 1043228, 665644, 632548, 1125476, 699492, 1133700, 469028, 543836, 658524, 1026084, 1140772, 724068, 715876, 642140},
[9246]={527092, 632396, 664196, 672388, 688772, 696964, 1024644, 1041028, 1139332, 468908, 534444, 542276, 640580, 648772, 656964},
[9250]={524932, 534372, 632468, 664964, 1043356, 1123796, 468668, 542396, 657092, 681660, 689780, 698044, 707684, 714436, 722628},
[9254]={1042076, 468548, 525892, 632388, 697924, 723700, 1025604, 1132460, 1140292, 542636, 1123908, 535284, 658524, 715868, 689852},
[8754]={1043588, 699524, 1133700, 527492, 631788, 469628, 534084, 640580, 656964, 665156, 673708, 689732, 722500, 1025604, 1033796},
[8762]={525892, 543716, 1042468, 632428, 665156, 1124268, 1133540, 690932, 724060, 699364, 1027044, 469988, 641780, 674788, 534204},
[9274]={526372, 665644, 469028, 534612, 632508, 657452, 690220, 698404, 714796, 722988, 1026084, 1042148, 1123956, 1132580, 682028},
[8767]={128780334, 130877630, 219007142, 218998822, 132974734, 219170934, 219220014, 212666406, 210569262, 218982438, 219211894, 219129894, 219179126, 214763662, 120391726},
[9279]={853606, 518854, 1116990, 1067718, 502430, 1100902, 896014, 510766, 904342, 1076390, 830206, 470182, 822438, 1108678, 838342},
[8771]={219171126, 219220150, 128780630, 132976134, 218982582, 219205126, 218998966, 130877574, 219211958, 219007078, 218974390, 214763654, 218966606, 219179110, 216861326},
[9283]={128780846, 219222214, 219205830, 132976734, 55516704134, 33505003886, 54442963070, 33504981118, 56066338566, 33504963294, 56064077694, 56059873758, 56064241534, 33498664758, 54442970942},
[8775]={34041874718, 33418971206, 33505004950, 133187702, 853622, 128780846, 218974326, 218999390, 218990734, 219129998, 219211918, 219220510, 219179566, 212666518, 214763558},
[9287]={502894, 519286, 1117294, 219172942, 130879566, 133197942, 131092558, 219009094, 133222574, 212668494, 133017694, 219213894, 120057942, 132968542, 219205702},
[9291]={502894, 519286, 1117294, 219172942, 130879566, 133197942, 131092558, 219009094, 133222574, 212668494, 133017694, 219213894, 120057942, 132968542, 219205702},
[8783]={32968132486, 32880002990, 1099382, 517750, 1066614, 902902, 853542, 501718, 829166, 1073718, 467510, 1114806, 861934, 845550, 819766},
[9295]={501366, 219172782, 518110, 1100822, 1116126, 470038, 510990, 1027094, 855062, 1068054, 838678, 1076238, 904206, 822286, 1109006},
[8787]={56108312774, 56066379086, 56057940286, 56066330414, 518710, 501326, 837238, 879278, 1026734, 1100422, 894574, 1107574, 1115766, 871078, 1066574},
[8791]={128780486, 132975214, 219171062, 219008574, 219205182, 829038, 509550, 1074798, 468590, 820846, 1107566, 1116006, 837230, 861806, 886382},
[8795]={219203750, 216860742, 128781774, 130879414, 219007062, 132974662, 219000414, 218982566, 212667862, 219211862, 1116990, 1075846, 1066638, 469638, 821894},
[9315]={501366, 219172782, 518110, 1100822, 1116126, 470038, 510990, 1027094, 855062, 1068054, 838678, 1076238, 904206, 822286, 1109006},
[8811]={852502, 501326, 518830, 895662, 1067694, 1116846, 1100462, 829046, 509878, 1073726, 467518, 819774, 836158, 844350, 860734},
[9323]={128780846, 219222214, 219205830, 132976734, 55516704134, 33505003886, 54442963070, 33504981118, 56066338566, 33504963294, 56064077694, 56059873758, 56064241534, 33498664758, 54442970942},
[8815]={853622, 509910, 1075158, 829166, 516662, 1099262, 468590, 501318, 820846, 837230, 845782, 886382, 894582, 903126, 1025646},
[9327]={132974630, 128829678, 219220214, 133189190, 130877510, 130543078, 219204190, 219179254, 219007222, 128780830, 284231894, 223365662, 120441078, 130854966, 282136134},
[8819]={219205350, 219221734, 128781894, 218984446, 219007766, 517774, 1117350, 502470, 1100966, 903870, 854726, 1066598, 510646, 830134, 1108614},
[9331]={501366, 853974, 829006, 894494, 508798, 1074046, 516550, 1097942, 467478, 819766, 836118, 844310, 860694, 877078, 885302},
[8823]={852542, 517750, 1066614, 1099742, 501366, 862174, 894942, 1115766, 845790, 878558, 902182, 829046, 509558, 1075246, 467518},
[9335]={219008654, 519190, 128994790, 853622, 128757782, 210783718, 214978022, 1115766, 510662, 1100486, 903982, 502438, 1066614},
[8827]={56066328494, 32968132486, 34041874318, 853542, 509558, 1099382, 1115766, 870358, 1074806, 838678, 879278, 829038, 468598, 820814, 1107534},
[9339]={33418971750, 128829678, 212666582, 33559742398, 133023982, 219179254, 32880256942, 54979807430, 32882354294, 219170862, 32880266894, 30814308270, 32880019374, 219007222, 56068475086},
[8831]={852502, 468590, 1099382, 1107566, 517990, 501358, 510990, 837230, 896022, 1115766, 1066606, 1025646, 870358, 903142, 829534},
[9343]={502894, 519286, 1117294, 219172942, 130879566, 133197942, 131092558, 219009094, 133222574, 212668494, 133017694, 219213894, 120057942, 132968542, 219205702},
[8835]={219205182, 130879070, 219221574, 128781798, 518830, 502446, 853574, 1066734, 903982, 1075910, 1116846, 510662, 1100462},
[9347]={501366, 219172782, 518110, 1100822, 1116126, 470038, 510990, 1027094, 855062, 1068054, 838678, 1076238, 904206, 822286, 1109006},
[8839]={128780334, 133023982, 219170854, 128829678, 219220014, 130877654, 219211822, 219205190, 219179254, 219015214, 132974638, 219007222, 1066606, 510046, 501366},
[9351]={502894, 519286, 1117294, 219172942, 130879566, 133197942, 131092558, 219009094, 133222574, 212668494, 133017694, 219213894, 120057942, 132968542, 219205702},
[9355]={501366, 219172782, 518110, 1100822, 1116126, 470038, 510990, 1027094, 855062, 1068054, 838678, 1076238, 904206, 822286, 1109006},
[9359]={853646, 519190, 469702, 821958, 1100486, 1107958, 501390, 895686, 1115910, 1075910, 846534, 1066598, 879302, 1026758, 870030},
[8851]={56064264390, 32968306078, 54443183534, 34042071246, 32961793358, 56116709574, 32968346918, 56110401862, 54443165926, 32968329422, 903878, 518830, 1116846, 501366, 1099382},
[9363]={219220574, 219172854, 132976654, 130877982, 219007222, 829406, 501758, 1075846, 1098302, 821926, 1107926, 893862, 837590, 861814, 887462},
[8855]={128780358, 34042038470, 30734616774, 34042046350, 830478, 510990, 904206, 822286, 1099734, 1109006, 871438, 1115038, 838670, 863246, 887822},
[9367]={853934, 509630, 902742, 1074758, 518846, 829134, 1107886, 870318, 501798, 837550, 1116078, 468550, 820806, 1066566, 1025966},
[8859]={219007222, 128780358, 130877654, 133238798, 273731134, 903982, 128757782, 133230606, 273748030, 129003542, 133017158, 284233278, 853582, 120041526, 132958830},
[9371]={854702, 518110, 1075886, 510998, 468958, 501366, 820854, 837238, 878198, 886390, 895662, 1025654, 1066574, 1099342, 1107574},
[8863]={56064265702, 518950, 1067814, 1116990, 511134, 502590, 853582, 1076382, 871582, 903270, 822430, 1109150, 470174, 1100606},
[9375]={32968132990, 130877654, 56108321086, 34035533942, 56057980814, 56064241526, 219007062, 32963889078, 34042071398, 56108312614, 54443183734, 32959695638, 30734616990, 56057940086, 56110419606},
[9379]={32880002990, 219007582, 32980912686, 132974630, 32879667758, 212666990, 32980888110, 219220214, 32880250510, 56108312454, 56057768518, 32882149422, 219179254, 32880052782, 54979832590},
[9383]={853598, 219170966, 218998966, 128780462, 219220150, 130877590, 132974726, 219211958, 218982582, 219007078, 218974390, 219129958, 216860790, 219203694, 210569334},
[8875]={853622, 128831118, 830118, 510662, 1075910, 469702, 1100486, 1108678, 517774, 838342, 887494, 894606, 1116870, 1066638, 1026758},
[9387]={128780334, 282136214, 130543550, 218983998, 128437902, 133238942, 216862182, 212668022, 210569758, 219180718, 219203622, 219221446, 130879094, 132976198, 904350, 231753942},
[8879]={855014, 501318, 517702, 1066566, 1107526, 837190, 509934, 894934, 903262, 869958, 1116118, 829046, 468550, 1074934, 819726, 885422},
[8883]={853582, 517750, 501278, 509510, 829046, 1074758, 836150, 860734, 877118, 886670, 1025494, 1065486, 1098302, 1106486, 1114686},
[8887]={853646, 511142, 1100966, 1115190, 904358, 830630, 1076366, 501870, 895806, 879782, 822294, 1109158, 517142, 470182, 861238, 844854},
[8891]={219009014, 517870, 1066614, 510662, 853702, 903878, 1115766, 1075910, 502470, 1099382, 871110, 1108678, 469702, 821958},
[8895]={854662, 903142, 517766, 509550, 1108614, 1066934, 1075878, 502406, 895622, 1116086, 1099342, 468622, 820878, 871102, 829414},
[8899]={219222118, 132976078, 904342, 510662, 852622, 502430, 1076262, 871078, 1066606, 821926, 1099406, 1108646, 830502, 838318, 895686},
[8903]={128780326, 132974790, 218982438, 219220014, 219203630, 219006902, 219170862, 130877510, 216860902, 218999070, 212666438, 218966302, 219211822, 218974374, 219179054},
[8907]={219008502, 132974662, 130879094, 223365286, 518830, 903982, 273731142, 273739238, 853582, 1116846, 1076014, 509686, 1100838, 1067654},
[8911]={219009142, 130878942, 518790, 128993318, 904342, 273746446, 129034278, 853582, 128757782, 263211054, 129003542, 273737766, 120039470, 129043918, 511006, 829534},
[8919]={854782, 508462, 827990, 1073710, 1066038, 517894, 1116270, 901678, 467502, 870510, 819758, 1098286, 1106478, 500270, 836142},
[8923]={853614, 517862, 1067086, 1117318, 1099374, 509686, 828918, 1075718, 468230, 500238, 820486, 836230, 844662, 861046, 877830},
[8927]={853622, 501358, 828998, 509870, 895694, 1073718, 516310, 1066134, 467510, 819766, 836150, 844342, 860734, 877110, 885302},
[8931]={34042039854, 903982, 853614, 518830, 1116870, 510766, 1067654},
[8947]={853486, 829030, 509542, 501654, 1074790, 902758, 1068198, 467982, 822198, 1099286, 1107438, 517134, 893966, 1114790, 837222},
[8951]={219203622, 219221566, 128781894, 132976654, 219007222, 501366, 518830, 1116846, 1100462, 853582, 829046, 510598, 1075246, 878078, 893494},
[8955]={853742, 902734, 829406, 509398, 1075126, 1067694, 516670, 870366, 821134, 1107334, 501726, 468598, 886350, 1116238, 911086},
[8959]={219170862, 219221934, 218974446, 517742, 215017998, 263243822, 1066606, 870006, 231804942, 282127814, 131141646, 853694, 129042958, 227610366, 215026382},
[8963]={219008526, 128780454, 518790, 895622, 1067654, 1116806, 1108614, 510614, 501326, 903262, 852502, 830086, 1074766, 468558, 820814},
[8967]={34041850198, 54442962510, 34042046470, 54443134542, 56064240086, 34042071262, 34042039894, 34035535526, 502830, 1115790, 510750, 903870, 1066638, 518910, 852502},
[8971]={853934, 904342, 510006, 518182, 1117318, 1109126, 1068126, 470150, 502918, 830630, 1076374, 1100814, 871462, 1027206, 838630},
[8975]={219170854, 128831598, 132976198, 130927334, 219221478, 219205094, 219181078, 212668350, 219213382, 210570726, 218976278, 214764062, 218984006, 218992270, 219000830},
[8979]={32968345582, 853214, 829158, 509670, 1074918, 902886, 468670, 820966, 1099854, 1107646, 516782, 837310, 886502, 895054, 845902},
[8987]={853574, 517750, 1066614, 501718, 828998, 509478, 1074718, 894854, 467478, 819734, 836118, 845350, 861734, 877070, 885302},
[8991]={853614, 829398, 509510, 1074798, 902766, 894982, 519190, 1116246, 1098294, 1106486, 820806, 500278, 836150, 886262, 861806},
[8995]={854278, 830478, 510990, 1075158, 517630, 468590, 501318, 821206, 837590, 846510, 886742, 894582, 1025646, 1066606, 1099342},
[8999]={56064231718, 56066361630, 33505004998, 56066328582, 129002262, 128756502, 131123982, 131099382, 128994014, 231762702, 853502, 128436430, 231754510, 128830230, 130927350},
[9003]={854702, 519190, 903982, 1115766, 1067718, 511022, 502446, 1100454},
[9007]={128780334, 219221566, 132976094, 219008654, 130877478, 1100822, 821934, 1108654, 1067814, 838318, 1026734, 871086, 469678, 879278, 1074798},
[9011]={219221958, 219008654, 133001334, 131125374, 132943990, 231755422, 217124974, 128781942, 212930646, 130543702, 231788630, 275845326, 218983126, 133222518, 130928774},
[9015]={854702, 502446, 518830, 1116846, 1067694},
[9019]={34042089350, 56116711566, 56060088462, 128831030, 128437934, 210816742, 130928278, 225496806, 854806, 1117350, 131124958, 231787158, 129027814, 519310, 510758},
[9023]={56066363030, 33505167702, 56116701510, 55516712734, 56108279878, 54980036806, 56066328726, 56057972942, 53906294982, 33505200326, 56110402926, 56108304550, 1117326, 519190, 229494918},
[9027]={219203654, 219008502, 502806, 853646, 519150, 510646, 1116806, 1067686, 896014, 903982, 1100454},
[9031]={218999342, 500798, 828078, 508470, 901806, 1073718, 467510, 1097934, 819766, 1106486, 870118, 516302, 1114318, 836150, 860726},
[9035]={132974870, 219007158, 130879030, 219220526, 1066950, 501382, 895078, 830510, 1076270, 517766, 1116142, 904238, 511022, 853238, 1099742, 1107934},
[9039]={56057980926, 32968100046, 519206, 903262, 128756270, 853638, 128821766, 120039614, 129001510, 129034398, 128796830, 1116798, 1066926, 510046, 1100806},
[9043]={132974790, 219007222, 34054670758, 32968126006, 56057940030, 33505208510, 53906294982, 54442944862, 219222206, 56097785902, 32968093158, 33502857566, 56110410046, 56059882238, 53906090686},
[9059]={128780326, 219220006, 219170854, 132974638, 219007222, 130878950, 219205190, 894942, 1099742, 501366, 518102, 1115766, 853462, 829006, 1075142},
[9063]={853982, 517862, 501366, 1067086, 509910, 1075158, 468950, 821206, 1099342, 1107566, 903126, 837230, 886742, 894582, 1115766},
[9067]={132976094, 130878934, 34054672358, 219205110, 33419022166, 56108312526, 56064240958, 53906067022, 54442929742, 219221494, 56062134222, 56060071494, 55516884286, 54438726406, 56068467158},
[9071]={853574, 828998, 509510, 1074758, 501798, 518182, 903110, 1067046, 468974, 1100118, 821230, 1107950, 1116502, 837614, 863270},
[9079]={853582, 518110, 1117206, 830126, 509918, 1075166, 903854, 468598, 1099262, 821214, 1107574, 501350, 837238, 861814, 886750},
[9083]={853462, 501358, 517710, 1066614, 1099742, 1107574, 1116126, 870006, 903262, 509550, 468598, 829174, 1074798, 837230, 820846},
[9091]={853598, 509886, 903214, 1075134, 518806, 1067670, 830438, 501694, 895798, 1107550, 1116822, 838334, 886478, 1026750, 468606},
[9095]={128780334, 132974638, 130878950, 219007214, 829046, 1074806, 468558, 820814, 837198, 862166, 878158, 886350, 894934, 1025614, 1066574},
[9099]={32968347038, 56064264390, 34041851798, 32961793454, 53906312862, 33505200326, 32968134302, 56060086478, 34042071822, 56064282014, 32880004526, 56060070094, 56066379958, 32882102422, 32968124998},
[9107]={853582, 1100462, 502446, 518830, 1116846, 1067694, 509998, 829406, 1075846, 903134, 469518, 822214, 1107854, 837518, 862774},
[9111]={854102, 516662, 501318, 1066606, 1107526, 902862, 1116838, 1099734, 509558, 468550, 837190, 1025606, 1074798, 878198, 869998},
[9115]={54443134262, 133025926, 32880266574, 854726, 34054656134, 32980930542, 32882347574, 33517801286, 34048167830, 32980880718, 59337936942, 32880053622, 34054672518, 32980914158, 32882151286},
[9119]={132974638, 219170862, 219007214, 128780334, 130879070, 468958, 837598, 878558, 894582, 1107534, 1115766, 870006, 1074806, 845430, 1025654},
[9127]={219221606, 219171014, 132974798, 130877982, 218983006, 218966622, 218999390, 219213846, 219130614, 219179726, 219203710, 829046, 502822, 904206, 822286},
[9131]={128780950, 219222070, 132976694, 219203734, 219007526, 210571470, 130878214, 518126, 1116862, 502822, 1099766, 904342, 853598, 1066990, 830614},
[9135]={132974638, 128780326, 219222014, 219008662, 219203630, 130877654, 212668022, 219179254, 902902, 128994886, 212913638, 129026094, 128757318, 853582, 1116870, 518126},
[9139]={128780326, 132976574, 219222126, 130878062, 219205630, 829046, 1074806, 468558, 820846, 837230, 845430, 861814, 878158, 886382, 894574},
[9143]={853638, 502422, 518846, 509534, 829062, 1074782, 469614, 821870, 838254, 879214, 887406, 895278, 1026670, 1065974, 1100078},
[9147]={853622, 502446, 830126, 509918, 1075166, 467878, 516670, 820134, 836518, 846150, 862534, 877118, 885670, 893862, 1024934},
[9151]={32880003310, 32968132606, 32961792238, 1117158, 519182, 852854, 502398, 1075190, 468582, 820878, 837262, 862918, 879302, 886774, 894966},
[9155]={852542, 501366, 517710, 879278, 1026734, 1066574, 1099382, 1115766, 837238, 903878, 510662, 820854, 887470, 829046, 1074766},
[9167]={854702, 1116846, 903982, 518854, 1100486, 511014},
[9171]={852542, 502766, 518110, 1068014, 1100462, 1116870, 821934, 1108654, 838318, 878198, 1075878, 904342, 510662, 830150, 469670},
[9175]={519190, 852534, 830126, 509558, 1074806, 501246, 1066494, 1099022, 1115646, 468598, 820854, 837238, 845430, 861814, 878198},
[9187]={219007214, 830126, 510638, 1074806, 1100462, 1116990, 518854, 821934, 1108774, 502926, 1067718, 838318, 887590, 879278, 1026734},
[9191]={32968345806, 518950, 1067694, 1100462, 903982, 853942, 1117206, 502590, 829006, 510638, 1108678, 895806, 1076030, 879422, 1026758},
[9195]={128781894, 219205182, 132976574, 219008662, 1117206, 879278, 519190, 502438, 1100822, 853582, 1067694, 510662, 830254, 1076014, 863246},
[9199]={128780334, 219205062, 219221446, 132976078, 216862182, 218984006, 219000390, 218967622, 219007222, 130879094, 1067694, 1116990, 1100582, 903846, 502446},
[9203]={130879214, 128445894, 219172302, 129001518, 219222078, 128757198, 219205574, 128822854, 216862182, 128747566, 218984486, 129034286, 218967622, 129044414, 219017134},
[9207]={132976078, 128781798, 219222014, 130879502, 273748086, 284233366, 853622, 904342, 518822, 1066638, 510046, 1117198},
[9211]={128779014, 218997390, 132974630, 130877654, 212666582, 219008582, 219221574, 219205182, 219179254, 219170862, 216862182, 214765294, 219213486, 219129902, 120391718},
[9215]={855062, 1117326, 519190, 1100822, 904342, 511126, 830614, 502438},
[9219]={853614, 128829678, 131141758, 128755950, 130542302, 133238902, 129027654, 130920574, 131125374, 128437902, 902902, 511126},
[9223]={32968132678, 34041874310, 32880004662, 56066328502, 32882101814, 32968297958, 517750, 1067694, 903982, 852526, 1100582, 1107534, 837198, 895622, 1115846},
[9227]={853622, 501366, 518830, 1116846, 510662, 1075910, 1067694, 904238, 469702, 821958, 1100590, 1108798, 830254},
[9231]={219222054, 219009142, 219205190, 32968108230, 32965987086, 32959696526, 519214, 1100846, 1116870, 904342, 852542, 830510, 511022, 1076270, 895806},
[9235]={219007606, 128780358, 219221574, 130879502, 130543550, 128438294, 854702, 275828750, 212881494, 904342, 133230526, 229707774, 212684926, 210817038, 273707006},
[9239]={128780334, 219007214, 130877694, 132975134, 219220574, 219203630, 128436462, 282136686, 133222414, 131141278, 128446454, 130543782, 133238958, 853622, 212889766, 903270},
[9243]={128780326, 132974630, 130878062, 219221574, 219203630, 212666990, 216862182, 219179606, 219000390, 219171422, 219211822, 902902, 129026086, 133188206, 129044030},
[9247]={852534, 510630, 830126, 1075878, 903854, 500758, 1100814, 518102, 896134, 1116118, 1068046, 821926, 1108646, 1027086, 468982},
[9251]={32961792318, 32968345798, 32968329414, 517750, 1067654, 511022, 1108678, 1076270, 912046, 904238, 1115766, 1099382, 853222, 501366, 468558, 820854},
[8743]={219171422, 132974630, 130877654, 219007062, 128780358, 219179094, 219221574, 837198, 878158, 894582, 1025614, 1107534, 468558, 501326, 517710},
[9255]={32968132486, 32880002990, 852542, 1116990, 517774, 1066638, 1100782, 896142, 830238, 1076238, 1109006, 511126, 904342, 501390, 469102, 1026038},
[8747]={853598, 518246, 1116262, 509654, 829502, 1074902, 468694, 501342, 820950, 837214, 845526, 861910, 878174, 886486, 894558},
[8755]={56057981246, 56066336846, 54442969070, 56064272702, 56057776086, 56066369454, 518102, 509566, 1107526, 902862, 852494, 468710, 1066686, 820966, 1099694},
[8759]={853582, 829046, 509550, 1074798, 902766, 518246, 1117342, 1067110, 467510, 1098294, 1106486, 820846, 500278, 836150, 893854},
[8763]={853622, 501366, 510998, 904230, 1076206, 829398, 468950, 1100094, 821206, 1107926, 516662, 1114806, 837590, 862174, 886742},
[9275]={128780326, 132974638, 219221566, 219172414, 219205182, 130877654, 129035750, 133230150, 282136038, 128755758, 133189190, 129001518, 133238718, 120041030, 128765414},
}