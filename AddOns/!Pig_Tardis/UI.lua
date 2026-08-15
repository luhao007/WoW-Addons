local addonName, PD = ...;
local Create, Data, Fun, L= unpack(PIG)
local PIGButton = Create.PIGButton
local PIGFontString=Create.PIGFontString
------------------------
local TardisInfo=PD.TardisInfo
function TardisInfo.ADD_UI()
	if not PIGA["Tardis"]["Open"] then return end
	if Data.TardisUI then return end
	local PIGFrame=Create.PIGFrame
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local PIGSetFont=Create.PIGSetFont
	local PIGDiyBut=Create.PIGDiyBut
	local adddata=L.ExtList[addonName]
	--
	local GnName,GnUI,GnIcon,FrameLevel,QuickBut_index = unpack(TardisInfo.uidata)
	local GetPIGID=Fun.GetPIGID
	Create.PIGModbutton(GnName,GnIcon,GnUI,FrameLevel)
	Create.PIGaddQuickBut(QuickBut_index,{
		Open=function()
			return PIGA["QuickBut"]["Open"] and PIGA["Tardis"]["Open"] and PIGA["Tardis"]["AddBut"]
		end,
		Icon=GnIcon,
		ShowGnUI=GnUI,
		FrameLevel=FrameLevel,
		Tooltip=KEY_BUTTON1.."-|cff00FFFF打开"..GnName.."|r\n"..KEY_BUTTON2.."-|cff00FFFF"..SETTINGS.."|r",
		fun=function(QkBut)
			QkBut:HookScript("OnClick", function(self,button)
				if button=="RightButton" then
					adddata.OpenSetUI(button)
				end
			end);
		end,
	})
	local Width,Height  = 880, 530;
	local InvF=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,60},{Width, Height},GnUI,true)
	Data.TardisUI=InvF
	InvF:PIGSetBackdrop()
	InvF:PIGClose()
	InvF:PIGSetMovableNoSave()
	InvF:SetFrameLevel(FrameLevel)
	InvF.hang_Height,InvF.hang_NUM=25,15
	InvF.pindao="PIG"
	InvF.Biaotou=Data.Tardis.Prefix
	InvF.xuanzhongBG = {{0.2, 0.2, 0.2, 0.2},{0.4, 0.8, 0.8, 0.2}}
	if not C_ChatInfo.IsAddonMessagePrefixRegistered(InvF.Biaotou) then
		C_ChatInfo.RegisterAddonMessagePrefix(InvF.Biaotou)
	end
	InvF.biaoti = PIGFontString(InvF,{"TOP", InvF, "TOP", 0, -3},GnName)
	--必须加入PIG频道获取
	local function gengxinbut1()
		local PIGxulieID =GetPIGID(InvF.pindao)
		if PIGxulieID>0 then
			InvF.jiaruchazhaoqi:Disable()
			InvF.jiaruchazhaoqi:SetText(L["TARDIS_LFG_LEAVE"]);
		else
			InvF.jiaruchazhaoqi:Enable()
			InvF.jiaruchazhaoqi:SetText(L["TARDIS_LFG_JOIN"]);
		end
	end
	InvF.jiaruchazhaoqi = PIGButton(InvF, {"TOPRIGHT",InvF,"TOPRIGHT",-100,-14},{110,18})
	PIGSetFont(InvF.jiaruchazhaoqi.Text,12)
	InvF.jiaruchazhaoqi:SetFrameLevel(InvF.jiaruchazhaoqi:GetFrameLevel()+6)
	InvF.jiaruchazhaoqi:Disable()
	InvF.jiaruchazhaoqi:HookScript("OnShow", function (self)
		gengxinbut1()
	end)
	InvF.jiaruchazhaoqi:SetScript("OnClick", function (self)
		JoinTemporaryChannel("PIG", nil, DEFAULT_CHAT_FRAME:GetID(), 1);
		ChatFrameMixin.RemoveMessageGroup(DEFAULT_CHAT_FRAME, "CHANNEL")
		gengxinbut1()
	end)
	local InfoMsgList=Data.Tardis.GetMsg
	function InvF:PIGSendAddonMsg(vfname,fujiF,gnindexID)
		local PIG_ID=GetPIGID(InvF.pindao)
		if PIG_ID==0 then
			fujiF.GetBut.err:SetText("请先加入"..InvF.pindao.."频道");
			return
		end
		PIGA["Tardis"][vfname]["DaojishiCD"]=GetServerTime();
		fujiF.JieshouInfoList={};
		fujiF.GetBut.yanchiNerMsg=nil
		if PIG_MaxTocversion() then
			SendChatMessage(InfoMsgList[gnindexID],"CHANNEL",nil,PIG_ID)
		else
			PIGSendAddonMessage(InvF.Biaotou,InfoMsgList[gnindexID],"CHANNEL",PIG_ID)
		end
		fujiF.GetBut:CZdaojishi()
	end
	--设置-------------------
	InvF.setbut=PIGDiyBut(InvF,{"TOPRIGHT",InvF,"TOPRIGHT",-40,-14},{20,nil,nil,nil,132054})
	InvF.setbut:HookScript("OnClick", function (self)
		adddata.OpenSetUI("RightButton")
	end);
	--内容显示
	InvF.F=PIGOptionsList_RF(InvF,44)
	local tab1jihuo
	for i=1,#TardisInfo.tablists do
		if PIGA["Tardis"][TardisInfo.tablists[i][1]]["Open"] then
			TardisInfo[TardisInfo.tablists[i][1]](tab1jihuo==nil)
			tab1jihuo=true
		end
	end
