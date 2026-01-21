local addonName, addonTable = ...;
local L=addonTable.locale
local Fun = addonTable.Fun
local Data = addonTable.Data
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter

--功能动作条
local UIname="PIG_QuickButUI"
Data.QuickButUIname=UIname
local QuickPData = {ActionButton1:GetWidth(),200,200}
if PIG_MaxTocversion() then
else
	QuickPData[2]=0
	QuickPData[3]=290
end
Data.UILayout[UIname]={"BOTTOM","BOTTOM",QuickPData[2],QuickPData[3]}
local QuickBut=PIGFrame(UIParent,nil,{QuickPData[1]+14,QuickPData[1]},UIname)
QuickBut.butWWW=QuickPData[1]
QuickBut:Hide()
QuickBut.ButList={}
QuickBut.QuickButList={}
function QuickBut:UpdateWidth()
	if not self.nr then return end
	if not New_PailieFunButList then
		local Showtiaojian,pailieName,paiNum,PailieFun,ShowHideNumFun,ShowHideEvent,PailieFunButList=unpack(addonTable.Fun.ActionFun.UIdata)
		New_PailieFunButList=PailieFunButList
	end
	wipe(self.QuickButList)
	local Children1 = {self.nr:GetChildren()};
	for i=1,#Children1 do
		Children1[i]:ClearAllPoints();
		if not Children1[i].yincang then
			table.insert(self.QuickButList,Children1[i])
		end
	end
	local geshu1 = #self.QuickButList
	if geshu1>0 then 
		local butW = self.butWWW
		for i=1,geshu1 do
			if i==1 then
			else
				--print(self.QuickButList,i,2,PIGA["QuickBut"]["Pailie"])
				New_PailieFunButList(self.QuickButList,i,2,PIGA["QuickBut"]["Pailie"])
			end
		end
		local NewWidth = butW*geshu1+15
		self.yidong:ClearAllPoints();
		self.nr:ClearAllPoints();
		self.QuickButList[1]:ClearAllPoints();
		if PIGA["QuickBut"]["Pailie"]==1 then
			self:SetSize(NewWidth,butW)
			self.yidong:SetPoint("TOPLEFT",QuickBut,"TOPLEFT",0,0);
			self.yidong:SetPoint("BOTTOMLEFT", QuickBut, "BOTTOMLEFT", 0, 0);
			self.yidong:SetWidth(13);
			self.nr:SetPoint("TOPLEFT",self.yidong,"TOPRIGHT",1,0)
			self.nr:SetPoint("BOTTOMRIGHT", QuickBut, "BOTTOMRIGHT", 0, 0)
			self.QuickButList[1]:SetPoint("LEFT",self.nr,"LEFT",0,0);
		elseif PIGA["QuickBut"]["Pailie"]==2 then
			self:SetSize(butW,NewWidth)
			self.yidong:SetPoint("TOPLEFT",QuickBut,"TOPLEFT",0,0);
			self.yidong:SetPoint("TOPRIGHT", QuickBut, "TOPRIGHT", 0, 0);
			self.yidong:SetHeight(13);
			self.nr:SetPoint("TOPLEFT",self.yidong,"BOTTOMLEFT",1,0)
			self.nr:SetPoint("BOTTOMRIGHT", QuickBut, "BOTTOMRIGHT", 0, 0)
			self.QuickButList[1]:SetPoint("TOP",self.nr,"TOP",0,0);
		end
		self:Show()
	end
