local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.LFGCreation_Vanilla(FCTabF,GetCategorieData,EnterF)
	local Create, Data, Fun, L= unpack(PIG)
	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGButton = Create.PIGButton
	local PIGDownMenu=Create.PIGDownMenu
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGFontString=Create.PIGFontString
	local PIGSetFont=Create.PIGSetFont
	local PIGDiyBut=Create.PIGDiyBut
	local FasongYCqingqiu=Fun.FasongYCqingqiu
	---------------
	local gsub = _G.string.gsub
	local TalentData=Data.TalentData
	local GetTianfuIcon_YC=TalentData.GetTianfuIcon_YC
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local RolesName=InvF.RolesName
	local UpdatehangEnter=InvF.UpdatehangEnter
	local SetEditBoxBG=InvF.SetEditBoxBG
	----
	FCTabF:HookScript("OnShow", function (self)
		self:UpdateEditMode()
	end);

	--创建车队
	FCTabF.selectedActivity={}
	function FCTabF:ListFrameRemoveListing()
		--FCTabF:ClearActivityADD()
		PENDING_LISTING_UPDATE = true;
		C_LFGList.RemoveListing()
	end

	FCTabF.ADD.Category_T=PIGFontString(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD,"TOPLEFT",20,-20},LFG_LIST_SELECT..CALENDAR_CREATE_EVENT..TYPE)
	FCTabF.ADD.CategorieButList={}
	for i=1,8 do
		local ckbut = PIGCheckbutton(FCTabF.ADD)
		FCTabF.ADD.CategorieButList[i]=ckbut
		if i==1 then
			ckbut:SetPoint("TOPLEFT",FCTabF.ADD,"TOPLEFT",20,-40)
		else
			ckbut:SetPoint("LEFT",FCTabF.ADD.CategorieButList[i-1].Text,"RIGHT",8,0)
		end
		ckbut:HookScript("OnClick", function (self)
			FCTabF:ClearActivityADD()
			self:SetChecked(true)
			FCTabF.selectedCategory=self:GetID()
			FCTabF:UpdateActivityADD()
		end)
	end
	function FCTabF.ADD:CategorieIsChecked(BOT)
		for i=1,#self.CategorieButList do
			self.CategorieButList[i]:SetChecked(BOT)
		end
	end
	function FCTabF.ADD:CategorieSetChecked(CategorieID)
		for i=1,#self.CategorieButList do
			if self.CategorieButList[i]:GetID()==CategorieID then
				self.CategorieButList[i]:SetChecked(true)
				return
			end
		end
	end
	function FCTabF.ADD:CategorieIsEnabled(BOT)
		for i=1,#self.CategorieButList do
			self.CategorieButList[i]:SetEnabled(BOT)
		end
	end
	FCTabF.ADD:HookScript("OnShow", function (self)
		for i=1,#self.CategorieButList do
			self.CategorieButList[i]:Hide()
			if FCTabF.tabList[i] then
				self.CategorieButList[i]:Show()
				self.CategorieButList[i].Text:SetText(FCTabF.tabList[i][2])
				self.CategorieButList[i]:SetID(FCTabF.tabList[i][1])
				self.CategorieButList[i]:UpdateHitRectInsets()
			end
		end
	end);

	FCTabF.ADD.GroupsBut={}
	FCTabF.ADD.ActivityBut={}
	function FCTabF.ADD:Clear_Activitys()
		FCTabF.selectedActivityCount=0
		for i=1,#self.GroupsBut,1 do
			self.GroupsBut[i]:Hide()
		end
		for i=1,#self.ActivityBut,1 do
			self.ActivityBut[i]:Hide()
		end
	end
	FCTabF.FilterFBData={}
	FCTabF.OldSelectedActivity={}
	function FCTabF.ADD:Update_Activitys()
		FCTabF.OldSelectedActivity=nil
		if C_LFGList.HasActiveEntryInfo() then
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			FCTabF.OldSelectedActivity=activeEntryInfo.activityIDs
			for acid=1,#activeEntryInfo.activityIDs do
				local activityID=activeEntryInfo.activityIDs[acid]
				local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
				FCTabF.selectedCategory=activityInfo.categoryID
				self:CategorieSetChecked(activityInfo.categoryID)
				break
			end
		end
		if not FCTabF.selectedCategory then return end
		InvF.GetActivities(FCTabF.FilterFBData,FCTabF.selectedCategory)
		local Butindex={["Activ"]=0}
		for i=1,#FCTabF.FilterFBData.groups,1 do
			local groupID=FCTabF.FilterFBData.groups[i][1]
			if not self.GroupsBut[i] then
				self.GroupsBut[i]=PIGFontString(FCTabF.ADD)
				if i==1 then
					self.GroupsBut[i]:SetPoint("TOPLEFT",FCTabF.ADD,"TOPLEFT",20,-70)
				else
					self.GroupsBut[i]:SetPoint("TOPLEFT",self.GroupsBut[i-1],"TOPLEFT",160,0)
				end
			end
			self.GroupsBut[i]:Show()
			self.GroupsBut[i]:SetText(FCTabF.FilterFBData.groups[i][2])
			for ii=1,#FCTabF.FilterFBData.Activs[groupID] do
				Butindex.Activ=Butindex.Activ+1
				local ActivityD=FCTabF.FilterFBData.Activs[groupID][ii]
				if not self.ActivityBut[Butindex.Activ] then
					self.ActivityBut[Butindex.Activ]=PIGCheckbutton(FCTabF.ADD,nil,nil,{16,16})
					self.ActivityBut[Butindex.Activ]:HookScript("OnClick", function (self)
						if self:GetChecked() then
							FCTabF.selectedActivity[self.activityID]=true
							FCTabF.selectedActivityCount=FCTabF.selectedActivityCount+1
						else
							FCTabF.selectedActivity[self.activityID]=nil
							FCTabF.selectedActivityCount=FCTabF.selectedActivityCount-1
						end
						FCTabF.ADD:ListGroupButton_Update()
					end)
				end
				self.ActivityBut[Butindex.Activ]:ClearAllPoints();
				if ii==1 then
					self.ActivityBut[Butindex.Activ]:SetPoint("TOPLEFT",self.GroupsBut[i],"BOTTOMLEFT",0,-4)
				elseif ii==19 then
					self.ActivityBut[Butindex.Activ]:SetPoint("TOPLEFT",self.ActivityBut[Butindex.Activ-18],"TOPLEFT",160,0)
				else
					self.ActivityBut[Butindex.Activ]:SetPoint("TOP",self.ActivityBut[Butindex.Activ-1],"BOTTOM",0,-4)
				end
				self.ActivityBut[Butindex.Activ]:SetChecked(false)
				self.ActivityBut[Butindex.Activ]:Show()
				self.ActivityBut[Butindex.Activ].Text:SetText(ActivityD[1].."("..ActivityD[3].."-"..ActivityD[4]..")")
				self.ActivityBut[Butindex.Activ]:UpdateHitRectInsets()
				InvF.UpdateLevelColor(self.ActivityBut[Butindex.Activ].Text,ActivityD[3],ActivityD[4])
				self.ActivityBut[Butindex.Activ].activityID=ActivityD[2]
				if FCTabF.OldSelectedActivity then
					for acid=1,#FCTabF.OldSelectedActivity do
						if FCTabF.OldSelectedActivity[acid]==ActivityD[2] then
							self.ActivityBut[Butindex.Activ]:SetChecked(true)
							FCTabF.selectedActivityCount=FCTabF.selectedActivityCount+1
							break
						end
					end
				end
			end
		end
	end

	--标题
	FCTabF.ADD.DescriptionF=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD,"TOPLEFT",FCTabF.ADD.Width,-40},{360,180})
	FCTabF.ADD.DescriptionF:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
	FCTabF.ADD.DescriptionF:Hide()
	local DescriptionBox = LFGListingComment
	FCTabF.ADD.DescriptionF:SetObject(DescriptionBox, {4, -4, -4, 4})
	DescriptionBox.EditBox:SetWidth(DescriptionBox:GetWidth())
    DescriptionBox.TopTex:Hide()
    DescriptionBox.TopLeftTex:Hide()
    DescriptionBox.TopRightTex:Hide()
    DescriptionBox.LeftTex:Hide()
    DescriptionBox.MiddleTex:Hide()
    DescriptionBox.RightTex:Hide()
    DescriptionBox.BottomTex:Hide()
    DescriptionBox.BottomLeftTex:Hide()
    DescriptionBox.BottomRightTex:Hide()
	FCTabF.ADD.DescriptionF.t=PIGFontString(FCTabF.ADD.DescriptionF,{"BOTTOMLEFT",FCTabF.ADD.DescriptionF,"TOPLEFT",0,2},LFG_LIST_DETAILS)
	SetEditBoxBG(DescriptionBox.EditBox,FCTabF.ADD.DescriptionF)
	DescriptionBox.EditBox:SetScript('OnTextChanged', function(self)
		if ( self:GetText() ~= "" ) then
			self.Instructions:Hide();
		else
			self.Instructions:Show();
		end
        FCTabF.ADD:ListGroupButton_Update()
    end)
    --
    FCTabF.ADD.Role = InvF.addRoleSetBut(FCTabF.ADD,40,{"BOTTOMLEFT",FCTabF.ADD,"BOTTOMLEFT",FCTabF.ADD.Width+24,140},4)
	FCTabF.ADD.Role:SetScript("OnShow", function(self)
		-- local availTank, availHealer, availDPS = C_LFGList.GetAvailableRoles();
		-- self.T:SetShown(availTank);
		-- self.H:SetShown(availHealer);
		-- self.D:SetShown(availDPS);
		local roles = C_LFGListRoles.GetSavedRoles();
		self.T.CheckButton:SetChecked(roles.tank);
		self.H.CheckButton:SetChecked(roles.healer);
		self.D.CheckButton:SetChecked(roles.dps);
		self.New.CheckButton:SetChecked(GetCVarBool("lfgNewPlayerFriendly"));
	end)
	local PENDING_LISTING_UPDATE = false
    FCTabF.ADD.ListGroupButton=PIGButton(FCTabF.ADD,{"BOTTOMLEFT",FCTabF.ADD,"BOTTOMLEFT",FCTabF.ADD.Width,40},{100,30})
    FCTabF.ADD.ListGroupButton:Hide()
	FCTabF.ADD.ListGroupButton:SetScript("OnClick", function (self)
		FCTabF.EditMode=nil
		local selectedActivityIDs = {};
		local hasSelectedActivity = false;
		if FCTabF.selectedCategory==120 then
			hasSelectedActivity = true;
			selectedActivityIDs[1]=1064
		else
			local i = 1;
			for activityID, selected in pairs(FCTabF.selectedActivity) do
				if (selected) then
					hasSelectedActivity = true;
					selectedActivityIDs[i] = activityID;
					i = i+1;
				end
			end
		end		
		local newPlayerFriendlyEnabled = FCTabF.ADD.Role.New.CheckButton:GetChecked();
		if (C_LFGList.HasActiveEntryInfo()) then
			if (hasSelectedActivity) then
				PENDING_LISTING_UPDATE = true;
				C_LFGList.UpdateListing({
					activityIDs = selectedActivityIDs,
					newPlayerFriendly = newPlayerFriendlyEnabled,
				});
			else
				PENDING_LISTING_UPDATE = true;
				C_LFGList.RemoveListing();
			end
		else
			if (hasSelectedActivity) then
				PENDING_LISTING_UPDATE = true;
				C_LFGList.CreateListing({
					activityIDs = selectedActivityIDs,
					newPlayerFriendly = newPlayerFriendlyEnabled,
				});
			end
		end
	end);
	FCTabF.ADD.ADDerror=PIGFontString(FCTabF.ADD,{"BOTTOMLEFT",FCTabF.ADD.ListGroupButton,"TOPLEFT",0,4})
	FCTabF.ADD.ADDerror:SetTextColor(1,0,0,1);
	FCTabF.ADD.RemoveBut=PIGButton(FCTabF.ADD,{"LEFT",FCTabF.ADD.ListGroupButton,"RIGHT",80,0},{100,30},CALENDAR_DELETE_EVENT..LFG_LIST_ACTIVITY)
	FCTabF.ADD.RemoveBut:Hide()
	FCTabF.ADD.RemoveBut:HookScript("OnClick", FCTabF.ListFrameRemoveListing);
	function FCTabF.ADD:ListGroupButton_errorText()
		if (not LFGListingUtil_CanEditListing()) then
			return LFG_LIST_NOT_LEADER;
		end
		if FCTabF.selectedCategory==120 then
			if DescriptionBox.EditBox:GetText() == "" then
       			return LFG_LIST_MUST_HAVE_NAME;
			end
		else
			if FCTabF.selectedActivityCount ==0 then
				return LFG_LIST_SELECT..LFG_LIST_ACTIVITY
			end
		end
		if (FCTabF.selectedActivityCount > Constants.LFGConstsExposed.GROUP_FINDER_MAX_ACTIVITY_CAPACITY) then
			return LFG_LIST_TOO_MANY_ACTIVITIES_SELECTED;
		end
		if ( ( self.Role.T:IsShown() and self.Role.T.checkButton:GetChecked())
			or ( self.Role.H:IsShown() and self.Role.H.checkButton:GetChecked())
			or ( self.Role.D:IsShown() and self.Role.D.checkButton:GetChecked()) ) then
		else
			return ERR_LFG_NO_ROLES_SELECTED;
		end
		local NumGroup=GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
		for k,v in pairs(FCTabF.selectedActivity) do
			if v then
				local activityInfo = C_LFGList.GetActivityInfoTable(k)
				local maxNumPlayers = activityInfo and  activityInfo.maxNumPlayers or 0;
				if ( maxNumPlayers > 0 and NumGroup >= maxNumPlayers ) then
					return string.format(LFG_LIST_TOO_MANY_FOR_ACTIVITY, maxNumPlayers)
				end
			end
		end 
	end
	function FCTabF.ADD:ListGroupButton_Update()
		if not self:IsVisible() then return end
		local errorText=self:ListGroupButton_errorText()
		self.ADDerror:SetText(errorText)
		self.ListGroupButton:SetEnabled(not errorText and not mythicPlusDisableActivity);
	end

	--当前活动
	FCTabF.DQ.Category_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ,"TOPLEFT",10,-10},LFG_LIST_ACTIVITY..TYPE)
	FCTabF.DQ.Category_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.Category_V=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Category_T,"BOTTOMLEFT",0,-2},"")
	FCTabF.DQ.Category_V:SetTextColor(0.9,0.9,0.9,1);

	FCTabF.DQ.Name_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Category_T,"BOTTOMLEFT",0,-24},"目的地")
	FCTabF.DQ.Name_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.Name_V=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Name_T,"BOTTOMLEFT",0,-2},"")
	FCTabF.DQ.Name_V:SetTextColor(0.9,0.9,0.9,1);
	FCTabF.DQ.Name_V:SetWidth(FCTabF.DQ.Width-8);
	FCTabF.DQ.Name_V:SetJustifyH("LEFT")

	FCTabF.DQ.Description_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Name_T,"BOTTOMLEFT",0,-110},LFG_LIST_DETAILS)
	FCTabF.DQ.Description_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.DescriptionScroll = Create.PIGScrollFrame(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Description_T,"BOTTOMLEFT",0,-2},{FCTabF.DQ.Width-28,156})
	FCTabF.DQ.Description = PIGFrame(FCTabF.DQ.DescriptionScroll,nil,{FCTabF.DQ.DescriptionScroll:GetWidth()+2,20})
	FCTabF.DQ.Description.V=PIGFontString(FCTabF.DQ.Description,{"TOPLEFT",FCTabF.DQ.Description,"TOPLEFT",0,0})
	FCTabF.DQ.Description.V:SetTextColor(0.9,0.9,0.9,1);
	FCTabF.DQ.Description.V:SetWidth(FCTabF.DQ.Description:GetWidth())
	FCTabF.DQ.Description.V:SetJustifyH("LEFT")
	FCTabF.DQ.Description.V:SetNonSpaceWrap(true)
	FCTabF.DQ.DescriptionScroll:SetScrollChild(FCTabF.DQ.Description)

	FCTabF.DQ.Role = InvF.addRoleSetBut(FCTabF.DQ,30,{"BOTTOMLEFT",FCTabF.DQ,"BOTTOMLEFT",30,60},4)
	FCTabF.DQ.Role.T.CheckButton:Hide();
	FCTabF.DQ.Role.H.CheckButton:Hide();
	FCTabF.DQ.Role.D.CheckButton:Hide();
	FCTabF.DQ.Role.New.CheckButton:Hide();
	FCTabF.DQ.Role.T:SetScript("OnClick", nil)
	FCTabF.DQ.Role.H:SetScript("OnClick", nil)
	FCTabF.DQ.Role.D:SetScript("OnClick", nil)
	FCTabF.DQ.Role.New:SetScript("OnClick", nil)

	FCTabF.DQ.EditButton=PIGButton(FCTabF.DQ,{"BOTTOMLEFT",FCTabF.DQ,"BOTTOMLEFT",10,18},{80,22},CALENDAR_EDIT_EVENT)
	FCTabF.DQ.EditButton:HookScript("OnClick", function (self)
		FCTabF.EditMode=true
		FCTabF:UpdateEditMode()
	end);

	FCTabF.DQ.RemoveEntryButton=PIGButton(FCTabF.DQ,{"LEFT",FCTabF.DQ.EditButton,"RIGHT",20,0},{80,22},CALENDAR_DELETE_EVENT..LFG_LIST_ACTIVITY)
	FCTabF.DQ.RemoveEntryButton:HookScript("OnClick", FCTabF.ListFrameRemoveListing);

	--申请界面--------------
	FCTabF.DQ.Apply=PIGFrame(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ,"TOPLEFT",FCTabF.DQ.Width,-34})
	FCTabF.DQ.Apply:SetPoint("BOTTOMRIGHT",FCTabF.DQ,"BOTTOMRIGHT",-16,2);
	FCTabF.DQ.Apply:PIGSetBackdrop(0)
	--状态提示
	FCTabF.DQ.Apply.UnempoweredCover=PIGFrame(FCTabF.DQ.Apply,{"TOPLEFT",FCTabF.DQ.Apply,"TOPLEFT",0,0})
	FCTabF.DQ.Apply.UnempoweredCover:SetPoint("BOTTOMRIGHT",FCTabF.DQ.Apply,"BOTTOMRIGHT",0,0);
	FCTabF.DQ.Apply.UnempoweredCover:PIGSetBackdrop(1)
	FCTabF.DQ.Apply.UnempoweredCover:Hide()
	FCTabF.DQ.Apply.UnempoweredCover.err = PIGFontString(FCTabF.DQ.Apply.UnempoweredCover,{"CENTER", FCTabF.DQ.Apply.UnempoweredCover, "CENTER",0, 40});
	FCTabF.DQ.Apply.UnempoweredCover.err:SetText(LFG_LIST_GROUP_FORMING);
	FCTabF.DQ.Apply.LFM_TITLE=PIGFontString(FCTabF.DQ.Apply,{"BOTTOMLEFT",FCTabF.DQ.Apply,"TOPLEFT",10,6},LOOKING..PLAYERS_IN_GROUP)
	FCTabF.DQ.Apply.LFM_TITLE:SetTextColor(0,1,0,1);
	FCTabF.DQ.Apply.RefreshButton = PIGButton(FCTabF.DQ.Apply,{"BOTTOMRIGHT",FCTabF.DQ.Apply,"TOPRIGHT",-180,4},{60,22},LFG_LIST_REFRESH)
	FCTabF.DQ.Apply.RefreshButton:HookScript("OnClick", function (self)
		C_LFGList.RefreshApplicants();
	end);
	FCTabF.DQ.Apply.AutoAcceptButton = PIGCheckbutton(FCTabF.DQ.Apply,{"BOTTOMRIGHT",FCTabF.DQ.Apply,"TOPRIGHT",-80,6},{LFG_LIST_AUTO_ACCEPT},{16,16})
	FCTabF.DQ.Apply.AutoAcceptButton:HookScript("OnClick", function (self)
		if ( self:GetChecked() ) then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		else
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		end
		LFGListUtil_SetAutoAccept(self:GetChecked());
	end);
	FCTabF.DQ.Apply.AutoAcceptButton:Disable()
	--成员显示模式
	InvF.addPlayerShowMode(FCTabF.DQ,{"LEFT", FCTabF.DQ.Apply.LFM_TITLE, "RIGHT", 4, 1})
	function FCTabF.DQ:Update_PlayerShowMode()
		if not self:IsVisible() then return end
		C_Timer.After(0.4,function()
			self.EditButton:SetEnabled(not IsRestrictedAccount())
			self:ShowMode_Restore()
			if IsInGroup(LE_PARTY_CATEGORY_HOME) then
				if LFGListUtil_IsEntryEmpowered() then
					self.Apply.UnempoweredCover:Hide()
					self.RemoveEntryButton:Show();
					self.EditButton:Show();
					self.Apply.RefreshButton:Enable();
					self.Apply.Scroll.errt:SetText(LFG_LIST_NO_APPLICANTS)
				else
					self.Apply.UnempoweredCover:Show()
					self.RemoveEntryButton:Hide();
					self.EditButton:Hide();
					self.Apply.RefreshButton:Disable();
					self.Apply.Scroll.errt:SetText(LFG_LIST_GROUP_FORMING)
				end
				if not C_LFGList.HasActiveEntryInfo() then return end
				--local NumGroup=GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
				-- local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
				-- for k,v in pairs(activeEntryInfo) do
				-- 	print(k,v)
				-- end
				--local bestDisplayType, maxNumPlayers=LFGBrowseUtil_GetBestDisplayTypeForActivityIDs(activeEntryInfo.activityIDs)
				-- local activityID=activeEntryInfo.activityIDs[1]
				-- local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
				-- local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
				-- if activityInfo.displayType==Enum.LFGListDisplayType.RoleEnumerate then
				-- 	self.RoleEnumerate:Restore_But(0.2)
				-- 	self.RoleEnumerate:Update_But(displayData,searchResultInfo.isDelisted)
				-- else
				-- 	self.RoleCount:Restore_But()
				-- 	self.RoleCount:Update_But(displayData,searchResultInfo.isDelisted)
				-- end
				-- if NumGroup>5 then

				-- end
			-- 		self.Apply.RoleEnumerate:RestoreDefault(0.4)
			-- 		--wipe(self.DQplayers)
			-- 		-- for ix=1,#RolesName do
			-- 		-- 	self.DQplayers[RolesName[ix]]={}
			-- 		-- end
			-- 		-- for p=1, MAX_PARTY_MEMBERS do
			-- 		-- 	local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
			-- 		-- 	if name and combatRole then
			-- 		-- 		table.insert(self.DQplayers[combatRole],fileName)
			-- 		-- 	end
			-- 		-- end
			-- 		-- if #self.DQplayers[RolesName[1]]>0 then
			-- 		-- 	self.Apply.RoleEnumerate:Update_Show("T",self.DQplayers[RolesName[1]][1])
			-- 		-- end
			-- 		-- if #self.DQplayers[RolesName[2]]>0 then
			-- 		-- 	self.Apply.RoleEnumerate:Update_Show("H",self.DQplayers[RolesName[2]][1])
			-- 		-- end
			-- 		-- if #self.DQplayers[RolesName[3]]>0 then
			-- 		-- 	self.Apply.RoleEnumerate:Update_Show("D",self.DQplayers[RolesName[3]][1])
			-- 		-- 	if self.DQplayers[RolesName[3]][2] then
			-- 		-- 		self.Apply.RoleEnumerate:Update_Show("D1",self.DQplayers[RolesName[3]][2])
			-- 		-- 	end
			-- 		-- 	if self.DQplayers[RolesName[3]][3] then
			-- 		-- 		self.Apply.RoleEnumerate:Update_Show("D2",self.DQplayers[RolesName[3]][3])
			-- 		-- 	end
			-- 		-- end
			-- 	else
			-- 		local displayData = GetGroupMemberCountsForDisplay();
			-- 		self.Apply.RoleCount:Show()		
			-- 		self.Apply.RoleCount.TNum:SetText(displayData.TANK);
			-- 		self.Apply.RoleCount.HNum:SetText(displayData.HEALER);
			-- 		self.Apply.RoleCount.DNum:SetText(displayData.DAMAGER);
			-- 		--self.Apply.RoleCount.NONum:SetText(displayData.NOROLE)
			-- 	end
			else
				self.Apply.LFM_TITLE:SetText(LOOKING..COMPACT_UNIT_FRAME_PROFILE_SORTBY_GROUP)
				self.Apply.RefreshButton:Disable();
			end
		end)
	end
	--申请人
	local Apphang_Height,Apphang_NUM,Apphang_Width=25,15,FCTabF.DQ.Apply:GetWidth();
	local AppbiaotiName={{"申请人(|cffFF80FF点击"..L["CHAT_WHISPER"].."|r)",6},{"天赋",164},{"装等",272},{"申请留言",324},{"操作",584}}
	for i=1,#AppbiaotiName do
		local biaoti=PIGFontString(FCTabF.DQ.Apply,{"TOPLEFT",FCTabF.DQ.Apply,"TOPLEFT",AppbiaotiName[i][2],-5},AppbiaotiName[i][1])
		biaoti:SetTextColor(1,1,0, 0.9);
	end
	FCTabF.DQ.Apply.line = PIGLine(FCTabF.DQ.Apply,"TOP",-24,nil,nil,{0.2,0.2,0.2,0.5})

	FCTabF.DQ.Apply.Scroll = CreateFrame("Frame", nil, FCTabF.DQ.Apply)
	FCTabF.DQ.Apply.Scroll:SetPoint("TOPLEFT",FCTabF.DQ.Apply,"TOPLEFT",0,-24);
	FCTabF.DQ.Apply.Scroll:SetPoint("BOTTOMRIGHT",FCTabF.DQ.Apply,"BOTTOMRIGHT",0,0);
	FCTabF.DQ.Apply.Scroll.errt=PIGFontString(FCTabF.DQ.Apply.Scroll,{"CENTER",FCTabF.DQ.Apply.Scroll,"CENTER",0,40})
	FCTabF.DQ.Apply.Scroll.ScrollBox = CreateFrame("Frame", nil, FCTabF.DQ.Apply.Scroll, "WowScrollBoxList")
	FCTabF.DQ.Apply.Scroll.ScrollBar = CreateFrame("EventFrame", nil, FCTabF.DQ.Apply.Scroll, "MinimalScrollBar")
	FCTabF.DQ.Apply.Scroll.ScrollBar:SetPoint("TOPLEFT", FCTabF.DQ.Apply.Scroll.ScrollBox, "TOPRIGHT",4,0)
	FCTabF.DQ.Apply.Scroll.ScrollBar:SetPoint("BOTTOMLEFT", FCTabF.DQ.Apply.Scroll.ScrollBox, "BOTTOMRIGHT",4,0)
	local anchorsWithBar = {
        CreateAnchor("TOPLEFT", FCTabF.DQ.Apply.Scroll, "TOPLEFT", 1, -1),
        CreateAnchor("BOTTOMRIGHT", FCTabF.DQ.Apply.Scroll, "BOTTOMRIGHT", 0, 1),
    }
    ScrollUtil.AddManagedScrollBarVisibilityBehavior(FCTabF.DQ.Apply.Scroll.ScrollBox, FCTabF.DQ.Apply.Scroll.ScrollBar, anchorsWithBar, anchorsWithBar);
    local function UIEnterLeave(uix,highui)
    	uix:HookScript("OnEnter", function ()
			highui:Show()
		end);
		uix:HookScript("OnLeave", function ()
			highui:Hide()
		end);
    end
	local function CZ_tianfuShow_1(txt,tex,tisp)
		txt:SetTextColor(0.6,0.6,0.6);
		txt:SetText(" - -");
		tex:SetDesaturated(true)
		tex:SetTexture("interface/icons/ability_marksmanship.blp");
		tisp=nil
	end
	local function CZ_tianfuShow(uix)
		uix.getCount=0
		CZ_tianfuShow_1(uix.zhu,uix.zhutex,uix.tftisp1)
		CZ_tianfuShow_1(uix.fu,uix.futex,uix.tftisp2)
	end
	local function Update_Showtianfu(uix,class,nameX)
		if not uix:IsVisible() then return end
		if uix.name~=nameX then return end
		if class and nameX then
			local tfdd_1, tfdd_2=GetTianfuIcon_YC(class,nameX)
			if tfdd_1[1]=="--" and uix.getCount<5 then
				uix.getCount=uix.getCount+1
				C_Timer.After(0.5,function()
					Update_Showtianfu(uix,class,nameX)
				end)
			else
				if tfdd_1[1]~="--" then
					uix.tftisp1=tfdd_1
					uix.zhu:SetTextColor(1,1,0);
					uix.zhutex:SetDesaturated(false)		
					uix.zhu:SetText(tfdd_1[1]);
					uix.zhutex:SetTexture(tfdd_1[2]);
				end
				if tfdd_2[1]~="--" then
					uix.tftisp2=tfdd_2
					uix.fu:SetTextColor(1,1,0);
					uix.futex:SetDesaturated(false)
					uix.fu:SetText(tfdd_2[1]);
					uix.futex:SetTexture(tfdd_2[2]);
				end
			end
		end
	end
    local function UpdateApplicant_1(member, appID, memberIdx, applicationStatus)	
		local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage, assignedRole, relationship, dungeonScore, pvpItemLevel = C_LFGList.GetApplicantMemberInfo(appID, memberIdx);
		local rPerc, gPerc, bPerc, argbHex = GetClassColor(class);
		member.allname=name
		member.Role:SetAtlas(PIGGetIconForRole(assignedRole, false));
		member.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]));
		member.nameF.name:SetText(name.."("..level..")");
		member.iLvl:SetText(floor(itemLevel));
		member.tianfuF.name=name
		if applicationStatus=="applied" or applicationStatus== "invited" then
			FasongYCqingqiu(name,2)
			member:Updata_IsEnabled(false)
			member.nameF.name:SetTextColor(rPerc, gPerc, bPerc);
			CZ_tianfuShow(member.tianfuF)
			Update_Showtianfu(member.tianfuF,class,name)
		end
		member:Show();
	end
	local function add_MemberList(MemberBut)
		local frame=MemberBut:GetParent()
		local PF = CreateFrame("Frame",nil,MemberBut)
		PF:SetSize(MemberBut:GetWidth(),Apphang_Height);
		if #MemberBut.ListBut==0 then
			PF:SetPoint("TOPLEFT", MemberBut, "TOPLEFT",0, 0);
		else
			PF:SetPoint("TOPLEFT", MemberBut.ListBut[(#MemberBut.ListBut)], "BOTTOMLEFT",0, 0);
		end
		UIEnterLeave(PF,frame.highlight)
   		PF.Role = PF:CreateTexture();
		PF.Role:SetPoint("LEFT", PF, "LEFT", 1,0);
		PF.Role:SetSize(Apphang_Height-2,Apphang_Height-2);
		PF.Role:SetAlpha(0.9);
		UIEnterLeave(PF.Role,frame.highlight)
		PF.Class = PF:CreateTexture();
		PF.Class:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
		PF.Class:SetPoint("LEFT", PF.Role, "RIGHT", 1,0);
		PF.Class:SetSize(Apphang_Height-4,Apphang_Height-4);
		PF.Class:SetAlpha(0.9);
		UIEnterLeave(PF.Class,frame.highlight)
		PF.nameF = PIGFrame(PF,{"LEFT", PF.Class, "RIGHT",1, 0},{120,Apphang_Height-4});
		UIEnterLeave(PF.nameF,frame.highlight)
		PF.nameF.name = PIGFontString(PF.nameF);
		PF.nameF.name:SetAllPoints(PF.nameF)
		PF.nameF.name:SetJustifyH("LEFT");
		PF.nameF:SetScript("OnMouseUp", function(self,button)
			local wjName = self:GetParent().allname
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/WHISPER " ..wjName.." ".. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/WHISPER " ..wjName.." ".. hasText);
			end
		end)
		PF.tianfuF = PIGFrame(PF,{"LEFT", PF, "LEFT",AppbiaotiName[2][2]-4, 0},{100,Apphang_Height-2});
		UIEnterLeave(PF.tianfuF,frame.highlight)
		PF.tianfuF:HookScript("OnEnter", function (self)
			if self.tftisp1 then
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
				local tishineirrr = "|T518449:13:13|t|T"..self.tftisp1[2]..":0|t"..self.tftisp1[1].." |cffFFFFFF"..self.tftisp1[3].."|r"
				if self.tftisp2 then
					tishineirrr =tishineirrr.."\n    |T"..self.tftisp2[2]..":0|t"..self.tftisp2[1].." |cffFFFFFF"..self.tftisp2[3].."|r"
				end
				GameTooltip:AddLine(tishineirrr)
				GameTooltip:Show();
			end
		end);
		PF.tianfuF:HookScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide();
		end);
		PF.tianfuF.zhutex = PF.tianfuF:CreateTexture();
		PF.tianfuF.zhutex:SetSize(Apphang_Height-6,Apphang_Height-6);
		PF.tianfuF.zhutex:SetPoint("LEFT",PF.tianfuF, "LEFT",0, 0);
		PF.tianfuF.zhutex:SetAlpha(0.9);
		PF.tianfuF.zhu = PIGFontString(PF.tianfuF,{"LEFT",PF.tianfuF.zhutex, "RIGHT",0, 0});
		PF.tianfuF.zhu:SetJustifyH("LEFT");
		PF.tianfuF.futex = PF.tianfuF:CreateTexture();
		PF.tianfuF.futex:SetSize(Apphang_Height-6,Apphang_Height-6);
		PF.tianfuF.futex:SetPoint("LEFT",PF.tianfuF.zhu, "RIGHT",2, 0);
		PF.tianfuF.futex:SetAlpha(0.9);
		PF.tianfuF.fu = PIGFontString(PF.tianfuF,{"LEFT",PF.tianfuF.futex, "RIGHT",0, 0});
		PF.tianfuF.fu:SetJustifyH("LEFT");
		PF.item = PIGDiyBut(PF, {"LEFT", PF, "LEFT",AppbiaotiName[3][2]-2, 0},{Apphang_Height-4,Apphang_Height-4,nil,nil,133122})
		UIEnterLeave(PF.item,frame.highlight)
		PF.item:HookScript("OnClick", function(self,button)
			FasongYCqingqiu(self:GetParent().allname)
		end); 
		PF.iLvl = PIGFontString(PF,{"LEFT", PF.item, "RIGHT",1, 0});
		function PF:Updata_IsEnabled(Effective)
			PF.Role:SetDesaturated(Effective)
			PF.Class:SetDesaturated(Effective)
			PF.item:SetEnabled(not Effective)
			PF.tianfuF.zhutex:SetDesaturated(Effective)
			PF.tianfuF.futex:SetDesaturated(Effective)
			if Effective then
				PF.nameF.name:SetTextColor(0.5,0.5,0.5,1);
				PF.tianfuF.zhu:SetTextColor(0.5,0.5,0.5,1);
				PF.tianfuF.fu:SetTextColor(0.5,0.5,0.5,1);
				PF.iLvl:SetTextColor(0.5,0.5,0.5,1);
			else
				PF.tianfuF.zhu:SetTextColor(1,1,1,1);
				PF.tianfuF.fu:SetTextColor(1,1,1,1);
				PF.iLvl:SetTextColor(0,0.98,0.6, 1);
			end
		end
		return PF
	end
    function FCTabF.DQ.Apply.Scroll.add_hang(frame)
		if frame.bg then return end
		frame.bg = frame:CreateTexture();
		frame.bg:SetTexture("interface/characterframe/ui-party-background.blp");
		frame.bg:SetBlendMode("ADD")
		frame.bg:SetAllPoints(frame)
		frame.bg:SetColorTexture(0.1, 0.1, 0.1, 0.3)
		frame.highlight = frame:CreateTexture();
		frame.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
		frame.highlight:SetBlendMode("ADD")
		frame.highlight:SetAllPoints(frame)
		frame.highlight:SetAlpha(0.2);
		frame.highlight:Hide()
		UIEnterLeave(frame,frame.highlight)
		frame.MemberBut=PIGFrame(frame,{"TOPLEFT", frame, "TOPLEFT",0, 0})
		frame.MemberBut:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0,0);
		frame.MemberBut:SetWidth(320);
		frame.MemberBut.ListBut={}
		function frame.MemberBut:UpdateApplicantMember(AppID,applicantInfo)
			for iG=1, #self.ListBut do
				self.ListBut[iG]:Hide();
			end
			for iG=1, applicantInfo.numMembers do
				if not self.ListBut[iG] then
					self.ListBut[iG]=add_MemberList(self,iG)
				end
				self.ListBut[iG]:Updata_IsEnabled(true)
				UpdateApplicant_1(self.ListBut[iG], AppID, iG, applicantInfo.applicationStatus);
			end
		end
		frame.caozuoF=PIGFrame(frame,{"TOPRIGHT", frame, "TOPRIGHT",0, 0})
		frame.caozuoF:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0,0);
		frame.caozuoF:SetWidth(70);
		UIEnterLeave(frame.caozuoF,frame.highlight)
		frame.caozuoF.Status= PIGFontString(frame.caozuoF,{"LEFT", frame.caozuoF, "LEFT",0, 0},"已取消",nil,13);
		frame.caozuoF.InviteButton = PIGButton(frame.caozuoF,{"LEFT", frame.caozuoF, "LEFT",1, 0},{44,Apphang_Height-6},INVITE)
		PIGSetFont(frame.caozuoF.InviteButton.Text,12)
		frame.caozuoF.InviteButton:SetBackdropColor(0.545, 0.137, 0.137,1)
		UIEnterLeave(frame.caozuoF.InviteButton,frame.highlight)
		frame.caozuoF.InviteButton:HookScript("OnClick", function(self)
			if ( not IsInRaid(LE_PARTY_CATEGORY_HOME) and GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) + self:GetParent().numMembers + C_LFGList.GetNumInvitedApplicantMembers() > MAX_PARTY_MEMBERS + 1 ) then
				local dialog = StaticPopup_Show("LFG_LIST_INVITING_CONVERT_TO_RAID");
				if ( dialog ) then
					dialog.data = self:GetParent():GetParent().applicantID;
				end
			else
				C_LFGList.InviteApplicant(self:GetParent():GetParent().applicantID);
			end
		end)
		frame.caozuoF.DeclineButton = PIGDiyBut(frame.caozuoF, {"LEFT", frame.caozuoF.InviteButton, "RIGHT", 6, 0},{16,16})
		UIEnterLeave(frame.caozuoF.DeclineButton,frame.highlight)
		frame.caozuoF.DeclineButton:HookScript("OnClick", function(self)
			if ( self.isAck ) then
				C_LFGList.RemoveApplicant(self:GetParent():GetParent().applicantID);
			else
				C_LFGList.DeclineApplicant(self:GetParent():GetParent().applicantID);
			end
		end)
		frame.jieshaoF=PIGFrame(frame,{"TOPLEFT", frame.MemberBut, "TOPRIGHT", 0, 0})
		frame.jieshaoF:SetPoint("BOTTOMRIGHT", frame.caozuoF, "BOTTOMLEFT", 0, 0);
		frame.jieshaoF.t = PIGFontString(frame.jieshaoF,{"LEFT", frame.jieshaoF, "LEFT",0, 0});
		frame.jieshaoF.t:SetAllPoints(frame.jieshaoF)
		frame.jieshaoF.t:SetJustifyH("LEFT");
		UIEnterLeave(frame.jieshaoF.t,frame.highlight)
		frame.jieshaoF:SetScript("OnEnter", function (self)
			if self.t:IsTruncated() then
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
				GameTooltip:AddLine(AppbiaotiName[4][1],1,1,0, 0.9)
				GameTooltip:AddLine(self.t:GetText(), 0.9,0.9,0.9, true)
				GameTooltipTextLeft2:SetNonSpaceWrap(true)
				GameTooltip:Show();
			end
		end);
		frame.jieshaoF:HookScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		function frame:Updata_IsEnabled(Effective)
			if Effective then
				frame.jieshaoF.t:SetTextColor(0.5,0.5,0.5,1);
			else
				frame.jieshaoF.t:SetTextColor(0.9,0.9,0.9,1);
			end
		end
    end
    function FCTabF.DQ.Apply.Scroll:initialize()
		local view = CreateScrollBoxListLinearView()
	    view:SetElementExtent(Apphang_Height)
	    view:SetPadding(0,0,0,0,1)
	    ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, view)
        view:SetElementInitializer("Frame", function(frame, elementData)
        	FCTabF.DQ.Apply.Scroll.add_hang(frame)
        	FCTabF.DQ.Apply.Scroll:Update_hang(frame,elementData.AppID)
	    end)
	end
	FCTabF.DQ.Apply.Scroll:initialize()
	function FCTabF.DQ.Apply.Scroll:Update_hang(frame,AppID)
		frame:Updata_IsEnabled(true)
    	frame.applicantID=AppID
		local applicantInfo = C_LFGList.GetApplicantInfo(AppID);
		frame:SetHeight(applicantInfo.numMembers*Apphang_Height);
		frame.MemberBut:UpdateApplicantMember(AppID,applicantInfo)
		frame.jieshaoF.t:SetText(applicantInfo.comment);
		--更新邀请和拒绝
		--print(222,applicantInfo.applicationStatus)
		if ( applicantInfo.applicantInfo or applicantInfo.applicationStatus == "applied" ) then
			frame:Updata_IsEnabled(false)
			frame.caozuoF.Status:Hide();
		elseif ( applicantInfo.applicationStatus == "invited" ) then
			frame:Updata_IsEnabled(false)
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_INVITED);
			frame.caozuoF.Status:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		elseif ( applicantInfo.applicationStatus == "failed" or applicantInfo.applicationStatus == "cancelled" ) then
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_CANCELLED);
			frame.caozuoF.Status:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		elseif ( applicantInfo.applicationStatus == "declined" or applicantInfo.applicationStatus == "declined_full" or applicantInfo.applicationStatus == "declined_delisted" ) then
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_DECLINED);
			frame.caozuoF.Status:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		elseif ( applicantInfo.applicationStatus == "timedout" ) then
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_TIMED_OUT);
			frame.caozuoF.Status:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		elseif ( applicantInfo.applicationStatus == "inviteaccepted" ) then
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_INVITE_ACCEPTED);
			frame.caozuoF.Status:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		elseif ( applicantInfo.applicationStatus == "invitedeclined" ) then
			frame.caozuoF.Status:Show();
			frame.caozuoF.Status:SetText(LFG_LIST_APP_INVITE_DECLINED);
			frame.caozuoF.Status:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		end
		frame.caozuoF.numMembers = applicantInfo.numMembers;
		local useSmallInviteButton = LFGApplicationViewerRatingColumnHeader:IsShown();
		frame.caozuoF.Status:ClearAllPoints()
		frame.caozuoF.InviteButton:SetShown(not useSmallInviteButton and not applicantInfo.applicantInfo and applicantInfo.applicationStatus == "applied" and LFGListUtil_IsEntryEmpowered());
		frame.caozuoF.DeclineButton:SetShown(not applicantInfo.applicantInfo and applicantInfo.applicationStatus ~= "invited" and LFGListUtil_IsEntryEmpowered());
		frame.caozuoF.DeclineButton.isAck = (applicantInfo.applicationStatus ~= "applied" and applicantInfo.applicationStatus ~= "invited");
		if(frame.caozuoF.DeclineButton:IsShown()) then
			frame.caozuoF.Status:SetPoint("RIGHT", frame.caozuoF.DeclineButton, "LEFT", -14, 0);
		else
			frame.caozuoF.Status:SetPoint("LEFT", frame.caozuoF, "LEFT", 4, 0);
		end
	end
	function FCTabF.DQ.Apply.Scroll:Update_list()
		if not self:IsVisible() then return end
		FCTabF.DQ.Apply.Scroll.errt:Show()
		local view = self.ScrollBox:GetView()
		view:SetDataProvider(CreateDataProvider())
		local DataProvider = view:GetDataProvider();
		local applicants = C_LFGList.GetApplicants();
		if #applicants>0 then
			FCTabF.DQ.Apply.Scroll.errt:Hide()
			LFGListUtil_SortApplicants(applicants);
			for index = 1, #applicants do
				DataProvider:Insert({index=index, AppID=applicants[index]});
			end
		end
	end
	----
	function FCTabF:Update_ShownADD(bot,editMode)
		self.ADD.DescriptionF:SetShown(bot)
		self.ADD.Role:SetShown(bot)
		self.ADD.ListGroupButton:SetShown(bot)
		self.ADD.RemoveBut:SetShown(editMode)
	end
	function FCTabF:ClearActivityADD()
		--C_LFGList.ClearCreationTextFields();
		self.EditMode=nil
		self.selectedCategory = nil;
		self.selectedGroup = nil;
		self.selectedActivityCount=0
		wipe(self.selectedActivity)
		self.ADD:CategorieIsChecked(false)
		self.ADD:CategorieIsEnabled(true)
		self.ADD:Clear_Activitys()
		self.ADD.ADDerror:SetText("");
		self:Update_ShownADD(false)
	end
	function FCTabF:UpdateActivityADD()
		self.ADD:Show()
		if self.EditMode and C_LFGList.HasActiveEntryInfo() then
			self:Update_ShownADD(true,self.EditMode)
			self.ADD:CategorieIsEnabled(false)
			self.ADD:Clear_Activitys()
			self.ADD:Update_Activitys()
			self.ADD:ListGroupButton_Update()
			self.ADD.ListGroupButton:SetText(UPDATE..LFG_LIST_ACTIVITY)
			self.ADD.RemoveBut:Show()
		else
			if self.selectedCategory then
				self:Update_ShownADD(true)
				self.ADD:CategorieIsEnabled(true)
				self.ADD:Update_Activitys()
				self.ADD.ListGroupButton:SetText(CALENDAR_CREATE_EVENT)	
				self.ADD:ListGroupButton_Update()
			else
				self:ClearActivityADD()
			end
		end
	end
	function FCTabF:UpdateActivityDQ()
		self.DQ:Show()
		local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
		local huodongname=""
		local activityNames=""
		for acid=1,#activeEntryInfo.activityIDs do
			local activityID=activeEntryInfo.activityIDs[acid]
			local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
			activityNames=activityNames..activityInfo.fullName..", "
			local categoryInfo= C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID)
			if huodongname=="" then
				huodongname=FCTabF.tabListName[categoryInfo.name] or categoryInfo.name
			end
		end
		self.DQ.Category_V:SetText(huodongname);
		self.DQ.Name_V:SetText(activityNames);
		local roles = C_LFGListRoles.GetSavedRoles();
		self.DQ.Role.T:SetShown(roles.tank);
		self.DQ.Role.H:SetShown(roles.healer);
		self.DQ.Role.D:SetShown(roles.dps);
		self.DQ.Role.New:SetShown(GetCVarBool("lfgNewPlayerFriendly"));
		self.DQ.Description.V:SetText(activeEntryInfo.comment);
		self.DQ:Update_PlayerShowMode()
		self.DQ.Apply.Scroll:Update_list()
	end
	function FCTabF:UpdateEditMode(Mode)
		if not self:IsVisible() then return end
		if not self.tabList then
			self.tabList,self.tabListName=GetCategorieData()
		end
		self.ADD:Hide()
		self.DQ:Hide()
		if C_LFGList.HasActiveEntryInfo() and not self.EditMode then
			self:UpdateActivityDQ()
		else
			self:UpdateActivityADD()
		end
	end
	----------
	FCTabF:RegisterEvent("LFG_LIST_APPLICANT_UPDATED");
	FCTabF:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED");
	FCTabF:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");
	FCTabF:RegisterEvent("LFG_LIST_AVAILABILITY_UPDATE");
	FCTabF:RegisterEvent("GROUP_ROSTER_UPDATE");
	FCTabF:HookScript("OnEvent", function(self,event,arg1)
		--print(event,arg1)
		if event=="LFG_LIST_APPLICANT_UPDATED" then--來自申请人狀態改變
			-- if ( not LFGListUtil_IsEntryEmpowered() ) then--你不是队长则清除
			-- 	C_LFGList.RemoveApplicant(arg1);
			-- else
			-- 	local frame = self.DQ.Apply.Scroll.ScrollBox:FindFrameByPredicate(function(frame, elementData)
			-- 		return elementData.AppID == arg1;
			-- 	end);
			-- 	if frame then
			-- 		self.DQ.Apply.Scroll:Update_hang(frame, arg1)
			-- 	end
			-- end
		elseif event=="LFG_LIST_AVAILABILITY_UPDATE" then--列表可用性更新
			self.DQ:Update_PlayerShowMode()
		elseif event=="LFG_LIST_APPLICANT_LIST_UPDATED" then--申请人列表刷新
			self.DQ.Apply.Scroll:Update_list()
		elseif event=="GROUP_ROSTER_UPDATE" then
			self.DQ:Update_PlayerShowMode()
		elseif event=="LFG_LIST_ACTIVE_ENTRY_UPDATE" then----自己创建活动变动时Mode值(true新建/false编辑/nil取消)
			PENDING_LISTING_UPDATE = false;
			self:UpdateEditMode(arg1)
		end
	end);
end