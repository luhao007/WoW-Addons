local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local match = _G.string.match
local Fun = addonTable.Fun
-------------
--LFG副本信息
function Fun.PIG_GetCategories(baseFilters)
	local data={}
	local categories = C_LFGList.GetAvailableCategories(baseFilters);
	for i=1, #categories do
		local categoryID=categories[i]
		local CategoryInfo= C_LFGList.GetLfgCategoryInfo(categoryID)
		local renwuname=CategoryInfo.name:match(QUESTS_LABEL)
		if renwuname then CategoryInfo.name=QUESTS_LABEL end
		table.insert(data, {categoryID,CategoryInfo.name})
	end
	return data
end
--排序
local function ActivitySortComparator(lhs, rhs)
    local lhsMax = lhs[4]
    local rhsMax = rhs[4]
    if lhsMax ~= rhsMax then
        if lhsMax == 0 then
            return false
        elseif rhsMax == 0 then
            return true
        end
        return lhsMax < rhsMax
    end
    local lhsMin = lhs[3]
    local rhsMin = rhs[3]
    if lhsMin ~= rhsMin then
        return lhsMin < rhsMin
    end
    return false
end
local function PIG_GetActivityGroupInfo(groupID)
	local name = C_LFGList.GetActivityGroupInfo(groupID) or ""
	return name:gsub("Raids",RAIDS)
end
local FiltersDiy = {[4]="PvE",[8]="PvP"}
local function IsBaseFilters(fullName,baseFilters)
	if FiltersDiy[baseFilters] and fullName:match(FiltersDiy[baseFilters]) then
		return true
	end
	return false
end
Fun.IsBaseFilters=IsBaseFilters
function Fun.PIG_GetGroups(categoryID,baseFilters)
	local data={{},{},{},{}}
	if PIG_MaxTocversion(50000) then
		--活动类型(地下城2/团队114/任务和地图116/PVP118/自定义120)
		local groups = C_LFGList.GetAvailableActivityGroups(categoryID);
		if categoryID==120 then
			local activityInfo= C_LFGList.GetActivityInfoTable(1064)
			table.insert(data[2],{1064,activityInfo.fullName,activityInfo.minLevelSuggestion,activityInfo.maxLevelSuggestion})
		else
			for groupIndex = 1, #groups do
				local groupID = groups[groupIndex];
				if not data[2][groupID] then
					local groupName = PIG_GetActivityGroupInfo(groupID)
					table.insert(data[1],{groupID,groupName})
					data[2][groupID]={}
				end
				local activities = C_LFGList.GetAvailableActivities(categoryID,groupID)
				for ii=1,#activities,1 do
					local activityID=activities[ii]
					local activityInfo= C_LFGList.GetActivityInfoTable(activityID)
					table.insert(data[2][groupID],{activityID,activityInfo.fullName,activityInfo.minLevelSuggestion,activityInfo.maxLevelSuggestion})
					if categoryID==2 or categoryID==114 then
						if not data[4][activityInfo.difficultyID] then
							local DifficultyName = PIG_GetDifficultyInfo(activityInfo.difficultyID) or NONE
							data[4][activityInfo.difficultyID]={activityInfo.difficultyID,DifficultyName}
						end
					else

					end
				end
				table.sort(data[2][groupID], ActivitySortComparator)
			end
			for k,v in pairs(data[4]) do
				table.insert(data[3],v)
			end
			-- table.sort(data[3], function(a, b)
			--     return a[1] < b[1]
			-- end)
		end
	else
		--活动类型(任务1/地下城2/团队3/竞技场4/自定义6/竞技场练习赛7/战场8/评级战场9/海岛探险111/121地下堡)
		local activities = C_LFGList.GetAvailableActivities(categoryID);
		for ii=1,#activities do
			local activityID=activities[ii]
			local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
			if categoryID==1 then
				if not data[2][activityInfo.groupFinderActivityGroupID] then
					local groupName, groupOrderIndex = C_LFGList.GetActivityGroupInfo(activityInfo.groupFinderActivityGroupID);
					table.insert(data[1],{activityInfo.groupFinderActivityGroupID,groupName})
					data[2][activityInfo.groupFinderActivityGroupID]={}
				end
				table.insert(data[2][activityInfo.groupFinderActivityGroupID], {activityID,activityInfo.fullName,activityInfo.shortName})
			elseif categoryID==2 or categoryID==3 then
				if not data[2][activityInfo.difficultyID] then
					local DifficultyName = PIG_GetDifficultyInfo(activityInfo.difficultyID) or NONE
					table.insert(data[1],{activityInfo.difficultyID,DifficultyName})
					data[2][activityInfo.difficultyID]={}
				end
				table.insert(data[2][activityInfo.difficultyID], {activityID,activityInfo.fullName,activityInfo.shortName})
			elseif categoryID==6 or categoryID==121 then--自定义6/121地下堡
				if categoryID==6 then
					if baseFilters==4 or baseFilters==8 then
						if IsBaseFilters(activityInfo.fullName,baseFilters) then
							table.insert(data[2], {activityID,activityInfo.fullName,activityInfo.shortName})
						end
					else
						table.insert(data[2], {activityID,activityInfo.fullName,activityInfo.shortName})
					end
				else
					table.insert(data[2], {activityID,activityInfo.fullName,activityInfo.shortName})
				end
			else--if categoryID==4 or categoryID==7 then
				table.insert(data[2], {activityID,activityInfo.fullName,activityInfo.shortName})
			end
		end
		if #data[1]>0 then
			for diffID, group in pairs(data[2]) do
				table.sort(group, function(a, b)
					return a[1] < b[1]  --按activityID升序
				end)
			end
		end
	end
	return data[1],data[2],data[3]