end
function QuickBut:UpdatePointJustify(QkBut,ListUI,butW,anniushu)
	for k,v in pairs(ListUI) do
		v:ClearAllPoints();
	end
	if PIGA["QuickBut"]["Pailie"]==1 then
		local WowHeight=GetScreenHeight();
		local offset1 = QkBut:GetBottom();
		for i=1,anniushu do
			local fujikj = ListUI[1].ButList[i]
			fujikj.name:ClearAllPoints();
			fujikj.name:SetPoint("LEFT", fujikj, "RIGHT", 2, 0)
			fujikj.name:SetSize(butW*4,butW)
			fujikj.name:SetJustifyH("LEFT")
			fujikj.name:SetJustifyV("MIDDLE")
		end
		if offset1>(WowHeight*0.5) then
			for k,v in pairs(ListUI) do
				v:SetPoint("TOP",QkBut,"BOTTOM",0,0);
			end
			for i=1,anniushu do
				local fujikj = ListUI[1].ButList[i]
				fujikj:ClearAllPoints();
				if i==1 then
					fujikj:SetPoint("TOPRIGHT",ListUI[1],"TOPRIGHT",0,-2);
				else
					fujikj:SetPoint("TOPRIGHT",ListUI[1].ButList[i-1],"BOTTOMRIGHT",0,0);
				end
			end
		else
			for k,v in pairs(ListUI) do
				v:SetPoint("BOTTOM",QkBut,"TOP",0,0);
			end
			for i=1,anniushu do
				local fujikj = ListUI[1].ButList[i]
				fujikj:ClearAllPoints();
				if i==1 then
					fujikj:SetPoint("BOTTOMRIGHT",ListUI[1],"BOTTOMRIGHT",0,2);
				else
					fujikj:SetPoint("BOTTOMRIGHT",ListUI[1].ButList[i-1],"TOPRIGHT",0,0);
				end
			end
		end
	elseif PIGA["QuickBut"]["Pailie"]==2 then
		local WowWidth=GetScreenWidth()
		local offset1 = QkBut:GetLeft() or 500
		for i=1,anniushu do
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
			for i=1,anniushu do
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
			for i=1,anniushu do
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
function QuickBut:Add()
	QuickBut.ButList[1]()--[1]总开关
	-- [2]战场通报[3]饰品管理[4]符文管理[5]装备管理[6]插件管理
	-- [7]炉石/专业[8]职业辅助技能[9]角色信息统计
	-- [10]售卖助手丢弃[11]售卖助手开[12]售卖助手分[13]售卖助手选矿
	-- [19]AFK
	for i=2,19 do
		if self.ButList[i] then
			self.ButList[i]()
		end
	end
	-------
	-- [20]时空之门[21]时空之门喊话
	-- [30]开团助手
	-- [40]带本助手
	self:UpdateWidth()
end
--创建功能动作条按钮
local WowHeight=GetScreenHeight();
function Create.PIGQuickBut(QkButUI,Tooltip,Icon,ShowGnUI,FrameLevel,Template)
	local nr = QuickBut.nr
	local butW = QuickBut.butWWW
	local Children = {nr:GetChildren()};
	local geshu = #Children;
	local But = CreateFrame("Button", QkButUI, nr, Template);
	But:RegisterForClicks("LeftButtonUp","RightButtonUp")
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
	But:SetSize(butW-2,butW-2);
	if geshu==0 then
		But:SetPoint("LEFT",nr,"LEFT",0,0);
	else
		But:SetPoint("LEFT",Children[geshu],"RIGHT",2,0);
	end
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
	But.Height = But:CreateTexture(nil, "OVERLAY");
	But.Height:SetTexture(130724);
	But.Height:SetBlendMode("ADD");
	But.Height:SetAllPoints(But)
	But.Height:Hide()
	if ShowGnUI then
		But:HookScript("OnClick", function(self,button)
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
	QuickBut:UpdateWidth()
	return But
end
--创建功能开启选项+添加功能条按钮
function Create.PIGModCheckbutton(fuF,text,Point)
	local But = Create.PIGCheckbutton(fuF,nil,text)
	But:SetPoint(unpack(Point))
	local text1 = {string.format(L["ACTION_ADDQUICKBUT"],text[1]),string.format(L["ACTION_ADDQUICKBUTTIS"],text[1])}
	But.QKBut = Create.PIGCheckbutton(But,{"LEFT",But,"RIGHT",220,0},text1)
	return But
end
--创建侧面功能按钮
function Create.PIGModbutton(GnTooltip,GnIcon,GnUI,FrameLevel)
	local nr = PIG_OptionsUI.ListFun
	local butW = nr:GetWidth()
	local But = CreateFrame("Button", nil, nr);
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
				PIG_OptionsUI:Hide()
				_G[GnUI]:SetFrameLevel(FrameLevel)
				_G[GnUI]:Show();
			end
		end)
	end
	return But
end