local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.LFGCreation(FCTabF,GetCategorieData,EnterF)
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
	-- -----------------
	local TalentData=Data.TalentData
	local GetTianfuIcon_YC=TalentData.GetTianfuIcon_YC
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
	local InvF=_G[GnUI]
	local RolesName=InvF.RolesName
	local addPlayerListF=InvF.addPlayerListF
	local addPlayerListBut_1=InvF.addPlayerListBut_1
	local addPlayerListBut_2=InvF.addPlayerListBut_2
	local UpdatehangEnter=InvF.UpdatehangEnter
	----
	FCTabF:HookScript("OnShow", function (self)
		self:UpdateEditMode()
	end);

	--创建车队
	FCTabF.ADD.Category_T=PIGFontString(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD,"TOPLEFT",20,-20},"选择要创建车队类型")
	FCTabF.ADD.CategorieButList={}
	for i=1,8 do
		local ckbut = PIGCheckbutton(FCTabF.ADD)
		FCTabF.ADD.CategorieButList[i]=ckbut
		if i==1 then
			ckbut:SetPoint("TOPLEFT",FCTabF.ADD,"TOPLEFT",20,-40)
		elseif i==4 then
			ckbut:SetPoint("TOPLEFT",FCTabF.ADD.CategorieButList[1],"TOPLEFT",0,-30)
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

	FCTabF.ADD.GroupDropDown =PIGDownMenu(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.Category_T,"TOPLEFT",0,-110},{FCTabF.ADD.Width,nil})
	FCTabF.ADD.GroupDropDown:Hide()
	FCTabF.ADD.GroupDropDown.t=PIGFontString(FCTabF.ADD.GroupDropDown,{"BOTTOMLEFT",FCTabF.ADD.GroupDropDown,"TOPLEFT",0,4},"目的地")
	function FCTabF.ADD.GroupDropDown:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		local ActivityGroups = C_LFGList.GetAvailableActivityGroups(FCTabF.selectedCategory)
		for i=1,#ActivityGroups,1 do
			local groupID = ActivityGroups[i];
			local name = C_LFGList.GetActivityGroupInfo(groupID);
		    info.text, info.arg1, info.arg2 = name, groupID, "group";
		    info.checked = groupID == FCTabF.selectedGroup
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function FCTabF.ADD.GroupDropDown:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		FCTabF.selectedGroup=arg1
		local activities = C_LFGList.GetAvailableActivities(FCTabF.selectedCategory,FCTabF.selectedGroup)
		FCTabF.selectedActivity=activities[1] or 0
		FCTabF:UpdateActivityADD()
		PIGCloseDropDownMenus()
	end
	--
	FCTabF.ADD.ActivityDropDown =PIGDownMenu(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.GroupDropDown,"BOTTOMLEFT",0,-8},{FCTabF.ADD.Width,nil})
	FCTabF.ADD.ActivityDropDown:Hide()
	local function panduancunzaitongName(heji,name1)
		for i=1,#heji do
			if heji[i][1]==name1 then
				return false
			end
		end
		return true
	end
	function FCTabF.ADD.ActivityDropDown:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		local Activities = C_LFGList.GetAvailableActivities(FCTabF.selectedCategory,FCTabF.selectedGroup)
		local newActivities = {}
		for i=1,#Activities,1 do
			local ActivityInfo= C_LFGList.GetActivityInfoTable(Activities[i])
			if FCTabF.selectedGroup==300 then
				if panduancunzaitongName(newActivities,ActivityInfo.fullName) then
					table.insert(newActivities,{ActivityInfo.fullName,Activities[i]})
				end
			else
				table.insert(newActivities,{ActivityInfo.fullName,Activities[i]})
			end
		end
		for i=1,#newActivities,1 do
		    info.text, info.arg1, info.arg2 = newActivities[i][1], newActivities[i][2], "activity";
		    info.checked = newActivities[i][2] == FCTabF.selectedActivity
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function FCTabF.ADD.ActivityDropDown:PIGDownMenu_SetValue(value,arg1,arg2)
		self:PIGDownMenu_SetText(value)
		FCTabF.selectedActivity=arg1
		FCTabF:UpdateActivityADD()
		PIGCloseDropDownMenus()
	end
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
	FCTabF.ADD.ItemLevel=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.ActivityDropDown,"BOTTOMLEFT",0,-40},{FCTabF.ADD.Width,24})
	FCTabF.ADD.ItemLevel:Hide()
	FCTabF.ADD.ItemLevel.CheckButton = PIGCheckbutton(FCTabF.ADD.ItemLevel,{"LEFT",FCTabF.ADD.ItemLevel,"LEFT",0,0},{LFG_LIST_ITEM_LEVEL_REQ,LFG_LIST_ITEM_LEVEL_REQ})
	FCTabF.ADD.ItemLevel.EditBox = CreateFrame("EditBox", nil, FCTabF.ADD.ItemLevel);
	FCTabF.ADD.ItemLevel.EditBox:SetPoint("LEFT", FCTabF.ADD.ItemLevel.CheckButton.Text, "RIGHT", 6,0);
	FCTabF.ADD.ItemLevel.EditBox:SetPoint("RIGHT", FCTabF.ADD.ItemLevel, "RIGHT", -90,0);
	FCTabF.ADD.ItemLevel.EditBox:SetHeight(20);
	PIGSetFont(FCTabF.ADD.ItemLevel.EditBox,14,"OUTLINE")
	FCTabF.ADD.ItemLevel.EditBox:SetMaxLetters(6)
	FCTabF.ADD.ItemLevel.EditBox:SetNumeric(true)
	FCTabF.ADD.ItemLevel.EditBox:SetAutoFocus(false)
	FCTabF.ADD.ItemLevel.EditBox.BG=PIGFrame(FCTabF.ADD.ItemLevel.EditBox,{"TOPLEFT", FCTabF.ADD.ItemLevel.EditBox, "TOPLEFT", -4,0})
	FCTabF.ADD.ItemLevel.EditBox.BG:SetPoint("BOTTOMRIGHT", FCTabF.ADD.ItemLevel.EditBox, "BOTTOMRIGHT", 4,0);
	FCTabF.ADD.ItemLevel.EditBox.BG:SetFrameLevel(FCTabF.ADD.ItemLevel.EditBox:GetFrameLevel()-1)
	SetEditBoxBG(FCTabF.ADD.ItemLevel.EditBox)
	FCTabF.ADD.ItemLevel.EditBox:SetScript("OnTextChanged", function(self)
		FCTabF.ADD:ListGroupButton_Update()
	end);
	FCTabF.ADD.ItemLevel.maxlvt=PIGFontString(FCTabF.ADD.ItemLevel,{"LEFT",FCTabF.ADD.ItemLevel.EditBox,"RIGHT",10,0},"当前")
	FCTabF.ADD.ItemLevel.maxlv=PIGFontString(FCTabF.ADD.ItemLevel,{"LEFT",FCTabF.ADD.ItemLevel.maxlvt,"RIGHT",0,0})

	FCTabF.ADD.VoiceChat=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.ItemLevel,"BOTTOMLEFT",0,-10},{FCTabF.ADD.Width,24})
	FCTabF.ADD.VoiceChat:Hide()
	FCTabF.ADD.VoiceChat.CheckButton = PIGCheckbutton(FCTabF.ADD.VoiceChat,{"LEFT",FCTabF.ADD.VoiceChat,"LEFT",0,0},{LFG_LIST_VOICE_CHAT,LFG_LIST_VOICE_CHAT_INSTR})
	FCTabF.ADD.VoiceChat.CheckButton:Disable()
	FCTabF.ADD.VoiceChat.EditBox = CreateFrame("EditBox", nil, FCTabF.ADD.VoiceChat);
	FCTabF.ADD.VoiceChat.EditBox:SetPoint("LEFT", FCTabF.ADD.VoiceChat.CheckButton.Text, "RIGHT", 6,0);
	FCTabF.ADD.VoiceChat.EditBox:SetPoint("RIGHT", FCTabF.ADD.VoiceChat, "RIGHT", -10,0);
	FCTabF.ADD.VoiceChat.EditBox:SetHeight(20);
	PIGSetFont(FCTabF.ADD.VoiceChat.EditBox,14,"OUTLINE")
	FCTabF.ADD.VoiceChat.EditBox:SetAutoFocus(false)
	FCTabF.ADD.VoiceChat.EditBox:Disable()
	FCTabF.ADD.VoiceChat.EditBox.BG=PIGFrame(FCTabF.ADD.VoiceChat.EditBox,{"TOPLEFT", FCTabF.ADD.VoiceChat.EditBox, "TOPLEFT", -4,0})
	FCTabF.ADD.VoiceChat.EditBox.BG:SetPoint("BOTTOMRIGHT", FCTabF.ADD.VoiceChat.EditBox, "BOTTOMRIGHT", 4,0);
	FCTabF.ADD.VoiceChat.EditBox.BG:PIGSetBackdrop(0,0.8,nil,{0.5, 0.5, 0.5})
	FCTabF.ADD.VoiceChat.EditBox.BG:SetFrameLevel(FCTabF.ADD.VoiceChat.EditBox:GetFrameLevel()-1)
	SetEditBoxBG(FCTabF.ADD.VoiceChat.EditBox)
	---
	FCTabF.ADD.CrossFactionGroup=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.VoiceChat,"BOTTOMLEFT",0,-10},{FCTabF.ADD.Width,24})
	FCTabF.ADD.CrossFactionGroup:Hide()
	local _, localizedFaction = UnitFactionGroup("player");
	FCTabF.ADD.CrossFactionGroup.CheckButton = PIGCheckbutton(FCTabF.ADD.CrossFactionGroup,{"LEFT",FCTabF.ADD.CrossFactionGroup,"LEFT",0,0},{LFG_LIST_CROSS_FACTION:format(localizedFaction),LFG_LIST_CROSS_FACTION_TOOLTIP:format(localizedFaction)})
	FCTabF.ADD.CrossFactionGroup.CheckButton:Disable()
	
	FCTabF.ADD.PrivateGroup=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.CrossFactionGroup,"BOTTOMLEFT",0,-10},{FCTabF.ADD.Width,24})
	FCTabF.ADD.PrivateGroup:Hide()
	FCTabF.ADD.PrivateGroup.CheckButton = PIGCheckbutton(FCTabF.ADD.PrivateGroup,{"LEFT",FCTabF.ADD.PrivateGroup,"LEFT",0,0},{"仅对公会/好友可见",LFG_LIST_PRIVATE_TOOLTIP})

	FCTabF.ADD.Role=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.PrivateGroup,"BOTTOMLEFT",0,-18},{FCTabF.ADD.Width,42})
	FCTabF.ADD.Role:Hide()
	FCTabF.ADD.Role.biao=PIGFontString(FCTabF.ADD.Role,{"LEFT",FCTabF.ADD.Role,"LEFT",0,0},"职\n责")
	function FCTabF.ADD.Role_checkButton(self)
		local roleFf = self:GetParent()
		if ( self:GetChecked() ) then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		else
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		end
		local leader, tank, healer, dps = GetLFGRoles();
		local dialog = LFGListCreateRoleDialog
		if dialog.exclusive then
			local setDPS = false;
			local setTank = false;
			local setHealer = false;
			if roleFf:GetID() == 1 then
				setDPS = true;
			elseif roleFf:GetID() == 2 then
				setTank = true;
			elseif roleFf:GetID() == 3 then
				setHealer = true;
			end
			SetLFGRoles(leader, setTank, setHealer, setDPS);
			local _, tank, healer, dps = GetLFGRoles();
			local roleFff = roleFf:GetParent()
			roleFff.T.checkButton:SetChecked(tank);
			roleFff.H.checkButton:SetChecked(healer);
			roleFff.D.checkButton:SetChecked(dps);
			FCTabF.ADD:ListGroupButton_Update()
		end
	end
	local function addRoleSetBut(index,roleID)
		local RoleBut = CreateFrame("Button",nil,FCTabF.ADD.Role,"LFGRoleButtonWithBackgroundAndRewardTemplate",roleID);
		RoleBut:SetPoint("LEFT",FCTabF.ADD.Role.biao,"RIGHT",4+(index-1)*50,0);
		RoleBut:SetSize(40,40);
		RoleBut.role=RolesName[index]
		RoleBut:SetNormalAtlas(PIGGetIconForRole(RoleBut.role, false), TextureKitConstants.IgnoreAtlasSize);
		RoleBut.checkButton:SetScript("OnClick", FCTabF.ADD.Role_checkButton)
		return RoleBut
	end
	FCTabF.ADD.Role.T = addRoleSetBut(1,2)
	FCTabF.ADD.Role.H = addRoleSetBut(2,3)
	FCTabF.ADD.Role.D = addRoleSetBut(3,1)
	FCTabF.ADD.Role:SetScript("OnShow", function(self)
		local availTank, availHealer, availDPS = C_LFGList.GetAvailableRoles();
		self.T:SetShown(availTank);
		self.H:SetShown(availHealer);
		self.D:SetShown(availDPS);
		local _, tank, healer, dps = GetLFGRoles();
		self.T.checkButton:SetChecked(tank);
		self.H.checkButton:SetChecked(healer);
		self.D.checkButton:SetChecked(dps);
	end)

	-- 未启用
	-- FCTabF.ADD.PVPRating=PIGFrame(FCTabF.ADD)
	-- FCTabF.ADD.PVPRating.EditBox = CreateFrame("EditBox", nil, FCTabF.ADD.PVPRating);
	-- FCTabF.ADD.PVPRating.EditBox:SetAutoFocus(false)
	-- FCTabF.ADD.PVPRating.CheckButton = PIGCheckbutton(FCTabF.ADD.PVPRating)
	-- FCTabF.ADD.PvpItemLevel=PIGFrame(FCTabF.ADD)
	-- FCTabF.ADD.PvpItemLevel.CheckButton = PIGCheckbutton(FCTabF.ADD.PvpItemLevel)
	-- FCTabF.ADD.PvpItemLevel.EditBox = CreateFrame("EditBox", nil, FCTabF.ADD.PvpItemLevel);
	-- FCTabF.ADD.PvpItemLevel.EditBox:SetAutoFocus(false)
	-- FCTabF.ADD.MythicPlusRating=PIGFrame(FCTabF.ADD)
	-- FCTabF.ADD.MythicPlusRating.EditBox = CreateFrame("EditBox", nil, FCTabF.ADD.MythicPlusRating);
	-- FCTabF.ADD.MythicPlusRating.EditBox:SetAutoFocus(false)
	-- FCTabF.ADD.MythicPlusRating.CheckButton = PIGCheckbutton(FCTabF.ADD.MythicPlusRating)

	--标题
	local NameBox = LFGListFrame.EntryCreation.Name
	NameBox:SetMultiLine(true)
	NameBox.Left:Hide()
    NameBox.Middle:Hide()
    NameBox.Right:Hide()
    NameBox:SetScript('OnTextChanged', function(self)
        InputBoxInstructions_OnTextChanged(self)
        FCTabF.ADD:ListGroupButton_Update()
    end)
	FCTabF.ADD.NameF=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD,"TOPLEFT",FCTabF.ADD.Width+100,-40},{400,40})
	FCTabF.ADD.NameF:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
	FCTabF.ADD.NameF:Hide()
	FCTabF.ADD.NameF.Label=PIGFontString(FCTabF.ADD.NameF,{"BOTTOMLEFT",FCTabF.ADD.NameF,"TOPLEFT",0,2},"标题")
	FCTabF.ADD.NameF:SetObject(NameBox, {4, -4, -4, 4})
   	FCTabF.ADD.Name=NameBox
   	SetEditBoxBG(NameBox,FCTabF.ADD.NameF)

    FCTabF.ADD.DescriptionF=PIGFrame(FCTabF.ADD,{"TOPLEFT",FCTabF.ADD.NameF,"BOTTOMLEFT",0,-60},{400,180})
	FCTabF.ADD.DescriptionF:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
	FCTabF.ADD.DescriptionF:Hide()
	local DescriptionBox = LFGListFrame.EntryCreation.Description
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
    --
    FCTabF.ADD.ListGroupButton=PIGButton(FCTabF.ADD,{"BOTTOM",FCTabF.ADD,"BOTTOM",0,40},{100,30})
    FCTabF.ADD.ListGroupButton:Hide()
	FCTabF.ADD.ListGroupButton:SetScript("OnClick", function (self)
		local itemLevel = tonumber(FCTabF.ADD.ItemLevel.EditBox:GetText()) or 0;
		local privateGroup = FCTabF.ADD.PrivateGroup.CheckButton:GetChecked();
		local chosenRole;
		if FCTabF.ADD.Role.T.checkButton:GetChecked() then
			chosenRole = "TANK";
		elseif FCTabF.ADD.Role.H.checkButton:GetChecked() then
			chosenRole = "HEALER";
		elseif FCTabF.ADD.Role.D.checkButton:GetChecked() then
			chosenRole = "DAMAGER";
		end
		local createData = {
			activityIDs = { FCTabF.selectedActivity },
			questID = 0,
			isAutoAccept = false,--自动接受申请
			isCrossFactionListing = false,
			playstyle = nil,
			requiredDungeonScore = 0,
			isPrivateGroup = privateGroup,
			requiredItemLevel = itemLevel,
			requiredPvpRating = 0,
			--honorLevel = 0,
		};
		if self:GetText()=="更新车队" then
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			createData.activityIDs=activeEntryInfo.activityIDs
			createData.isAutoAccept = activeEntryInfo.autoAccept;
			createData.questID = activeEntryInfo.questID;
			if activeEntryInfo.isCrossFactionListing == createData.isCrossFactionListing then
				C_LFGList.UpdateListing(createData);
			else
				C_LFGList.RemoveListing();
				C_LFGList.CreateListing(createData);
			end
		else
			C_LFGList.CreateListing(createData)
		end
	end);
	FCTabF.ADD.ADDerror=PIGFontString(FCTabF.ADD,{"BOTTOMLEFT",FCTabF.ADD.ListGroupButton,"TOPLEFT",0,4})
	FCTabF.ADD.ADDerror:SetTextColor(1,0,0,1);

	FCTabF.ADD.RemoveBut=PIGButton(FCTabF.ADD,{"BOTTOM",FCTabF.ADD,"BOTTOM",280,40},{100,30},PET_DISMISS.."车队")
	FCTabF.ADD.RemoveBut:Hide()
	FCTabF.ADD.RemoveBut:HookScript("OnClick", function (self)
		FCTabF:ClearActivityADD()
		C_LFGList.RemoveListing()
	end);
	function FCTabF.ADD:ListGroupButton_Update()
		if not self:IsVisible() then return end
		local errorText;
		local isPartyLeader = UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME);
		if ( IsInGroup(LE_PARTY_CATEGORY_HOME) and not isPartyLeader ) then
			errorText = LFG_LIST_NOT_LEADER;
		else
			local myItemLevel = GetAverageItemLevel();
			self.ItemLevel.maxlv:SetText(myItemLevel)
			local eItemLevel = self.ItemLevel.EditBox:GetNumber();
			if eItemLevel>myItemLevel then
				self.ItemLevel.CheckButton:SetChecked(false)
				self.ItemLevel.warningText = LFG_LIST_ILVL_ABOVE_YOURS
			else
				self.ItemLevel.warningText = nil
				if eItemLevel>0 then
					self.ItemLevel.CheckButton:SetChecked(true)
				else
					self.ItemLevel.CheckButton:SetChecked(false)
				end
			end
			if ( ( self.Role.T:IsShown() and self.Role.T.checkButton:GetChecked())
				or ( self.Role.H:IsShown() and self.Role.H.checkButton:GetChecked())
				or ( self.Role.D:IsShown() and self.Role.D.checkButton:GetChecked()) ) then
				self.Role.warningText = nil;
			else
				self.Role.warningText = LFG_LIST_MUST_SELECT_ROLE;
			end
			FCTabF.selectedActivity=FCTabF.selectedActivity or LFGListFrame.EntryCreation.selectedActivity or 0
			local activityInfo = C_LFGList.GetActivityInfoTable(FCTabF.selectedActivity) or {}
			local maxNumPlayers = activityInfo and  activityInfo.maxNumPlayers or 0;
			local mythicPlusDisableActivity = not C_LFGList.IsPlayerAuthenticatedForLFG(FCTabF.selectedActivity) and (activityInfo.isMythicPlusActivity and not C_LFGList.GetKeystoneForActivity(FCTabF.selectedActivity));
			if ( maxNumPlayers > 0 and GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) >= maxNumPlayers ) then
				errorText = string.format(LFG_LIST_TOO_MANY_FOR_ACTIVITY, maxNumPlayers);
			elseif (mythicPlusDisableActivity) then
				errorText = LFG_AUTHENTICATOR_BUTTON_MYTHIC_PLUS_TOOLTIP;
			elseif (LFGListEntryCreation_GetSanitizedName(self) == "") then
				errorText = LFG_LIST_MUST_HAVE_NAME;
			elseif self.ItemLevel.warningText then
				errorText = self.ItemLevel.warningText
			elseif self.Role.warningText then
				errorText = self.Role.warningText
			else
				errorText = LFGListUtil_GetActiveQueueMessage(false);
			end
		end
		self.ADDerror:SetText(errorText)
		self.ListGroupButton:SetEnabled(not errorText and not mythicPlusDisableActivity);
	end

	--当前活动
	FCTabF.DQ.Category_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ,"TOPLEFT",10,-10},"车队类型")
	FCTabF.DQ.Category_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.Category_V=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Category_T,"BOTTOMLEFT",0,-2},"")
	FCTabF.DQ.Category_V:SetTextColor(0.9,0.9,0.9,1);

	FCTabF.DQ.Name_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Category_T,"BOTTOMLEFT",0,-24},"目的地")
	FCTabF.DQ.Name_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.Name_V=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Name_T,"BOTTOMLEFT",0,-2},"")
	FCTabF.DQ.Name_V:SetTextColor(0.9,0.9,0.9,1);
	FCTabF.DQ.Name_V:SetWidth(FCTabF.DQ.Width-8);
	FCTabF.DQ.Name_V:SetJustifyH("LEFT")

	FCTabF.DQ.ItemLevel_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.Name_T,"BOTTOMLEFT",0,-34},LFG_LIST_ITEM_LEVEL_REQ)
	FCTabF.DQ.ItemLevel_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.ItemLevel_V=PIGFontString(FCTabF.DQ,{"LEFT",FCTabF.DQ.ItemLevel_T,"RIGHT",4,0},0)
	FCTabF.DQ.ItemLevel_V:SetTextColor(0.9,0.9,0.9,1);

	FCTabF.DQ.EntryName = PIGFrame(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.ItemLevel_T,"BOTTOMLEFT",0,-10})
	FCTabF.DQ.EntryName:SetSize(FCTabF.DQ.Width-24,54)
	FCTabF.DQ.EntryName.T=PIGFontString(FCTabF.DQ.EntryName,{"TOPLEFT",FCTabF.DQ.EntryName,"TOPLEFT",0,0},"标题")
	FCTabF.DQ.EntryName.T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.EntryName.V=PIGFontString(FCTabF.DQ.EntryName,{"TOPLEFT",FCTabF.DQ.EntryName.T,"BOTTOMLEFT",0,0})
	FCTabF.DQ.EntryName.V:SetTextColor(0.9,0.9,0.9,1);
	FCTabF.DQ.EntryName.V:SetWidth(FCTabF.DQ.EntryName:GetWidth())
	FCTabF.DQ.EntryName.V:SetJustifyH("LEFT")
	FCTabF.DQ.EntryName.V:SetNonSpaceWrap(true)

	FCTabF.DQ.Description_T=PIGFontString(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ.EntryName,"BOTTOMLEFT",0,-4},LFG_LIST_DETAILS)
	FCTabF.DQ.Description_T:SetTextColor(0,0.98,0.6, 1);
	FCTabF.DQ.DescriptionScroll = CreateFrame("ScrollFrame",nil,FCTabF.DQ, "UIPanelScrollFrameTemplate"); 
	FCTabF.DQ.DescriptionScroll:SetPoint("TOPLEFT",FCTabF.DQ.Description_T,"BOTTOMLEFT",0,-2);
	FCTabF.DQ.DescriptionScroll:SetSize(FCTabF.DQ.Width-28,156)
	FCTabF.DQ.DescriptionScroll.ScrollBar:SetScale(0.7);
	FCTabF.DQ.Description = PIGFrame(FCTabF.DQ.DescriptionScroll,nil,{FCTabF.DQ.DescriptionScroll:GetWidth()+4,20})
	FCTabF.DQ.Description.V=PIGFontString(FCTabF.DQ.Description,{"TOPLEFT",FCTabF.DQ.Description,"TOPLEFT",0,0})
	FCTabF.DQ.Description.V:SetTextColor(0.9,0.9,0.9,1);
	FCTabF.DQ.Description.V:SetWidth(FCTabF.DQ.Description:GetWidth())
	FCTabF.DQ.Description.V:SetJustifyH("LEFT")
	FCTabF.DQ.Description.V:SetNonSpaceWrap(true)
	FCTabF.DQ.DescriptionScroll:SetScrollChild(FCTabF.DQ.Description)

	local _, localizedFaction = UnitFactionGroup("player");
	FCTabF.DQ.CrossFactionGroup=PIGFrame(FCTabF.DQ,{"BOTTOMLEFT",FCTabF.DQ,"BOTTOMLEFT",10,72},{200,20})
	FCTabF.DQ.CrossFactionGroup.CheckButton = PIGCheckbutton(FCTabF.DQ.CrossFactionGroup,{"LEFT",FCTabF.DQ.CrossFactionGroup,"LEFT",0,0},{LFG_LIST_CROSS_FACTION:format(localizedFaction),LFG_LIST_CROSS_FACTION_TOOLTIP:format(localizedFaction)},{16,16})
	FCTabF.DQ.CrossFactionGroup.CheckButton:Hide()
	FCTabF.DQ.PrivateGroup=PIGFrame(FCTabF.DQ,{"BOTTOMLEFT",FCTabF.DQ,"BOTTOMLEFT",10,50},{200,20})
	FCTabF.DQ.PrivateGroup.CheckButton = PIGCheckbutton(FCTabF.DQ.PrivateGroup,{"LEFT",FCTabF.DQ.PrivateGroup,"LEFT",0,0},{"仅对公会/好友可见",LFG_LIST_PRIVATE_TOOLTIP},{16,16})
	FCTabF.DQ.PrivateGroup.CheckButton:Disable()

	FCTabF.DQ.EditButton=PIGButton(FCTabF.DQ,{"BOTTOMLEFT",FCTabF.DQ,"BOTTOMLEFT",10,18},{80,22},EDIT.."车队")
	FCTabF.DQ.EditButton:HookScript("OnClick", function (self)
		FCTabF:UpdateEditMode("Edit")
	end);

	FCTabF.DQ.RemoveEntryButton=PIGButton(FCTabF.DQ,{"LEFT",FCTabF.DQ.EditButton,"RIGHT",20,0},{80,22},PET_DISMISS.."车队")
	FCTabF.DQ.RemoveEntryButton:HookScript("OnClick", function (self)
		FCTabF:ClearActivityADD()
		C_LFGList.RemoveListing()
	end);

	--申请界面
	FCTabF.DQ.Apply=PIGFrame(FCTabF.DQ,{"TOPLEFT",FCTabF.DQ,"TOPLEFT",FCTabF.DQ.Width,-34})
	FCTabF.DQ.Apply:SetPoint("BOTTOMRIGHT",FCTabF.DQ,"BOTTOMRIGHT",-16,2);
	FCTabF.DQ.Apply:PIGSetBackdrop(0)
	FCTabF.DQ.Apply.LFM_TITLE=PIGFontString(FCTabF.DQ.Apply,{"BOTTOMLEFT",FCTabF.DQ.Apply,"TOPLEFT",10,6},"正在"..LFM_TITLE)
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

	-- FCTabF.DQ.Apply.UnempoweredCover=PIGFrame(FCTabF.DQ.Apply,{"TOPLEFT",FCTabF.DQ.Apply,"TOPLEFT",0,0})
	-- FCTabF.DQ.Apply.UnempoweredCover:SetPoint("BOTTOMRIGHT",FCTabF.DQ.Apply,"BOTTOMRIGHT",0,0);
	-- FCTabF.DQ.Apply.UnempoweredCover:PIGSetBackdrop(1)
	-- FCTabF.DQ.Apply.UnempoweredCover:Hide()
	-- FCTabF.DQ.Apply.UnempoweredCover.err = PIGFontString(FCTabF.DQ.Apply.UnempoweredCover,{"CENTER", FCTabF.DQ.Apply.UnempoweredCover, "CENTER",0, 40});
	-- FCTabF.DQ.Apply.UnempoweredCover.err:SetText(LFG_LIST_GROUP_FORMING);
	--五人本人员显示模式
	FCTabF.DQ.Apply.RoleEnumerate=addPlayerListF(FCTabF.DQ.Apply,{"LEFT", FCTabF.DQ.Apply.LFM_TITLE, "RIGHT", 4, 1})
	FCTabF.DQ.Apply.RoleEnumerate:HookScript("OnEnter", function (self)
		EnterF:Update_PlayersList(self,true)
	end);
	FCTabF.DQ.Apply.RoleEnumerate:HookScript("OnLeave", function (self)
		EnterF:Hide()
	end);
	FCTabF.DQ.Apply.RoleEnumerate.T,FCTabF.DQ.Apply.RoleEnumerate.Tjiao=addPlayerListBut_1(FCTabF.DQ.Apply.RoleEnumerate,1,1)
	FCTabF.DQ.Apply.RoleEnumerate.H,FCTabF.DQ.Apply.RoleEnumerate.Hjiao=addPlayerListBut_1(FCTabF.DQ.Apply.RoleEnumerate,2,2)
	FCTabF.DQ.Apply.RoleEnumerate.D,FCTabF.DQ.Apply.RoleEnumerate.Djiao=addPlayerListBut_1(FCTabF.DQ.Apply.RoleEnumerate,3,3)
	FCTabF.DQ.Apply.RoleEnumerate.D1,FCTabF.DQ.Apply.RoleEnumerate.D1jiao=addPlayerListBut_1(FCTabF.DQ.Apply.RoleEnumerate,4,3)
	FCTabF.DQ.Apply.RoleEnumerate.D2,FCTabF.DQ.Apply.RoleEnumerate.D2jiao=addPlayerListBut_1(FCTabF.DQ.Apply.RoleEnumerate,5,3)
	function FCTabF.DQ.Apply.RoleEnumerate:RestoreDefault(Alpha)
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
	function FCTabF.DQ.Apply.RoleEnumerate:Update_Show(zhizex,Coord)
		self[zhizex]:SetAlpha(1);
		self[zhizex]:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
		self[zhizex]:SetTexCoord(unpack(CLASS_ICON_TCOORDS[Coord]));
	end
	--其他人员显示模式
	FCTabF.DQ.Apply.RoleCount=addPlayerListF(FCTabF.DQ.Apply,{"LEFT", FCTabF.DQ.Apply.LFM_TITLE, "RIGHT", 4, 1})
	FCTabF.DQ.Apply.RoleCount:HookScript("OnEnter", function (self)
		EnterF:Update_PlayersList(self,true)
	end);
	FCTabF.DQ.Apply.RoleCount:HookScript("OnLeave", function (self)
		EnterF:Hide()
	end);
	FCTabF.DQ.Apply.RoleCount.T,FCTabF.DQ.Apply.RoleCount.TNum=addPlayerListBut_2(FCTabF.DQ.Apply.RoleCount,1)	
	FCTabF.DQ.Apply.RoleCount.H,FCTabF.DQ.Apply.RoleCount.HNum=addPlayerListBut_2(FCTabF.DQ.Apply.RoleCount,2)
	FCTabF.DQ.Apply.RoleCount.D,FCTabF.DQ.Apply.RoleCount.DNum=addPlayerListBut_2(FCTabF.DQ.Apply.RoleCount,3)
	FCTabF.DQ.DQplayers = {}
	function FCTabF.DQ:Update_ApplyPlayers()
		if not self:IsVisible() then return end
		C_Timer.After(0.4,function()
			if LFGListUtil_IsEntryEmpowered() then
				self.RemoveEntryButton:Show();
				self.EditButton:Show();
				self.Apply.RefreshButton:Enable();
				self.Apply.Scroll.errt:SetText(LFG_LIST_NO_APPLICANTS)
				
			else
				self.RemoveEntryButton:Hide();
				self.EditButton:Hide();
				self.Apply.RefreshButton:Disable();
				self.Apply.Scroll.errt:SetText(LFG_LIST_GROUP_FORMING)
			end
			if ( IsRestrictedAccount() ) then
				self.EditButton:Disable();
			else
				self.EditButton:Enable();
			end
			local empowered = LFGListUtil_IsEntryEmpowered();
			self.Apply.RoleEnumerate:Hide()
			self.Apply.RoleCount:Hide()
			if not C_LFGList.HasActiveEntryInfo() then return end
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			local activityID=activeEntryInfo.activityIDs[1]
			local activityInfo = C_LFGList.GetActivityInfoTable(activityID);
			if activityInfo.displayType == Enum.LFGListDisplayType.RoleEnumerate then
				self.Apply.RoleEnumerate:RestoreDefault(0.4)
				wipe(self.DQplayers)
				for ix=1,#RolesName do
					self.DQplayers[RolesName[ix]]={}
				end
				for p=1, MAX_PARTY_MEMBERS do
					local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
					if name and combatRole then
						table.insert(self.DQplayers[combatRole],fileName)
					end
				end
				if #self.DQplayers[RolesName[1]]>0 then
					self.Apply.RoleEnumerate:Update_Show("T",self.DQplayers[RolesName[1]][1])
				end
				if #self.DQplayers[RolesName[2]]>0 then
					self.Apply.RoleEnumerate:Update_Show("H",self.DQplayers[RolesName[2]][1])
				end
				if #self.DQplayers[RolesName[3]]>0 then
					self.Apply.RoleEnumerate:Update_Show("D",self.DQplayers[RolesName[3]][1])
					if self.DQplayers[RolesName[3]][2] then
						self.Apply.RoleEnumerate:Update_Show("D1",self.DQplayers[RolesName[3]][2])
					end
					if self.DQplayers[RolesName[3]][3] then
						self.Apply.RoleEnumerate:Update_Show("D2",self.DQplayers[RolesName[3]][3])
					end
				end
			else
				local displayData = GetGroupMemberCountsForDisplay();
				self.Apply.RoleCount:Show()		
				self.Apply.RoleCount.TNum:SetText(displayData.TANK);
				self.Apply.RoleCount.HNum:SetText(displayData.HEALER);
				self.Apply.RoleCount.DNum:SetText(displayData.DAMAGER);
				--self.Apply.RoleCount.NONum:SetText(displayData.NOROLE)
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
    	-- PF.Faction = PF:CreateTexture();
		-- PF.Faction:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
		-- PF.Faction:SetPoint("LEFT", PF, "LEFT", 0,0);
		-- PF.Faction:SetSize(Apphang_Height-2,Apphang_Height-2);
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
		self.ADD.GroupDropDown:SetShown(bot)
		self.ADD.ActivityDropDown:SetShown(bot)
		self.ADD.ItemLevel:SetShown(bot)
		self.ADD.NameF:SetShown(bot)
		self.ADD.DescriptionF:SetShown(bot)
		self.ADD.VoiceChat:SetShown(bot)
		self.ADD.CrossFactionGroup:SetShown(bot)
		self.ADD.PrivateGroup:SetShown(bot)
		self.ADD.Role:SetShown(bot)
		self.ADD.ListGroupButton:SetShown(bot)
		self.ADD.RemoveBut:SetShown(editMode)
	end
	function FCTabF:ClearActivityADD()
		--C_LFGList.ClearCreationTextFields();
		self.selectedCategory = nil;
		self.selectedGroup = nil;
		self.selectedActivity = nil;
		self.ADD.editMode = nil
		self.ADD:CategorieIsChecked(false)
		self.ADD:CategorieIsEnabled(true)
		self.ADD.ItemLevel.CheckButton:SetChecked(false);
		self.ADD.PrivateGroup.CheckButton:SetChecked(false);
		self.ADD.CrossFactionGroup.CheckButton:SetChecked(false);
		self.ADD.ItemLevel.EditBox:SetText("");
		self.ADD.GroupDropDown:PIGDownMenu_SetText("")
		self.ADD.ActivityDropDown:PIGDownMenu_SetText("")
		self.ADD.ADDerror:SetText("");
		self:Update_ShownADD(false)
	end
	function FCTabF:UpdateActivityADD(editMode)
		self.ADD:Show()
		if editMode and C_LFGList.HasActiveEntryInfo() then
			self:Update_ShownADD(true,editMode)
			self.ADD:CategorieIsEnabled(false)
			self.ADD.GroupDropDown:Disable()
			self.ADD.ActivityDropDown:Disable()
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			local activityID=activeEntryInfo.activityIDs[1]
			self.selectedActivity=activityID
			local activityInfo = C_LFGList.GetActivityInfoTable(activityID);	
			self.selectedCategory=activityInfo.categoryID
			if self.selectedCategory==120 then
				self.ADD.GroupDropDown:Hide()
				self.ADD.ActivityDropDown:Hide()
			else
				self.ADD.ActivityDropDown:PIGDownMenu_SetText(activityInfo.fullName)
				local Groupname = C_LFGList.GetActivityGroupInfo(activityInfo.groupFinderActivityGroupID)
				self.ADD.GroupDropDown:PIGDownMenu_SetText(Groupname)
			end
			self.ADD.ItemLevel.EditBox:SetText(activeEntryInfo.requiredItemLevel)
			self.ADD.PrivateGroup.CheckButton:SetChecked(activeEntryInfo.privateGroup);
			self.ADD.CrossFactionGroup.CheckButton:SetChecked(activeEntryInfo.allowCrossFaction)
			self.ADD.ListGroupButton:SetText("更新车队")
			self.ADD.RemoveBut:Show()
		else
			if self.selectedCategory then
				self:Update_ShownADD(true)
				if self.selectedCategory==120 then
					self.ADD.GroupDropDown:Hide()
					self.ADD.ActivityDropDown:Hide()
				end
				self.ADD.ListGroupButton:SetText("创建车队")			
				local categoryInfo = C_LFGList.GetLfgCategoryInfo(self.selectedCategory);
				local activityGroups = C_LFGList.GetAvailableActivityGroups(self.selectedCategory)
				self.selectedGroup=self.selectedGroup or activityGroups[1] or 0
				local name = C_LFGList.GetActivityGroupInfo(self.selectedGroup)
				self.ADD.GroupDropDown:PIGDownMenu_SetText(name)
				local activities = C_LFGList.GetAvailableActivities(self.selectedCategory,self.selectedGroup)
				self.selectedActivity=self.selectedActivity or activities[1] or 0
				local activityInfo = C_LFGList.GetActivityInfoTable(self.selectedActivity)
				self.ADD.ActivityDropDown:PIGDownMenu_SetText(activityInfo.fullName)
				self.ADD:ListGroupButton_Update()
			else
				self:ClearActivityADD()
			end
		end
		--处理外服账号未绑定手机
		-- self.selectedPlaystyle=1
		-- local isAccountSecured = C_LFGList.IsPlayerAuthenticatedForLFG(self.selectedActivity);
		-- self.Name.editBoxEnabled = isAccountSecured;
		-- self.Description.editBoxEnabled = isAccountSecured;
		-- self.Name:SetEnabled(isAccountSecured);
		-- self.Description.EditBox:SetEnabled(isAccountSecured);
		-- self.Name.LockButton:SetShown(not isAccountSecured);
		-- self.Description.LockButton:SetShown(not isAccountSecured);
		-- local descInstructions = nil;
		-- if isAccountSecured then
		-- 	self.NameF:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
		-- 	self.DescriptionF:PIGSetBackdrop(0,0.8,nil,{0, 1, 1})
		-- else
		-- 	self.NameF:PIGSetBackdrop(0,0.6,nil,{0.3, 0.3, 0.3})
		-- 	self.DescriptionF:PIGSetBackdrop(0,0.6,nil,{0.3, 0.3, 0.3})
		-- 	descInstructions = LFG_AUTHENTICATOR_DESCRIPTION_BOX;
		-- end
		-- self.Description.EditBox.Instructions:SetText(descInstructions or DESCRIPTION_OF_YOUR_GROUP);
		-- if self.selectedCategory==118 then
		-- 	if(not isAccountSecured) then
		-- 		if not caozuo then
		-- 			C_LFGList.SetEntryTitle(1064, 0, self.selectedPlaystyle);
		-- 		end
		-- 	end
		-- elseif self.selectedCategory==GROUP_FINDER_CATEGORY_ID_DUNGEONS or self.selectedCategory==114 then
		-- 	if((activityInfo and activityInfo.isMythicPlusActivity) or not isAccountSecured) then
		-- 		if not caozuo then
		-- 			C_LFGList.SetEntryTitle(self.selectedActivity, self.selectedGroup, self.selectedPlaystyle);
		-- 		end
		-- 	end
		-- end
	end
	function FCTabF:UpdateActivityDQ()
		self.DQ:Show()
		if C_LFGList.HasActiveEntryInfo() then
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			local activityID=activeEntryInfo.activityIDs[1]
			local activityInfo = C_LFGList.GetActivityInfoTable(activityID);	
			local categoryInfo= C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID)
			local huodongname=FCTabF.tabListName[categoryInfo.name] or categoryInfo.name
			self.DQ.Category_V:SetText(huodongname);
			self.DQ.Name_V:SetText(activityInfo.fullName);
			self.DQ.ItemLevel_V:SetText(activeEntryInfo.requiredItemLevel);
			self.DQ.EntryName.V:SetText(activeEntryInfo.name);
			self.DQ.Description.V:SetText(activeEntryInfo.comment);
			local shouldDisableCrossFactionToggle = (categoryInfo.allowCrossFaction) and not (activityInfo.allowCrossFaction);
			self.DQ.CrossFactionGroup.CheckButton:SetChecked(shouldDisableCrossFactionToggle)
			self.DQ.PrivateGroup.CheckButton:SetChecked(activeEntryInfo.privateGroup);
			self.DQ:Update_ApplyPlayers()
			self.DQ.Apply.Scroll:Update_list()
		else
			self:UpdateActivityADD()
		end
	end
	function FCTabF:UpdateEditMode(Mode)
		if not self:IsVisible() then return end
		if not self.tabList then
			self.tabList,self.tabListName=GetCategorieData()
		end
		self.ADD:Hide()
		self.DQ:Hide()
		if Mode=="New" then
			self:UpdateActivityDQ()
		elseif Mode=="Edit" then
			self:UpdateActivityADD(true)
		elseif Mode=="Rem" then
			self:UpdateActivityADD()
		else
			if C_LFGList.HasActiveEntryInfo() then
				self:UpdateActivityDQ()
			else
				self:UpdateActivityADD()
			end
		end
	end
	----------
	FCTabF:RegisterEvent("LFG_LIST_APPLICANT_UPDATED");--來自申请人狀態改變
	FCTabF:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED");--列表刷新
	FCTabF:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE");--自己创建活动变动时
	FCTabF:RegisterEvent("LFG_LIST_AVAILABILITY_UPDATE");--列表可用性更新
	FCTabF:RegisterEvent("GROUP_ROSTER_UPDATE");
	FCTabF:HookScript("OnEvent", function(self,event,arg1)
		--print(event,arg1)
		if event=="LFG_LIST_APPLICANT_UPDATED" then
			if ( not LFGListUtil_IsEntryEmpowered() ) then--你不是队长则清除
				C_LFGList.RemoveApplicant(arg1);
			else
				local frame = self.DQ.Apply.Scroll.ScrollBox:FindFrameByPredicate(function(frame, elementData)
					return elementData.AppID == arg1;
				end);
				if frame then
					self.DQ.Apply.Scroll:Update_hang(frame, arg1)
				end
			end
		elseif event=="LFG_LIST_AVAILABILITY_UPDATE" then

		elseif event=="LFG_LIST_APPLICANT_LIST_UPDATED" then
			self.DQ.Apply.Scroll:Update_list()
		elseif event=="GROUP_ROSTER_UPDATE" then
			self.DQ:Update_ApplyPlayers()
		elseif event=="LFG_LIST_ACTIVE_ENTRY_UPDATE" then--Mode值(true新建/false编辑/nil取消)
			if arg1==true then
				self:UpdateEditMode("New")
			elseif arg1==false then
				self:UpdateEditMode("New")
			elseif arg1==nil then
				self:UpdateEditMode()
			end
		end
	end);
end