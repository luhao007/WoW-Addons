local addonName, addonTable = ...;
local TardisInfo=addonTable.TardisInfo
function TardisInfo.Invite(Activate)
	if not PIGA["Tardis"]["Invite"]["Open"] then return end
	local Create, Data, Fun, L= unpack(PIG)
	local PIGFrame=Create.PIGFrame
	local PIGEnter=Create.PIGEnter
	local PIGButton = Create.PIGButton
	local PIGDownMenu=Create.PIGDownMenu
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGFontString=Create.PIGFontString
	local PIGQuickBut=Create.PIGQuickBut
	local PIGSetFont=Create.PIGSetFont
-- 	------------------------
-- 	local ConvertToParty=ConvertToParty or C_PartyInfo and C_PartyInfo.ConvertToParty
-- 	local ConvertToRaid=ConvertToRaid or C_PartyInfo and C_PartyInfo.ConvertToRaid
	local GnName,GnUI,GnIcon,FrameLevel = unpack(TardisInfo.uidata)
-- 	local sub = _G.string.sub
-- 	local gsub = _G.string.gsub
-- 	local match = _G.string.match
	local GetPindaoList=Fun.GetPindaoList
	local GetYellPindao=Fun.GetYellPindao
-- 	local Key_fenge=Fun.Key_fenge
	local Get_famsg=Fun.Get_famsg
	local cl_Name=Data.cl_Name
-- 	local cl_Name_Role=Data.cl_Name_Role
	local zhizeAtlas=Data.zhizeAtlas
	local MSGsuijizifu=Data.MSGsuijizifu
-- 	---
	local InvF=_G[GnUI]
	local fujiF,fujiTabBut=PIGOptionsList_R(InvF.F,GROUPS,80,"Bot")
	if Activate then fujiF:Show() fujiTabBut:Selected() end
