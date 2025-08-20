local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.Chedui(Activate)
	if not PIGA["Tardis"]["Chedui"]["Open"] then return end
	local Create, Data, Fun, L= unpack(PIG)
	local PIGFrame=Create.PIGFrame
	local PIGFontString=Create.PIGFontString
	local PIGLine=Create.PIGLine
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local PIGOptionsList_R=Create.PIGOptionsList_R
	-- 
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local hang_Height=InvF.hang_Height
	local RolesName = {"TANK","HEALER", "DAMAGER"}
	InvF.RolesName=RolesName
	local ClassesName = {}
	local cl_Name=Data.cl_Name
	for i=1,#cl_Name do
		table.insert(ClassesName,cl_Name[i][1])
	end
	---------
	local fujiF,fujiTabBut=PIGOptionsList_R(InvF.F,L["TARDIS_CHEDUI"],80,"Bot")
	if Activate then
		fujiF:Show()
		fujiTabBut:Selected()
	end
	fujiF.F=PIGOptionsList_RF(fujiF,28,nil,{4,4,4})
	fujiF.F:PIGSetBackdrop()
	--人员详情提示
	local tishikWW,tishikHH,biaotiH = 350,80,20
	fujiF.F.EnterF = PIGFrame(fujiF.F);
	fujiF.F.EnterF:PIGSetBackdrop(1)
	fujiF.F.EnterF:SetSize(tishikWW,tishikHH*3+biaotiH);
	fujiF.F.EnterF:SetFrameLevel(fujiF.F:GetFrameLevel()+10)	
	fujiF.F.EnterF:Hide()
	PIGFontString(fujiF.F.EnterF,{"TOPLEFT", fujiF.F.EnterF, "TOPLEFT", 4,-2},MEMBERS..INFO,"OUTLINE");
	fujiF.F.EnterF.errtishi=PIGFontString(fujiF.F.EnterF,{"CENTER", fujiF.F.EnterF, "CENTER", 0,0},LFG_LIST_ENTRY_DELISTED,"OUTLINE");
	fujiF.F.EnterF.errtishi:SetTextColor(1,0,0,1);
	fujiF.F.EnterF.errtishi:Hide();
	fujiF.F.EnterF.ButList={}
	for ix=1,#RolesName do
		local tishiui = CreateFrame("Frame", nil, fujiF.F.EnterF);
		fujiF.F.EnterF.ButList[ix]=tishiui
		tishiui:SetSize(tishikWW,tishikHH);
		if ix==1 then
			tishiui:SetPoint("TOPLEFT", fujiF.F.EnterF, "TOPLEFT", 0, -biaotiH);
		else
			PIGLine(tishiui,"TOP",-0,nil,nil,{0.2,0.2,0.2,0.5})
			tishiui:SetPoint("TOPLEFT", fujiF.F.EnterF.ButList[ix-1], "BOTTOMLEFT", 0, 0);
		end
		tishiui.ICON = tishiui:CreateTexture();
		tishiui.ICON:SetAtlas(PIGGetIconForRole(RolesName[ix], false), TextureKitConstants.IgnoreAtlasSize);
		tishiui.ICON:SetSize(hang_Height+8,hang_Height+8);
		tishiui.ICON:SetPoint("LEFT", tishiui, "LEFT", 2,10);
		tishiui.heji = PIGFontString(tishiui,{"TOP", tishiui.ICON, "BOTTOM",0, 0},0,"OUTLINE");
		tishiui.ButList={}
		for class=1,#ClassesName do
			local tishizhiye = CreateFrame("Frame", nil, tishiui);
			tishiui.ButList[class]=tishizhiye
			tishizhiye:SetSize(1,hang_Height-4);
			if class<8 then
				if class==1 then
					tishizhiye:SetPoint("TOPLEFT", tishiui, "TOPLEFT", 44*class+38,-12);
				else
					tishizhiye:SetPoint("TOPLEFT", tishiui, "TOPLEFT", 44*class+38,-12);
				end
			else
				tishizhiye:SetPoint("TOPLEFT", tishiui, "TOPLEFT", 44*(class-7)+38,-42);
			end
			tishizhiye.icon = tishizhiye:CreateTexture();
			tishizhiye.icon:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			tishizhiye.icon:SetSize(hang_Height-4,hang_Height-4);
			tishizhiye.icon:SetPoint("RIGHT", tishizhiye, "RIGHT", 0,0);
			tishizhiye.heji = PIGFontString(tishizhiye,{"RIGHT", tishizhiye.icon, "LEFT",0, 0},0,"OUTLINE");
			tishizhiye.heji:SetTextColor(1, 1, 1, 1);
		end
	end	
	fujiF.F.EnterF.roleData={}
	function fujiF.F.EnterF:Update_PlayersList(hangUI,ADD)
		local hangF=hangUI:GetParent() 
		self:ClearAllPoints();
		if ADD then
			self:SetPoint("TOPLEFT", hangUI, "BOTTOMLEFT", -100,-4);
		else
			self:SetPoint("RIGHT", hangUI, "LEFT", -2,0);
		end
		self:Show()
		self.errtishi:Hide();
		for ix=1,#RolesName do
			fujiF.F.EnterF.ButList[ix]:Hide()
			for class=1,#ClassesName do
				fujiF.F.EnterF.ButList[ix].ButList[class]:Hide()
			end
		end
		wipe(self.roleData)
		for i=1,#RolesName do
			self.roleData[RolesName[i]]={0,{}}
		end
		if ADD then
			if not C_LFGList.HasActiveEntryInfo() then return end
			local numGroupMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
			if numGroupMembers>0 then
				for p=1,MAX_RAID_MEMBERS do
					local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
					if name then
						if self.roleData[combatRole][2][fileName] then
							self.roleData[combatRole][2][fileName]=self.roleData[combatRole][2][fileName]+1
						else
							self.roleData[combatRole][2][fileName]=1
						end
					end
				end
			end
		else
			local resultID=hangF.resultID
			local searchResultInfo=C_LFGList.GetSearchResultInfo(resultID)
			if not searchResultInfo or searchResultInfo.isDelisted then
				self.errtishi:Show();
			else	
				for ix=1, searchResultInfo.numMembers do
					local role, class, classLocalized, specLocalized = C_LFGList.GetSearchResultMemberInfo(resultID, ix);
					self.roleData[role][1]=self.roleData[role][1]+1
					if self.roleData[role][2][class] then
						self.roleData[role][2][class]=self.roleData[role][2][class]+1
					else
						self.roleData[role][2][class]=1
					end
				end
			end
		end
		for ix=1,#RolesName do
			local zhiyocin = fujiF.F.EnterF.ButList[ix]
			zhiyocin:Show()
			zhiyocin.heji:SetText(self.roleData[RolesName[ix]][1])
			local zhizezhiyeNum = {}
			for class=1,#ClassesName do
				if self.roleData[RolesName[ix]][2][ClassesName[class]] then
					table.insert(zhizezhiyeNum,{ClassesName[class],self.roleData[RolesName[ix]][2][ClassesName[class]]})
				end
			end
			for uiid=1,#zhizezhiyeNum do
				local zzzyui = fujiF.F.EnterF.ButList[ix].ButList[uiid]
				zzzyui:Show()
				zzzyui.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[zhizezhiyeNum[uiid][1]]));
				zzzyui.heji:SetText(zhizezhiyeNum[uiid][2])
			end
		end
	end
	----
	fujiF.F.CategorieCC=0
	local function GetCategorieData()
		local listD,nameD={},{}
		local cunzail = C_LFGList.GetAvailableCategories()
		if #cunzail==0 and fujiF.F.CategorieCC<5 then
			fujiF.F.CategorieCC=fujiF.F.CategorieCC+1
			C_Timer.After(0.1,function() GetCategorieData() end)
		else
			--系统活动类型(地下城2/团队114/任务和地图116/PVP118/自定义120){{DUNGEONS,2},{GUILD_INTEREST_RAID,114},{OTHER,120}}--活动类型
			local baseFilters = LFGListFrame.baseFilters;
			for _,v in pairs(C_LFGList.GetAvailableCategories(baseFilters)) do
				local kkdfin= C_LFGList.GetLfgCategoryInfo(v)
				local renwuname=kkdfin.name:match(QUESTS_LABEL)
				if renwuname then
					nameD[kkdfin.name]=QUESTS_LABEL
					kkdfin.name=QUESTS_LABEL
				end
				if kkdfin.name==CUSTOM then
					table.insert(listD,{118,"PVP"})
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
	local function UpdatehangEnter(uix,fujie)
		local fujie=fujie or uix
		uix:HookScript("OnEnter", function ()
			fujie:SetBackdropColor(0.4, 0.4, 0.4, 0.2);
		end);
		uix:HookScript("OnLeave", function ()
			fujie:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
		end);
	end
	local function addPlayerListF(fujix,xxxoff)
		local PlayerF = CreateFrame("Frame", nil, fujix);
		PlayerF:SetSize((hang_Height-2)*5+4,hang_Height);
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
		return PlayerF
	end
	local function addPlayerListBut_1(fujix,index,roleid)
		local T = fujix:CreateTexture(nil, "BORDER");
		T:SetSize(hang_Height-2,hang_Height-2);
		T:SetPoint("LEFT", fujix, "LEFT", (index-1)*(hang_Height-2),-1);
		local Tjiao = fujix:CreateTexture(nil,"ARTWORK");
		Tjiao:SetTexture("interface/lfgframe/ui-lfg-icon-portraitroles.blp");
		Tjiao:SetTexCoord(GetTexCoordsForRoleSmallCircle(RolesName[roleid]));
		Tjiao:SetSize(hang_Height-10,hang_Height-10);
		Tjiao:SetPoint("BOTTOMLEFT", T, "TOPRIGHT", -12,-12);
		Tjiao:SetAlpha(0.8);
		return T,Tjiao
	end
	local function addPlayerListBut_2(fujik,roleid)		
		local T = fujik:CreateTexture();
		T:SetAtlas(PIGGetIconForRole(RolesName[roleid], false), TextureKitConstants.IgnoreAtlasSize);
		T:SetSize(hang_Height-4,hang_Height-4);
		T:SetPoint("LEFT", fujik, "LEFT", (roleid-1)*(hang_Height+14)+19,0);
		T:SetAlpha(0.9);
		local TNum = PIGFontString(fujik,{"RIGHT", T, "LEFT", 2,0},0,"OUTLINE");
		TNum:SetTextColor(1, 1, 1, 1);
		return T,TNum
	end

	InvF.addPlayerListF=addPlayerListF
	InvF.addPlayerListBut_1=addPlayerListBut_1
	InvF.addPlayerListBut_2=addPlayerListBut_2
	InvF.UpdatehangEnter=UpdatehangEnter
	-------------
	local TabF,TabBut=PIGOptionsList_R(fujiF.F,"找车队",70)
	TardisInfo.LFGList(TabF,GetCategorieData,fujiF.F.EnterF)

	local FCTabF,FCTabBut=PIGOptionsList_R(fujiF.F,"我的车队",80)
	--我的车队
	FCTabF.DQ=PIGFrame(FCTabF,{"TOPLEFT",FCTabF,"TOPLEFT",0,0})
	FCTabF.DQ:SetPoint("BOTTOMRIGHT",FCTabF,"BOTTOMRIGHT",0,0);
	FCTabF.DQ.Width=200
	FCTabF.DQ:Hide()
	--创建活动
	FCTabF.ADD=PIGFrame(FCTabF,{"TOPLEFT",FCTabF,"TOPLEFT",0,0})
	FCTabF.ADD:SetPoint("BOTTOMRIGHT",FCTabF,"BOTTOMRIGHT",0,0);
	FCTabF.ADD.Width=280
	FCTabF.ADD:Hide()
	TardisInfo.LFGCreation(FCTabF,GetCategorieData,fujiF.F.EnterF)

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
	--改变小地图按钮点击行为
	MiniMapLFGFrame:SetScript("OnClick", function (self,button)
		if ( button == "RightButton" ) then
			QueueStatusDropdown_Show(self);
		else
			local inBattlefield, showScoreboard = QueueStatus_InActiveBattlefield();
			if ( IsInLFDBattlefield() ) then
				inBattlefield = true;
				showScoreboard = true;
			end
			local lfgListActiveEntry = C_LFGList.HasActiveEntryInfo();
			if ( inBattlefield ) then
				if ( showScoreboard ) then
					TogglePVPScoreboardOrResults();
				end
			elseif ( lfgListActiveEntry ) then
				LFGListUtil_OpenBestWindow(true);
			else
				local mode = GetLFGMode(LE_LFG_CATEGORY_LFD);
				if ( mode == "queued" or mode == "rolecheck" or mode == "proposal" or mode == "suspended" ) then
					PVEFrame_ToggleFrame()
				else
					if InvF:IsShown() then
						InvF:Hide()
					else
						InvF:Show()
						-- local apps = C_LFGList.GetApplications();
						-- for i=1, #apps do
						-- 	local _, appStatus = C_LFGList.GetApplicationInfo(apps[i]);
						-- 	if ( appStatus == "applied" or appStatus == "invited" ) then
						-- 		--打开申请列表
						-- 		LFGListUtil_OpenBestWindow(true);
						-- 		return;
						-- 	end
						-- end
						Create.Show_TabBut_R(InvF.F,fujiF,fujiTabBut)
					end
				end
			end
		end
	end);
end