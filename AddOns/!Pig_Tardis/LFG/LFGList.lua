local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.LFGList(TabF,GetCategorieData,EnterF)
	local Create, Data, Fun, L= unpack(PIG)
	local match = _G.string.match
	---------------------
	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGFontString=Create.PIGFontString
	local PIGSetFont=Create.PIGSetFont
	local PIGDiyBut=Create.PIGDiyBut
	------
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local hang_Height,hang_NUM=InvF.hang_Height,InvF.hang_NUM-1
	local RolesName=InvF.RolesName
	local addPlayerListF=InvF.addPlayerListF
	local addPlayerListBut_1=InvF.addPlayerListBut_1
	local addPlayerListBut_2=InvF.addPlayerListBut_2
	local UpdatehangEnter=InvF.UpdatehangEnter
	-----
	TabF.CategorieButList={}
	for i=1,8 do
		local ckbut = PIGCheckbutton(TabF)
		TabF.CategorieButList[i]=ckbut
		if i==1 then
			ckbut:SetPoint("TOPLEFT",TabF,"TOPLEFT",10,-10)
		else
			ckbut:SetPoint("LEFT",TabF.CategorieButList[i-1].Text,"RIGHT",8,0)
		end
		ckbut:HookScript("OnClick", function (self)
			for ix=1,#TabF.CategorieButList do
				TabF.CategorieButList[ix]:SetChecked(false)
			end
			self:SetChecked(true)
			TabF.selectedCategory=self:GetID()
			TabF:RefreshDifficulty()
			TabF:Update_Search()
		end)
	end
	function TabF:CategorieIsEnabled(BOT)
		for i=1,#TabF.CategorieButList do
			TabF.CategorieButList[i]:SetEnabled(BOT)
		end
	end
	TabF:HookScript("OnShow", function (self)
		if not TabF.tabList then
			TabF.tabList=GetCategorieData()
		end
		for i=1,#TabF.CategorieButList do
			TabF.CategorieButList[i]:Hide()
			if TabF.tabList[i] then
				TabF.CategorieButList[i]:Show()
				TabF.CategorieButList[i].Text:SetText(TabF.tabList[i][2])
				TabF.CategorieButList[i]:SetID(TabF.tabList[i][1])
				TabF.CategorieButList[i]:UpdateHitRectInsets()
			end
		end
		TabF.Update_HangALL()
	end);
	--难度
	local DifficuData = {[2]={PLAYER_DIFFICULTY1,PLAYER_DIFFICULTY2},[114]={RAID_DIFFICULTY1,RAID_DIFFICULTY2}}
	local DifficuIDs = {[2]={1,2},[114]={{3,5},{4,6}}}
	TabF.DifficultyList={}
	for i=1,5 do
		local ckbut = PIGCheckbutton(TabF)
		ckbut:Hide()
		TabF.DifficultyList[i]=ckbut
		if i==1 then
			ckbut:SetPoint("TOPLEFT",TabF,"TOPLEFT",10,-40)
		else
			ckbut:SetPoint("LEFT",TabF.DifficultyList[i-1].Text,"RIGHT",8,0)
		end
		ckbut:HookScript("OnClick", function (self)
			if i==1 then
				for ix=1,#TabF.DifficultyList do
					TabF.DifficultyList[ix]:SetChecked(true)
				end
			else
				for ix=1,#TabF.DifficultyList do
					TabF.DifficultyList[ix]:SetChecked(false)
				end
				self:SetChecked(true)
			end
			TabF.selectDifficulty=self.DifficuIDs
			TabF.Update_HangALL()
		end)
	end
	function TabF:DifficultyIsEnabled(BOT)
		for i=1,#TabF.DifficultyList do
			TabF.DifficultyList[i]:SetEnabled(BOT)
		end
	end
	function TabF:RefreshDifficulty()
		self.SearchBox:SetText("")
		for i=1,#self.DifficultyList do
			self.DifficultyList[i]:Hide()
		end
		self.selectDifficulty=0
		if DifficuData[self.selectedCategory] then
			self.DifficultyList[1].DifficuIDs=0
			self.DifficultyList[1]:Show()
			self.DifficultyList[1]:SetChecked(true)
			self.DifficultyList[1].Text:SetText(ALL)
			for ixx=2,#DifficuData[self.selectedCategory]+1 do
				self.DifficultyList[ixx].DifficuIDs=DifficuIDs[self.selectedCategory][ixx-1]
				self.DifficultyList[ixx]:Show()
				self.DifficultyList[ixx]:SetChecked(true)
				self.DifficultyList[ixx].Text:SetText(DifficuData[self.selectedCategory][ixx-1])
			end
		end
	end
	--搜索
	TabF.SearchBoxBG=PIGFrame(TabF,{"TOPRIGHT",TabF,"TOPRIGHT",-110,-6},{120,18})
	TabF.SearchBoxBG:PIGSetBackdrop(0,0.8,nil,{0.5, 0.5, 0.5})
	TabF.SearchBoxBG:Hide()
	TabF.SearchBox = CreateFrame("EditBox", nil, TabF.SearchBoxBG, "SearchBoxTemplate");
	TabF.SearchBox:SetPoint("TOPLEFT",TabF.SearchBoxBG,"TOPLEFT",3,-1);
	TabF.SearchBox:SetPoint("BOTTOMRIGHT",TabF.SearchBoxBG,"BOTTOMRIGHT",0,1);
	TabF.SearchBox.Left:Hide()
    TabF.SearchBox.Middle:Hide()
    TabF.SearchBox.Right:Hide()
    TabF.SearchBox:HookScript("OnEditFocusLost", function(self)
		TabF.SearchBoxBG:PIGSetBackdrop(0,0.8,nil,{0.5, 0.5, 0.5})
	end)
	TabF.SearchBox:HookScript("OnEditFocusGained", function(self)
		TabF.SearchBoxBG:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
	end);
	TabF.SearchBox:HookScript("OnEnterPressed", function(self)
		TabF:Update_Search()
	end);
	--刷新按钮
	TabF.RefreshBut=PIGButton(TabF,{"TOPRIGHT",TabF,"TOPRIGHT",-20,-6},{74,21},REFRESH)
	TabF.RefreshBut:Disable()
	TabF.RefreshBut:HookScript("OnClick", function (self)
		TabF:Update_Search()
	end);
	--重置
	TabF.ResetBut=PIGButton(TabF,{"TOP",TabF.RefreshBut,"BOTTOM",0,-8},{74,21},RESET)
	TabF.ResetBut:Disable()
	TabF.ResetBut:HookScript("OnClick", function (self)
		TabF.ResetSearch()
	end);
	function TabF.ResetSearch()
		C_LFGList.ClearSearchResults();
		C_LFGList.ClearSearchTextFields();
		TabF.Reset_HangALL()
	end
	function TabF:DelayUpdateButEnable()
		TabF.RefreshBut:SetText(REFRESH)
		TabF.RefreshBut:Enable()
		TabF.SearchBoxBG:Show()
		TabF:CategorieIsEnabled(true)
		TabF:DifficultyIsEnabled(true)
	end
	function TabF:Update_Search()
		TabF.Returned=false
		TabF.RefreshBut:SetText(SEARCHING)
		TabF.RefreshBut:Disable()
		TabF.SearchBoxBG:Hide()
		TabF:CategorieIsEnabled(false)
		TabF:DifficultyIsEnabled(false)
		TabF.Reset_HangALL()
		local languages = C_LFGList.GetLanguageSearchFilter();
		C_LFGList.Search(TabF.selectedCategory, 0, 0, languages);--[1大分类][2小分类(5疑似自己建立队伍)][1推荐,2不推荐,4PVE,8PVP][语言过滤]
		C_Timer.After(2,function()
			if not TabF.Returned then TabF:DelayUpdateButEnable() end 
		end)
	end

	----
	TabF.F=PIGFrame(TabF,{"TOPLEFT",TabF,"TOPLEFT",0,-66})
	TabF.F:SetPoint("BOTTOMRIGHT",TabF,"BOTTOMRIGHT",0,0);
	TabF.F:PIGSetBackdrop()
	--
	local biaotiName={{"目的地",6},{"司机(|cffFF80FF点击"..L["CHAT_WHISPER"].."|r)",200},{"乘客",320},{"装等",440},{"详情",490},{"操作",800}}
	for i=1,#biaotiName do
		local biaoti=PIGFontString(TabF.F,{"TOPLEFT",TabF.F,"TOPLEFT",biaotiName[i][2],-5},biaotiName[i][1])
		biaoti:SetTextColor(1,1,0, 0.9);
	end
	TabF.F.line = PIGLine(TabF.F,"TOP",-24,nil,nil,{0.2,0.2,0.2,0.5})
	local hang_Width = TabF.F:GetWidth();
	TabF.F.Scroll = CreateFrame("ScrollFrame",nil,TabF.F, "FauxScrollFrameTemplate");  
	TabF.F.Scroll:SetPoint("TOPLEFT",TabF.F,"TOPLEFT",2,-24);
	TabF.F.Scroll:SetPoint("BOTTOMRIGHT",TabF.F,"BOTTOMRIGHT",-20,2);
	TabF.F.Scroll.ScrollBar:SetScale(0.8);
	TabF.F.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, TabF.Hang_Update)
	end)
	local function PIG_LFGListSearchEntry_UpdateExpiration(self)
		local duration = 0;
		local now = GetTime();
		if ( self.expiration and self.expiration > now ) then
			duration = self.expiration - now;
		end
		local minutes = math.floor(duration / 60);
		local seconds = duration % 60;
		self.caozuo.ExpirationTime:SetFormattedText("%d:%.2d", minutes, seconds);
	end
	TabF.CheduiListBut={}
	for i=1, hang_NUM, 1 do
		local hangL = CreateFrame("Button", nil, TabF.F,"BackdropTemplate");
		TabF.CheduiListBut[i]=hangL
		hangL:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
		hangL:SetSize(hang_Width-2,hang_Height);
		hangL:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
		if i==1 then
			hangL:SetPoint("TOPLEFT", TabF.F.Scroll, "TOPLEFT", 0, -1);
		else
			hangL:SetPoint("TOPLEFT", TabF.CheduiListBut[i-1], "BOTTOMLEFT", 0, -1);
		end
		UpdatehangEnter(hangL)
		hangL.resultIDT=PIGFontString(hangL,{"RIGHT", hangL, "LEFT", -10,0},0,"OUTLINE");
		hangL.resultIDT:Hide()
		hangL.mudidi = PIGFontString(hangL,{"LEFT", hangL, "LEFT",biaotiName[1][2], 0});
		hangL.mudidi:SetTextColor(0,0.98,0.6, 1);
		hangL.mudidi:SetJustifyH("LEFT");

		hangL.chetou = CreateFrame("Frame", nil, hangL);
		hangL.chetou:SetSize(120,hang_Height);
		hangL.chetou:SetPoint("LEFT", hangL, "LEFT", biaotiName[2][2], 0);
		UpdatehangEnter(hangL.chetou,hangL)
		hangL.chetou.T = PIGFontString(hangL,{"LEFT", hangL.chetou, "LEFT", 0, 0});
		hangL.chetou:SetScript("OnMouseUp", function(self,button)
			local wjName = self.allname
			if wjName==UNKNOWNOBJECT then return end
			local editBox = ChatEdit_ChooseBoxForSend();
			local hasText = editBox:GetText()
			if editBox:HasFocus() then
				editBox:SetText("/WHISPER " ..wjName.." ".. hasText);
			else
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("/WHISPER " ..wjName.." ".. hasText);
			end
		end)
		--五人本人员显示模式
		hangL.RoleEnumerate=addPlayerListF(hangL,biaotiName[3][2]-4)
		hangL.RoleEnumerate:HookScript("OnEnter", function (self)
			EnterF:Update_PlayersList(self)
		end);
		hangL.RoleEnumerate:HookScript("OnLeave", function (self)
			EnterF:Hide()
		end);
		hangL.RoleEnumerate.T,hangL.RoleEnumerate.Tjiao=addPlayerListBut_1(hangL.RoleEnumerate,1,1)
		hangL.RoleEnumerate.H,hangL.RoleEnumerate.Hjiao=addPlayerListBut_1(hangL.RoleEnumerate,2,2)
		hangL.RoleEnumerate.D,hangL.RoleEnumerate.Djiao=addPlayerListBut_1(hangL.RoleEnumerate,3,3)
		hangL.RoleEnumerate.D1,hangL.RoleEnumerate.D1jiao=addPlayerListBut_1(hangL.RoleEnumerate,4,3)
		hangL.RoleEnumerate.D2,hangL.RoleEnumerate.D2jiao=addPlayerListBut_1(hangL.RoleEnumerate,5,3)
		function hangL.RoleEnumerate:RestoreDefault(Alpha)
			self:Show()
			self.T:SetTexCoord(0,1,0,1);
			self.H:SetTexCoord(0,1,0,1);
			self.D:SetTexCoord(0,1,0,1);
			self.D1:SetTexCoord(0,1,0,1);
			self.D2:SetTexCoord(0,1,0,1);
			self.T:SetAtlas("bags-roundhighlight");
			self.H:SetAtlas("bags-roundhighlight");
			self.D:SetAtlas("bags-roundhighlight");
			self.D1:SetAtlas("bags-roundhighlight");
			self.D2:SetAtlas("bags-roundhighlight");
			self.T:SetAlpha(Alpha);
			self.H:SetAlpha(Alpha);
			self.D:SetAlpha(Alpha);
			self.D1:SetAlpha(Alpha);
			self.D2:SetAlpha(Alpha);
		end
		function hangL.RoleEnumerate:Update_Show(zhizex,Coord)
			self[zhizex]:SetAlpha(1);
			self[zhizex]:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			self[zhizex]:SetTexCoord(unpack(CLASS_ICON_TCOORDS[Coord]));
		end
		--其他人员显示模式
		hangL.RoleCount=addPlayerListF(hangL,biaotiName[3][2]-4)
		hangL.RoleCount:HookScript("OnEnter", function (self)
			EnterF:Update_PlayersList(self)
		end);
		hangL.RoleCount:HookScript("OnLeave", function (self)
			EnterF:Hide()
		end);
		hangL.RoleCount.T,hangL.RoleCount.TNum=addPlayerListBut_2(hangL.RoleCount,1)	
		hangL.RoleCount.H,hangL.RoleCount.HNum=addPlayerListBut_2(hangL.RoleCount,2)
		hangL.RoleCount.D,hangL.RoleCount.DNum=addPlayerListBut_2(hangL.RoleCount,3)

		hangL.ilv = PIGFontString(hangL,{"LEFT", hangL, "LEFT", biaotiName[4][2]-6, 0});
		hangL.ilv:SetJustifyH("RIGHT");
		hangL.ilv:SetWidth(34)

		hangL.commentF=PIGFrame(hangL,{"LEFT", hangL, "LEFT",biaotiName[5][2], 0},{310,hang_Height-4})
		UpdatehangEnter(hangL.commentF,hangL)
		hangL.commentF.t = PIGFontString(hangL.commentF,{"LEFT", hangL.commentF, "LEFT", 0, 0});
		hangL.commentF.t:SetTextColor(0.9,0.9,0.9,0.9);
		hangL.commentF.t:SetAllPoints(hangL.commentF)
		hangL.commentF.t:SetJustifyH("LEFT");
		hangL.commentF:HookScript("OnEnter", function (self)
			if self.t:IsTruncated() then
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
				GameTooltip:AddLine(biaotiName[5][1],1,1,0, 0.9)
				GameTooltip:AddLine(self.t:GetText(), 0.9,0.9,0.9, true)
				GameTooltipTextLeft2:SetNonSpaceWrap(true)
				GameTooltip:Show();
			end
		end);
		hangL.commentF:HookScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);

		hangL.caozuo=PIGFrame(hangL,{"LEFT", hangL, "LEFT", biaotiName[6][2], 0},{54,hang_Height})
		UpdatehangEnter(hangL.caozuo,hangL)
		hangL.caozuo.Apply = PIGButton(hangL.caozuo, {"LEFT", hangL.caozuo, "LEFT", 0, 0},{46,18},SIGN_UP);
		UpdatehangEnter(hangL.caozuo.Apply,hangL)
		PIGSetFont(hangL.caozuo.Apply.Text,12)
		hangL.caozuo.Apply:SetBackdropColor(0.545, 0.137, 0.137,1)
		hangL.caozuo.Apply:HookScript("OnClick", function(self)
			--C_LFGList.ApplyToGroup(self.resultID)
			LFGListApplicationDialog_Show(LFGListApplicationDialog, self:GetParent():GetParent().resultID);
		end)
		hangL.caozuo.CancelButton = PIGDiyBut(hangL.caozuo, {"RIGHT", hangL.caozuo, "RIGHT", 2, 0})
		UpdatehangEnter(hangL.caozuo.CancelButton,hangL)
		hangL.caozuo.CancelButton:HookScript("OnClick", function(self)
			C_LFGList.CancelApplication(self:GetParent():GetParent().resultID);
		end)
		hangL.caozuo.PendingLabel = PIGFontString(hangL.caozuo,{"RIGHT", hangL.caozuo.CancelButton, "LEFT", 0, 5.6},"","OUTLINE",12);
		hangL.caozuo.ExpirationTime = PIGFontString(hangL.caozuo,{"RIGHT", hangL.caozuo.CancelButton, "LEFT", -2, -5.6},"","OUTLINE",12);
		hangL.caozuo.ExpirationTime:SetTextColor(0, 1, 0);

		function hangL:Updata_mudidi(searchResultInfo,SetcategoryID)
			local activityID=searchResultInfo.activityIDs[1]
			local activityName = C_LFGList.GetActivityFullName(activityID, nil, searchResultInfo.isWarMode);
			if SetcategoryID==2 then
				hangL.mudidi:SetText(activityName);
			elseif SetcategoryID==114 then
				hangL.mudidi:SetText(activityName);
			elseif SetcategoryID==116 then
				hangL.mudidi:SetText(activityName.."("..searchResultInfo.name..")");
			elseif SetcategoryID==118 then
				hangL.mudidi:SetText(activityName);
			elseif SetcategoryID==120 then
				hangL.mudidi:SetText(searchResultInfo.name);
			end
		end
		function hangL:Updata_IsEnabled(Effective)
			self.caozuo.Apply:SetShown(false)
			self.caozuo.CancelButton:SetShown(false)
			self.caozuo.PendingLabel:SetShown(false)
			self.caozuo.ExpirationTime:SetShown(false)
			self.RoleCount.T:SetDesaturated(Effective)
			self.RoleCount.H:SetDesaturated(Effective)
			self.RoleCount.D:SetDesaturated(Effective)
			self.RoleEnumerate.T:SetDesaturated(Effective)
			self.RoleEnumerate.H:SetDesaturated(Effective)
			self.RoleEnumerate.D:SetDesaturated(Effective)
			self.RoleEnumerate.D1:SetDesaturated(Effective)
			self.RoleEnumerate.D2:SetDesaturated(Effective)
			self.RoleEnumerate.Tjiao:SetDesaturated(Effective)
			self.RoleEnumerate.Hjiao:SetDesaturated(Effective)
			self.RoleEnumerate.Djiao:SetDesaturated(Effective)
			self.RoleEnumerate.D1jiao:SetDesaturated(Effective)
			self.RoleEnumerate.D2jiao:SetDesaturated(Effective)
			if Effective then
				self.mudidi:SetTextColor(0.5,0.5,0.5,1);
				self.chetou.T:SetTextColor(0.5,0.5,0.5,1);
				self.RoleCount.TNum:SetTextColor(0.5,0.5,0.5,1);
				self.RoleCount.HNum:SetTextColor(0.5,0.5,0.5,1);
				self.RoleCount.DNum:SetTextColor(0.5,0.5,0.5,1);
				self.ilv:SetTextColor(0.5,0.5,0.5,1);
				self.commentF.t:SetTextColor(0.5,0.5,0.5,1);
			else
				self.mudidi:SetTextColor(0,0.98,0.6, 1);
				self.chetou.T:SetTextColor(1,1,1,1);
				self.RoleCount.TNum:SetTextColor(1, 1, 1, 1);
				self.RoleCount.HNum:SetTextColor(1, 1, 1, 1);
				self.RoleCount.DNum:SetTextColor(1, 1, 1, 1);
				self.commentF.t:SetTextColor(0.9,0.9,0.9,0.9);
			end
		end
		hangL.dixiacinfo={}
		function hangL:Updata_Chengke(searchResultInfo,SetcategoryID)
			self.RoleCount:Hide()
			self.RoleEnumerate:Hide()
			local resultID=self.resultID
			local activityID=searchResultInfo.activityIDs[1]
			local ActivityInfo= C_LFGList.GetActivityInfoTable(activityID)
			if ActivityInfo.displayType==Enum.LFGListDisplayType.RoleEnumerate then
				self.RoleEnumerate:RestoreDefault(0.2)
				wipe(self.dixiacinfo)
				for ix=1,#RolesName do
					self.dixiacinfo[RolesName[ix]]={}
				end
				for ix=1, searchResultInfo.numMembers do
					local role, class, classLocalized, specLocalized = C_LFGList.GetSearchResultMemberInfo(resultID, ix);
					table.insert(self.dixiacinfo[role],class)
				end
				if #self.dixiacinfo[RolesName[1]]>0 then
					self.RoleEnumerate:Update_Show("T",self.dixiacinfo[RolesName[1]][1])
				end
				if #self.dixiacinfo[RolesName[2]]>0 then
					self.RoleEnumerate:Update_Show("H",self.dixiacinfo[RolesName[2]][1])
				end
				if #self.dixiacinfo[RolesName[3]]>0 then
					self.RoleEnumerate:Update_Show("D",self.dixiacinfo[RolesName[3]][1])
					if self.dixiacinfo[RolesName[3]][2] then
						self.RoleEnumerate:Update_Show("D1",self.dixiacinfo[RolesName[3]][2])
					end
					if self.dixiacinfo[RolesName[3]][3] then
						self.RoleEnumerate:Update_Show("D2",self.dixiacinfo[RolesName[3]][3])
					end
				end
			else
				self.RoleCount:Show()
				local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);			
				self.RoleCount.TNum:SetText(displayData.TANK);
				self.RoleCount.HNum:SetText(displayData.HEALER);
				self.RoleCount.DNum:SetText(displayData.DAMAGER);
			end
		end
		function hangL:Updata_caozuo()
			if C_LFGList.HasActiveEntryInfo() then
				self.caozuo:Hide()
				return
			end
			self.caozuo:Show()
			local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(self.resultID);
			--print(_, appStatus, pendingStatus, appDuration)
			-- pendingStatus/appStatus可能的值
			-- applied - 已提交申请
			-- invited - 申请后被邀请加入小组
			-- inviterejected - 您拒绝了邀请
			-- inviteaccepted - 您接受了邀请
			-- cancelled - 您取消了申请
			-- timedout - 应用程序超时
			-- rejected - 您的申请被拒绝
			-- declined_full - 组现已满员
			-- declined_delisted - 活动已移除
			-- none - 无
			local isApplication = (appStatus ~= "none" or pendingStatus);
			if ( pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_ROLE_CHECK);
				self.caozuo.PendingLabel:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_APP_CANCELLED);
				self.caozuo.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( appStatus == "declined" or appStatus == "declined_full" or appStatus == "declined_delisted" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText((appStatus == "declined_full") and LFG_LIST_APP_FULL or LFG_LIST_APP_DECLINED);
				self.caozuo.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( appStatus == "timedout" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_APP_TIMED_OUT);
				self.caozuo.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( appStatus == "invited" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_APP_INVITED);
				self.caozuo.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( appStatus == "inviteaccepted" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_APP_INVITE_ACCEPTED);
				self.caozuo.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( appStatus == "invitedeclined" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_APP_INVITE_DECLINED);
				self.caozuo.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
			elseif ( isApplication and pendingStatus ~= "applied" ) then
				self.caozuo.Apply:Hide()
				self.caozuo.PendingLabel:SetText(LFG_LIST_PENDING);
				self.caozuo.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				self.caozuo.PendingLabel:Show();
				self.caozuo.ExpirationTime:Show();
				self.caozuo.CancelButton:Show();
			else
				self.caozuo.PendingLabel:Hide();
				self.caozuo.ExpirationTime:Hide();
				self.caozuo.CancelButton:Hide();
				self.caozuo.Apply:Show()
			end
			if ( self.caozuo.ExpirationTime:IsShown() ) then
				self.caozuo.PendingLabel:SetPoint("RIGHT", self.caozuo.CancelButton, "LEFT", 0, 5.6);
			else
				self.caozuo.PendingLabel:SetPoint("RIGHT", self.caozuo.CancelButton, "LEFT", 4, 0);
			end
			self.expiration = GetTime() + appDuration;
			if ( isApplication ) then
				self:SetScript("OnUpdate", PIG_LFGListSearchEntry_UpdateExpiration);
				PIG_LFGListSearchEntry_UpdateExpiration(self);
			else
				self:SetScript("OnUpdate", nil);
			end
		end
	end
	---
	TabF.JieshouInfoList={}
	TabF.JieshouInfoList_Filte={}
	function TabF.Reset_HangALL()
		for i=1,#TabF.CheduiListBut do
			TabF.CheduiListBut[i]:Hide()
			TabF.CheduiListBut[i].resultID=nil
		end
	end
	TabF.Reset_HangALL()
	--过滤难度
	local function IsShowDifficulty(difficultyID)
		if TabF.selectDifficulty==0 then
			return true
		end
		if type(TabF.selectDifficulty)=="table" then
			for i=1,#TabF.selectDifficulty do
				if TabF.selectDifficulty==TabF.selectDifficulty[i] then
					return true
				end
			end
		else
			if TabF.selectDifficulty==difficultyID then
				return true
			end
		end
		return false
	end
	--过滤自定义字符
	local function IsShowData(data,key)
		if not key or key == "" then
			return true
		end
		for _,v in pairs(data) do
			if v:match(key) then
				return true
			end
		end
		return false
	end
	function TabF.PIGGetSearchResults()
		TabF.Returned=true
		wipe(TabF.JieshouInfoList)
		C_Timer.After(1,function() TabF:DelayUpdateButEnable() end)
		local totalResultsFound, results = C_LFGList.GetSearchResults()
		for i=1,totalResultsFound do
			table.insert(TabF.JieshouInfoList,results[i])
		end
	end
	function TabF.FilteredSearchData()
		wipe(TabF.JieshouInfoList_Filte)
		local searchText = TabF.SearchBox:GetText()
		for i=1,#TabF.JieshouInfoList do
			local searchResultInfo=C_LFGList.GetSearchResultInfo(TabF.JieshouInfoList[i])
			local activityID=searchResultInfo.activityIDs[1]
			local ActivityInfo= C_LFGList.GetActivityInfoTable(activityID)
			local activityName = C_LFGList.GetActivityFullName(activityID, nil, searchResultInfo.isWarMode);
			if IsShowDifficulty(ActivityInfo.difficultyID or -1) and IsShowData({activityName or "",searchResultInfo.name or "",searchResultInfo.comment or ""},searchText) then
				table.insert(TabF.JieshouInfoList_Filte,TabF.JieshouInfoList[i])
			end
		end
	end
	function TabF.Update_HangALL()
		if not TabF:IsVisible() then return end
		TabF.Reset_HangALL()
		TabF.FilteredSearchData()
		local TotalNum=#TabF.JieshouInfoList_Filte
		local ScrollUI = TabF.F.Scroll
		FauxScrollFrame_Update(ScrollUI, TotalNum, hang_NUM, hang_Height);
    	local offset = FauxScrollFrame_GetOffset(ScrollUI);
    	for But = 1, hang_NUM do
			local dangqian = But+offset;
			if TabF.JieshouInfoList_Filte[dangqian] then
				TabF.CheduiListBut[But]:Show()
				TabF.CheduiListBut[But].resultID=TabF.JieshouInfoList_Filte[dangqian]
				TabF.Update_Hang(TabF.CheduiListBut[But])
			end
		end
	end
	function TabF.GetHangBut(resultID)
		for But = 1, hang_NUM do
			if TabF.CheduiListBut[But].resultID==resultID then
				return TabF.Update_Hang(TabF.CheduiListBut[But])
			end
		end
	end
	function TabF.Update_Hang(hangL)
		local searchResultInfo=C_LFGList.GetSearchResultInfo(hangL.resultID)
		if searchResultInfo then
			hangL:Updata_IsEnabled(searchResultInfo.isDelisted)
			if not searchResultInfo.isDelisted then
				local activityID=searchResultInfo.activityIDs[1]
				hangL.resultIDT:SetText(resultID);
				local ActivityInfo= C_LFGList.GetActivityInfoTable(activityID)
				--print(ActivityInfo.difficultyID)
				-- for k,v in pairs(ActivityInfo) do
				-- 	print(k,v)
				-- end			
				local allname=searchResultInfo.leaderName or UNKNOWNOBJECT
				hangL.chetou.allname=allname
				local wjName, fuwiqi = strsplit("-", allname);
				if fuwiqi then
					hangL.chetou.T:SetText(wjName.."(*)");
				else
					hangL.chetou.T:SetText(allname);
				end
				hangL.ilv:SetText(searchResultInfo.requiredItemLevel);
				local myItemLevel = GetAverageItemLevel();
				if myItemLevel>=searchResultInfo.requiredItemLevel then
					hangL.ilv:SetTextColor(0,1,0,1);
				else
					hangL.ilv:SetTextColor(1,0,0,1);
				end
				hangL.commentF.t:SetText(searchResultInfo.name..searchResultInfo.comment)
				hangL:Updata_mudidi(searchResultInfo,ActivityInfo.categoryID)
				hangL:Updata_Chengke(searchResultInfo,ActivityInfo.categoryID)
				hangL:Updata_caozuo()
			end
		end
	end
	TabF:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");--搜索结束
	TabF:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");--条目已经更新
	TabF:RegisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED");--申请后事件结果
	TabF:HookScript("OnEvent", function(self,event,searchResultID, newStatus, oldStatus, groupName)
		if self:IsShown() then
			if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
				self.PIGGetSearchResults()
				self.Update_HangALL()
			elseif event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
				TabF.GetHangBut(searchResultID)
			elseif event == "LFG_LIST_APPLICATION_STATUS_UPDATED" then
				TabF.GetHangBut(searchResultID)
			end
		end	
	end);
end