-- 	--=====================
	local Roles = {"TANK", "HEALER","DAMAGER"}
	local RolesXulie = {["TANK"]=1, ["HEALER"]=2,["DAMAGER"]=3}
	local Roles_List={{},{},{}};
	--提取职业职责信息
	local function GetClassRoles(id)
		for i=1,#cl_Name do
			local zhize = cl_Name[i][2]
			for ii=1,#zhize do
				if Roles[id]==zhize[ii] then
					table.insert(Roles_List[id],{cl_Name[i][1],cl_Name[i][3]})
				end
			end
		end
	end
	GetClassRoles(1)
	GetClassRoles(2)
	GetClassRoles(3)
	if PIG_MaxTocversion(20000) then
		local englishFaction = UnitFactionGroup("player")
		if englishFaction=="Alliance" then
			for id=1,#Roles_List do
				for ix=#Roles_List[id],1,-1 do
					if Roles_List[id][ix][1]=="SHAMAN" then
						table.remove(Roles_List[id],ix)
					end
				end
			end
		elseif englishFaction=="Horde" then
			for id=1,#Roles_List do
				for ix=#Roles_List[id],1,-1 do
					if Roles_List[id][ix][1]=="PALADIN" then
						table.remove(Roles_List[id],ix)
					end
				end
			end
		end
	end
	local function InitializationData(DQMubiao,mb)
		local datax={}
		for xulie=1,#Roles_List do
			datax[xulie]={}
			for id=1,#Roles_List[xulie] do
				if mb then
					datax[xulie][id]=DQMubiao and DQMubiao[xulie] and DQMubiao[xulie][id] or 0
				else
					datax[xulie][id]= 0
				end
			end
		end
		return datax
	end
	----职业人数显示
	fujiF.topF = PIGFrame(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",0,0});
	fujiF.topF:SetPoint("TOPRIGHT", fujiF, "TOPRIGHT", 0, 0);
	fujiF.topF:SetHeight(320)

	local zhiye_F_H,zhiye_but_H=90,20
	fujiF.topF.RoleButList={}
	local function ADD_Roles_Frame(xulie)
		local zhizeF=PIGFrame(fujiF.topF)
		fujiF.topF.RoleButList[xulie]=zhizeF
		zhizeF:SetHeight(zhiye_F_H)
		zhizeF:PIGSetBackdrop()
		if xulie==1 then
			zhizeF:SetPoint("TOPLEFT",fujiF.topF,"TOPLEFT",4,-4);
			zhizeF:SetPoint("TOPRIGHT", fujiF.topF, "TOPRIGHT", -4, 4);
		else
			zhizeF:SetPoint("TOPLEFT",fujiF.topF.RoleButList[xulie-1],"BOTTOMLEFT",0,-6);
			zhizeF:SetPoint("TOPRIGHT",fujiF.topF.RoleButList[xulie-1],"BOTTOMRIGHT",0,-6);
		end
		zhizeF.Tex = zhizeF:CreateTexture(nil, "BORDER");
		zhizeF.Tex:SetAtlas(zhizeAtlas[xulie]);
		zhizeF.Tex:SetSize(zhiye_but_H*3,zhiye_but_H*3);
		zhizeF.Tex:SetPoint("LEFT", zhizeF, "LEFT", 10,0);
		--
		zhizeF.mubiaoAll = PIGFontString(zhizeF,{"LEFT", zhizeF, "LEFT", 70,8},"目标人数", "OUTLINE");
		zhizeF.mubiaoAll_V = PIGFontString(zhizeF,{"LEFT", zhizeF.mubiaoAll, "RIGHT", 2,0},0, "OUTLINE");
		zhizeF.mubiaoAll_V:SetTextColor(1,1,1,1);
		zhizeF.dangqianAll = PIGFontString(zhizeF,{"LEFT", zhizeF, "LEFT", 70,-16},"已组人数", "OUTLINE");
		zhizeF.dangqianAll_V = PIGFontString(zhizeF,{"LEFT", zhizeF.dangqianAll, "RIGHT", 2,0},0, "OUTLINE");
		zhizeF.dangqianAll_V:SetTextColor(1,1,1,1);
		zhizeF.mubiao_EBut={}
		for id=1,#Roles_List[xulie] do
			local EditBox = CreateFrame("EditBox", nil, zhizeF, "InputBoxInstructionsTemplate");
			zhizeF.mubiao_EBut[id]=EditBox
			EditBox:SetSize(zhiye_but_H+4,zhiye_but_H);
			if id==1 then
				EditBox:SetPoint("LEFT", zhizeF.mubiaoAll, "LEFT", 110,0);
			else
				EditBox:SetPoint("LEFT",zhizeF.mubiao_EBut[id-1],"RIGHT",30,0);
			end
			PIGSetFont(EditBox,14,"OUTLINE")
			EditBox:SetJustifyH("CENTER")
			EditBox:SetNumeric(true)
			EditBox:SetMaxLetters(2)
			EditBox:SetAutoFocus(false)
			EditBox:SetTextColor(0.6, 0.6, 0.6, 0.94)
			EditBox:SetScript("OnEditFocusLost", function(self)
				self:SetTextColor(0.6, 0.6, 0.6, 0.94)
			end);
			EditBox:SetScript("OnEditFocusGained", function(self) 
				self:SetTextColor(1, 1, 1, 1)
				self:HighlightText()
			end)
			EditBox:SetScript("OnEscapePressed", function(self) 
				self:ClearFocus() 
			end);
			EditBox:HookScript("OnTextChanged", function(self)
				fujiF.Datas_MB[xulie][id]=self:GetNumber();
				PIGA["Tardis"]["Invite"]["DQMubiao"]=fujiF.Datas_MB
				fujiF:Update_ShowList()
			end);
			EditBox:SetScript("OnEnterPressed", function(self) 
				self:ClearFocus() 
				fujiF.Datas_MB[xulie][id]=self:GetNumber();
				PIGA["Tardis"]["Invite"]["DQMubiao"]=fujiF.Datas_MB
				fujiF:Update_ShowList()
			end);
			EditBox.Icon=PIGFrame(EditBox,{"BOTTOM", EditBox, "TOP", -1,2},{zhiye_but_H,zhiye_but_H-2})
			EditBox.Icon.tex = EditBox.Icon:CreateTexture();
			EditBox.Icon.tex:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			EditBox.Icon.tex:SetAllPoints(EditBox.Icon)
			local coords = CLASS_ICON_TCOORDS[Roles_List[xulie][id][1]]
			EditBox.Icon.tex:SetTexCoord(unpack(coords));
			-- EditBox.Icon:SetScript("OnMouseUp", function(self)
			-- 	if fujiF.topF.xiugaiRF:IsShown() then
			-- 		fujiF.topF.xiugaiRF:Hide()
			-- 	else
			-- 		fujiF.topF.xiugaiRF:Show()
			-- 		xianshixiugaiUI(EditBox.Icon,xulie,id)
			-- 	end
			-- end)
			EditBox.yizu = PIGFontString(EditBox,{"TOP", EditBox, "BOTTOM", -1,-8},nil,"OUTLINE");
			EditBox.wancheng = EditBox:CreateTexture();
			EditBox.wancheng:SetSize(zhiye_but_H,zhiye_but_H-4);
			EditBox.wancheng:SetPoint("TOP", EditBox.yizu, "BOTTOM", 0,-2);
		end
	end
	ADD_Roles_Frame(1)
	ADD_Roles_Frame(2)
	ADD_Roles_Frame(3)
-- 	---
-- 	--手动设置玩家职责
-- 	--fujiF.Datas_DQList={}--自定义职责
-- 	-- fujiF.xiugaiRF=PIGFrame(fujiF,nil,{260,300})
-- 	-- fujiF.xiugaiRF:PIGSetBackdrop(1)
-- 	-- fujiF.xiugaiRF:PIGClose()
-- 	-- fujiF.xiugaiRF:Hide()
-- 	-- fujiF.xiugaiRF:SetFrameLevel(fujiF.xiugaiRF:GetFrameLevel()+10)
-- 	-- fujiF.xiugaiRF.biaoti = PIGFontString(fujiF.xiugaiRF,{"TOP", fujiF.xiugaiRF, "TOP", 0,-3},"", "OUTLINE");
-- 	-- local shezhiWH = 24
-- 	-- for i=1,MAX_RAID_MEMBERS do
-- 	-- 	local pbut = CreateFrame("Button","Zuidui_xigairzhizeUI_"..i,fujiF.xiugaiRF)
-- 	-- 	pbut:SetSize(shezhiWH,shezhiWH);
-- 	-- 	if i==1 then
-- 	-- 		pbut:SetPoint("TOPLEFT", fujiF.xiugaiRF, "TOPLEFT", 10,-24);
-- 	-- 	elseif i==21 then
-- 	-- 		pbut:SetPoint("TOPLEFT", fujiF.xiugaiRF, "TOPLEFT", 290,-24);
-- 	-- 	else
-- 	-- 		pbut:SetPoint("TOP",_G["Zuidui_xigairzhizeUI_"..(i-1)],"BOTTOM",0,-3);
-- 	-- 	end
-- 	-- 	pbut.Tex = pbut:CreateTexture();
-- 	-- 	pbut.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
-- 	-- 	pbut.Tex:SetTexCoord(zhizeIcon[1][1],zhizeIcon[1][2],zhizeIcon[1][3],zhizeIcon[1][4]);
-- 	-- 	pbut.Tex:SetSize(shezhiWH,shezhiWH);
-- 	-- 	pbut.Tex:SetPoint("CENTER", pbut, "CENTER", 0,0);
-- 	-- 	pbut:SetScript("OnMouseDown", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut, "CENTER", 1.5,-1.5);
-- 	-- 	end);
-- 	-- 	pbut:SetScript("OnMouseUp", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut, "CENTER", 0,0);
-- 	-- 	end);
-- 	-- 	pbut:HookScript("OnClick", function (self)
-- 	-- 		local wanjname = self.name:GetText()
-- 	-- 		for p=1,MAX_RAID_MEMBERS do
-- 	-- 			local name = GetRaidRosterInfo(p);
-- 	-- 			if name then
-- 	-- 				if name==wanjname then
-- 	-- 					UnitSetRole(riad..p, "TANK")--"NONE"
-- 	-- 					break
-- 	-- 				end
-- 	-- 			end
-- 	-- 		end
-- 	-- 		fujiF.xiugaiRF:Hide()
-- 	-- 	end);
-- 	-- 	pbut.zhize2 = CreateFrame("Button",nil,pbut)
-- 	-- 	pbut.zhize2:SetSize(shezhiWH,shezhiWH);
-- 	-- 	pbut.zhize2:SetPoint("LEFT", pbut, "RIGHT", 4,0);
-- 	-- 	pbut.zhize2.Tex = pbut.zhize2:CreateTexture();
-- 	-- 	pbut.zhize2.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
-- 	-- 	pbut.zhize2.Tex:SetTexCoord(zhizeIcon[2][1],zhizeIcon[2][2],zhizeIcon[2][3],zhizeIcon[2][4]);
-- 	-- 	pbut.zhize2.Tex:SetSize(shezhiWH,shezhiWH);
-- 	-- 	pbut.zhize2.Tex:SetPoint("CENTER", pbut.zhize2, "CENTER", 0,0);
-- 	-- 	pbut.zhize2:SetScript("OnMouseDown", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut.zhize2, "CENTER", 1.5,-1.5);
-- 	-- 	end);
-- 	-- 	pbut.zhize2:SetScript("OnMouseUp", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut.zhize2, "CENTER", 0,0);
-- 	-- 	end);
-- 	-- 	pbut.zhize2:HookScript("OnClick", function (self)
-- 	-- 		local fujiku = self:GetParent()
-- 	-- 		local wanjname = fujiku.name:GetText()
-- 	-- 		for p=1,MAX_RAID_MEMBERS do
-- 	-- 			local name = GetRaidRosterInfo(p);
-- 	-- 			if name then
-- 	-- 				if name==wanjname then
-- 	-- 					UnitSetRole(riad..p, "HEALER")
-- 	-- 					break
-- 	-- 				end
-- 	-- 			end
-- 	-- 		end
-- 	-- 		fujiF.xiugaiRF:Hide()
-- 	-- 	end);
-- 	-- 	pbut.zhize3 = CreateFrame("Button",nil,pbut)
-- 	-- 	pbut.zhize3:SetSize(shezhiWH,shezhiWH);
-- 	-- 	pbut.zhize3:SetPoint("LEFT", pbut.zhize2, "RIGHT", 4,0);
-- 	-- 	pbut.zhize3.Tex = pbut.zhize3:CreateTexture();
-- 	-- 	pbut.zhize3.Tex:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
-- 	-- 	pbut.zhize3.Tex:SetTexCoord(zhizeIcon[3][1],zhizeIcon[3][2],zhizeIcon[3][3],zhizeIcon[3][4]);
-- 	-- 	pbut.zhize3.Tex:SetSize(shezhiWH,shezhiWH);
-- 	-- 	pbut.zhize3.Tex:SetPoint("CENTER", pbut.zhize3, "CENTER", 0,0);
-- 	-- 	pbut.zhize3:SetScript("OnMouseDown", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut.zhize3, "CENTER", 1.5,-1.5);
-- 	-- 	end);
-- 	-- 	pbut.zhize3:SetScript("OnMouseUp", function (self)
-- 	-- 		self.Tex:SetPoint("CENTER", pbut.zhize3, "CENTER", 0,0);
-- 	-- 	end);
-- 	-- 	pbut.zhize3:HookScript("OnClick", function (self)
-- 	-- 		local fujiku = self:GetParent()
-- 	-- 		local wanjname = fujiku.name:GetText()
-- 	-- 		for p=1,MAX_RAID_MEMBERS do
-- 	-- 			local name = GetRaidRosterInfo(p);
-- 	-- 			if name then
-- 	-- 				if name==wanjname then
-- 	-- 					UnitSetRole(riad..p, "DAMAGER")
-- 	-- 					break
-- 	-- 				end
-- 	-- 			end
-- 	-- 		end
-- 	-- 		fujiF.xiugaiRF:Hide()
-- 	-- 	end);
-- 	-- 	pbut.name = PIGFontString(pbut,{"LEFT", pbut.zhize3, "RIGHT", 4,0},"", "OUTLINE");
-- 	-- end
-- 	-- local function xianshixiugaiUI(self,rid,ZID)
-- 	-- 	fujiF.xiugaiRF:SetPoint("TOP", self, "BOTTOM", 0,-4);
-- 	-- 	fujiF.xiugaiRF.biaoti:SetText(_G[Roles[rid]].."-"..Roles_List[rid][ZID][2])
-- 	-- 	for p=1,MAX_RAID_MEMBERS do
-- 	-- 		local xuanzeli = _G["Zuidui_xigairzhizeUI_"..p]
-- 	-- 		xuanzeli:Hide()
-- 	-- 		if fujiF.Datas_DQList[p] then
-- 	-- 			if fujiF.Datas_DQList[p][3]==Roles[rid] then
-- 	-- 				xuanzeli:Show()
-- 	-- 				xuanzeli.name:SetText(fujiF.Datas_DQList[p][1])
-- 	-- 			end
-- 	-- 		end
-- 	-- 	end
-- 	-- end
	fujiF.topF.playerNum = PIGFontString(fujiF.topF,{"BOTTOMLEFT",fujiF.topF,"BOTTOMLEFT", 10,10},"总人数:");
	fujiF.topF.playerNumV = PIGFontString(fujiF.topF,{"LEFT",fujiF.topF.playerNum,"RIGHT",4,0});
	fujiF.topF.playerNumV:SetTextColor(0, 1, 0, 1);
	fujiF.topF.playerNumxie = PIGFontString(fujiF.topF,{"LEFT", fujiF.topF.playerNumV, "RIGHT", 2,0},"/");
	fujiF.topF.playerNumV_max = PIGFontString(fujiF.topF,{"LEFT", fujiF.topF.playerNumxie, "RIGHT", 2,0});
	fujiF.topF.playerNumV_max:SetTextColor(1, 0, 0, 1)
	--载入开团模板
	fujiF.topF.daoruMoren=PIGDownMenu(fujiF.topF,{"LEFT",fujiF.topF.playerNum,"RIGHT", 50,0},{124,22})
	fujiF.topF.daoruMoren:PIGDownMenu_SetText("导入开团模板")
	function fujiF.topF.daoruMoren:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for ixx=1,#PIGA["Tardis"]["Invite"]["Template"] do
			info.text, info.arg1 = PIGA["Tardis"]["Invite"]["Template"][ixx][1], PIGA["Tardis"]["Invite"]["Template"][ixx][2]
		    info.notCheckable = true;
		    self:PIGDownMenu_AddButton(info)
		end
	end
	function fujiF.topF.daoruMoren:PIGDownMenu_SetValue(value,arg1)
		PIGA["Tardis"]["Invite"]["DQMubiao"]=arg1
		fujiF.Datas_MB=InitializationData(PIGA["Tardis"]["Invite"]["DQMubiao"],true)
		fujiF:Update_ShowList()
		PIG_OptionsUI:ErrorMsg("已导入|cffFFFFFF"..value.."|r开团模板");
		PIGCloseDropDownMenus()
	end
	fujiF.topF.SaveTemplate=PIGButton(fujiF.topF,{"LEFT",fujiF.topF.daoruMoren,"RIGHT", 2,0},{50,20},"保存")
	fujiF.topF.SaveTemplate:SetScript("OnClick", function (self)
		if self.F:IsShown() then
			self.F:Hide()
		else
			self.F:Show()
		end
	end)
	fujiF.topF.SaveTemplate.F = PIGFrame(fujiF.topF.SaveTemplate,{"BOTTOM",fujiF.topF.SaveTemplate,"TOP",0,1});
	fujiF.topF.SaveTemplate.F:SetSize(250,160)
	fujiF.topF.SaveTemplate.F:PIGSetBackdrop(1)
	fujiF.topF.SaveTemplate.F:SetFrameLevel(fujiF.topF.SaveTemplate.F:GetFrameLevel()+5)
	fujiF.topF.SaveTemplate.F:Hide()
	fujiF.topF.SaveTemplate.F.TT = PIGFontString(fujiF.topF.SaveTemplate.F,{"TOP", fujiF.topF.SaveTemplate.F, "TOP", 0,-6},"保存目标人数为模板", "OUTLINE");
	fujiF.topF.SaveTemplate.F.Name = PIGFontString(fujiF.topF.SaveTemplate.F,{"TOPLEFT", fujiF.topF.SaveTemplate.F, "TOPLEFT", 6,-50},"模版名:", "OUTLINE");
	fujiF.topF.SaveTemplate.F.E = CreateFrame("EditBox", nil, fujiF.topF.SaveTemplate.F, "InputBoxInstructionsTemplate");
	fujiF.topF.SaveTemplate.F.E:SetSize(180,zhiye_but_H);
	fujiF.topF.SaveTemplate.F.E:SetPoint("LEFT", fujiF.topF.SaveTemplate.F.Name, "RIGHT", 4,0);
	PIGSetFont(fujiF.topF.SaveTemplate.F.E,14,"OUTLINE")
	fujiF.topF.SaveTemplate.F.E:SetMaxLetters(20)
	fujiF.topF.SaveTemplate.F.error = PIGFontString(fujiF.topF.SaveTemplate.F,{"TOPLEFT", fujiF.topF.SaveTemplate.F.E, "BOTTOMLEFT", 6,-2},"", "OUTLINE");
	fujiF.topF.SaveTemplate.F.error:SetTextColor(1, 0, 0, 1)
	fujiF.topF.SaveTemplate.F.SaveBut=PIGButton(fujiF.topF.SaveTemplate.F,{"BOTTOM",fujiF.topF.SaveTemplate.F,"BOTTOM", -50,30},{50,24},"保存")
	fujiF.topF.SaveTemplate.F.SaveBut:SetScript("OnClick", function (self)
		local tpname = fujiF.topF.SaveTemplate.F.E:GetText()
		if tpname and tpname~="" and tpname~=" " then
			for ixx=1,#PIGA["Tardis"]["Invite"]["Template"] do
				if PIGA["Tardis"]["Invite"]["Template"][ixx][1]==tpname then
					fujiF.topF.SaveTemplate.F.error:SetText("已存在同名模版")
					return
				end
			end
			table.insert(PIGA["Tardis"]["Invite"]["Template"],{tpname,fujiF.Datas_MB})
			fujiF.topF.SaveTemplate.F:Hide()
		else
			fujiF.topF.SaveTemplate.F.error:SetText("模版名不能为空")
		end
	end)
	fujiF.topF.SaveTemplate.F.OffBut=PIGButton(fujiF.topF.SaveTemplate.F,{"BOTTOM",fujiF.topF.SaveTemplate.F,"BOTTOM", 50,30},{50,24},"取消")
	fujiF.topF.SaveTemplate.F.OffBut:SetScript("OnClick", function (self)
		fujiF.topF.SaveTemplate.F:Hide()
	end)
	---转换团队/小队
	fujiF.topF.zhuanhuanPR=PIGButton(fujiF.topF,{"LEFT",fujiF.topF.SaveTemplate,"RIGHT", 30,0},{80,20},"转为团队")
	fujiF.topF.zhuanhuanPR:SetScript("OnShow", function (self)
		fujiF.topF.zhuanhuanPR:Update_ButText()
	end)
	fujiF.topF.zhuanhuanPR:SetScript("OnClick", function (self)
		if IsInRaid(LE_PARTY_CATEGORY_HOME) then
			ConvertToParty() 
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			ConvertToRaid()
		end
	end)
	function fujiF.topF.zhuanhuanPR:Update_ButText()
		if IsInRaid(LE_PARTY_CATEGORY_HOME) then
			self:SetText("转为小队")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			self:SetText("转为团队")
		end
	end
	---职责确认
	fujiF.topF.RolesJC=PIGButton(fujiF.topF,{"LEFT",fujiF.topF.zhuanhuanPR,"RIGHT", 30,0},{90,20},"职责确认")
	fujiF.topF.RolesJC:SetScript("OnClick", function (self)
		if PIG_MaxTocversion(20000) then
			--LFGListingRolePollButton_OnClick(self, button)
		elseif PIG_MaxTocversion(30000) then
			LFGListingRolePollButton_OnClick(self, button)
		else
			InitiateRolePoll()
		end
	end)
	---就位确认
	fujiF.topF.jiuwei=PIGButton(fujiF.topF,{"LEFT",fujiF.topF.RolesJC,"RIGHT", 30,0},{90,20},"就位确认")
	fujiF.topF.jiuwei:SetScript("OnClick", function (self)
		DoReadyCheck()
	end)
	---刷新
	fujiF.topF.shuaxinP=PIGButton(fujiF.topF,{"LEFT",fujiF.topF.jiuwei,"RIGHT", 30,0},{110,20},"刷新成员信息")
	fujiF.topF.shuaxinP:SetScript("OnClick", function (self)
		fujiF:_GetNumGroupMembers()
		fujiF:Update_ShowList()
	end)
	fujiF.topF:HookScript("OnShow", function(self)
		fujiF:_GetNumGroupMembers()
		fujiF:Update_ShowList()
	end);
	------
	fujiF.Datas_MB=InitializationData(PIGA["Tardis"]["Invite"]["DQMubiao"],true)
	fujiF.Datas_DQ=InitializationData()
	fujiF.PlayerNum_MB={["All"]=0,["Role"]={}};
	fujiF.PlayerNum_DQ={["All"]=0,["Role"]={}};
	--更新人数显示
	function fujiF:Update_Data()
		self.PlayerNum_MB.All=0
		wipe(self.PlayerNum_MB.Role)
		for xulie=1,#Roles_List do
			self.PlayerNum_MB.Role[xulie]=0
			for id=1,#Roles_List[xulie] do
				self.PlayerNum_MB.All=self.PlayerNum_MB.All+self.Datas_MB[xulie][id]
				self.PlayerNum_MB.Role[xulie]=self.PlayerNum_MB.Role[xulie]+self.Datas_MB[xulie][id]
			end
		end
		---
		self.PlayerNum_DQ.All=0
		wipe(self.PlayerNum_DQ.Role)
		for xulie=1,#Roles_List do
			self.PlayerNum_DQ.Role[xulie]=0
			for id=1,#Roles_List[xulie] do
				self.PlayerNum_DQ.All=self.PlayerNum_DQ.All+self.Datas_DQ[xulie][id]
				self.PlayerNum_DQ.Role[xulie]=self.PlayerNum_DQ.Role[xulie]+self.Datas_DQ[xulie][id]
			end
		end
	end
	function fujiF:Update_ShowList()
		self:Update_Data()
		if not self.topF:IsVisible() then return end
		for xulie=1,#Roles_List do
			for id=1,#Roles_List[xulie] do
				self.topF.RoleButList[xulie].mubiao_EBut[id]:SetText(self.Datas_MB[xulie][id])
			end
			self.topF.RoleButList[xulie].mubiaoAll_V:SetText(self.PlayerNum_MB.Role[xulie])
		end
		self.topF.playerNumV_max:SetText(self.PlayerNum_MB.All)
		---
		for xulie=1,#Roles_List do
			for id=1,#Roles_List[xulie] do
				local fujiku = self.topF.RoleButList[xulie].mubiao_EBut[id]
				fujiku.yizu:SetText(self.Datas_DQ[xulie][id])
				fujiku.wancheng:Hide()
				if self.Datas_DQ[xulie][id]==self.Datas_MB[xulie][id] then
					fujiku.wancheng:Show()
					fujiku.wancheng:SetTexture("interface/raidframe/readycheck-ready.blp");
				elseif self.Datas_DQ[xulie][id]<self.Datas_MB[xulie][id] then
					fujiku.wancheng:Show()
					fujiku.wancheng:SetTexture("interface/raidframe/readycheck-notready.blp");
				elseif self.Datas_DQ[xulie][id]>self.Datas_MB[xulie][id] then
					fujiku.wancheng:Show()
					fujiku.wancheng:SetTexture(136815);
				end	
			end
			self.topF.RoleButList[xulie].dangqianAll_V:SetText(self.PlayerNum_DQ.Role[xulie])
		end
		self.topF.playerNumV:SetText(self.PlayerNum_DQ.All)
	end
	--获取当前人员/人数
	function fujiF:_GetNumGroupMembers()
		for xulie=1,#Roles_List do
			for id=1,#Roles_List[xulie] do
				self.Datas_DQ[xulie][id]=0
			end
		end
		local NewZhiyeData={};
		for p=1,MAX_RAID_MEMBERS do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
			if name then
				NewZhiyeData[name]={fileName,combatRole}
			end
		end
		for xulie=1,#Roles_List do
			for id=1,#Roles_List[xulie] do
				for k,v in pairs(NewZhiyeData) do
					if v[1]==Roles_List[xulie][id][1] then
						if v[2]==Roles[xulie] then
							self.Datas_DQ[xulie][id]=self.Datas_DQ[xulie][id]+1
						end
					end
				end
			end
		end	
	end
	fujiF:RegisterEvent("PLAYER_ENTERING_WORLD")	
	fujiF:HookScript("OnEvent",function(self,event,arg1,arg2,_,_,arg5,_,_,_,_,_,_,arg12)
		if event=="PLAYER_ENTERING_WORLD" then
			self:_GetNumGroupMembers()
			self:RegisterEvent("GROUP_ROSTER_UPDATE")
		elseif event=="GROUP_ROSTER_UPDATE" then
			self.topF.zhuanhuanPR:Update_ButText()
			C_Timer.After(0.4,function()
				self:_GetNumGroupMembers()
				-- self.Is_GroupLeader("event")
				-- self.Is_RaidNumOK("event")
			end)
		end
	end)
	---底部设置===================
	fujiF.botF = PIGFrame(fujiF,{"TOPLEFT",fujiF.topF,"BOTTOMLEFT",4,0});
	fujiF.botF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", -4, 4);
	fujiF.botF:PIGSetBackdrop(0)
	--喊话内容
	fujiF.botF.YellF = PIGFrame(fujiF.botF,{"TOPLEFT", fujiF.botF, "TOPLEFT", 4,-22});
	fujiF.botF.YellF:SetPoint("BOTTOMLEFT", fujiF.botF, "BOTTOMLEFT", -200, 4);
	fujiF.botF.YellF:SetWidth(300)
	fujiF.botF.YellF:PIGSetBackdrop()
	fujiF.botF.YellF.biaoti = PIGFontString(fujiF.botF.YellF,{"BOTTOMLEFT", fujiF.botF.YellF, "TOPLEFT", 2,4},"喊话内容");
	fujiF.botF.YellF.biaoti:SetTextColor(0, 1, 0, 1);
	fujiF.botF.YellF.zifulen = PIGFontString(fujiF.botF.YellF,{"BOTTOMLEFT", fujiF.botF.YellF.biaoti, "BOTTOMRIGHT", 0,0},"(当前字符数",nil,12);
	fujiF.botF.YellF.zifulen:SetTextColor(0, 1, 1, 1);
	fujiF.botF.YellF.zifulenV = PIGFontString(fujiF.botF.YellF,{"LEFT", fujiF.botF.YellF.zifulen, "RIGHT", 0,0},0,nil,12);
	fujiF.botF.YellF.zifulenV:SetTextColor(0, 1, 0, 1);
	fujiF.botF.YellF.zifulenend = PIGFontString(fujiF.botF.YellF,{"LEFT", fujiF.botF.YellF.zifulenV, "RIGHT", 0,0},"/250):",nil,12);
	fujiF.botF.YellF.zifulenend:SetTextColor(0, 1, 1, 1);
	fujiF.botF.YellF.E = CreateFrame("EditBox", nil, fujiF.botF.YellF);
	fujiF.botF.YellF.E:SetPoint("TOPLEFT", fujiF.botF.YellF, "TOPLEFT", 2,-2);
	fujiF.botF.YellF.E:SetPoint("BOTTOMRIGHT", fujiF.botF.YellF, "BOTTOMRIGHT", -2,2);
	fujiF.botF.YellF.E:SetFontObject(ChatFontNormal);
	fujiF.botF.YellF.E:SetAutoFocus(false);
	fujiF.botF.YellF.E:SetMultiLine(true)
	fujiF.botF.YellF.E:SetMaxLetters(200);
	fujiF.botF.YellF.E:SetTextColor(0.7, 0.7, 0.7, 1);
	fujiF.botF.YellF.E:SetScript("OnEditFocusGained", function(self) 
		fujiF.botF.YellF.SaveBut:Show();
		self:SetTextColor(1, 1, 1, 1);
	end);
	fujiF.botF.YellF.E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.7, 0.7, 0.7, 1);
		self:SetText(PIGA["Tardis"]["Invite"]["YellMsg"])
	end);
	fujiF.botF.YellF.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
		fujiF.botF.YellF.SaveBut:Hide();
	end);
	local function EditBox_panduan(Newtxt)
		local famsg = Get_famsg("yell",Newtxt,PIGA["Tardis"]["Yell"]["jinzuCMD_inv"],PIGA["Tardis"]["Yell"]["jinzuCMD"])
		local msglen = #famsg
		if msglen>250 then
			fujiF.botF.YellF.zifulenV:SetText(msglen)
			fujiF.botF.YellF.zifulenV:SetTextColor(1, 0, 0, 1);
			PIG_OptionsUI:ErrorMsg("超过最大字符数!!!","R");
			return true,msglen
		else
			fujiF.botF.YellF.zifulenV:SetText(msglen)
			fujiF.botF.YellF.zifulenV:SetTextColor(1, 1, 0, 1);
		end
		return false,msglen
	end
	fujiF.botF.YellF.E:SetScript("OnCursorChanged", function(self)
		EditBox_panduan(fujiF.botF.YellF.E:GetText())
	end);
	fujiF.botF.YellF.SaveBut = PIGButton(fujiF.botF.YellF,{"BOTTOMRIGHT",fujiF.botF.YellF,"TOPRIGHT",0,0.4},{50,19},"保存");
	fujiF.botF.YellF.SaveBut:Hide()
	fujiF.botF.YellF.SaveBut:SetScript("OnClick", function(self)
		local Newtxt = fujiF.botF.YellF.E:GetText()
		if not EditBox_panduan(Newtxt) then
			PIGA["Tardis"]["Invite"]["YellMsg"]=Newtxt
			fujiF.botF.YellF.E:ClearFocus()
			fujiF.botF.YellF.SaveBut:Hide()
		end
	end);
	fujiF.botF.YellF.SaveYellTemp = PIGButton(fujiF.botF.YellF,{"LEFT",fujiF.botF.YellF.SaveBut,"RIGHT",4,0},{100,19},"保存为模板");
	fujiF.botF.YellF.SaveYellTemp:SetScript("OnClick", function(self)
		local Newtxt = fujiF.botF.YellF.E:GetText()
		-- if not EditBox_panduan(Newtxt) then
		-- 	PIGA["Tardis"]["Invite"]["YellMsg"]=Newtxt
		-- 	--fujiF.Updata_Macro()
		-- 	fujiF.botF.YellF.E:ClearFocus()
		-- 	fujiF.botF.YellF.SaveBut:Hide()
		-- end
	end);
	--喊话模板
	fujiF.botF.YellF.YellTemp=PIGDownMenu(fujiF.botF.YellF,{"TOPLEFT",fujiF.botF.YellF.SaveYellTemp,"BOTTOMLEFT",0,-4},{100,22})
	fujiF.botF.YellF.YellTemp:PIGDownMenu_SetText("喊话模板")
	function fujiF.botF.YellF.YellTemp:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for ixx=1,#PIGA["Tardis"]["Invite"]["YellTemp"] do
			info.text, info.arg1 = PIGA["Tardis"]["Invite"]["YellTemp"][ixx][1], PIGA["Tardis"]["Invite"]["YellTemp"][ixx][2]
		    info.notCheckable = true;
		    self:PIGDownMenu_AddButton(info)
		end
	end
	function fujiF.botF.YellF.YellTemp:PIGDownMenu_SetValue(value,arg1)
		fujiF.botF.YellF.E:SetText(arg1)
		PIGCloseDropDownMenus()
	end