end
function Fun.GetGroupName(selectedGroup,Groups)
	for Gid=1,#Groups do
		if selectedGroup==Groups[Gid][1] then
			return Groups[Gid][2]
		end
	end
	return NONE
end
function Fun.GetactivityName(selectedActivity,activities)
	for Gid=1,#activities do
		if selectedActivity==activities[Gid][1] then
			return activities[Gid][2]
		end
	end
	return NONE
end
function Fun.IsAvailGroups(activityID,Groups,Radio)
	if Radio then
		for i=1,#Groups do
			if activityID[Groups[i][1]] then
				return true
			end
		end
	else
		for i=1,#Groups do
			if Groups[i][1]==activityID then
				return true
			end
		end
	end
	return false
end
---
for i=1,10000 do
	local InfoTable=C_LFGList.GetActivityInfoTable(i)
	if InfoTable and InfoTable.fullName:match("永恒之眼") then
		--print(i,InfoTable.fullName)
		-- for k,v in pairs(InfoTable) do
		-- 	print(i,k,v)
		-- end
	end
end

--获取队伍等级
local is_slist=Fun.is_slist
function Fun.Get_GroupLv()
	if is_slist() then return "G#0#0#0#0";end
	local MsgNr="";
	if IsInRaid() then
		MsgNr = "R#40#"..GetNumGroupMembers()
	elseif IsInGroup() then
		MsgNr="G#"
		for id = 1, MAX_PARTY_MEMBERS, 1 do
			if UnitExists("Party"..id) then
				local dengjiKk = UnitLevel("Party"..id)
				if id==numgroup then
					MsgNr=MsgNr..dengjiKk
				else
					MsgNr=MsgNr..dengjiKk.."#";
				end
			else
				if id==numgroup then
					MsgNr=MsgNr.."-"
				else
					MsgNr=MsgNr.."-".."#";
				end
			end
		end
	else
		MsgNr="G#-#-#-#-";
	end
	return MsgNr
