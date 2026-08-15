local addonName, PD = ...;
--
local L=PD.locale
local Fun = PD.Fun
local Data = PD.Data
--
local Create = PD.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton=Create.PIGButton
--功能动作条
Data.QKData={}
for index=1,50 do
	Data.QKData[index]=""
end
function Create.PIGaddQuickBut(index,qkdata)
	Data.QKData[index]=qkdata
end
local UIname="PIG_QuickButUI"
Data.QuickButUIname=UIname
local function addQuickBarUI()
	if _G[UIname] then return _G[UIname] end
	local ActionBarfun=PD.ActionBarfun
	local QuickPData = {ActionButton1:GetWidth(),200,200}
	if PIG_MaxTocversion() then
	else
		QuickPData[2]=0
		QuickPData[3]=290
	end
	Data.UILayout[UIname]={"BOTTOM","BOTTOM",QuickPData[2],QuickPData[3]}
	local QuickBar=PIGFrame(UIParent,nil,{QuickPData[1]+14,QuickPData[1]},UIname)
	QuickBar.butWWW=QuickPData[1]
	QuickBar:Hide()
	Create.PIG_SetPoint(UIname)
	hooksecurefunc(QuickBar, "StopMovingOrSizing", function()
		QuickBar:UpdateShowHide()
	end)
	
	QuickBar.yidong=PIGButton(QuickBar)
	Create.PIGSetMovable(QuickBar.yidong,QuickBar,nil,nil,true)
	QuickBar.yidong:HookScript("OnClick", function (self,Button)
		if Button=="LeftButton" then
		else
			PD.UpdateOptionsUI()
			ActionBarfun.RightButClick(Button)
		end
	end);
	QuickBar.yidong.tisplist={KEY_BUTTON1.."拖拽-|cff00FFff"..TUTORIAL_TITLE2.."|r\n"..KEY_BUTTON2.."-|cff00FFff"..SETTINGS.."|r"}
	QuickBar.yidong:HookScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_LEFT",0,0);
		GameTooltip:AddLine(L["LIB_TIPS"])
		for i=1,#QuickBar.yidong.tisplist do
			GameTooltip:AddLine(QuickBar.yidong.tisplist[i])
		end
		GameTooltip:Show();
	end);
	QuickBar.yidong:HookScript("OnLeave", function (self)
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end)
	QuickBar.yidong.onoff = QuickBar.yidong:CreateTexture()
	QuickBar.yidong.onoff:SetTexture("interface/common/indicator-green.blp")
	QuickBar.yidong.onoff:SetSize(16,16);
	QuickBar.yidong.onoff:SetDesaturated(true)
	QuickBar.yidong.move = QuickBar.yidong:CreateTexture()
	QuickBar.yidong.move:SetAtlas("OptionsIcon-Brown")
	QuickBar.yidong.move:SetSize(13,13);
	QuickBar.yidong.move:SetDesaturated(true)
	QuickBar.nr=PIGFrame(QuickBar)
	QuickBar.nr:PIGSetBackdrop()
	function QuickBar:UpdateShowHide()
		self:SetScale(PIGA["QuickBut"]["bili"]);
		self.yidong:SetShown(not PIGA["QuickBut"]["Lock"])
		self.Pailie=PIGA["QuickBut"]["Pailie"]
		local butcount,nextbut=0,nil
		for index,data in pairs(Data.QKData) do
			if data.butUI then
				if not data.butUI.Fenli then
					data.butUI:ClearAllPoints();
					if data.Open() and not Data.QKData[index].Hide then
						butcount=butcount+1
						if self.Pailie==1 then
							if nextbut then
								data.butUI:SetPoint("LEFT",nextbut,"RIGHT",0,0);
							else
								data.butUI:SetPoint("LEFT",self.nr,"LEFT",0,0);
							end
						else
							if nextbut then
								data.butUI:SetPoint("TOP",nextbut,"BOTTOM",0,0);
							else
								data.butUI:SetPoint("TOP",self.nr,"TOP",0,0);
							end
						end
						nextbut=data.butUI
					end
				end
			end
		end
		if not nextbut then self:Hide() return end
		self:Show()
		self.yidong:ClearAllPoints();
		self.nr:ClearAllPoints();
		local butW = self.butWWW
		self.yidong.onoff:ClearAllPoints();self.yidong.move:ClearAllPoints();
		if self.Pailie==1 then
			self:SetSize(butW*butcount+14,butW)
			self.yidong:SetPoint("TOPLEFT",QuickBar,"TOPLEFT",0,0);
			self.yidong:SetPoint("BOTTOMLEFT", QuickBar, "BOTTOMLEFT", 0, 0);
			self.yidong:SetWidth(13);
			self.yidong.onoff:SetPoint("BOTTOM",self.yidong, "CENTER",0, 0);
			self.yidong.move:SetPoint("TOP",self.yidong, "CENTER",0, 0);
			self.nr:SetPoint("TOPLEFT",self.yidong,"TOPRIGHT",1,0)
			self.nr:SetPoint("BOTTOMRIGHT", QuickBar, "BOTTOMRIGHT", 0, 0)
		elseif self.Pailie==2 then
			self:SetSize(butW,butW*butcount+14)
			self.yidong:SetPoint("TOPLEFT",QuickBar,"TOPLEFT",0,0);
			self.yidong:SetPoint("TOPRIGHT", QuickBar, "TOPRIGHT", 0, 0);
			self.yidong:SetHeight(13);
			self.yidong.onoff:SetPoint("RIGHT",self.yidong, "CENTER",0, 0);
			self.yidong.move:SetPoint("LEFT",self.yidong, "CENTER",0, 0);
			self.nr:SetPoint("TOPLEFT",self.yidong,"BOTTOMLEFT",1,0)
			self.nr:SetPoint("BOTTOMRIGHT", QuickBar, "BOTTOMRIGHT", 0, 0)
		end
	end
	function QuickBar:UpdatePointJustify(QkBut,ListUI,butW)
		for _,but in pairs(ListUI) do
			but:ClearAllPoints();
		end
		if self.Pailie==1 then
			local WowHeight=GetScreenHeight();
			local offset1 = QkBut:GetBottom();
			for i=1,#ListUI[1].ButList do
				local fujikj = ListUI[1].ButList[i]
				fujikj.name:ClearAllPoints();
				fujikj.name:SetPoint("LEFT", fujikj, "RIGHT", 2, 0)
				fujikj.name:SetSize(butW*4,butW)
				fujikj.name:SetJustifyH("LEFT")
				fujikj.name:SetJustifyV("MIDDLE")
			end
			if offset1>(WowHeight*0.5) then
				for _,but in pairs(ListUI) do
					but:SetPoint("TOP",QkBut,"BOTTOM",0,0);
				end
				for i=1,#ListUI[1].ButList do
					local fujikj = ListUI[1].ButList[i]
					fujikj:ClearAllPoints();
					if i==1 then
						fujikj:SetPoint("TOPRIGHT",ListUI[1],"TOPRIGHT",0,-2);
					else
						fujikj:SetPoint("TOPRIGHT",ListUI[1].ButList[i-1],"BOTTOMRIGHT",0,0);
					end
				end
			else
				for _,but in pairs(ListUI) do
					but:SetPoint("BOTTOM",QkBut,"TOP",0,0);
				end
				for i=1,#ListUI[1].ButList do
					local fujikj = ListUI[1].ButList[i]
					fujikj:ClearAllPoints();
					if i==1 then
						fujikj:SetPoint("BOTTOMRIGHT",ListUI[1],"BOTTOMRIGHT",0,2);
					else
						fujikj:SetPoint("BOTTOMRIGHT",ListUI[1].ButList[i-1],"TOPRIGHT",0,0);
					end
				end
			end
		elseif self.Pailie==2 then
			local WowWidth=GetScreenWidth()
			local offset1 = QkBut:GetLeft() or 500
			for i=1,#ListUI[1].ButList do
				local fujikj = ListUI[1].ButList[i]
				fujikj.name:ClearAllPoints();
				fujikj.name:SetPoint("BOTTOM", fujikj, "TOP", 0, 2)
				fujikj.name:SetSize(butW,butW*4)
				fujikj.name:SetJustifyV("BOTTOM")
			end
			if offset1>(WowWidth*0.5) then
				for k,v in pairs(ListUI) do
					v:SetPoint("RIGHT",QkBut,"LEFT",0,0);
				end
				if ListUI[2] then ListUI[2]:SetJustifyH("RIGHT") end
				for i=1,#ListUI[1].ButList do
					local fujikj = ListUI[1].ButList[i]
					fujikj:ClearAllPoints();
					if i==1 then
						fujikj:SetPoint("RIGHT",ListUI[1],"RIGHT",-2,0);
					else
						fujikj:SetPoint("RIGHT",ListUI[1].ButList[i-1],"LEFT",0,0);
					end
				end
			else
				for k,v in pairs(ListUI) do
					v:SetPoint("LEFT",QkBut,"RIGHT",0,0);
				end
				if ListUI[2] then ListUI[2]:SetJustifyH("LEFT") end
				for i=1,#ListUI[1].ButList do
					local fujikj = ListUI[1].ButList[i]
					fujikj:ClearAllPoints();
					if i==1 then
						fujikj:SetPoint("LEFT",ListUI[1],"LEFT",2,0);
					else
						fujikj:SetPoint("LEFT",ListUI[1].ButList[i-1],"RIGHT",0,0);
					end
				end
			end
		end
	end
	QuickBar:HookScript("OnEvent", function(self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
			self:UpdateShowHide()
		end
	end);
	return QuickBar
end
local WowHeight=GetScreenHeight();
local function addQuickBut(QuickBar,index,data)
	if Data.QKData[index].butUI then return end
	local PIGUseKeyDown=Fun.PIGUseKeyDown
	local UIname=data.UIname
	local Tooltip=data.Tooltip
	local Icon=data.Icon
	local ShowGnUI=data.ShowGnUI
	local FrameLevel=data.FrameLevel
	local Template=data.Template
	local fun=data.fun
	----
	local nr = QuickBar.nr
	local butW = QuickBar.butWWW
	local Children = {nr:GetChildren()};
	local geshu = #Children;
	local But = CreateFrame("Button", UIname, nr, Template);
	Data.QKData[index].butUI=But
	PIGUseKeyDown(But,true)
	if type(Icon)=="number" then
		But:SetNormalTexture(Icon)
	else
		But:SetNormalAtlas(Icon)
	end
	if Fun.IsElvUI() or Fun.IsNDui() then
		But:GetNormalTexture():SetTexCoord(0.1,0.9,0.1,0.9)
	else
		But._BACKGROUND = But:CreateTexture(nil, "BACKGROUND");
		But._BACKGROUND:SetAtlas("search-iconframe-large");
		But._BACKGROUND:SetPoint("TOPLEFT", But, "TOPLEFT", -0.8, 0.8);
		But._BACKGROUND:SetPoint("BOTTOMRIGHT", But, "BOTTOMRIGHT", 0.8, -0.8);
	end
	But:SetHighlightTexture(130718);
	But:SetSize(butW,butW);
	But:HookScript("OnEnter", function(self)
		GameTooltip:ClearLines();
		local offset1 = But:GetBottom();
		if offset1>(WowHeight*0.5) then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",-20,0);
		else
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		end
		GameTooltip:AddLine(Tooltip, nil, nil, nil, true)
		GameTooltip:Show();
	end);
	But:HookScript("OnLeave", function()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	But.Down = But:CreateTexture(nil, "OVERLAY");
	But.Down:SetTexture(130839);
	But.Down:SetAllPoints(But)
	But.Down:Hide();
	But:HookScript("OnMouseDown", function (self)
		self.Down:Show();
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	But:HookScript("OnMouseUp", function (self)
		self.Down:Hide();
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
	end);
	if fun then fun(But,QuickBar) end
	if ShowGnUI then
		But:HookScript("OnClick", function(self,button,down)
			if button=="LeftButton" then
				if _G[ShowGnUI]:IsShown() then
					_G[ShowGnUI]:Hide();
				else
					_G[ShowGnUI]:SetFrameLevel(FrameLevel)
					_G[ShowGnUI]:Show();
				end
			end
		end)
	end
end
-- [1]战场通报[2]饰品左[3]饰品左[4]装备管理[5]符文管理[6]插件管理[7]炉石/专业[8]职业辅助技能
-- [9]角色信息统计[10]售卖助手丢弃[11]售卖助手开[12]售卖助手分[13]售卖助手选矿
-- [19]AFK
-- [20]时空之门[21]时空之门喊话
-- [30]开团助手
-- [40]带本助手
-- [50]汇合石
function Fun.QuickBut_Update()
	if next(Data.QKData)==nil then return end
	local QuickBar=addQuickBarUI()
	if not PIGA["QuickBut"]["Open"] then QuickBar:Hide() return end
	if InCombatLockdown()  then 
		PIGErrorMsg("操作将在脱战后执行")
		QuickBar:RegisterEvent("PLAYER_REGEN_ENABLED");
		return 
	end
	for index,data in ipairs(Data.QKData) do
		if data~="" and data.Open() then
			addQuickBut(QuickBar,index,data)
		end
	end
	QuickBar:UpdateShowHide()
end
PD.QuickBut=Fun.QuickBut_Update
--创建功能开启选项+添加功能条按钮
function Create.PIGModCheckbutton(fuF,text,Point,Mode)
	local But = Create.PIGCheckbutton(fuF,nil,text,nil,nil,nil,nil,Mode)
	But:SetPoint(unpack(Point))
	local text1 = {L["ACTION_ADDQUICKBUT"],string.format(L["ACTION_ADDQUICKBUTTIS"],text[1])}
	But.QKBut = Create.PIGCheckbutton(But,{"LEFT",But,"RIGHT",220,0},text1)
	return But
end

--创建侧面功能按钮
local function add_modebutR(nr,GnTooltip,GnIcon,GnUI,FrameLevel)
	if nr.ButList[GnUI] then return end
	local butW = nr:GetWidth()
	local But = CreateFrame("Button", nil, nr);
	nr.ButList[GnUI]=But
	if type(GnIcon)=="number" then
		But:SetNormalTexture(GnIcon)
	else
		But:SetNormalAtlas(GnIcon)
	end
	But:GetNormalTexture():SetTexCoord(0.07,0.93,0.07,0.93);
	But:SetHighlightTexture(130718);
	But:SetSize(butW-10,butW-10);
	local Children = {nr:GetChildren()};
	local geshu = #Children;
	But:SetPoint("TOP",nr,"TOP",0,-((geshu-1)*(butW)+8));
	PIGEnter(But,GnTooltip)
	But.Down = But:CreateTexture(nil, "OVERLAY");
	But.Down:SetTexture(130839);
	But.Down:SetAllPoints(But)
	But.Down:Hide();
	But:HookScript("OnMouseDown", function (self)
		self.Down:Show();
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	But:HookScript("OnMouseUp", function (self)
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
		self.Down:Hide();
	end);
	But.Height = But:CreateTexture(nil, "OVERLAY");
	But.Height:SetTexture(130724);
	But.Height:SetBlendMode("ADD");
	But.Height:SetAllPoints(But)
	But.Height:Hide()
	if GnUI then
		But:HookScript("OnClick", function(self,button)
			if _G[GnUI]:IsShown() then
				_G[GnUI]:Hide();
			else
				OptionsUI:Hide()
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end)
	end
end
local ModbutData={}
local RModeOptionsUI
local function add_ListFun(OptionsUI)
	if not OptionsUI.RModeList then
		OptionsUI.RModeList = PIGFrame(OptionsUI)
		OptionsUI.RModeList:PIGSetBackdrop()
		OptionsUI.RModeList:SetPoint("TOPLEFT", OptionsUI.R.F, "TOPRIGHT", 4, 0)
		OptionsUI.RModeList:SetPoint("BOTTOMRIGHT", OptionsUI, "BOTTOMRIGHT", 40, 0)
		OptionsUI.RModeList.modedata={}
		OptionsUI.RModeList.ButList={}
		OptionsUI.RModeList:HookScript("OnShow", function (self)
			self:UpdateLists()
		end);
		function OptionsUI.RModeList:UpdateLists()
			if self:IsVisible() then
				for i=1,#ModbutData do
					local GnTooltip,GnIcon,GnUI,FrameLevel = unpack(ModbutData[i])
					add_modebutR(OptionsUI.RModeList,GnTooltip,GnIcon,GnUI,FrameLevel)
				end
			end
		end
	end
	OptionsUI.RModeList:UpdateLists()
end
function Create.PIGModbutton(GnTooltip,GnIcon,GnUI,FrameLevel)
	table.insert(ModbutData,{GnTooltip,GnIcon,GnUI,FrameLevel})
	if RModeOptionsUI then RModeOptionsUI.RModeList:UpdateLists() end
end
function PD.addOptions_RightBar(OptionsUI)
	RModeOptionsUI=OptionsUI
	OptionsUI:HookScript("OnShow", function (self)
		add_ListFun(self)
	end);
end