-- 	--指令邀请
-- 	fujiF.botF.jinzuCMD_inv = PIGCheckbutton(fujiF.botF,{"TOPLEFT",fujiF.botF.changyong,"BOTTOMLEFT",0,-10},{"喊话附加进组暗号","喊话内容附加进组暗号，玩家回复暗号可执行预设指令\n|cffFF0000需开启《自动回复/邀请》|r"})
-- 	fujiF.botF.jinzuCMD_inv:SetScript("OnClick", function (self)
-- 		if self:GetChecked() then
-- 			PIGA["Tardis"]["Yell"]["jinzuCMD_inv"]=true;
-- 		else
-- 			PIGA["Tardis"]["Yell"]["jinzuCMD_inv"]=false;
-- 		end
-- 		if not EditBox_panduan(fujiF.botF.YellF.E:GetText()) then
-- 			--fujiF.Updata_Macro()
-- 		end
-- 	end);
-- 	--主屏幕快捷按钮===
-- 	local QuickButUI=_G[Data.QuickButUIname]
-- 	fujiF.botF.ShowDesktopBut = PIGCheckbutton(fujiF.botF,{"TOPLEFT",fujiF.botF.jinzuCMD_inv,"BOTTOMLEFT",0,-10},{"功能动作条按钮","添加喊话按钮到功能动作条\n此功能需要先开启功能动作条"})
-- 	fujiF.botF.ShowDesktopBut:SetScript("OnClick", function (self)
-- 		if self:GetChecked() then
-- 			PIGA["Tardis"]["Yell"]["ShowDesktopBut"]=true;
-- 		else
-- 			PIGA["Tardis"]["Yell"]["ShowDesktopBut"]=false;
-- 		end
-- 		QuickButUI.ButList[TardisInfo.uidata[5]+1]()
-- 	end);
-- 	local WWHH = 24
-- 	QuickButUI.ButList[TardisInfo.uidata[5]+1]=function()
-- 		if PIGA["QuickBut"]["Open"] and PIGA["Tardis"]["Open"] then
-- 			if PIGA["Tardis"]["Yell"]["ShowDesktopBut"] then
-- 				if QuickButUI.ShowDesktopButOpen then
-- 					QuickButUI.ShowDesktopButOpen.yincang=nil
-- 					local fujiww = QuickButUI.nr:GetHeight()
-- 					QuickButUI.ShowDesktopButOpen:Show()
-- 					QuickButUI.ShowDesktopButOpen:SetWidth(fujiww)
-- 					QuickButUI:UpdateWidth()
-- 					return 
-- 				end
				