end
function Fun.Get_GroupLvTxt()
	if is_slist() then return Fun.Base64_decod("LOmYn+WGhSgwLDAsMCwwKQ=="); end
	if IsInRaid() then
		local numgroup =GetNumGroupMembers()
		if numgroup>0 then
			local MsgNr=",队内("
			for id=2,numgroup do
				local name, rank, subgroup, dengjiKk = GetRaidRosterInfo(id)
				if name and PIGA_Per["Farm"]["Other_RaidMode"] and PIGA_Per["Farm"]["Other_RaidModeShow"][subgroup] then
					MsgNr=MsgNr..dengjiKk..",";
				end
			end
			MsgNr=MsgNr..")";
			return MsgNr
		end
	elseif IsInGroup() then
		local numgroup = GetNumSubgroupMembers()
		if numgroup>0 then
			local MsgNr=",队内("
			for id=1,numgroup do
				local dengjiKk = UnitLevel("Party"..id);
				if id==numgroup then
					MsgNr=MsgNr..dengjiKk..")";
				else
					MsgNr=MsgNr..dengjiKk..",";
				end
			end
			return MsgNr
		end
	end
	return ""
end
local function IsdanjiaOK(fubenID,danjiaCF)
	if danjiaCF[fubenID] then
		local hangD=danjiaCF[fubenID]
		for id = 1, 4, 1 do
			if hangD[id][1]>0 and hangD[id][2]>0 then
				return danjiaCF[fubenID]
			end
		end
	end
	return false
end
--根据等级计算单价
function Fun.Get_LvDanjia(lv,fubenID,danjiaCF)
	if lv==0 then return 0 end
	if is_slist() then return 0 end
	local hangD = IsdanjiaOK(fubenID,danjiaCF)
	if hangD then
		for id = 1, 4, 1 do
			local SavetG = hangD[id]
			if SavetG[1]>0 and SavetG[2]>0 then
				if lv>=SavetG[1] and lv<=SavetG[2] then
					return SavetG[3]
				end
			end
		end
	end
	return 0
end
--获取所带副本级别单价文本
function Fun.Get_LvDanjiaYC(fubenID,danjiaCF)
	if is_slist() then return "-" end
	local hangD = IsdanjiaOK(fubenID,danjiaCF)
	if hangD then
		local MsgNr = ""
		for id = 1, 4, 1 do
			local SavetG = hangD[id]
			if SavetG[1]>0 and SavetG[2]>0 then
				MsgNr=MsgNr..SavetG[1].."@"..SavetG[2].."@"..SavetG[3].."#"
			end
		end
		local MsgNr = MsgNr:sub(1,-2)
		return MsgNr
	end
	return "-"
end
function Fun.Get_LvDanjiaTxt(fubenID,danjiaCF)
	if is_slist() then
		return Fun.Base64_decod("PDEtODA+5YWN6LS5")
	end
	local MsgNr = ""
	local hangD = IsdanjiaOK(fubenID,danjiaCF)
	if hangD then
		for id = 1, 4, 1 do
			local SavetG = hangD[id]
			if SavetG[1]>0 and SavetG[2]>0 then
				if SavetG[3]>0 then
					MsgNr=MsgNr.."<"..SavetG[1].."-"..SavetG[2]..">"..SavetG[3].."G"
				else
					MsgNr=MsgNr.."<"..SavetG[1].."-"..SavetG[2]..">"..Fun.Base64_decod("5YWN6LS5")
				end
			end
		end
	end
	return MsgNr
end
--获取设置的最小和最大级别
local function Get_LVminmax(fubenID,danjiaCF)
	if is_slist() then return 0,0 end
	local min,max = nil,nil
	local hangD = IsdanjiaOK(fubenID,danjiaCF)
	if hangD then
		for id = 1, 4, 1 do
			local SavetG = hangD[id]
			if SavetG[1]>0 and SavetG[2]>0 then
				if min then
					if SavetG[1]<min then
						min=SavetG[1]
					end
				else
					min=SavetG[1]
				end
				if max then
					if SavetG[2]>max then
						max=SavetG[2]
					end
				else
					max=SavetG[2]
				end
			end
		end
	end
	return min or 0,max or 0	
end
function Fun.Get_LVminmaxTxt(fubenID,danjiaCF)
	local min,max = Get_LVminmax(fubenID,danjiaCF)
	return min.."#"..max
end