end
-----
function TardisInfo.GetInfoBut(fuF,Point,daojiCDtime,jinduS,butTXT,jindutiaoW,GetButW)
	local GetButTXT = butTXT or REFRESH
	local GetButW=GetButW or {80,21}
	local GetBut = PIGButton(fuF,{Point[1],Point[2],Point[3],Point[4],Point[5]},{GetButW[1],GetButW[2]},GetButTXT);
	GetBut.daojiCDtime=daojiCDtime;
	GetBut.Highlight = GetBut:CreateTexture();
	GetBut.Highlight:SetAtlas("reportlist-buttonselect")
	GetBut.Highlight:SetAllPoints(GetBut)
	GetBut.Highlight:Hide()
	---
	local jindutiaoW=jindutiaoW or {160,20}
	GetBut.jindutiao = CreateFrame("Frame", nil, GetBut);
	GetBut.jindutiao:SetSize(jindutiaoW[1],jindutiaoW[2]);
	GetBut.jindutiao:SetPoint("RIGHT",GetBut,"LEFT",-10,0);
	GetBut.jindutiao:Hide();
	GetBut.jindutiao.tex = GetBut.jindutiao:CreateTexture();
	GetBut.jindutiao.tex:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
	GetBut.jindutiao.tex:SetColorTexture(0.3, 0.7, 0.1, 0.9)
	GetBut.jindutiao.tex:SetSize(jindutiaoW[1],jindutiaoW[2]-1);
	GetBut.jindutiao.tex:SetPoint("LEFT",GetBut.jindutiao,"LEFT",0,0);
	GetBut.jindutiao.edg = CreateFrame("Frame", nil, GetBut.jindutiao, "BackdropTemplate");
	GetBut.jindutiao.edg:SetBackdrop({edgeFile = Create.edgeFile,edgeSize = Create.edgeSize});
	GetBut.jindutiao.edg:SetBackdropBorderColor(0, 1, 1, 0.9);
	GetBut.jindutiao.edg:SetAllPoints(GetBut.jindutiao)
	GetBut.jindutiao.edg.t = PIGFontString(GetBut.jindutiao.edg,{"CENTER",GetBut.jindutiao.edg,"CENTER",0,0},L["TARDIS_RECEIVEDATA"],"OUTLINE",12);
	GetBut.jindutishi = PIGFontString(GetBut,{"RIGHT",GetBut,"LEFT",-10,0},"","OUTLINE");
	GetBut.jindutishi:SetTextColor(0, 0.9, 0, 1);
	GetBut.err = PIGFontString(GetBut,{"BOTTOMLEFT",GetBut,"TOPLEFT",0,6},"","OUTLINE");
	GetBut.err:SetTextColor(1, 0, 0, 1);
	------
	GetBut.daojishiJG = 0
	function GetBut:CZdaojishi()
		self:Disable();
		self.err:SetText("")
		self.jindutishi:SetText("")
		self.daojishiJG = GetServerTime()
		self.jindutiao.time = 0
		self.jindutiao:Show()
	end
	function GetBut:NewMsgadd()
		self.yanchiNerMsg=true
		self:Enable();
		self.err:SetText("有新的"..self.ButName.."信息，点击刷新")
		self.Highlight:Show()
		self:SetText(GetButTXT);
	end
	function GetBut:daojishiCDFUN()
		local chazhiV = self.daojiCDtime-(GetServerTime()-self.daojishiJG)
		if chazhiV>0 and not self.yanchiNerMsg then
			self:Disable()
			self:SetText("冷却中("..chazhiV..")");
		else
			self:Enable()
			self:SetText(GetButTXT);
		end
		if self:IsVisible() then
			C_Timer.After(1,function()
				self:daojishiCDFUN()
			end)
		end
	end
	GetBut:HookScript("OnShow", function(self)
		if self.daojishiJG==0 then
			self.jindutishi:SetText("上次获取:未知");
		else
			local yiguoqu = GetServerTime()-self.daojishiJG
			if yiguoqu>3600 then
				self.jindutishi:SetText("上次获取:一小时之前");
			elseif yiguoqu>1800 then
				self.jindutishi:SetText("上次获取:半小时之前");
			elseif yiguoqu>600 then
				self.jindutishi:SetText("上次获取:10分钟之前");
			elseif yiguoqu>300 then
				self.jindutishi:SetText("上次获取:5分钟之前");
			else
				self.jindutishi:SetText("上次获取:刚刚");
			end
		end
		self:daojishiCDFUN()
	end);
	GetBut.jindutiao.time = 0
	local zengjiasu=jindutiaoW[1]/jinduS
	GetBut.jindutiao:SetScript("OnUpdate", function(self,sss)
		self.time=self.time+sss
		if self.time<jinduS then
			self.tex:SetWidth(zengjiasu*self.time)
			self:Show();
		else
			self:Hide()
			GetBut:Update_DataHang()
		end
	end);
	------
	return GetBut
end