-- 				local QuickTooltip = KEY_BUTTON1.."-|cff00FFFF"..L["TARDIS_YELL"].."|r\n"..KEY_BUTTON2.."-|cff00FFFF"..SETTINGS.."|r"
-- 				local QkBut=PIGQuickBut(nil,QuickTooltip,132333)
-- 				QuickButUI.ShowDesktopButOpen=QkBut
-- 				QkBut.Cooldown = CreateFrame("Cooldown",nil, QkBut, "CooldownFrameTemplate")
-- 				QkBut.Cooldown:SetAllPoints()
-- 				QkBut:HookScript("OnClick", function (self,button)
-- 					if button=="LeftButton" then
-- 						if self.Cooldown:GetCooldownDuration()>0 then
-- 							PIG_OptionsUI:ErrorMsg(ERR_CHAT_THROTTLED);
-- 						else
-- 							fujiF.Kaishi_Yell(self)
-- 						end	
-- 					else
-- 						if InvF:IsShown() then
-- 							InvF:Hide()
-- 						else
-- 							InvF:Show()
-- 							Create.Show_TabBut_R(InvF.F,fujiF,fujiTabBut)
-- 						end
-- 					end
-- 				end);
-- 				local WowHeight=GetScreenHeight();
-- 				local function YaoqingSetPoint(self)		
-- 					local offset1 = QkBut:GetBottom();
-- 					self:ClearAllPoints();
-- 					if offset1>(WowHeight*0.5) then
-- 						self:SetPoint("TOP",QkBut,"BOTTOM",0,-2);
-- 					else
-- 						self:SetPoint("BOTTOM",QkBut,"TOP",0,2);
-- 					end
-- 				end
-- 				QkBut.AutoYaoqing = CreateFrame("Button",nil,QkBut);
-- 				QuickButUI.yidong:HookScript("OnDragStop",function(self)
-- 					YaoqingSetPoint(QkBut.AutoYaoqing)	
-- 				end)
-- 				YaoqingSetPoint(QkBut.AutoYaoqing)	
-- 				QkBut.AutoYaoqing:SetSize(WWHH,WWHH);
-- 				QkBut.AutoYaoqing.Tex = QkBut.AutoYaoqing:CreateTexture(nil, "BORDER");
-- 				if PIG_OptionsUI.autoInvite_shikong then
-- 					QkBut.AutoYaoqing.Tex:SetTexture("interface/common/indicator-green.blp");
-- 				else
-- 					QkBut.AutoYaoqing.Tex:SetTexture("interface/common/indicator-gray.blp");
-- 				end
-- 				QkBut.AutoYaoqing.Tex:SetPoint("CENTER",0,-1);
-- 				QkBut.AutoYaoqing.Tex:SetSize(WWHH,WWHH);
-- 				QkBut.AutoYaoqing:SetScript("OnEnter", function (self)
-- 					GameTooltip:ClearLines();
-- 					local offset1 = QkBut:GetBottom();
-- 					if offset1>(WowHeight*0.5) then
-- 						GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",-20,0);
-- 					else
-- 						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
-- 					end
-- 					if PIG_OptionsUI.autoInvite_shikong then
-- 						GameTooltip:AddLine("自动回复/邀请:|cff00ff00"..ENABLE.."|r")
-- 						GameTooltip:AddLine("|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..CLOSE.."|r")
-- 					else
-- 						GameTooltip:AddLine("自动回复/邀请:|cffff0000"..CLOSE.."|r")
-- 						GameTooltip:AddLine("|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..ENABLE.."|r")
-- 					end
-- 					GameTooltip:Show();
-- 				end);
-- 				QkBut.AutoYaoqing:SetScript("OnLeave", function ()
-- 					GameTooltip:ClearLines();
-- 					GameTooltip:Hide() 
-- 				end);
-- 				QkBut.AutoYaoqing:SetScript("OnClick", function (self)
-- 					PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
-- 					fujiF.Auto_FunOpen()
-- 					GameTooltip:Hide() 
-- 				end)
-- 			else
-- 				if QuickButUI.ShowDesktopButOpen then
-- 					QuickButUI.ShowDesktopButOpen:Hide()
-- 					QuickButUI.ShowDesktopButOpen:SetWidth(0.0001)
-- 					QuickButUI.ShowDesktopButOpen.yincang=true
-- 					QuickButUI:UpdateWidth()
-- 				end
-- 			end
-- 		end
-- 	end
	--喊话按钮
	fujiF.botF.yellbut = PIGButton(fujiF.botF,{"BOTTOMLEFT",fujiF.botF.YellF,"BOTTOMRIGHT",10,10},{100,25},SEND_LABEL..L["TARDIS_YELL"]);
	fujiF.botF.yellbut:SetScript("OnClick", function (self)
		fujiF.Kaishi_Yell(PIG_QuickButUI.ShowDesktopButOpen)
	end);
	--喊话频道
	fujiF.botF.Yell_CHANNEL=PIGDownMenu(fujiF.botF,{"LEFT",fujiF.botF.yellbut,"RIGHT",10,0},{70,25})
	fujiF.botF.Yell_CHANNEL:PIGDownMenu_SetText(CHANNEL)
	function fujiF.botF.Yell_CHANNEL:PIGDownMenu_Update_But()
		fujiF.PindaoList=GetPindaoList()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#fujiF.PindaoList,1 do
		    info.text, info.arg1 = fujiF.PindaoList[i][1], fujiF.PindaoList[i][2]
		    info.checked = PIGA["Tardis"]["Yell"]["Yell_CHANNEL"][fujiF.PindaoList[i][2]]
		    info.isNotRadio=true
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function fujiF.botF.Yell_CHANNEL:PIGDownMenu_SetValue(value,arg1,arg2,checked)
		PIGA["Tardis"]["Yell"]["Yell_CHANNEL"][arg1]=checked
		PIGCloseDropDownMenus()
	end
	---
	fujiF.botF:HookScript("OnShow", function(self)
		self.YellF.E:SetText(PIGA["Tardis"]["Invite"]["YellMsg"])
		-- self.jinzuCMD_inv:SetChecked(PIGA["Tardis"]["Yell"]["jinzuCMD_inv"])
		-- self.ShowDesktopBut:SetChecked(PIGA["Tardis"]["Yell"]["ShowDesktopBut"])
	end);
	---
	fujiF.Yell_CD=10
	fujiF.PindaoList={}
	local function hanhuadaojishiTime()
		if fujiF.hanhuadaojishi>0 then
			fujiF.botF.yellbut:SetText(ON_COOLDOWN.."("..fujiF.hanhuadaojishi..")");
			C_Timer.After(1,hanhuadaojishiTime)
			fujiF.hanhuadaojishi=fujiF.hanhuadaojishi-1
		else
			fujiF.botF.yellbut:Enable() 
			fujiF.botF.yellbut:SetText(SEND_LABEL..L["TARDIS_YELL"]);
		end
	end
	function fujiF.Kaishi_Yell(self)
		if EditBox_panduan(PIGA["Tardis"]["Invite"]["YellMsg"]) then return end
		local yellpindaolist =GetYellPindao(fujiF.PindaoList,PIGA["Tardis"]["Yell"]["Yell_CHANNEL"])
		local keyongshu = #yellpindaolist
		if keyongshu>0 then
			local famsg =Get_famsg("yell",PIGA["Tardis"]["Invite"]["YellMsg"],PIGA["Tardis"]["Yell"]["jinzuCMD_inv"],PIGA["Tardis"]["Yell"]["jinzuCMD"])
			for x=1,#yellpindaolist do
				local suijishu=random(1, 8)
				local famsg = famsg..MSGsuijizifu[suijishu]
				SendChatMessage(famsg,yellpindaolist[x][1],nil,yellpindaolist[x][2])
			end
			fujiF.hanhuadaojishi=fujiF.Yell_CD*keyongshu
			fujiF.botF.yellbut:Disable();
			fujiF.botF.yellbut:SetText(L["TARDIS_YELL"].."("..fujiF.hanhuadaojishi..")");
			if self then self.Cooldown:SetCooldown(GetTime(), fujiF.Yell_CD*keyongshu) end
			hanhuadaojishiTime()
		else
			PIG_OptionsUI:ErrorMsg("请先选择喊话频道");
		end
	end
-- 	--=邀请条件====================
-- 	fujiF.botF_R = PIGFrame(fujiF,{"TOPLEFT",fujiF.botF,"TOPRIGHT",4,0});
-- 	fujiF.botF_R:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", -4, 4);
-- 	fujiF.botF_R:PIGSetBackdrop(0)
-- 	local function SetInvModeFun()
-- 		fujiF.botF_R.AutoHuifu:SetChecked(false)
-- 		fujiF.botF_R.XZ_zhiye:SetChecked(false)
-- 		fujiF.topF.zhiyeXZ:Hide()
-- 		fujiF.topF.autoHF:Hide()
-- 		if PIGA["Tardis"]["Yell"]["InvMode"]==1 then
-- 			fujiF.botF_R.AutoHuifu:SetChecked(true)
-- 			fujiF.topF.autoHF:Show()
-- 		elseif PIGA["Tardis"]["Yell"]["InvMode"]==2 then
-- 			fujiF.botF_R.XZ_zhiye:SetChecked(true)
-- 			fujiF.topF.zhiyeXZ:Show()
-- 		end
-- 	end
-- 	---自定义回复
-- 	fujiF.botF_R.AutoHuifu = PIGCheckbutton(fujiF.botF_R,{"TOPLEFT",fujiF.botF_R,"TOPLEFT",10,-10},{"自定义回复/邀请","根据自定义触发词自动回复/邀请"})
-- 	fujiF.botF_R.AutoHuifu:SetScript("OnClick", function (self)
-- 		PIGA["Tardis"]["Yell"]["InvMode"]=1;
-- 		SetInvModeFun()
-- 	end);
-- 	---职业职责限制
-- 	fujiF.botF_R.XZ_zhiye = PIGCheckbutton(fujiF.botF_R,{"TOPLEFT",fujiF.botF_R.AutoHuifu,"BOTTOMLEFT",0,-10},{"根据职业回复/邀请","检测到进组暗号后自动询问职业职责，符合预设条件即邀请，达到预设人数将停止邀请"})
-- 	fujiF.botF_R.XZ_zhiye:SetScript("OnClick", function (self)
-- 		PIGA["Tardis"]["Yell"]["InvMode"]=2;
-- 		SetInvModeFun()
-- 	end);
-- 	----自动邀请
-- 	fujiF.botF_R.AutoYaoqing = PIGButton(fujiF.botF_R,{"BOTTOMLEFT",fujiF.botF_R,"BOTTOMLEFT",10,6},{130,24},"自动回复/邀请");  
-- 	fujiF.botF_R.AutoYaoqing.Text:SetPoint("CENTER",fujiF.botF_R.AutoYaoqing,"CENTER",8,0);
-- 	fujiF.botF_R.AutoYaoqing.Text:SetTextColor(0, 1, 1, 1);
-- 	fujiF.botF_R.AutoYaoqing.Tex = fujiF.botF_R.AutoYaoqing:CreateTexture(nil, "BORDER");
-- 	fujiF.botF_R.AutoYaoqing.Tex:SetTexture("interface/common/indicator-gray.blp");
-- 	fujiF.botF_R.AutoYaoqing.Tex:SetPoint("RIGHT",fujiF.botF_R.AutoYaoqing.Text,"LEFT",0,-1);
-- 	fujiF.botF_R.AutoYaoqing.Tex:SetSize(23,23);
-- 	fujiF.botF_R.AutoYaoqing:HookScript("OnMouseDown", function(self)
-- 		if self:IsEnabled() then
-- 			self.Text:SetPoint("CENTER",fujiF.botF_R.AutoYaoqing,"CENTER",9.5,-1.5);
-- 		end
-- 	end);
-- 	fujiF.botF_R.AutoYaoqing:HookScript("OnMouseUp", function(self)
-- 		if self:IsEnabled() then
-- 			self.Text:SetPoint("CENTER",fujiF.botF_R.AutoYaoqing,"CENTER",8,0);
-- 		end
-- 	end);
-- 	fujiF.botF_R.AutoYaoqing:SetScript("OnClick", function (self)
-- 		fujiF.Auto_FunOpen()
-- 	end)
-- 	--进组指令
-- 	fujiF.botF_R.jinzuCMDE_T = PIGFontString(fujiF.botF_R,{"LEFT",fujiF.botF_R.AutoYaoqing,"RIGHT",20,0},"进组暗号:");
-- 	fujiF.botF_R.jinzuCMDE = CreateFrame("EditBox", nil, fujiF.botF_R,"InputBoxInstructionsTemplate");
-- 	fujiF.botF_R.jinzuCMDE:SetSize(60,26);
-- 	fujiF.botF_R.jinzuCMDE:SetPoint("LEFT",fujiF.botF_R.jinzuCMDE_T,"RIGHT",6,0);
-- 	fujiF.botF_R.jinzuCMDE:SetFontObject(ChatFontNormal);
-- 	fujiF.botF_R.jinzuCMDE:SetMaxLetters(6)
-- 	fujiF.botF_R.jinzuCMDE:SetAutoFocus(false);
-- 	fujiF.botF_R.jinzuCMDE:SetTextColor(0.7, 0.7, 0.7, 1);
-- 	fujiF.botF_R.jinzuCMDE:SetScript("OnEditFocusGained", function(self) 
-- 		self:SetTextColor(1, 1, 1, 1);
-- 	end);
-- 	fujiF.botF_R.jinzuCMDE:SetScript("OnEditFocusLost", function(self)
-- 		self:SetTextColor(0.7, 0.7, 0.7, 1);
-- 		self:SetText(PIGA["Tardis"]["Yell"]["jinzuCMD"])
-- 	end);
-- 	fujiF.botF_R.jinzuCMDE:SetScript("OnEscapePressed", function(self) 
-- 		self:ClearFocus()
-- 	end);
-- 	fujiF.botF_R.jinzuCMDE:SetScript("OnEnterPressed", function(self) 
-- 		PIGA["Tardis"]["Yell"]["jinzuCMD"]=self:GetText();
-- 		self:ClearFocus()
-- 		--fujiF.Updata_Macro()
-- 	end);
-- 	----
-- 	fujiF.botF_R:HookScript("OnShow", function(self)
-- 		SetInvModeFun()
-- 		self.jinzuCMDE:SetText(PIGA["Tardis"]["Yell"]["jinzuCMD"]);
-- 	end);

-- 	--根据指令邀请
-- 	local function OFF_autoInvite(msg)
-- 		PIG_OptionsUI.autoInvite_shikong=false;
-- 		fujiF.botF_R.AutoYaoqing.Tex:SetTexture("interface/common/indicator-gray.blp");
-- 		if QuickButUI.ShowDesktopButOpen then QuickButUI.ShowDesktopButOpen.AutoYaoqing.Tex:SetTexture("interface/common/indicator-gray.blp");end
-- 		if fujiF.botF_R.hanhuaOpen then fujiF.botF_R.hanhuaOpen.Tex:SetTexture("interface/common/indicator-gray.blp");end
-- 		fujiF:UnregisterEvent("CHAT_MSG_WHISPER");
-- 		fujiF:UnregisterEvent("CHAT_MSG_SYSTEM");
-- 		PIG_OptionsUI:ErrorMsg(msg);
-- 	end
-- 	--判断是否是队长/团长/助理
-- 	function fujiF.Is_GroupLeader(laiyuan)
-- 		if IsInGroup() then
-- 			local isLeader = UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME);
-- 			local isTrue = UnitIsGroupAssistant("player", LE_PARTY_CATEGORY_HOME);
-- 			if not isLeader and not isTrue then
-- 				if laiyuan~="event" then
-- 					OFF_autoInvite("你不是队长/团长/助理,自动邀请已关闭")
-- 				end
-- 				return false
-- 			end
-- 		end
-- 		return true
-- 	end
	--获取目标人数
	--function fujiF.GetRaidMubiao()
		-- fujiF.Datas_MB=PIGCopyTable(initialNumRaid)
		-- if PIGA["Tardis"]["Yell"]["InvMode"]==1 then
		-- 	fujiF.Datas_MB.All=PIGA["Tardis"]["Yell"]["MaxPlayerNum"]
		-- elseif PIGA["Tardis"]["Yell"]["InvMode"]==2 then
		-- 	local renyuanD = PIGA["Tardis"]["Yell"]["mubiaoNum"]
		-- 	for xulie=1,#Roles_List do
		-- 		for id=1,#Roles_List[xulie] do
		-- 			local mubiaoS = renyuanD[xulie][id] or 0
		-- 			fujiF.Datas_MB.All=fujiF.Datas_MB.All+mubiaoS
		-- 			fujiF.Datas_MB.Xulie[xulie]=fujiF.Datas_MB.Xulie[xulie]+mubiaoS
		-- 			local ZhiyeS = fujiF.Datas_MB.Xulie_MB[xulie][id] or 0
		-- 			fujiF.Datas_MB.Xulie_MB[xulie][id]=ZhiyeS+mubiaoS
		-- 		end
		-- 	end
		-- end
	--end
-- 	--获取当前人员/人数
-- 	function fujiF.GetNumRaidPlayers()
-- 		local numGroupMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
-- 		if PIGA["Tardis"]["Yell"]["InvMode"]==1 then

-- 		elseif PIGA["Tardis"]["Yell"]["InvMode"]==2 then
-- 			local NewZhiyeData={};
-- 			if numGroupMembers>0 then
-- 				for p=1,MAX_RAID_MEMBERS do
-- 					local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(p);
-- 					if name then
-- 						NewZhiyeData[name]={fileName,combatRole}
-- 					end
-- 				end
-- 			end
-- 			---如果没有职责信息根据玩家回复设置
-- 			-- for x=1,#NewZhiyeData do
-- 			-- 	for p=1,#fujiF.Datas_DQList do		
-- 			-- 		if NewZhiyeData[x][1]==fujiF.Datas_DQList[p][1] then
-- 			-- 			--NewZhiyeData[x][3]=fujiF.Datas_DQ[p][3]
-- 			-- 		end
-- 			-- 	end
-- 			-- end
-- 			-- fujiF.Datas_DQList=NewZhiyeData;
-- 			fujiF.Datas_DQ=PIGCopyTable(initialNumRaid)
-- 			local renyuanNew = NewZhiyeData
-- 			for xulie=1,#Roles_List do
-- 				for id=1,#Roles_List[xulie] do
-- 					fujiF.Datas_DQ.Xulie_MB[xulie][id]=fujiF.Datas_DQ.Xulie_MB[xulie][id] or 0
-- 					for k,v in pairs(renyuanNew) do
-- 						fujiF.Datas_DQ.All=fujiF.Datas_DQ.All+1
-- 						if v[1]==Roles_List[xulie][id][1] then
-- 							if v[2]==Roles[xulie] then
-- 								fujiF.Datas_DQ.Xulie[xulie]=fujiF.Datas_DQ.Xulie[xulie]+1
-- 								fujiF.Datas_DQ.Xulie_MB[xulie][id]=fujiF.Datas_DQ.Xulie_MB[xulie][id]+1
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end	
-- 	end
-- 	function fujiF.Is_RaidNumOK(laiyuan)
-- 		local numGroupMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
-- 		local mubiaornshu = 40
-- 		if PIGA["Tardis"]["Yell"]["InvMode"]==1 then
-- 			mubiaornshu = PIGA["Tardis"]["Yell"]["MaxPlayerNum"]
-- 		elseif PIGA["Tardis"]["Yell"]["InvMode"]==2 then
-- 			mubiaornshu = fujiF.Datas_MB.All
-- 		end
-- 		if numGroupMembers>=mubiaornshu then
-- 			if laiyuan~="event" then
-- 				OFF_autoInvite("已达目标人数,自动邀请已关闭")
-- 			end
-- 			return false
-- 		end
-- 		return true,numGroupMembers
-- 	end
-- 	function fujiF.Auto_FunOpen()
-- 		if PIG_OptionsUI.autoInvite_daiben then
-- 			PIG_OptionsUI:ErrorMsg("带本助手自动邀请处于开启状态，请先关闭");
-- 		else
-- 			if PIG_OptionsUI.autoInvite_shikong then
-- 				OFF_autoInvite("已|cffFF0000关闭|r自动邀请")
-- 			else
-- 				if not EditBox_panduan(PIGA["Tardis"]["Invite"]["YellMsg"]) and fujiF.Is_GroupLeader() and fujiF.Is_RaidNumOK() then
-- 					PIG_OptionsUI.autoInvite_shikong=true
-- 					fujiF.botF_R.AutoYaoqing.Tex:SetTexture("interface/common/indicator-green.blp");
-- 					if QuickButUI.ShowDesktopButOpen then QuickButUI.ShowDesktopButOpen.AutoYaoqing.Tex:SetTexture("interface/common/indicator-green.blp"); end
-- 					fujiF:RegisterEvent("CHAT_MSG_WHISPER");
-- 					fujiF:RegisterEvent("CHAT_MSG_SYSTEM")
-- 					--fujiF.Updata_Macro("OPEN")
-- 					PIG_OptionsUI:ErrorMsg("已|cff00FF00开启|r自动邀请");
-- 				end
-- 			end
-- 		end
-- 	end
-- 	--------

-- 	--===================================
-- 	local yizuduiERR=ERR_ALREADY_IN_GROUP_S:gsub("%%s","")
-- 	--local zhiyeweizhiNameQ={"坦克","治疗","输出"}
-- 	local zhiyeweizhiKey={{"T","坦","熊","防骑","FQ"},{"N","奶","治疗"},{"DPS", "dps","伤害","输出","KBZ", "kbz", "狂暴","惩戒","电萨","鸟德","鸟D"}}
-- 	--执行邀请
-- 	local function PIG_Invite_Fun(Pname)
-- 		local numGroupMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
-- 		if numGroupMembers==5 and not IsInRaid(LE_PARTY_CATEGORY_HOME) then
-- 			ConvertToRaid()
-- 		end
-- 		PIG_InviteUnit(Pname)
-- 	end
-- 	fujiF.lishiwanjiaxinxi={};
-- 	function fujiF.Is_Oldmiyu(Pname)
-- 		for i=1,#fujiF.lishiwanjiaxinxi do
-- 			if Pname == fujiF.lishiwanjiaxinxi[i][2] then
-- 				return true
-- 			end
-- 		end
-- 		return false
-- 	end
-- 	function fujiF.GetKeyXulieID(arg1)					
-- 		for Keyxulie=1,#zhiyeweizhiKey do
-- 			for Keytxt=1,#zhiyeweizhiKey[Keyxulie] do
-- 				if arg1:match(zhiyeweizhiKey[Keyxulie][Keytxt]) then
-- 					return Keyxulie
-- 				end
-- 			end
-- 		end
-- 		return false
-- 	end
-- 	----------
-- 	fujiF:RegisterEvent("PLAYER_ENTERING_WORLD")
-- 	fujiF:RegisterEvent("GROUP_ROSTER_UPDATE")
-- 	fujiF:HookScript("OnEvent",function(self,event,arg1,arg2,_,_,arg5,_,_,_,_,_,_,arg12)
-- 		if event=="PLAYER_ENTERING_WORLD" then
-- 			C_Timer.After(3,gengxinhongtxt)
-- 		elseif event=="GROUP_ROSTER_UPDATE" then
-- 			C_Timer.After(0.6,function()
-- 				self.GetNumRaidPlayers()
-- 				self.Is_GroupLeader("event")
-- 				self.Is_RaidNumOK("event")
-- 			end)
-- 		else
-- 			if not PIG_OptionsUI.autoInvite_shikong then return end
-- 			if arg1:match("[!Pig]") then return end
-- 			if event=="CHAT_MSG_SYSTEM" then
-- 				if arg1:match(yizuduiERR) then
-- 					local wanjianameXXk=arg1:gsub(yizuduiERR,"")
-- 					SendChatMessage("[!Pig] 你已有队伍，请退组后再M", "WHISPER", nil, wanjianameXXk);
-- 				end
-- 			end
-- 			if event=="CHAT_MSG_WHISPER" then
-- 					for ih=#fujiF.lishiwanjiaxinxi,1,-1 do
-- 						if (GetServerTime()-fujiF.lishiwanjiaxinxi[ih][1])>60 then
-- 							table.remove(fujiF.lishiwanjiaxinxi, ih);
-- 						end
-- 					end
-- 					local localizedClass, englishClass= GetPlayerInfoByGUID(arg12)
-- 					if PIGA["Tardis"]["Yell"]["InvMode"]==1 then--根据自定义内容判断
-- 						for tjID=1,tiaojianNUM do
-- 							if PIGA["Tardis"]["Yell"]["InvMode1_Info"][tjID] and PIGA["Tardis"]["Yell"]["InvMode1_Info"][tjID]["Open"] then
-- 								if tjID==1 then
-- 									if arg1==PIGA["Tardis"]["Yell"]["jinzuCMD"] then
-- 										PIG_Invite_Fun(arg2)
-- 										return
-- 									end
-- 								elseif tjID==2 then
-- 									local tiaojianTXT = fujiF.topF.autoHF.keydata[tjID]["TJ"]
-- 									for tjtxt=1,#tiaojianTXT do
-- 										if arg1:match(tiaojianTXT[tjtxt]) then
-- 											PIG_Invite_Fun(arg2)
-- 											return
-- 										end
-- 									end
-- 								else
-- 									local tiaojianTXT = fujiF.topF.autoHF.keydata[tjID]["TJ"]
-- 									for tjtxt=1,#tiaojianTXT do
-- 										if arg1:match(tiaojianTXT[tjtxt]) then
-- 											local huifuTXT = fujiF.topF.autoHF.keydata[tjID]["HF"]
-- 											SendChatMessage("[!Pig] "..huifuTXT, "WHISPER", nil, arg2);
-- 											return
-- 										end
-- 									end
-- 								end
-- 							end
-- 						end
-- 					elseif PIGA["Tardis"]["Yell"]["InvMode"]==2 then--判断职业职责
-- 						if arg1==PIGA["Tardis"]["Yell"]["jinzuCMD"] then
-- 							local zhizeNum = #cl_Name_Role[englishClass]
-- 							if zhizeNum==1 then
-- 								local xulieID = RolesXulie[cl_Name_Role[englishClass][1]]
-- 								local zhizezhiyeList = Roles_List[xulieID]
-- 								for id=1,#zhizezhiyeList do
-- 									if zhizezhiyeList[id][1]==englishClass then
-- 										if fujiF.Datas_DQ.Xulie_MB[xulieID][id]<fujiF.Datas_MB.Xulie_MB[xulieID][id] then
-- 											PIG_Invite_Fun(arg2)
-- 										else
-- 											SendChatMessage("[!Pig] "..localizedClass .. "已满，可换其他职业，感谢支持", "WHISPER", nil, arg2);
-- 										end
-- 										break
-- 									end	
-- 								end
-- 							elseif zhizeNum>1 then
-- 								local xuqiuzhizeInfo = {}
-- 								local xulieIDList = cl_Name_Role[englishClass]
-- 								for xu=1,#xulieIDList do
-- 									local xulieID = RolesXulie[xulieIDList[xu]]
-- 									xuqiuzhizeInfo[xulieIDList[xu]]=0
-- 									local zhizezhiyeList = Roles_List[xulieID]
-- 									for id=1,#zhizezhiyeList do
-- 										if zhizezhiyeList[id][1]==englishClass then
-- 											if fujiF.Datas_DQ.Xulie_MB[xulieID][id]<fujiF.Datas_MB.Xulie_MB[xulieID][id] then
-- 												table.insert(xuqiuzhizeInfo,xulieIDList[xu])
-- 											end
-- 										end	
-- 									end
-- 								end
-- 								if #xuqiuzhizeInfo>0 then
-- 									local zuduizhushou_MSG=localizedClass.."尚缺:";
-- 									for img=1,#xuqiuzhizeInfo do
-- 										zuduizhushou_MSG=zuduizhushou_MSG.._G[xuqiuzhizeInfo[img]]..","
-- 									end
-- 									SendChatMessage("[!Pig] "..zuduizhushou_MSG.."请回复职责", "WHISPER", nil, arg2);
-- 									table.insert(fujiF.lishiwanjiaxinxi,{GetServerTime(),arg2,chazhiyefenlai})
-- 								end
-- 							end
-- 						else
-- 							if fujiF.Is_Oldmiyu(arg2) then
-- 								local Keyxulie = fujiF.GetKeyXulieID(arg1)
-- 								if Keyxulie then
-- 									local xulieID = Keyxulie
-- 									local zhizezhiyeList = Roles_List[xulieID]
-- 									for id=1,#zhizezhiyeList do
-- 										if zhizezhiyeList[id][1]==englishClass then
-- 											if fujiF.Datas_DQ.Xulie_MB[xulieID][id]<fujiF.Datas_MB.Xulie_MB[xulieID][id] then
-- 												PIG_Invite_Fun(arg2)
-- 											else
-- 												SendChatMessage("[!Pig] ".._G[Roles[Keyxulie]]..localizedClass .. "已满，可换其他职业或天赋，感谢支持", "WHISPER", nil, arg2);
-- 											end
-- 											break
-- 										end	
-- 									end
-- 								end
-- 							end
-- 							-----
-- 						end
-- 					end
-- 			------------
-- 			end
-- 		end
-- 	end)
end