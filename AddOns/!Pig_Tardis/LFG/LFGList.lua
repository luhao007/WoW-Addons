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
	local PIGDownMenu=Create.PIGDownMenu
	local FasongYCqingqiu=Fun.FasongYCqingqiu
	------
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local hang_Height,hang_NUM=InvF.hang_Height,InvF.hang_NUM-1
	local RolesName=InvF.RolesName
	local UpdatehangEnter=InvF.UpdatehangEnter
	-----
	TabF.CategorieButList={}
	function TabF:Enabled_Categorie(BOT)
		for i=1,#TabF.CategorieButList do
			TabF.CategorieButList[i]:SetEnabled(BOT)
		end
	end
		TabF:HookScript("OnShow", function (self)
		if not TabF.tabList then
			TabF.tabList=GetCategorieData()
		end
		for i=1,#TabF.tabList do
			if not TabF.CategorieButList[i] then
				TabF.CategorieButList[i] = PIGCheckbutton(TabF)
				if i==1 then
					TabF.CategorieButList[i]:SetPoint("TOPLEFT",TabF,"TOPLEFT",10,-10)
				else
					TabF.CategorieButList[i]:SetPoint("LEFT",TabF.CategorieButList[i-1].Text,"RIGHT",8,0)
				end
				TabF.CategorieButList[i]:HookScript("OnClick", function (self)
					for ix=1,#TabF.CategorieButList do
						TabF.CategorieButList[ix]:SetChecked(false)
					end
					self:SetChecked(true)
					TabF.selectedCategory=self:GetID()
					TabF:Refresh_ActType()
					TabF:Refresh_Difficulty()
					TabF:Refresh_FilterData3()
					wipe(TabF.selectedFBData)
					TabF:Update_Search()
				end)
			end
			TabF.CategorieButList[i]:Hide()
			TabF.CategorieButList[i]:Show()
			TabF.CategorieButList[i].Text:SetText(TabF.tabList[i][2])
			TabF.CategorieButList[i]:SetID(TabF.tabList[i][1])
			TabF.CategorieButList[i]:UpdateHitRectInsets()
		end
		TabF.Update_HangALL()
	end);
	--找队员还是找队伍
	TabF.ActTypeList={}
	TabF.selectActType=0
	for i=1,3 do
		
	end
	function TabF:Enabled_ActType(BOT)
		for i=1,#TabF.ActTypeList do
			TabF.ActTypeList[i]:SetEnabled(BOT)
		end
	end
	function TabF:Refresh_ActType()
		for i=1,#self.ActTypeList do
			self.ActTypeList[i]:Hide()
		end
		self.selectActType=0
		if InvF.ActTypeFilters[self.selectedCategory] then
			for i=1,#InvF.ActTypeFilters[self.selectedCategory] do
				if not self.ActTypeList[i] then
					self.ActTypeList[i] = PIGCheckbutton(TabF)
					if i==1 then
						self.ActTypeList[i]:SetPoint("TOPLEFT",TabF,"TOPLEFT",10,-40)
					else
						self.ActTypeList[i]:SetPoint("LEFT",TabF.ActTypeList[i-1].Text,"RIGHT",8,0)
					end
					self.ActTypeList[i]:HookScript("OnClick", function (self)
						for ix=1,#TabF.ActTypeList do
							TabF.ActTypeList[ix]:SetChecked(false)
						end
						self:SetChecked(true)
						TabF.selectActType=self.ActTypeID
						TabF.Update_HangALL(nil,true)
					end)
				end
				self.ActTypeList[i].ActTypeID=i-1
				self.ActTypeList[i]:Show()
				self.ActTypeList[i]:SetChecked(i==1 or false)
				self.ActTypeList[i].Text:SetText(InvF.ActTypeFilters[self.selectedCategory][i])
				self.ActTypeList[i]:UpdateHitRectInsets()
			end
		end
	end
	--难度过滤
	-- 1-地下城
	-- 2-地下城英雄
	-- 3-10人团队
	-- 4-25人团队
	-- 5-10人团队（英雄）	
	-- 6-25人团队（英雄）
	-- 9-40人团队
	-- 148-20人团队
	local DifficuData = {[2]={PLAYER_DIFFICULTY1,PLAYER_DIFFICULTY2},[114]={RAID_DIFFICULTY1,RAID_DIFFICULTY2}}
	local DifficuIDs = {[2]={1,2},[114]={{3,5},{4,6}}}
	TabF.DifficultyList={}
	TabF.selectDifficulty=0
	local function addDifficultyBut(i)
		if not TabF.DifficultyList[i] then
			local ckbut = PIGCheckbutton(TabF)
			ckbut:Hide()
			TabF.DifficultyList[i]=ckbut
			if i==1 then
				ckbut:SetPoint("LEFT",TabF.CategorieButList[#TabF.CategorieButList].Text,"RIGHT",36,0)
				ckbut.fenge = ckbut:CreateTexture();
				ckbut.fenge:SetAtlas("GreenCross")
				ckbut.fenge:SetSize(26,26);
				ckbut.fenge:SetPoint("RIGHT",ckbut,"LEFT",-2, 0);
			else
				ckbut:SetPoint("LEFT",TabF.DifficultyList[i-1].Text,"RIGHT",8,0)
			end
			ckbut:HookScript("OnClick", function (self)
				for ix=1,#TabF.DifficultyList do
					TabF.DifficultyList[ix]:SetChecked(false)
				end
				self:SetChecked(true)
				TabF.selectDifficulty=self.DifficuIDs
				TabF.Update_HangALL(nil,true)
			end)
			return ckbut
		end
	end
	function TabF:Enabled_Difficulty(BOT)
		for i=1,#TabF.DifficultyList do
			TabF.DifficultyList[i]:SetEnabled(BOT)
		end
	end
	function TabF:Refresh_Difficulty()
		self.SearchBox:SetText("")
		for i=1,#self.DifficultyList do
			self.DifficultyList[i]:Hide()
		end
		self.selectDifficulty=0
		if DifficuData[self.selectedCategory] then
			for ixx=1,#DifficuData[self.selectedCategory]+1 do
				addDifficultyBut(ixx)
				self.DifficultyList[ixx]:Show()
				if ixx==1 then
					self.DifficultyList[ixx].DifficuIDs=0
					self.DifficultyList[ixx]:SetChecked(true)
					self.DifficultyList[ixx].Text:SetText(ALL)
				else
					self.DifficultyList[ixx].DifficuIDs=DifficuIDs[self.selectedCategory][ixx-1]
					self.DifficultyList[ixx]:SetChecked(false)
					self.DifficultyList[ixx].Text:SetText(DifficuData[self.selectedCategory][ixx-1])
					self.DifficultyList[ixx]:UpdateHitRectInsets()
				end
			end
		end
	end
	--三级过滤
	local FilterData3 = InvF.FilterData3
	TabF.FilterData3List={}
	TabF.selectFilterData3={}
	for i=1,5 do
		
	end
	function TabF:Enabled_FilterData3(BOT)
		for i=1,#TabF.FilterData3List do
			TabF.FilterData3List[i]:SetEnabled(BOT)
		end
	end
	function TabF:Refresh_FilterData3()
		for i=1,#self.FilterData3List do
			self.FilterData3List[i]:Hide()
		end
		wipe(TabF.selectFilterData3)
		if FilterData3[self.selectedCategory] then
			for ixx=1,#FilterData3[self.selectedCategory] do
				if not self.FilterData3List[ixx] then
					self.FilterData3List[ixx] = PIGCheckbutton(TabF)
					if ixx==1 then
						self.FilterData3List[ixx].fenge = self.FilterData3List[ixx]:CreateTexture();
						self.FilterData3List[ixx].fenge:SetAtlas("GreenCross")
						self.FilterData3List[ixx].fenge:SetSize(26,26);
						self.FilterData3List[ixx].fenge:SetPoint("RIGHT",self.FilterData3List[ixx],"LEFT",-2, 0);
					else
						self.FilterData3List[ixx]:SetPoint("LEFT",TabF.FilterData3List[ixx-1].Text,"RIGHT",8,0)
					end
					self.FilterData3List[ixx]:HookScript("OnClick", function (self)
						if TabF.selectFilterData3[self.FilterData3ID] then
							TabF.selectFilterData3[self.FilterData3ID]=nil
						else
							TabF.selectFilterData3[self.FilterData3ID]=true
						end
						self:SetChecked(TabF.selectFilterData3[self.FilterData3ID])
						TabF.Update_HangALL(nil,true)
					end)
				end
				if ixx==1 then
					self.FilterData3List[ixx]:ClearAllPoints();
					self.FilterData3List[ixx]:SetPoint("LEFT",TabF.ActTypeList[#InvF.ActTypeFilters[self.selectedCategory]].Text,"RIGHT",30,0)
				end
				self.selectFilterData3[FilterData3[self.selectedCategory][ixx][2]]=nil
				self.FilterData3List[ixx].FilterData3ID=FilterData3[self.selectedCategory][ixx][2]
				self.FilterData3List[ixx]:Show()
				self.FilterData3List[ixx]:SetChecked(false)
				self.FilterData3List[ixx].Text:SetText(FilterData3[self.selectedCategory][ixx][1])
				self.FilterData3List[ixx]:UpdateHitRectInsets()
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
	TabF.SearchBox:HookScript("OnTextChanged", function(self)
    	TabF.IsSearchFilter()
	end)
	TabF.SearchBox:HookScript("OnEnterPressed", function(self)
		TabF:Update_Search()
	end);
	--选择具体副本
	TabF.FilterFBData={}
	TabF.selectedFBData={}
	TabF.FilterFB=PIGDownMenu(TabF,{"TOPRIGHT",TabF.SearchBoxBG,"BOTTOMRIGHT",0,-8},{90,22})
	TabF.FilterFB:PIGDownMenu_SetText(FILTER)
	TabF.FilterFB:Hide()
	function TabF.FilterFB:PIGDownMenu_Update_But()
		if not TabF.selectedCategory then return end
		self.fenlie=nil
		if TabF.selectedCategory==2 then
			--self.fenlie={1,10}
		elseif TabF.selectedCategory==116 then
			self.fenlie={1,18}
		end
		InvF.GetActivities(TabF.FilterFBData,TabF.selectedCategory)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#TabF.FilterFBData.groups,1 do
			local groupID=TabF.FilterFBData.groups[i][1]
			info.isTitle=true
			info.text = TabF.FilterFBData.groups[i][2]
			self:PIGDownMenu_AddButton(info)
			for ii=1,#TabF.FilterFBData.Activs[groupID] do
				local ActivityD=TabF.FilterFBData.Activs[groupID][ii]
				info.isTitle=nil
				info.isNotRadio=true
			    info.text, info.arg1 = InvF.UpdateLevelColor(nil,ActivityD[3],ActivityD[4],ActivityD[1]), ActivityD[2]
			    info.checked = TabF.selectedFBData[ActivityD[2]]
				self:PIGDownMenu_AddButton(info)
			end
		end 
	end
	function TabF.FilterFB:PIGDownMenu_SetValue(value,arg1,arg2,checked)
		if checked then
			TabF.selectedFBData[arg1]=true
		else
			TabF.selectedFBData[arg1]=nil
		end
		TabF.Update_HangALL(nil,true)
		PIGCloseDropDownMenus()
	end
	function TabF.IsSearchFilter()
		if TabF.selectActType~=0 or TabF.selectDifficulty~=0 or next(TabF.selectFilterData3)~=nil or next(TabF.selectedFBData)~=nil or
			TabF.SearchBox:GetText() ~= "" then
			TabF.ResetBut:Enable()
		else
			TabF.ResetBut:Disable()
		end
	end
	function TabF.ResetSearchFilter()
		TabF.ResetBut:Disable()
		--C_LFGList.ClearSearchResults();
		C_LFGList.ClearSearchTextFields();
		TabF:Refresh_ActType()
		TabF:Refresh_Difficulty()
		TabF:Refresh_FilterData3()
		wipe(TabF.selectedFBData)
		TabF.Update_HangALL(nil,true)
	end
	function TabF:DelayUpdateButEnable()
		TabF.RefreshBut:SetText(REFRESH)
		TabF.RefreshBut:Enable()
		TabF.SearchBoxBG:Show()
		if TabF.selectedCategory~=120 then TabF.FilterFB:Show() end
		TabF:Enabled_Categorie(true)
		TabF:Enabled_ActType(true)
		TabF:Enabled_Difficulty(true)
		TabF:Enabled_FilterData3(true)
	end
	function TabF:Update_Search()
		TabF.Returned=false
		TabF.RefreshBut:SetText(SEARCHING)
		TabF.RefreshBut:Disable()
		TabF.SearchBoxBG:Hide()
		TabF.FilterFB:Hide()
		TabF:Enabled_Categorie(false)
		TabF:Enabled_ActType(false)
		TabF:Enabled_Difficulty(false)
		TabF:Enabled_FilterData3(false)
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
	local biaotiName={{"目的地",6},{"司机(|cffFF80FF左"..L["CHAT_WHISPER"].."右"..INSPECT.."|r)",210},{MEMBERS,346},{"装等",464},{"详情",500},{"操作",800}}
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
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, TabF.Update_HangALL)
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
		hangL.mudidi:SetSize(biaotiName[2][2]-biaotiName[1][2]-4,hang_Height-4);
		hangL.mudidi:SetJustifyH("LEFT");

		hangL.chetou = CreateFrame("Frame", nil, hangL);
		hangL.chetou:SetSize(120,hang_Height);
		hangL.chetou:SetPoint("LEFT", hangL, "LEFT", biaotiName[2][2], 0);
		UpdatehangEnter(hangL.chetou,hangL)
		hangL.chetou.Class = hangL.chetou:CreateTexture(nil, "BORDER");
		hangL.chetou.Class:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		hangL.chetou.Class:SetSize(hang_Height*0.8,hang_Height*0.8);
		hangL.chetou.Class:SetPoint("BOTTOMLEFT", hangL.chetou, "BOTTOMLEFT", 0, 0);
		hangL.chetou.Role = hangL.chetou:CreateTexture(nil,"ARTWORK");
		hangL.chetou.Role:SetSize(hang_Height*0.5,hang_Height*0.5);
		hangL.chetou.Role:SetPoint("TOPLEFT", hangL.chetou.Class, "TOPLEFT", -3,6);
		hangL.chetou.level = PIGFontString(hangL.chetou,{"LEFT", hangL.chetou.Role, "RIGHT", -1,2},1,"OUTLINE",11);
		hangL.chetou.name = PIGFontString(hangL.chetou,{"LEFT", hangL.chetou, "LEFT", hang_Height*0.8, 0});
		hangL.chetou:SetScript("OnMouseUp", function(self,button)
			local allname = self:GetParent().allname
			if allname==UNKNOWNOBJECT then return end
			if button=="LeftButton" then
				local editBox = ChatEdit_ChooseBoxForSend();
				local hasText = editBox:GetText()
				if editBox:HasFocus() then
					editBox:SetText("/WHISPER " ..allname.." ".. hasText);
				else
					ChatEdit_ActivateChat(editBox)
					editBox:SetText("/WHISPER " ..allname.." ".. hasText);
				end
			else
				FasongYCqingqiu(allname)
			end
		end)
		--成员显示模式
		InvF.addPlayerShowMode(hangL,biaotiName[3][2]-4)

		hangL.ilv = PIGFontString(hangL,{"LEFT", hangL, "LEFT", biaotiName[4][2]-6, 0});
		hangL.ilv:SetJustifyH("RIGHT");
		hangL.ilv:SetWidth(34)

		hangL.commentF=PIGFrame(hangL,{"LEFT", hangL, "LEFT",biaotiName[5][2], 0},{biaotiName[6][2]-biaotiName[5][2]-4,hang_Height-4})
		UpdatehangEnter(hangL.commentF,hangL)
		hangL.commentF.t = PIGFontString(hangL.commentF,{"LEFT", hangL.commentF, "LEFT", 0, 0},nil,nil,nil,nil,nil,true);
		hangL.commentF.t:SetTextColor(0.9,0.9,0.9,0.9);
		hangL.commentF.t:SetAllPoints(hangL.commentF)
		hangL.commentF.t:SetJustifyH("LEFT");
		hangL.commentF.t.biaoti=biaotiName[5][1]
		UpdatehangEnter(hangL.commentF.t,hangL)

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
		function hangL:Updata_MudidiLvCom(searchResultInfo,ActivityInfo)
			local activityNames=""
			for acid=1,#searchResultInfo.activityIDs do
				local activityID=searchResultInfo.activityIDs[acid]
				local activityName = C_LFGList.GetActivityFullName(activityID, nil, searchResultInfo.isWarMode);
				if acid==#searchResultInfo.activityIDs then
					activityNames=activityNames..activityName
				else
					activityNames=activityNames..activityName..", "
				end
			end
			if ActivityInfo.categoryID==120 then
				self.mudidi:SetText(searchResultInfo.name);	
				self.commentF.t:SetText(searchResultInfo.comment)
			else
				self.mudidi:SetText(activityNames);	
				self.commentF.t:SetText(searchResultInfo.name..searchResultInfo.comment)
			end
			self.ilv:SetText(searchResultInfo.requiredItemLevel);
			local myItemLevel = GetAverageItemLevel();
			if myItemLevel>=searchResultInfo.requiredItemLevel then
				self.ilv:SetTextColor(0,1,0,1);
			else
				self.ilv:SetTextColor(1,0,0,1);
			end
			if searchResultInfo.isDelisted then
				self.mudidi:SetTextColor(0.5,0.5,0.5,1);
				self.commentF.t:SetTextColor(0.5,0.5,0.5,1);
				self.ilv:SetTextColor(0.5,0.5,0.5,1);
			else
				self.mudidi:SetTextColor(0,0.98,0.6, 1);
				self.commentF.t:SetTextColor(0.9,0.9,0.9,0.9);
			end
		end
		function hangL:Updata_LeaderChengke(searchResultInfo,ActivityInfo)
			local resultID=self.resultID
			local leaderInfo = C_LFGList.GetSearchResultLeaderInfo(resultID);
			local nameColor = NORMAL_FONT_COLOR;
			if (leaderInfo and leaderInfo.classFilename) then
				self.chetou.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[leaderInfo.classFilename]));
				nameColor = RAID_CLASS_COLORS[leaderInfo.classFilename];
			end
			self.chetou.Class:SetDesaturated(searchResultInfo.isDelisted);
			self.chetou.Role:SetDesaturated(searchResultInfo.isDelisted)
			self.chetou.Role:SetAtlas(InvF.RolesNameIcon[leaderInfo.assignedRole])
			self.chetou.level:SetText(leaderInfo.level);
			if leaderInfo.level==GetMaxPlayerLevel() then
				self.chetou.level:Hide()
			else
				self.chetou.level:Show()
			end
			local allname=searchResultInfo.leaderName or UNKNOWNOBJECT
			self.allname=allname
			local wjName, fuwiqi = strsplit("-", allname);
			if fuwiqi then
				self.chetou.name:SetText(wjName.."(*)");
			else
				self.chetou.name:SetText(allname);
			end
			if not searchResultInfo.isDelisted then
				self.chetou.level:SetTextColor(1, 0.843, 0, 1);
				self.chetou.name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);	
			else
				self.chetou.level:SetTextColor(0.5,0.5,0.5,1);
				self.chetou.name:SetTextColor(0.5,0.5,0.5,1);
			end
			self:ShowMode_Restore()
			local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
			if searchResultInfo.numMembers>1 then
				if ActivityInfo.displayType==Enum.LFGListDisplayType.RoleEnumerate then
					self.RoleEnumerate:Restore_But(0.2)
					self.RoleEnumerate:Update_But(displayData,searchResultInfo.isDelisted)
				else
					self.RoleCount:Restore_But()
					self.RoleCount:Update_But(displayData,searchResultInfo.isDelisted)
				end
			end
		end
		function hangL:Updata_Caozuo(searchResultInfo)
			if C_LFGList.HasActiveEntryInfo() then
				self.caozuo:Hide()
				return
			end
			self.caozuo.Apply:SetShown(false)
			self.caozuo.CancelButton:SetShown(false)
			self.caozuo.PendingLabel:SetShown(false)
			self.caozuo.ExpirationTime:SetShown(false)
			if not searchResultInfo.isDelisted then
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
	--过滤搜索字符
	local function IsShowSearchData(keyList,key)
		if not key or key == "" then
			return true
		end
		if keyList:match(key) then
			return true
		end
		return false
	end
	local function IsShowFBData(activityID)
		if next(TabF.selectedFBData) then
			for k,v in pairs(TabF.selectedFBData) do
				if v and k==activityID then
					return true
				end
			end
			return false
		end
		return true
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
			if IsShowDifficulty(ActivityInfo.difficultyID or -1) and
				IsShowFBData(activityID) and IsShowSearchData(activityName or "",searchText) then
				table.insert(TabF.JieshouInfoList_Filte,TabF.JieshouInfoList[i])
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
		hangL.resultIDT:SetText(hangL.resultID);
		if searchResultInfo then
			local activityID=searchResultInfo.activityIDs[1]
			local ActivityInfo= C_LFGList.GetActivityInfoTable(activityID)
			hangL:Updata_MudidiLvCom(searchResultInfo,ActivityInfo)
			hangL:Updata_LeaderChengke(searchResultInfo,ActivityInfo)
			hangL:Updata_Caozuo(searchResultInfo,ActivityInfo)
		end
	end
	function TabF.Update_HangALL(self,Filtered)
		if not TabF:IsVisible() then return end
		TabF.Reset_HangALL()
		TabF.IsSearchFilter()
		if Filtered then TabF.FilteredSearchData() end
		local TotalNum=#TabF.JieshouInfoList_Filte
		local ScrollUI = self or TabF.F.Scroll
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
	TabF:RegisterEvent("LFG_LIST_SEARCH_RESULTS_RECEIVED");--搜索结束
	TabF:RegisterEvent("LFG_LIST_SEARCH_RESULT_UPDATED");--条目已经更新
	TabF:RegisterEvent("LFG_LIST_APPLICATION_STATUS_UPDATED");--申请后事件结果
	TabF:HookScript("OnEvent", function(self,event,searchResultID, newStatus, oldStatus, groupName)
		if self:IsShown() then
			if event == "LFG_LIST_SEARCH_RESULTS_RECEIVED" then
				self.PIGGetSearchResults()
				self.Update_HangALL(nil,true)
			elseif event == "LFG_LIST_SEARCH_RESULT_UPDATED" then
				TabF.GetHangBut(searchResultID)
			elseif event == "LFG_LIST_APPLICATION_STATUS_UPDATED" then
				TabF.GetHangBut(searchResultID)
			end
		end	
	end);
end