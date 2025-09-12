local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.Chedui(Activate)
	if not PIGA["Tardis"]["Chedui"]["Open"] then return end
	local Create, Data, Fun, L= unpack(PIG)
	local PIGFrame=Create.PIGFrame
	local PIGButton = Create.PIGButton
	local PIGFontString=Create.PIGFontString
	local PIGLine=Create.PIGLine
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local PIGOptionsList_R=Create.PIGOptionsList_R
	-- 
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local hang_Height=InvF.hang_Height
	local RolesName = {"TANK","HEALER", "DAMAGER"}
	local RolesIcon = {"ui-lfg-roleicon-tank-micro-raid","ui-lfg-roleicon-healer-micro-raid","ui-lfg-roleicon-dps-micro-raid"}
	local RolesNameIcon = {["TANK"]=RolesIcon[1],["HEALER"]=RolesIcon[2], ["DAMAGER"]=RolesIcon[3]}
	local lfgroleicon = {"ui-lfg-roleicon-tank-micro","ui-lfg-roleicon-healer-micro","ui-lfg-roleicon-dps-micro"}
	local lfgroleNameIcon = {["TANK"]=lfgroleicon[1],["HEALER"]=lfgroleicon[2], ["DAMAGER"]=lfgroleicon[3]}
	if C_LFGList.GetPremadeGroupFinderStyle()==2 then
		RolesIcon[1],RolesIcon[2],RolesIcon[3] = "groupfinder-icon-role-micro-tank","groupfinder-icon-role-micro-heal","groupfinder-icon-role-micro-dps"
		RolesNameIcon["TANK"]=RolesIcon[1]
		RolesNameIcon["HEALER"]=RolesIcon[2]
		RolesNameIcon["DAMAGER"]=RolesIcon[3]
	end
	InvF.RolesName=RolesName
	InvF.RolesNameIcon=RolesNameIcon
	InvF.lfgroleNameIcon=lfgroleNameIcon
	local ClassesName = {}
	local cl_Name=Data.cl_Name
	for i=1,#cl_Name do
		table.insert(ClassesName,cl_Name[i][1])
	end
	---------
	local fujiF,fujiTabBut=PIGOptionsList_R(InvF.F,LFG_LIST_ACTIVITY,80,"Bot")
	if Activate then
		fujiF:Show()
		fujiTabBut:Selected()
	end
	fujiF.F=PIGOptionsList_RF(fujiF,28,nil,{4,4,4})
	fujiF.F:PIGSetBackdrop()
	--人员详情提示
	local tishikWW,Enter_Height,ClassesNum = 162,18,#ClassesName
	fujiF.F.EnterF = PIGFrame(fujiF.F);
	fujiF.F.EnterF:PIGSetBackdrop(1)
	fujiF.F.EnterF:SetClampedToScreen(true)
	fujiF.F.EnterF:SetSize(tishikWW*3-2,ClassesNum*Enter_Height+60);
	fujiF.F.EnterF:SetFrameLevel(fujiF.F:GetFrameLevel()+10)	
	fujiF.F.EnterF:Hide()
	fujiF.F.EnterF:HookScript("OnEnter", function (self)
		self:Show()
	end);
	fujiF.F.EnterF:HookScript("OnLeave", function (self)
		self:Hide()
	end);
	fujiF.F.EnterF.errtishi = CreateFrame("Frame", nil, fujiF.F.EnterF);
	fujiF.F.EnterF.errtishi:SetPoint("TOPLEFT", fujiF.F.EnterF, "TOPLEFT", 0, -100);
	fujiF.F.EnterF.errtishi:SetPoint("TOPRIGHT", fujiF.F.EnterF, "TOPRIGHT", 0, -100);
	fujiF.F.EnterF.errtishi:SetHeight(20)
	fujiF.F.EnterF.errtishi:SetFrameLevel(fujiF.F.EnterF:GetFrameLevel()+6)
	fujiF.F.EnterF.errtishi.t=PIGFontString(fujiF.F.EnterF.errtishi,{"CENTER", fujiF.F.EnterF.errtishi, "CENTER", 0,0},LFG_LIST_ENTRY_DELISTED,"OUTLINE");
	fujiF.F.EnterF.errtishi.t:SetTextColor(1,0,0,1);

	fujiF.F.EnterF.RoleTab={}
	for ix=1,#RolesName do
		local RoleF = PIGFrame(fujiF.F.EnterF,nil,{tishikWW,ClassesNum*Enter_Height+60});
		RoleF:PIGSetBackdrop(1)
		fujiF.F.EnterF.RoleTab[ix]=RoleF
		if ix==1 then
			RoleF:SetPoint("TOPLEFT", fujiF.F.EnterF, "TOPLEFT", 0, 0);
		else
			RoleF:SetPoint("TOPLEFT", fujiF.F.EnterF.RoleTab[ix-1], "TOPRIGHT", -1, 0);
		end
		RoleF.icon = RoleF:CreateTexture();
		RoleF.icon:SetAtlas(lfgroleicon[ix]);
		RoleF.icon:SetSize(hang_Height,hang_Height);
		RoleF.icon:SetPoint("TOP", RoleF, "TOP", -6,-2);
		RoleF.heji = PIGFontString(RoleF,{"LEFT", RoleF.icon, "RIGHT",0, 0},0,"OUTLINE");
		RoleF.NR = PIGFrame(fujiF.F.EnterF);
		RoleF.NR:PIGSetBackdrop(1)
		RoleF.NR:SetPoint("TOPLEFT", RoleF, "TOPLEFT", 0, -28);
		RoleF.NR:SetPoint("BOTTOMRIGHT", RoleF, "BOTTOMRIGHT", 0, 0);
		RoleF.classList={}
		for class=1,ClassesNum do
			local tishizhiye = CreateFrame("Frame", nil, RoleF.NR);
			RoleF.classList[class]=tishizhiye
			tishizhiye:SetSize(36,Enter_Height);
			if class==1 then
				tishizhiye:SetPoint("TOPLEFT", RoleF.NR, "TOPLEFT", 2,-2);
			else
				tishizhiye:SetPoint("TOPLEFT", RoleF.classList[class-1], "BOTTOMLEFT", 0,-3);
			end
			tishizhiye.icon = tishizhiye:CreateTexture();
			tishizhiye.icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			tishizhiye.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[ClassesName[class]]));
			tishizhiye.icon:SetSize(Enter_Height,Enter_Height);
			tishizhiye.icon:SetPoint("LEFT", tishizhiye, "LEFT", 15,0);
			tishizhiye.heji = PIGFontString(tishizhiye,{"RIGHT", tishizhiye.icon, "LEFT",1, 0},0,"OUTLINE");
			tishizhiye.heji:SetTextColor(1, 1, 1, 1);
		end
		RoleF.playerList={}
		for pp=1,40 do
			local playerBut = CreateFrame("Frame",nil,RoleF.NR)
			playerBut:SetSize(1,Enter_Height);
			RoleF.playerList[pp]=playerBut
			if pp==1 then
				playerBut:SetPoint("TOPLEFT", RoleF.NR, "TOPLEFT", 40,-2);
			else
				playerBut:SetPoint("TOPLEFT", RoleF.playerList[pp-1], "BOTTOMLEFT", 0,0);
			end
			playerBut.Class = playerBut:CreateTexture();
			playerBut.Class:SetTexture("Interface/TargetingFrame/UI-Classes-Circles")
			playerBut.Class:SetPoint("LEFT", playerBut, "LEFT", 0,0);
			playerBut.Class:SetSize(Enter_Height-1,Enter_Height-1);
			playerBut.Class:SetAlpha(0.9);
			playerBut.name = PIGFontString(playerBut,{"LEFT", playerBut.Class, "RIGHT",0, 0},nil,"OUTLINE",13);
			playerBut.name:SetJustifyH("LEFT");
		end
	end	
	fujiF.F.EnterF.roleData={}
	local function PIG_GetGroupMemberCountsForDisplay(roleData)
		local displayData = GetGroupMemberCountsForDisplay()
		displayData.classesByRole={}
		for RoleID=1,#RolesName do
			displayData.classesByRole[RolesName[RoleID]]={}
		end
		for p=1,MAX_RAID_MEMBERS do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
			if name then
				if roleData then table.insert(roleData[combatRole],{fileName,name,level}) end
				displayData.classesByRole[combatRole][fileName]=displayData.classesByRole[combatRole][fileName] or 0
				displayData.classesByRole[combatRole][fileName]=displayData.classesByRole[combatRole][fileName]+1
			end
		end
		return displayData
	end
	function fujiF.F.EnterF:Update_PlayersList(hangUI,ADD)
		local hangF=hangUI:GetParent()
		self:ClearAllPoints();
		if hangUI.ADD then
			self:SetPoint("TOPLEFT", hangUI, "BOTTOMLEFT", -100,-4);
		else
			self:SetPoint("RIGHT", hangUI, "LEFT", -2,0);
		end
		self:Show()
		self.errtishi:Hide();
		self.NewHNUM=0
		for ix=1,#RolesName do
			local RoleF=self.RoleTab[ix]
			RoleF.NR:Show()
			RoleF.icon:SetDesaturated(true)
			RoleF.heji:SetTextColor(0.5, 0.5, 0.5, 1);
			RoleF.heji:SetText(0);
			for class=1,#ClassesName do
				RoleF.classList[class].icon:SetDesaturated(true)
				RoleF.classList[class].heji:SetTextColor(0.5, 0.5, 0.5, 1);
				RoleF.classList[class].heji:SetText(0);
			end
			for pp=1,40 do
				RoleF.playerList[pp]:Hide()
			end
		end
		wipe(self.roleData)
		for RoleID=1,#RolesName do
			self.roleData[RolesName[RoleID]]={}
		end
		if hangUI.ADD then
			if not C_LFGList.HasActiveEntryInfo() then return end
			local displayData=PIG_GetGroupMemberCountsForDisplay(self.roleData)
			for ix=1,#RolesName do
				if displayData[RolesName[ix]]>0 then
					local RoleF=self.RoleTab[ix]
					RoleF.icon:SetDesaturated(false)
					RoleF.heji:SetTextColor(1, 1, 1, 1);
					RoleF.heji:SetText(displayData[RolesName[ix]]);
					for class=1,#ClassesName do
						if displayData.classesByRole[RolesName[ix]][ClassesName[class]] and displayData.classesByRole[RolesName[ix]][ClassesName[class]]>0 then
							RoleF.classList[class].icon:SetDesaturated(false)
							RoleF.classList[class].heji:SetTextColor(1, 1, 1, 1);
							RoleF.classList[class].heji:SetText(displayData.classesByRole[RolesName[ix]][ClassesName[class]]);
						end
					end
					for pp=1,#self.roleData[RolesName[ix]] do
						local playerBut=RoleF.playerList[pp]
						playerBut:Show()
						playerBut.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[self.roleData[RolesName[ix]][pp][1]]));
						local getname=self.roleData[RolesName[ix]][pp][2] or UNKNOWNOBJECT
						playerBut.name:SetText("("..self.roleData[RolesName[ix]][pp][3]..")"..getname);
						local color = PIG_CLASS_COLORS[self.roleData[RolesName[ix]][pp][1]];
						playerBut.name:SetTextColor(color.r, color.g, color.b, 1);
					end
				end
			end
		else
			local resultID=hangF.resultID
			local searchResultInfo=C_LFGList.GetSearchResultInfo(resultID)
			if not searchResultInfo or searchResultInfo.isDelisted then
				self.errtishi:Show();
				for ix=1,#RolesName do
					self.RoleTab[ix].NR:Hide()
				end
			else
				local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
				for ix=1, searchResultInfo.numMembers do
					local memberInfo = C_LFGList.GetSearchResultPlayerInfo(resultID, ix);
					table.insert(self.roleData[memberInfo.assignedRole],{memberInfo.classFilename,memberInfo.name,memberInfo.level})
				end
				for ix=1,#RolesName do
					if displayData[RolesName[ix]]>0 then
						local RoleF=self.RoleTab[ix]
						RoleF.icon:SetDesaturated(false)
						RoleF.heji:SetTextColor(1, 1, 1, 1);
						RoleF.heji:SetText(displayData[RolesName[ix]]);
						for class=1,#ClassesName do
							if displayData.classesByRole[RolesName[ix]][ClassesName[class]]>0 then
								RoleF.classList[class].icon:SetDesaturated(false)
								RoleF.classList[class].heji:SetTextColor(1, 1, 1, 1);
								RoleF.classList[class].heji:SetText(displayData.classesByRole[RolesName[ix]][ClassesName[class]]);
							end
						end
						if #self.roleData[RolesName[ix]]>self.NewHNUM then
							self.NewHNUM=#self.roleData[RolesName[ix]]
						end
						for pp=1,#self.roleData[RolesName[ix]] do
							local playerBut=RoleF.playerList[pp]
							playerBut:Show()
							playerBut.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[self.roleData[RolesName[ix]][pp][1]]));
							local getname=self.roleData[RolesName[ix]][pp][2] or UNKNOWNOBJECT
							playerBut.name:SetText("("..self.roleData[RolesName[ix]][pp][3]..")"..getname);
							local color = PIG_CLASS_COLORS[self.roleData[RolesName[ix]][pp][1]];
							playerBut.name:SetTextColor(color.r, color.g, color.b, 1);
						end
					end
				end
			end
		end
		local NewHNhhhh=self.NewHNUM*Enter_Height+36
		if NewHNhhhh>ClassesNum*Enter_Height+60 then
			fujiF.F.EnterF:SetHeight(NewHNhhhh);
			for ix=1,#fujiF.F.EnterF.RoleTab do
				fujiF.F.EnterF.RoleTab[ix]:SetHeight(NewHNhhhh);
			end
		else
			fujiF.F.EnterF:SetHeight(ClassesNum*Enter_Height+60);
		end
	end
	----
	InvF.ActTypeFilters={}
	InvF.FilterData3={}
	fujiF.F.CategorieCC=0
	local function GetCategorieData()
		local listD,nameD={},{}
		local cunzail = C_LFGList.GetAvailableCategories()
		if #cunzail==0 and fujiF.F.CategorieCC<5 then
			fujiF.F.CategorieCC=fujiF.F.CategorieCC+1
			C_Timer.After(0.1,function() GetCategorieData() end)
		else
			--系统活动类型(地下城2/团队114/任务和地图116/PVP118/自定义120){{DUNGEONS,2},{GUILD_INTEREST_RAID,114},{OTHER,120}}--活动类型
			--local baseFilters = LFGListFrame and LFGListFrame.baseFilters;
			for _,v in pairs(C_LFGList.GetAvailableCategories(baseFilters)) do
				if C_LFGList.GetPremadeGroupFinderStyle()==1 then
					InvF.ActTypeFilters[v]={ALL,"收藏团长"}
					--InvF.FilterData3[v]={{"符合"..LEVEL,90001},{LFG_LIST_NEW_PLAYER_FRIENDLY_HEADER,90002}}
				elseif C_LFGList.GetPremadeGroupFinderStyle()==2 then
					InvF.ActTypeFilters[v]={ALL,L["TARDIS_CHEDUI_1"],L["TARDIS_CHEDUI_2"]}
					---90001-欢迎新手90002-适合当前级别
					InvF.FilterData3[v]={{"符合"..LEVEL,90001},{LFG_LIST_NEW_PLAYER_FRIENDLY_HEADER,90002}}
				end
				local kkdfin= C_LFGList.GetLfgCategoryInfo(v)
				local renwuname=kkdfin.name:match(QUESTS_LABEL)
				if renwuname then
					nameD[kkdfin.name]=QUESTS_LABEL
					kkdfin.name=QUESTS_LABEL
				end
				if kkdfin.name==CUSTOM then
					table.insert(listD,{v,kkdfin.name})
				else
					table.insert(listD,{v,kkdfin.name})
				end
			end
			for i=1,#listD do
				if listD[i][1]==114 then
					table.remove(listD,i);
					table.insert(listD,1,{114,GUILD_INTEREST_RAID})
					break
				end
			end
		end
		return listD,nameD
	end
	--
	function InvF.UpdateLevelColor(Text,minv,maxv,textStr)
		local playerLevel = UnitLevel("player");
		if playerLevel>=minv and playerLevel<=maxv then
			if textStr then
				return "|cffffff00" .. textStr .. "|r"
			else
				Text:SetTextColor(1, 1, 0, 1);
			end
		elseif playerLevel<minv then
			if textStr then
				return "|cffff0000" .. textStr .. "|r"
			else
				Text:SetTextColor(1, 0, 0, 1);
			end
		elseif playerLevel>maxv then
			if textStr then
				return "|cff00ff00" .. textStr .. "|r"
			else
				Text:SetTextColor(0, 1, 0, 1);
			end
		end
	end
	local function PIG_GetActivityGroupInfo(groupID)
		local name = C_LFGList.GetActivityGroupInfo(groupID) or ""
		return name:gsub("Raids",RAIDS)
	end
	local function panduancunzaitongName(heji,name1)
		for i=1,#heji do
			if heji[i][1]==name1 then
				return false
			end
		end
		return true
	end
	--排序
	local function ActivitySortComparator(lhs, rhs)
	    local lhsName, lhsMinLevel, lhsMaxLevel = lhs[1], lhs[3], lhs[4]
	    local rhsName, rhsMinLevel, rhsMaxLevel = rhs[1], rhs[3], rhs[4]
	    if lhsMaxLevel ~= rhsMaxLevel then
	        if lhsMaxLevel == 0 or rhsMaxLevel == 0 then
	            return rhsMaxLevel == 0
	        end
	        return lhsMaxLevel < rhsMaxLevel
	    end
	    if lhsMinLevel ~= rhsMinLevel then
	        return lhsMinLevel < rhsMinLevel
	    end
	    return strcmputf8i(lhsName, rhsName) > 0
	end
	function InvF.GetActivities(Ndata,selectedCategory,group)
		wipe(Ndata)
		if selectedCategory then
			Ndata.groups={}
			Ndata.Activs={}
			local ActivityGroups = C_LFGList.GetAvailableActivityGroups(selectedCategory)
			for i=1,#ActivityGroups,1 do
				local groupID = ActivityGroups[i];
				local groupname = PIG_GetActivityGroupInfo(groupID);
				table.insert(Ndata.groups,{groupID,groupname})
				Ndata.Activs[groupID]={}
				local Activities = C_LFGList.GetAvailableActivities(selectedCategory,groupID)
				for ii=1,#Activities,1 do
					local ActivityInfo= C_LFGList.GetActivityInfoTable(Activities[ii])
					if groupID==300 then
						if panduancunzaitongName(Ndata.Activs[groupID],ActivityInfo.fullName) then
							table.insert(Ndata.Activs[groupID],{ActivityInfo.fullName,Activities[ii],ActivityInfo.minLevelSuggestion,ActivityInfo.maxLevelSuggestion})
						end
					else
						table.insert(Ndata.Activs[groupID],{ActivityInfo.fullName,Activities[ii],ActivityInfo.minLevelSuggestion,ActivityInfo.maxLevelSuggestion})
					end
				end
				table.sort(Ndata.Activs[groupID], ActivitySortComparator)
			end
		end
	end
	--显示模式
	local roleHeight,rolejiange=hang_Height*0.8,4
	local function UpdatehangEnter(uix,fujie)
		local fujie=fujie or uix
		uix:HookScript("OnEnter", function ()
			fujie:SetBackdropColor(0.4, 0.4, 0.4, 0.2);
		end);
		uix:HookScript("OnLeave", function ()
			fujie:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
		end);
	end
	InvF.UpdatehangEnter=UpdatehangEnter
	local function addPlayerListBut_1(fujix,index)
		local T = fujix:CreateTexture(nil, "BORDER");
		T:SetSize(roleHeight,roleHeight);
		T:SetPoint("BOTTOMLEFT", fujix, "BOTTOMLEFT", (index-1)*(roleHeight+rolejiange)+2,0);
		local Tjiao = fujix:CreateTexture(nil,"ARTWORK");
		if C_LFGList.GetPremadeGroupFinderStyle()==1 then
			Tjiao:SetSize(hang_Height*0.5,hang_Height*0.5);
		else
			Tjiao:SetSize(hang_Height*0.6,hang_Height*0.6);
		end
		Tjiao:SetPoint("TOPLEFT", T, "TOPLEFT", -3,6);
		return {T,Tjiao}
	end
	local function addPlayerListBut_2(fujik,roleid)		
		local T = fujik:CreateTexture();
		T:SetAtlas(lfgroleicon[roleid]);
		T:SetSize(roleHeight*1.2,roleHeight*1.2);
		T:SetPoint("LEFT", fujik, "LEFT", (roleid-1)*(roleHeight+18)+20,-1);
		T:SetAlpha(0.9);
		local TNum = PIGFontString(fujik,{"RIGHT", T, "LEFT", 2,1},0,"OUTLINE");
		TNum:SetTextColor(1, 1, 1, 1);
		return {T,TNum}
	end
	local function addPlayerListF(showtype,fujix,xxxoff,ADD)
		local PlayerF = CreateFrame("Frame", nil, fujix);
		PlayerF.ADD=ADD
		PlayerF:SetSize((roleHeight+rolejiange)*4+roleHeight+4,hang_Height);
		if type(xxxoff)=="number" then
			PlayerF:SetPoint("LEFT", fujix, "LEFT", xxxoff, 0);
			UpdatehangEnter(PlayerF,fujix)
		else
			PlayerF:SetPoint(unpack(xxxoff));
		end
		PlayerF.Higt = PlayerF:CreateTexture(nil,"HIGHLIGHT");
		PlayerF.Higt:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
		PlayerF.Higt:SetAllPoints(PlayerF)
		PlayerF.Higt:SetBlendMode("ADD")
		PlayerF.Higt:SetAlpha(0.2)
		PlayerF:HookScript("OnLeave", function()
			fujiF.F.EnterF:Hide()
		end);
		PlayerF:HookScript("OnEnter", function(self)
			fujiF.F.EnterF:Update_PlayersList(self)
		end);
		if showtype=="Enumerate" then
			PlayerF.pBut={}
			for pp=1,5 do
				PlayerF.pBut[pp]=addPlayerListBut_1(PlayerF,pp)
			end
			function PlayerF:Restore_But(Alpha)
				self:Show()
				for pp=1,5 do
					self.pBut[pp][1]:SetTexCoord(0,1,0,1);
					self.pBut[pp][1]:SetAtlas("bags-roundhighlight");
					self.pBut[pp][1]:SetAlpha(Alpha);
					self.pBut[pp][2]:Hide()
				end
			end
			function PlayerF:Delisted_But(isDelisted)
				for pp=1,5 do
					self.pBut[pp][1]:SetDesaturated(isDelisted)
					self.pBut[pp][2]:SetDesaturated(isDelisted)
				end
			end
			function PlayerF:Update_But(displayData,isDelisted)
				local NewdisplayData
				if displayData=="ADD" then
					NewdisplayData=PIG_GetGroupMemberCountsForDisplay()
				else
					NewdisplayData=displayData
				end
				local indexCount = 0
				for roleindex=1,3 do
					if NewdisplayData[RolesName[roleindex]]>0 then
						for class,Count in pairs(NewdisplayData.classesByRole[RolesName[roleindex]]) do
							if Count>0 then
								for ibut=1,Count do
									indexCount=indexCount+1
									self.pBut[indexCount][1]:SetAlpha(1);
									self.pBut[indexCount][1]:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
									self.pBut[indexCount][1]:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]));
									self.pBut[indexCount][2]:Show()
									self.pBut[indexCount][2]:SetAtlas(RolesIcon[roleindex])
									self.pBut[indexCount][1]:SetDesaturated(isDelisted)
									self.pBut[indexCount][2]:SetDesaturated(isDelisted)
								end
							end
						end
					end
				end
			end
		elseif showtype=="Count" then
			PlayerF.rBut={}
			for roleindex=1,3 do
				PlayerF.rBut[roleindex]=addPlayerListBut_2(PlayerF,roleindex)
			end
			function PlayerF:Restore_But()
				self:Show()
				for roleindex=1,3 do
					PlayerF.rBut[roleindex][2]:SetText(0);
				end
			end
			function PlayerF:Update_But(displayData,isDelisted)
				for roleindex=1,3 do
					PlayerF.rBut[roleindex][1]:SetDesaturated(isDelisted)
					PlayerF.rBut[roleindex][2]:SetText(displayData[RolesName[roleindex]]);
				end
			end
		end
		return PlayerF
	end
	local function addPlayerShowMode(fujix,xxxoff,ADD)
		--五人本
		fujix.RoleEnumerate=addPlayerListF("Enumerate",fujix,xxxoff,ADD)
		--职责人数统计
		fujix.RoleCount=addPlayerListF("Count",fujix,xxxoff,ADD)
		function fujix:ShowMode_Restore()
			self.RoleEnumerate:Hide()
			self.RoleCount:Hide()
		end
	end
	InvF.addPlayerShowMode=addPlayerShowMode
	----
	local function SetEditBoxBG(eui,bgui)
		local BGx = eui.BG or bgui
		BGx:PIGSetBackdrop(0,0.8,nil,{0.5, 0.5, 0.5})
		eui:HookScript("OnEditFocusLost", function(self)
			BGx:PIGSetBackdrop(0,0.8,nil,{0.5, 0.5, 0.5})
		end)
		eui:HookScript("OnEditFocusGained", function(self)
			BGx:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
		end);
		eui:SetScript("OnEscapePressed", function(self) 
			self:ClearFocus()
		end);
		eui:SetScript("OnEnterPressed", function(self)
			self:ClearFocus()
		end);
	end
	local function addRoleSetBut_1(fujik,index,roleID,wwhh)
		local butTemplate
		if C_LFGList.GetPremadeGroupFinderStyle()==1 then
			butTemplate="LFGRoleButtonTemplate"
		elseif C_LFGList.GetPremadeGroupFinderStyle()==2 then
			butTemplate="LFGListingRoleButtonTemplate"	
		end
		local RoleBut = CreateFrame("Button",nil,fujik,butTemplate,roleID);
		RoleBut:SetPoint("LEFT",fujik,"LEFT",(index-1)*(wwhh+10),0);
		RoleBut:SetSize(wwhh,wwhh);
		if RoleBut.Background then RoleBut.Background:Hide() end
		RoleBut.checkButton=RoleBut.checkButton or RoleBut.CheckButton
		if index==4 then
			RoleBut.role="GUIDE"
			RoleBut.roleID="GUIDE"
			RoleBut:SetNormalTexture("Interface/LFGFrame/UI-LFG-ICON-ROLES")
			RoleBut:GetNormalTexture():SetTexCoord(GetTexCoordsForRole("GUIDE"));
			RoleBut:SetScript("OnEnter", function(self)
				if ( self.CheckButton:IsEnabled() ) then
					self.CheckButton:LockHighlight();
				end
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetText(LFG_LIST_NEW_PLAYER_FRIENDLY_TOOLTIP, nil, nil, nil, nil, 1);
				GameTooltip:Show();
			end)
		else
			RoleBut.role=RolesName[index]
			RoleBut.roleID=RolesName[index]
			RoleBut:SetNormalAtlas(PIGGetIconForRole(RoleBut.role, false));
		end
		RoleBut.checkButton:SetScript("OnClick", function(self)
			self:Disable();RoleBut:Disable()
			C_Timer.After(1,function() self:Enable() RoleBut:Enable() end)
			local roleFf = self:GetParent()
			if C_LFGList.GetPremadeGroupFinderStyle()==1 then
				local UIroleID=roleFf:GetID()
				local leader, tank, healer, dps = GetLFGRoles();
				local dialog = LFGListCreateRoleDialog
				if dialog.exclusive then
					local setDPS = false;
					local setTank = false;
					local setHealer = false;
					if UIroleID == 1 then
						setDPS = true;
					elseif UIroleID == 2 then
						setTank = true;
					elseif UIroleID == 3 then
						setHealer = true;
					end
					SetLFGRoles(leader, setTank, setHealer, setDPS);
					local _, tank, healer, dps = GetLFGRoles();
					local roleFff = roleFf:GetParent()
					roleFff.T.checkButton:SetChecked(tank);
					roleFff.H.checkButton:SetChecked(healer);
					roleFff.D.checkButton:SetChecked(dps);	
				end
			elseif C_LFGList.GetPremadeGroupFinderStyle()==2 then
				local roles = C_LFGListRoles.GetSavedRoles();
				local UIroleID=roleFf.roleID
				if UIroleID == RolesName[3] then
					if roles.dps then
						roles.dps=false
						self:SetChecked(false);
					else
						roles.dps=true
						self:SetChecked(true);
					end
				elseif UIroleID == RolesName[1] then
					if roles.tank then
						roles.tank=false
						self:SetChecked(false);
					else
						roles.tank=true
						self:SetChecked(true);
					end
				elseif UIroleID == RolesName[2] then
					if roles.healer then
						roles.healer=false
						self:SetChecked(false);
					else
						roles.healer=true
						self:SetChecked(true);
					end
				elseif UIroleID =="GUIDE" then
					if GetCVarBool("lfgNewPlayerFriendly") then
						SetCVar("lfgNewPlayerFriendly", "0");
						self:SetChecked(false);
					else
						SetCVar("lfgNewPlayerFriendly", "1");
						self:SetChecked(true);
					end
				end
				if UIroleID ~="GUIDE" then
					C_LFGListRoles.SetRoles({
						tank   = roles.tank,
						healer = roles.healer,
						dps    = roles.dps,
					});
				end
			end
			fujik:GetParent():ListGroupButton_Update()
		end)
		return RoleBut	
	end
	local function addRoleSetBut(fujik,wwhh,xy,rsnum)
		local Role=PIGFrame(fujik,xy,{(wwhh+wwhh*0.2)*rsnum,wwhh})
		Role.biao=PIGFontString(Role,{"RIGHT",Role,"LEFT",-2,0},"职\n责")
		Role.T = addRoleSetBut_1(Role,1,2,wwhh)
		Role.H = addRoleSetBut_1(Role,2,3,wwhh)
		Role.D = addRoleSetBut_1(Role,3,1,wwhh)
		if rsnum>3 then
			Role.New = addRoleSetBut_1(Role,4,1,wwhh)
		end
		return Role
	end
	InvF.addRoleSetBut=addRoleSetBut
	InvF.SetEditBoxBG=SetEditBoxBG
	-------------
	local TabF,TabBut=PIGOptionsList_R(fujiF.F,"找"..LFG_LIST_ACTIVITY,70)
	--刷新按钮
	TabF.RefreshBut=PIGButton(TabF,{"TOPRIGHT",TabF,"TOPRIGHT",-20,-7},{74,21},REFRESH)
	TabF.RefreshBut:Disable()
	TabF.RefreshBut:HookScript("OnClick", function (self)
		TabF:Update_Search()
	end);
	--重置
	TabF.ResetBut=PIGButton(TabF,{"TOP",TabF.RefreshBut,"BOTTOM",0,-9.6},{74,21},RESET)
	TabF.ResetBut:Disable()
	TabF.ResetBut:HookScript("OnClick", function (self)
		TabF.ResetSearchFilter()
	end);
	local FCTabF,FCTabBut=PIGOptionsList_R(fujiF.F,"我的"..LFG_LIST_ACTIVITY,80)
	--我的车队
	FCTabF.DQ=PIGFrame(FCTabF,{"TOPLEFT",FCTabF,"TOPLEFT",0,0})
	FCTabF.DQ:SetPoint("BOTTOMRIGHT",FCTabF,"BOTTOMRIGHT",0,0);
	FCTabF.DQ.Width=200
	FCTabF.DQ:Hide()
	--创建活动
	FCTabF.ADD=PIGFrame(FCTabF,{"TOPLEFT",FCTabF,"TOPLEFT",0,0})
	FCTabF.ADD:SetPoint("BOTTOMRIGHT",FCTabF,"BOTTOMRIGHT",0,0);
	if PIG_MaxTocversion(20000) then
		FCTabF.ADD.Width=500
	else
		FCTabF.ADD.Width=300
	end
	FCTabF.ADD:Hide()
	if C_LFGList.GetPremadeGroupFinderStyle()==1 then--正式服寻求组队
		if PIG_MaxTocversion(50000) then
			TardisInfo.LFGList(TabF,GetCategorieData,fujiF.F.EnterF)
			TardisInfo.LFGCreation(FCTabF,GetCategorieData,fujiF.F.EnterF)
			MiniMapLFGFrame:HookScript("OnClick", function (self,button)
				if button == "LeftButton" then
					local inBattlefield, showScoreboard = QueueStatus_InActiveBattlefield();
					if ( IsInLFDBattlefield() ) then
						inBattlefield = true;
						showScoreboard = true;
					end
					if ( inBattlefield ) then

						if ( showScoreboard ) then
							TogglePVPScoreboardOrResults();
						end
					else
						local lfgListActiveEntry = C_LFGList.HasActiveEntryInfo();
						if ( lfgListActiveEntry ) then
							if InvF:IsShown() then
								InvF:Hide()
							else
								InvF:Show()
								Create.Show_TabBut_R(InvF.F,fujiF,fujiTabBut)
							end
						else
							PVEFrame_ShowFrame()
							--LFGListUtil_OpenBestWindow(true);
							--local mode = GetLFGMode(LE_LFG_CATEGORY_LFD);
							-- if ( mode == "queued" or mode == "rolecheck" or mode == "proposal" or mode == "suspended" ) then
								--LFGListUtil_OpenBestWindow(true);
							--end
						end
					end
				end
			end);
		end
	elseif C_LFGList.GetPremadeGroupFinderStyle()==2 then--经典寻求组队
		if not C_GameRules.IsHardcoreActive() then return end
		Fun.IsAddOnLoaded("Blizzard_GroupFinder_VanillaStyle",function()
			TardisInfo.LFGList_Vanilla(TabF,GetCategorieData,fujiF.F.EnterF)
			TardisInfo.LFGCreation_Vanilla(FCTabF,GetCategorieData,fujiF.F.EnterF)
			local function LeftClickFun(self,button,Micro)
				if button == "LeftButton" then
					if InvF:IsShown() then
						InvF:Hide()
					else
						InvF:Show()
						Create.Show_TabBut_R(InvF.F,fujiF,fujiTabBut)
					end
					if not Micro then ToggleLFGParentFrame() end
				end
			end
			LFGMinimapFrame:HookScript("OnClick",LeftClickFun);
			if _G["LFGMicroButton"] then _G["LFGMicroButton"].LeftClickFun=LeftClickFun end
		end)
	end
	-----
	fujiF.F:HookScript("OnShow", function (self)
		local EntryInfo = C_LFGList.HasActiveEntryInfo()
		if EntryInfo then
			TabF:Hide()
			TabBut:NotSelected()
			FCTabF:Show()
			FCTabBut:Selected()
		else
			FCTabF:Hide()
			FCTabBut:NotSelected()
			TabF:Show()
			TabBut:Selected()
		end
	end);
end