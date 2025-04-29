local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
----------------------------------------
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGDiyBut = Create.PIGDiyBut
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
-----
local Data=addonTable.Data
local Fun=addonTable.Fun
local PigLayoutFun=addonTable.PigLayoutFun
local RTabFrame =PigLayoutFun.RTabFrame
local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,"顶部"..INFO.."条",90)
fujiF:Show()
fujiBut:Selected()
function fujiF:Show_OptionsUI()
	if Pig_OptionsUI:IsShown() then
		Pig_OptionsUI:Hide()
	else
		Pig_OptionsUI:Show()
		Create.Show_TabBut(PigLayoutFun.fuFrame,PigLayoutFun.fuFrameBut)
		Create.Show_TabBut_R(RTabFrame,fujiF,fujiBut)
	end
end
---====
local biaojiW = 22
---
local ConvertToParty=ConvertToParty or C_PartyInfo and C_PartyInfo.ConvertToParty
local ConvertToRaid=ConvertToRaid or C_PartyInfo and C_PartyInfo.ConvertToRaid
local LeaveParty=LeaveParty or C_PartyInfo and C_PartyInfo.LeaveParty
--add倒计时
local PigPulldata={
	["morenCD"]=10,
	["BigGold"]  = {
		texture = "Interface\\Timer\\BigTimerNumbers", 
		w=256, h=170, texW=1024, texH=512,
		numberHalfWidths = {
			--0,   1,   2,   3,   4,   5,   6,   7,   8,   9,
			35/128, 14/128, 33/128, 32/128, 36/128, 32/128, 33/128, 29/128, 31/128, 31/128,
		},
	},
}
local daojishiList = {[1]="暴雪1",[2]="暴雪2",[3]="XXX",[4]="XXXX"}
local function PIG_DoCountdownUI()
	local timer=CreateFrame("Frame", "PIG_TimerTracker", UIParent)
	timer:SetAllPoints(UIParent)
	timer:Hide();
	local texCoW = PigPulldata.BigGold.w/PigPulldata.BigGold.texW;
	local texCoH = PigPulldata.BigGold.h/PigPulldata.BigGold.texH;
	local columns = floor(PigPulldata.BigGold.texW/PigPulldata.BigGold.w);
	for i=0,9 do
		local number = timer:CreateTexture("PIG_TimerTracker_"..i);
		local number1 = timer:CreateTexture("PIG_TimerTracker_1"..i);
		number:SetTexture(PigPulldata.BigGold.texture);
		number1:SetTexture(PigPulldata.BigGold.texture);
		local hw = PigPulldata.BigGold.numberHalfWidths[i+1]*PigPulldata.BigGold.w*0.5
		local l = mod(i, columns) * texCoW;
		local r = l + texCoW;
		local t = floor(i/columns) * texCoH;
		local b = t + texCoH;
		number:SetTexCoord(l,r,t,b);
		number1:SetTexCoord(l,r,t,b);
	end
	timer.Bar = CreateFrame("StatusBar", nil, timer);
	timer.Bar:SetStatusBarTexture("interface/chatframe/chatframebackground.blp")
	timer.Bar:SetStatusBarColor(1, 0.1, 0.1, 0.8);
	timer.Bar:SetSize(300,26);
	timer.Bar:SetPoint("CENTER", 0, 280);
	timer.Bar.Border = CreateFrame("Frame", nil, timer.Bar,"BackdropTemplate")
	timer.Bar.Border:SetBackdrop({edgeFile = Create.edgeFile, edgeSize = 8,})
	timer.Bar.Border:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	timer.Bar.Border:SetAllPoints(timer.Bar)
	timer.Bar.bg = timer.Bar:CreateTexture(nil, "BACKGROUND");
	timer.Bar.bg:SetTexture("interface/characterframe/ui-party-background.blp");
	timer.Bar.bg:SetPoint("TOPLEFT",timer.Bar,"TOPLEFT",0,0);
	timer.Bar.bg:SetPoint("BOTTOMRIGHT",timer.Bar,"BOTTOMRIGHT",0,0);
	timer.Bar.bg:SetAlpha(0.4)
	timer.Bar.t = PIGFontString(timer.Bar,{"CENTER", -10, 0},"开怪倒计: ","OUTLINE",16)
	timer.Bar.t:SetTextColor(1, 1, 1, 1);
	timer.Bar.V = PIGFontString(timer.Bar,{"LEFT",timer.Bar.t,"RIGHT", 0, 0},"","OUTLINE",18)
	timer.Bar.V:SetTextColor(1, 1, 1, 1);
	local function Hide_numbut()
		PIG_TimerTracker.Bar:Hide()
		for i=0,9 do
			_G["PIG_TimerTracker_"..i]:Hide()
			_G["PIG_TimerTracker_1"..i]:Hide()
		end
	end
	local function updatenumid(shid)
		if shid<10 then
			local numnut = _G["PIG_TimerTracker_"..shid]
			numnut:SetSize(PigPulldata.BigGold.w,PigPulldata.BigGold.h);
			numnut:SetPoint("CENTER", 0, 30);
			numnut:Show()
			PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
		elseif shid<31 then
			local shouid = tostring(shid):sub(1,1)
			local endid = tostring(shid):sub(2,2)
			local numnut = _G["PIG_TimerTracker_"..shouid]
			numnut:SetSize(PigPulldata.BigGold.w*0.5,PigPulldata.BigGold.h*0.5);
			numnut:SetPoint("CENTER", -24, 280);
			numnut:Show()
			local numnut = _G["PIG_TimerTracker_1"..endid]
			numnut:SetSize(PigPulldata.BigGold.w*0.5,PigPulldata.BigGold.h*0.5);
			numnut:SetPoint("CENTER", 24, 280);
			numnut:Show()
		end
	end
	local function StartTimer_BigNumberOnUpdate(self, elapsed)
		self.time = self.endTime - GetTime();
		if self.time>60 then
			self.Bar:SetValue(self.time);
			self.Bar.V:SetText(date("%M:%S",self.time))
			self.Bar:Show()
		elseif self.time>31 then
			self.Bar:SetValue(self.time);
			self.Bar.V:SetText(date("%S",self.time))
			self.Bar:Show()
		elseif self.time>1 then
			local seconds = floor(mod(self.time, 60));
			if self.updateTime>seconds then
				Hide_numbut()
				updatenumid(seconds)
				self.updateTime = seconds
			end
		else
			self:Hide()
			PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_3);
		end
	end
	local function PIG_PULL(CDtime)
		Hide_numbut()
		local CDtime = CDtime+1
		PIG_TimerTracker:SetScript("OnUpdate", nil);
		PIG_TimerTracker.updateTime=CDtime
		PIG_TimerTracker.endTime = GetTime() + CDtime;
		PIG_TimerTracker.Bar:SetMinMaxValues(0, CDtime)
		PIG_TimerTracker:SetScript("OnUpdate", StartTimer_BigNumberOnUpdate);
		PIG_TimerTracker:Show()
	end
	local function PIG_opentiem()
		timer.opentiem=true
		C_Timer.After(0.1,function()
			timer.opentiem=nil
		end)
	end
	local function DoCountdown(CDtime, arg1)
		if not SlashCmdList.DEADLYBOSSMODSPULL and not SlashCmdList.BIGWIGSPULL then
			--没有DBM/BigWigs使用PIG倒计时程序
			PIG_opentiem()
			PIG_PULL(tonumber(CDtime))
		end
	end
	C_ChatInfo.RegisterAddonMessagePrefix("D5")
	C_ChatInfo.RegisterAddonMessagePrefix("BigWigs")
	timer:RegisterEvent("CHAT_MSG_ADDON")
	timer:SetScript("OnEvent",function(self, event, arg1, arg2, arg3, arg4)
		if self.opentiem then return end
		if arg1=="D5" then
			local fullname, SyncProtocol, prefix, CDtime, CurrentArea = strsplit("\t", arg2);
			if prefix=="PT" and CDtime then
				DoCountdown(CDtime, arg1)
			end
		elseif arg1=="BigWigs" then
			local SyncProtocol, prefix, CDtime = strsplit("^", arg2);
			if SyncProtocol=="P" and prefix=="Pull" and CDtime then
				if not SlashCmdList.BIGWIGSPULL and not SlashCmdList.DEADLYBOSSMODSPULL then
					DoCountdown(CDtime, arg1)
				end
			end
		end
	end)
	return function(CDtime)
		local CDtime = CDtime or PigPulldata.morenCD
		if IsInGroup() then
			local _, instanceType, difficulty, _, _, _, _, mapID = GetInstanceInfo()
			PIGSendAddonRaidParty("D5", Pig_OptionsUI.AllName .. "\t1\t" .. "PT" .. "\t" .. CDtime .. "\t" .. mapID)
			PIGSendAddonRaidParty("BigWigs", "P^Pull^"..CDtime)
		else
			PIG_PULL(CDtime)
		end
	end
end
local function GetDoCountdownFun()
	if C_PartyInfo and C_PartyInfo.DoCountdown then
		return C_PartyInfo.DoCountdown
	else
		return PIG_DoCountdownUI()
	end
end
local DoCountFun=GetDoCountdownFun()
local function UpdateIcon_Coord(uif,l,r,t,b)
	uif.icon:SetTexCoord(l,r,t,b)
end
local function UpdateIcon_Size(uif,w,h)
	uif.icon:SetSize(w,h)
end
local function UpdateIcon_Coord_Size(uif,l,r,t,b,w,h)
	UpdateIcon_Coord(uif,l,r,t,b)
	UpdateIcon_Size(uif,w,h)
end
local function UpdateIcon(uif,iconV)
	if type(iconV[1])=="number" then
		uif.icon:SetTexture(iconV[1]);
	else
		uif.icon:SetAtlas(iconV[1])
	end
	if iconV[2] then
		iconV[2][1](uif,iconV[2][2],iconV[2][3],iconV[2][4],iconV[2][5],iconV[2][6],iconV[2][7])
	end
end
---===========
local function ListEventFun(self)
	if IsInGroup() then
		self:Enable()
		if self.UpdateExt_ON then self:UpdateExt_ON() end
	else
		self:Disable();
		if self.UpdateExt_OFF then self:UpdateExt_OFF() end
	end
end
local function SetEvent_MenuList(butui)
	butui:RegisterEvent("PLAYER_ENTERING_WORLD")
	butui:RegisterEvent("GROUP_ROSTER_UPDATE")
	butui:HookScript("OnEvent", ListEventFun);
end
local MenuList = {
	["Index"]={"LEAVE","CONVERT_TO","RESET","COMBATLOG","ROLE","READY","COUNTDOWN"},
	["Tips"] = {
		["LEAVE"]=KEY_BUTTON1.."-|cffFFFFff"..PARTY_LEAVE.."|r\n"..KEY_BUTTON2.."-|cffFFFFff"..INSTANCE_PARTY_LEAVE.."|r",--"离开队伍/离开副本队伍/离开地下堡
		["CONVERT_TO"]=CONVERT_TO_RAID,--"切换团队/小队"
		["RESET"]=RESET..INSTANCE,--"重置副本"
		["COMBATLOG"]=COMBATLOGDISABLED,--战斗记录
		["ROLE"]=ROLE_POLL,--职责确认
		["READY"]=READY_CHECK,--就位确认
		["COUNTDOWN"]=KEY_BUTTON1.."-|cffFFFFff倒计时|r\n"..KEY_BUTTON2.."-|cffFFFFff设置倒数时长|r",
	},
	["Icon"] = {
		["LEAVE"]={"common-icon-rotateleft",{UpdateIcon_Coord,0,1,-0.02,0.92}},
		["CONVERT_TO"]={"groupfinder-waitdot",{UpdateIcon_Size,biaojiW-6,biaojiW-4}},
		["RESET"]={"common-icon-undo",{UpdateIcon_Coord,0,1,0,1}},
		["COMBATLOG"]={518450,{UpdateIcon_Coord,0.1,0.9,0.06,0.9}},
		["ROLE"]={136815},
		["READY"]={136814},
		["COUNTDOWN"]={516773,{UpdateIcon_Coord,0.13,0.87,0.14,0.86}},
	},
	["IconON"] = {
		["COMBATLOG"]={518449},
		["CONVERT_TO"]={"socialqueuing-icon-group",{UpdateIcon_Size,biaojiW,biaojiW}}
	},
	["Click"] = {
		["LEAVE"]=function(butui,button) if button=="LeftButton" then LeaveParty() else ConfirmOrLeaveLFGParty() end end,
		["CONVERT_TO"]=function() if IsInRaid(LE_PARTY_CATEGORY_HOME) then ConvertToParty() elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then ConvertToRaid() end end,
		["RESET"]=function() StaticPopup_Show("CONFIRM_RESET_INSTANCES"); end,
		["COMBATLOG"]=function(butui,button) if button=="LeftButton" then  else butui.RClick() end end,
		["ROLE"]=function() InitiateRolePoll() end,
		["READY"]=function() DoReadyCheck() end,
		["COUNTDOWN"]=function(butui,button) if button=="LeftButton" then DoCountFun(PigPulldata.morenCD) else fujiF:Show_OptionsUI() end end,
	},
	["Event"] = {
		["LEAVE"]=SetEvent_MenuList,
		["CONVERT_TO"]=function(butui)
			function butui:UpdateExt_ON()
				if IsInRaid(LE_PARTY_CATEGORY_HOME) then
					UpdateIcon(self,self.ON_1)
					self.Tooltip=CONVERT_TO_PARTY
				else
					UpdateIcon(self,self.OFF)
					self.Tooltip=CONVERT_TO_RAID
				end
			end
			SetEvent_MenuList(butui)
		end,
		["COMBATLOG"]=function(butui,barUIxx) 
			barUIxx.WCLBut=butui
			function butui:WCLFun()
				if LoggingCombat() then
					if butui.ON_1 then
						UpdateIcon(butui,butui.ON_1)
					else
						butui.icon:SetDesaturated(false)
					end
					butui.Tooltip=COMBAT_LOG..SLASH_TEXTTOSPEECH_ON.."\n"..COMBATLOGENABLED
				else
					if butui.ON_1 then
						UpdateIcon(butui,butui.OFF)
					else
						butui.icon:SetDesaturated(true)
					end
					butui.Tooltip=COMBAT_LOG..SLASH_TEXTTOSPEECH_OFF--COMBATLOGDISABLED
				end
			end
		end,
		["ROLE"]=SetEvent_MenuList,
		["READY"]=SetEvent_MenuList,
		["COUNTDOWN"]=function() PigPulldata.morenCD=PIGA["PigLayout"]["topMenu"]["daojishiTime"] end
	},
}
if tocversion>100000 then
	MenuList.Tips["LEAVE"]=MenuList.Tips["LEAVE"].."\n".."shift+"..KEY_BUTTON1.."-|cffFFFFff"..INSTANCE_WALK_IN_LEAVE.."|r"
	MenuList.Icon["CONVERT_TO"]={"groupfinder-waitdot",{UpdateIcon_Coord_Size,0,1,0,1,biaojiW-6,biaojiW-4}}
	MenuList.Icon["RESET"]={"GM-raidMarker-reset",{UpdateIcon_Coord,0.1,0.9,0.04,0.84}}
	MenuList.Icon["COMBATLOG"]={"Ping_SpotGlw_Assist_In",{UpdateIcon_Coord,0,1,0,1}}
	MenuList.Icon["ROLE"]={"GM-icon-roles",{UpdateIcon_Coord,0.17,0.82,0.16,0.78}}
	MenuList.Icon["READY"]={"GM-icon-readyCheck",{UpdateIcon_Coord,0.236,0.764,0.20,0.73}}
	MenuList.Icon["COUNTDOWN"]={"GM-icon-countdown",{UpdateIcon_Coord,0.24,0.76,0.20,0.74}}
	MenuList.IconON["CONVERT_TO"]={"GM-icon-assistActive",{UpdateIcon_Coord_Size,0.16,0.84,0.23,0.78,biaojiW,biaojiW}}
	MenuList.IconON["COMBATLOG"]=nil
end

--信息条
local function ClearScriptList(butui)
	butui:SetScript("OnClick", nil);
	butui:SetScript("OnMouseDown", nil);
	butui:SetScript("OnMouseUp", nil);
	butui:SetScript("PostClick", nil);
end
local InfoList_L = {
	["Index"]={"LOOT","LOOT_THRESHOLD","DURABILITY","YISU"},
	["Tips"] = {
		["LOOT"]=LOOT_METHOD,
		["LOOT_THRESHOLD"]=LOOT_THRESHOLD,
		["DIFFICULTY"]=INSTANCE.."难度",
		["DURABILITY"]=DURABILITY,--"耐久"
		["YISU"]="移速",
	},
	["Icon"] ={
		["LOOT"]={"txt",12},
		["LOOT_THRESHOLD"]={"txt",12},
		["DIFFICULTY"]={"txt",14,{0,1,0}},
		["DURABILITY"]={"icontxt",26,{136465,biaojiW-2,biaojiW-2}},
		["YISU"]={"icontxt",27,{132307,biaojiW-5,biaojiW-5}},
	},
	["Click"] = {},
	["Event"] ={
		["LOOT"]=function(butui) 
			Fun.Update_LootType(butui,function(txtxx) butui.Text:SetText(txtxx) end,true) 
		end,
		["LOOT_THRESHOLD"]=function(butui,fujiUIx,set)
			function butui:UpdateExt_ON()
				local shujux=Data.Quality[GetLootThreshold()]
				butui.Text:SetText(shujux.Name)
			end
			function butui:UpdateExt_OFF()
				local shujux=Data.Quality[GetLootThreshold()]
				butui.Text:SetText("\124cff555555N/A\124r")
			end
			butui:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
			SetEvent_MenuList(butui)
			if set then ListEventFun(butui) end
			butui:SetupMenu(function(dropdown, rootDescription)
				rootDescription:SetTag("PIG_MENU_LOOT_THRESHOLD");
				local function IsSelected(Threshold)
					return GetLootThreshold() == Threshold;
				end
				local function SetSelected(Threshold)
					SetLootThreshold(Threshold);
				end
				rootDescription:CreateRadio(Data.Quality[2].Name, IsSelected, SetSelected, 2);
				rootDescription:CreateRadio(Data.Quality[3].Name, IsSelected, SetSelected, 3);
				rootDescription:CreateRadio(Data.Quality[4].Name, IsSelected, SetSelected, 4);
			end);
		end,
		["DIFFICULTY"]=function(butui,fujiUIx,set)
			butui:SetupMenu(function(dropdown, rootDescription)
				rootDescription:SetTag("PIG_MENU_DIFFICULTY");
				local function IsSelected(difficultyID)
					if IsInRaid() then
						return GetRaidDifficultyID() == difficultyID;
					else
						return GetDungeonDifficultyID() == difficultyID;
					end
				end
				local function SetSelected(difficultyID)
					if IsInRaid() then
						return SetRaidDifficultyID(difficultyID)
					else
						return SetDungeonDifficultyID(difficultyID)
					end
					C_Timer.After(1,function() ListEventFun(butui) end)
				end
				if tocversion>50000 then
					rootDescription:CreateRadio(PLAYER_DIFFICULTY1, IsSelected, SetSelected, 1);
					rootDescription:CreateRadio(PLAYER_DIFFICULTY2, IsSelected, SetSelected, 2);
					rootDescription:CreateRadio(PLAYER_DIFFICULTY6, IsSelected, SetSelected, 23);
				else
					if IsInRaid() then
						rootDescription:CreateRadio(RAID_DIFFICULTY1, IsSelected, SetSelected, 3);
						rootDescription:CreateRadio(RAID_DIFFICULTY2, IsSelected, SetSelected, 4);
						rootDescription:CreateRadio(RAID_DIFFICULTY3, IsSelected, SetSelected, 5);
						rootDescription:CreateRadio(RAID_DIFFICULTY4, IsSelected, SetSelected, 6);
					else
						rootDescription:CreateRadio(PLAYER_DIFFICULTY1, IsSelected, SetSelected, 1);
						rootDescription:CreateRadio(PLAYER_DIFFICULTY2, IsSelected, SetSelected, 2);
					end
				end
			end);
			function butui:UpdateExt_ON()
				if IsInRaid() then
					local DifficultyID=GetRaidDifficultyID()
					local name= GetDifficultyInfo(DifficultyID)
					self.Text:SetText(self.namelist[DifficultyID] or name)
				else
					local name = GetDifficultyInfo(GetDungeonDifficultyID())
					self.Text:SetText(self.namelist[DifficultyID] or name)
				end
			end
			function butui:UpdateExt_OFF()
				local DifficultyID=GetDungeonDifficultyID()
				butui:Enable()
				local name = GetDifficultyInfo(DifficultyID)
				self.Text:SetText(self.namelist[DifficultyID] or name)
			end
			butui.namelist={[5]="10H",[6]="25H",[150]="N/A"}
			butui:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
			SetEvent_MenuList(butui)
			if set then ListEventFun(butui) end
		end,
		["DURABILITY"]=function(butui,fujiUIx,set)
			ClearScriptList(butui)
			butui.Text:SetPoint("LEFT",butui.icon,"RIGHT", -3, 0);
			butui:RegisterEvent("PLAYER_ENTERING_WORLD")
			butui:RegisterEvent("UPDATE_INVENTORY_DURABILITY");--耐久变化
			butui:RegisterEvent("CONFIRM_XP_LOSS");--虚弱复活
			butui:RegisterEvent("UPDATE_INVENTORY_ALERTS");--耐久图标变化或其他
			local function UpdateDurabilityV(self)
				local zhuangbeinaijiuhezhi={0,0};
				for id = 1, 19, 1 do
					local current, maximum = GetInventoryItemDurability(id);
					if current~=nil then
						zhuangbeinaijiuhezhi[1]=zhuangbeinaijiuhezhi[1]+current;
						zhuangbeinaijiuhezhi[2]=zhuangbeinaijiuhezhi[2]+maximum;
					end
				end
				if zhuangbeinaijiuhezhi[1]>0 and zhuangbeinaijiuhezhi[2]>0 then
					local naijiubaifenbi=floor(zhuangbeinaijiuhezhi[1]/zhuangbeinaijiuhezhi[2]*100);
					self.Text:SetText(naijiubaifenbi.."%");
					if naijiubaifenbi>79 then
						self.Text:SetTextColor(0,1,0, 1);
					elseif  naijiubaifenbi>59 then
						self.Text:SetTextColor(1,215/255,0, 1);
					elseif  naijiubaifenbi>39 then
						self.Text:SetTextColor(1,140/255,0, 1);
					elseif  naijiubaifenbi>19 then
						self.Text:SetTextColor(1,69/255,0, 1);
					else
						self.Text:SetTextColor(1,0,0, 1);
					end
				else
					self.Text:SetText("N/A");
				end
			end
			butui:SetScript("OnEvent", UpdateDurabilityV)
			if set then UpdateDurabilityV(butui) end
		end,
		["YISU"]=function(butui)
			ClearScriptList(butui)
			butui:SetScript("OnUpdate", function ()
				local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player");
				local yisuv = currentSpeed/7
				butui.Text:SetText(Round(yisuv*100)..'%')
				if yisuv>=1 then
					butui.Text:SetTextColor(0,1,0,1);
				elseif yisuv==0 then
					butui.Text:SetTextColor(0.5,0.5,0.5,1);
				else
					butui.Text:SetTextColor(1,0,0,1);
				end
			end)
		end,	
	},
}
if tocversion>20000 then
	table.insert(InfoList_L.Index,3,"DIFFICULTY")
end
if tocversion>100000 then
	InfoList_L.Icon["LOOT"][2]=20
end
----
local function SetShowTXT(butui,labelTxt)
	ClearScriptList(butui)
	if labelTxt then
		butui.label = PIGFontString(butui,{"LEFT",butui,"LEFT", 1, 0},labelTxt)
		butui.label:SetTextColor(0, 1, 0, 1);
		butui.Text:SetPoint("LEFT",butui.label,"RIGHT", 0, 0);
	end
end
local InfoList_R = {
	["Index"]= {"XY","FPS","PING_B","PING_W"},
	["Tips"] = {
		["FPS"]="帧数",
		["XY"]="坐标",
		["PING_B"]="延迟(本地)",
		["PING_W"]="延迟(世界)",
	},
	["Icon"] = {
		["FPS"]={"txt",32},
		["XY"]={"txt",46},
		["PING_B"]={"txt",34},
		["PING_W"]={"txt",34},
	},
	["Click"] = {},
	["Event"] ={
		["FPS"]=function(butui)
			SetShowTXT(butui,"FPS:")
			butui.fpsTime = 0;
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					self.Text:SetFormattedText("%.0f", GetFramerate());
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["XY"]=function(butui)
			SetShowTXT(butui)
			butui.fpsTime = 0;
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					local mapinfo = C_Map.GetBestMapForUnit("player"); 
					if not mapinfo then return end
					local pos = C_Map.GetPlayerMapPosition(mapinfo,"player");
					if not pos then return end
					self.Text:SetText(string.format("%.1f",pos.x*100).."  "..string.format("%.1f",pos.y*100));
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["PING_B"]=function(butui)
			SetShowTXT(butui,"本地:")
			butui.fpsTime = 0;
			butui.Tooltip=butui.Tooltip.."\n此连接传输聊天数据、拍卖行资料、公会聊天和信息、\n一些插件数据以及少量其他数据。此连接传输的数据量较小。"
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
					self.Text:SetText(latencyHome);
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
		["PING_W"]=function(butui)
			SetShowTXT(butui,"世界:")
			butui.fpsTime = 0;
			butui.Tooltip=butui.Tooltip.."\n此连接传输如战斗信息、附近角色（属性、装备、附魔等）、\nNPC、生物、施法、职业等。进入人口稠密的区域将大大\n增加此连接传输的数据量，并增加延迟。"
			butui:SetScript("OnUpdate", function (self,elapsed)
				local timeLeft = self.fpsTime - elapsed
				if timeLeft <= 0 then
					self.fpsTime = 0.25;
					local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
					self.Text:SetText(latencyWorld);
				else
					self.fpsTime = timeLeft;
				end
			end)
		end,
	},
}
-----
local GNLsitsName={"topMenu","topInfoL","topInfoR"}
local GNLsits={
	["topMenu"]={["yes"]=true,["name"]="快捷菜单",["barHH"]=biaojiW,["Data"]=MenuList,["OptionsTop"]={0,50},["PointXY"]={0,0}},
	["topInfoL"]={["yes"]=true,["name"]="信息条(左)",["barHH"]=biaojiW-4,["Data"]=InfoList_L,["OptionsTop"]={210,80},["PointXY"]={-480,0}},
	["topInfoR"]={["yes"]=true,["name"]="信息条(右)",["barHH"]=biaojiW-4,["Data"]=InfoList_R,["OptionsTop"]={350,80},["PointXY"]={300,0}},
}
local function SetBGHide(peizhiT)
	local pigui=_G["PIG"..peizhiT.."_UI"]
	if pigui then
		if PIGA["PigLayout"][peizhiT]["BGHide"] then
			pigui:SetBackdropColor(0, 0, 0, 0);
			pigui:SetBackdropBorderColor(0, 0, 0, 0);
		else
			pigui:SetBackdropColor(0.08, 0.08, 0.08, 0.4);
			pigui:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		end
	end
end
local function SetLookUI(peizhiT)
	local pigui=_G["PIG"..peizhiT.."_UI"]
	if pigui then
		pigui.yidong:SetShown(not PIGA["PigLayout"][peizhiT]["Lock"])
	end
end
local function SetScaleUI(peizhiT)
	local pigui=_G["PIG"..peizhiT.."_UI"]
	if pigui then
		pigui:SetScale(PIGA["PigLayout"][peizhiT]["Scale"])
	end
end
local function add_barUI(peizhiT,set)
	if not PIGA["PigLayout"][peizhiT]["Open"] then return end
	if _G["PIG"..peizhiT.."_UI"] then return end
	local gnData=GNLsits[peizhiT]
	local ListIndex,ListTips,ListIcon,ListFun,ListEvent,ListIconON=gnData.Data.Index,gnData.Data.Tips,gnData.Data.Icon,gnData.Data.Click,gnData.Data.Event,gnData.Data.IconON
	local listNum=#ListIndex
	local SizeHH=gnData.barHH+4
	local PointX,PointY=gnData.PointXY[1],gnData.PointXY[2]
	local barUIxx = PIGFrame(UIParent,{"TOP", UIParent, "TOP", PointX, PointY},{(biaojiW+3)*listNum+5,SizeHH},"PIG"..peizhiT.."_UI")
	barUIxx:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	barUIxx.yidong = PIGFrame(barUIxx)
	barUIxx.yidong:PIGSetBackdrop(0.4,0.9,nil,{0.3,0.3,0.3})
	barUIxx.yidong:SetSize(12, SizeHH)
	barUIxx.yidong:SetPoint("RIGHT",barUIxx,"LEFT",1,0);
	barUIxx.yidong:PIGSetMovable(barUIxx)
	barUIxx.yidong:SetScript("OnEnter", function (self)
		self:SetBackdropBorderColor(0,0.8,1,0.9);
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",12,0);
		GameTooltip:AddLine(KEY_BUTTON1.."-|cff00FFff"..TUTORIAL_TITLE2.."|r\n"..KEY_BUTTON2.."-|cff00FFff"..SETTINGS.."|r")	
		GameTooltip:Show();
	end);
	barUIxx.yidong:SetScript("OnLeave", function (self)
		self:SetBackdropBorderColor(0.3,0.3,0.3,0.9);
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end)
	barUIxx.yidong:SetScript("OnMouseUp", function (self,Button)
		fujiF:Show_OptionsUI()
	end);
	barUIxx:SetScale(PIGA["PigLayout"][peizhiT]["Scale"])
	barUIxx.yidong:SetShown(not PIGA["PigLayout"][peizhiT]["Lock"])
	SetBGHide(peizhiT)
	barUIxx.butnum=1
	barUIxx.butjiangeW=0
	for i=1,listNum do
		if not PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]] then
			local frameType="Button"
			if ListIndex[i]=="DIFFICULTY" or ListIndex[i]=="LOOT_THRESHOLD" then frameType="DropdownButton" end
			local iconData = ListIcon[ListIndex[i]]
			local listbut
			if iconData[1]=="txt" or iconData[1]=="icontxt" then
				listbut = PIGDiyBut(barUIxx,{"LEFT", barUIxx, "LEFT",barUIxx.butnum*(biaojiW+3)-biaojiW+barUIxx.butjiangeW,0},{biaojiW+iconData[2],biaojiW,iconData[1],iconData[3]},nil,nil,frameType)
				barUIxx.butjiangeW=barUIxx.butjiangeW+iconData[2]
			else
				listbut = PIGDiyBut(barUIxx,{"LEFT", barUIxx, "LEFT",barUIxx.butnum*(biaojiW+3)-biaojiW+barUIxx.butjiangeW,0},{biaojiW,biaojiW,nil,nil,iconData[1]},nil,nil,frameType)
				listbut.OFF=iconData
				if iconData[2] then
					iconData[2][1](listbut,iconData[2][2],iconData[2][3],iconData[2][4],iconData[2][5],iconData[2][6],iconData[2][7])
				end
			end
			if ListIconON and ListIconON[ListIndex[i]] then
				listbut.ON_1=ListIconON[ListIndex[i]]
			end
			barUIxx.butnum=barUIxx.butnum+1
			--提示
			listbut.Tooltip=ListTips[ListIndex[i]]
			listbut:HookScript("OnLeave", function (self)
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end)
			listbut:HookScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT",0,0);
				if frameType=="DropdownButton" then
					if self.disabledTooltipText then
						local tooltipText = RED_FONT_COLOR:WrapTextInColorCode(self.disabledTooltipText);
						GameTooltip_SetTitle(GameTooltip, tooltipText);
					else
						GameTooltip_SetTitle(GameTooltip, self.Tooltip);
					end
				else
					if self.Tooltip then
						GameTooltip:AddLine(self.Tooltip)
					end
				end
				GameTooltip:Show();
			end);
			listbut:HookScript("OnClick", function(self)
				GameTooltip:Hide() 
			end)
			if ListEvent[ListIndex[i]] then
				ListEvent[ListIndex[i]](listbut,barUIxx,set)
			end
			if ListFun[ListIndex[i]] then
				listbut:HookScript("OnClick", function(self,button)
					ListFun[ListIndex[i]](self,button)
				end)
			end
		end
	end
	barUIxx:SetWidth((biaojiW+3)*(barUIxx.butnum-1)+2+barUIxx.butjiangeW)
end
local function add_Options(peizhiT)
	local gnData=GNLsits[peizhiT]
	local ckname=gnData.name
	local ListIndex,ListTips,ListIcon,ListFun,ListEvent,ListIconON=gnData.Data.Index,gnData.Data.Tips,gnData.Data.Icon,gnData.Data.Click,gnData.Data.Event,gnData.Data.IconON
	local listNum=#ListIndex
	local checkbutOpen = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-GNLsits[peizhiT].OptionsTop[1]-20},{"启用"..ckname,"在屏幕上显示"..ckname})
	checkbutOpen:SetScript("OnClick", function (self)
		if pigui==_G["PIGmarkerW_UI"] and InCombatLockdown() then self:SetChecked(PIGA["PigLayout"][peizhiT]["Open"]) PIGTopMsg:add(ERR_NOT_IN_COMBAT) return end
		if self:GetChecked() then
			PIGA["PigLayout"][peizhiT]["Open"]=true;
			add_barUI(peizhiT,true)
			self.F:Show()
		else
			PIGA["PigLayout"][peizhiT]["Open"]=false;
			self.F:Hide()
			Pig_Options_RLtishi_UI:Show()
		end
	end)
	---
	checkbutOpen.F = PIGFrame(checkbutOpen,{"TOPLEFT",checkbutOpen,"BOTTOMLEFT",20,-20},{1,1})
	checkbutOpen.F:Hide()
	checkbutOpen.F.BGHide= PIGCheckbutton(checkbutOpen.F,{"TOPLEFT",checkbutOpen.F,"TOPLEFT",0,0},{"隐藏背景","隐藏标记按钮背景"})
	checkbutOpen.F.BGHide:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"][peizhiT]["BGHide"]=true;
		else
			PIGA["PigLayout"][peizhiT]["BGHide"]=false;
		end
		SetBGHide(peizhiT)
	end);
	checkbutOpen.F.Lock =PIGCheckbutton(checkbutOpen.F,{"LEFT",checkbutOpen.F.BGHide.Text,"RIGHT",30,0},{LOCK_FRAME,LOCK_FOCUS_FRAME})
	checkbutOpen.F.Lock:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"][peizhiT]["Lock"]=true;
		else
			PIGA["PigLayout"][peizhiT]["Lock"]=false;
		end
		SetLookUI(peizhiT)
	end);
	local xiayiinfo = {0.6,2,0.01,{["Right"]="%"}}
	checkbutOpen.F.Scale = PIGSlider(checkbutOpen.F,{"LEFT",checkbutOpen.F.Lock.Text,"RIGHT",80,0},xiayiinfo)
	checkbutOpen.F.Scale.T = PIGFontString(checkbutOpen.F.Scale,{"RIGHT",checkbutOpen.F.Scale,"LEFT",-10,0},"缩放")
	checkbutOpen.F.Scale.Slider:HookScript("OnValueChanged", function(self, arg1)
		PIGA["PigLayout"][peizhiT]["Scale"]=arg1;
		SetScaleUI(peizhiT)
	end)
	checkbutOpen.F.Lock.CZBUT = PIGButton(checkbutOpen.F.Lock,{"LEFT",checkbutOpen.F.Scale,"RIGHT",90,0},{50,22},"重置")
	checkbutOpen.F.Lock.CZBUT:SetScript("OnClick", function ()
		local pigui=_G["PIG"..peizhiT.."_UI"]
		if pigui then
			PIGA["PigLayout"][peizhiT]["Scale"]=addonTable.Default["PigLayout"][peizhiT]["Scale"]
			pigui:PIGResPoint({"TOP", UIParent, "TOP", GNLsits[peizhiT].PointXY[1],GNLsits[peizhiT].PointXY[2]})
			SetScaleUI(peizhiT)
		end
		checkbutOpen.F.Scale:PIGSetValue(PIGA["PigLayout"][peizhiT]["Scale"])
	end)
	checkbutOpen.topMenuListBut={}
	for i=1,listNum do
		local pindaol = PIGCheckbutton(checkbutOpen.F,nil,{ListTips[ListIndex[i]]},nil,nil,i)
		if peizhiT=="topMenu" then
			pindaol.Text:SetText("")
			pindaol:SetHitRectInsets(0,-20,0,0);
			pindaol.icon = pindaol:CreateTexture();
			pindaol.icon:SetSize(20,20);
			pindaol.icon:SetPoint("LEFT",pindaol,"RIGHT",0,0);
			UpdateIcon(pindaol,ListIcon[ListIndex[i]])
		end
		checkbutOpen.topMenuListBut[i]=pindaol
		if i==1 then
			pindaol:SetPoint("TOPLEFT",checkbutOpen.F,"TOPLEFT",0,-36);
		else
			if peizhiT=="topMenu" then
				pindaol:SetPoint("LEFT", checkbutOpen.topMenuListBut[i-1], "RIGHT", GNLsits[peizhiT].OptionsTop[2], 0);
			else
				pindaol:SetPoint("LEFT", checkbutOpen.topMenuListBut[i-1].Text, "RIGHT", 6, 0);
			end
		end
		pindaol:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]]=nil;
			else
				PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]]=true;
			end
			Pig_Options_RLtishi_UI:Show()
		end);
	end
	if peizhiT=="topMenu" then
		checkbutOpen.F.SecondsAudio=PIGDownMenu(checkbutOpen.F,{"TOPLEFT",checkbutOpen.F,"TOPLEFT",64,-76},{180})
		checkbutOpen.F.SecondsAudio:Disable()
		checkbutOpen.F.SecondsAudio.t = PIGFontString(checkbutOpen.F.SecondsAudio,{"RIGHT",checkbutOpen.F.SecondsAudio,"LEFT",-4,0},"读秒音效");
		function checkbutOpen.F.SecondsAudio:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,4,1 do
			    info.text, info.arg1 = SecondsAudioList[i], i
			    info.checked = i==PIGA["PigLayout"][peizhiT]["SecondsAudio"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function checkbutOpen.F.SecondsAudio:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["PigLayout"][peizhiT]["SecondsAudio"]=arg1
			PIGCloseDropDownMenus()
		end
		checkbutOpen.F.EndAudio=PIGDownMenu(checkbutOpen.F,{"LEFT",checkbutOpen.F.SecondsAudio,"RIGHT",80,0},{180})
		checkbutOpen.F.EndAudio:Disable()
		checkbutOpen.F.EndAudio.t = PIGFontString(checkbutOpen.F.EndAudio,{"RIGHT",checkbutOpen.F.EndAudio,"LEFT",-4,0},"结束音效");
		function checkbutOpen.F.EndAudio:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,4,1 do
			    info.text, info.arg1 = EndAudioList[i], i
			    info.checked = i==PIGA["PigLayout"][peizhiT]["EndAudio"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function checkbutOpen.F.EndAudio:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["PigLayout"][peizhiT]["EndAudio"]=arg1
			PIGCloseDropDownMenus()
		end
		local xiayiinfoTime = {3,180,1}
		checkbutOpen.F.daojishiTime = PIGSlider(checkbutOpen.F,{"TOPLEFT",checkbutOpen.F,"TOPLEFT",54,-110},xiayiinfoTime)
		checkbutOpen.F.daojishiTime.T = PIGFontString(checkbutOpen.F.daojishiTime,{"RIGHT",checkbutOpen.F.daojishiTime,"LEFT",0,0},"倒数(秒)")
		checkbutOpen.F.daojishiTime.Slider:HookScript("OnValueChanged", function(self, arg1)
			PigPulldata.morenCD=arg1
			PIGA["PigLayout"][peizhiT]["daojishiTime"]=arg1;
		end)
	end
	checkbutOpen.F:HookScript("OnShow", function (self)
		self.Lock:SetChecked(PIGA["PigLayout"][peizhiT]["Lock"]);
		self.BGHide:SetChecked(PIGA["PigLayout"][peizhiT]["BGHide"]);
		self.Scale:PIGSetValue(PIGA["PigLayout"][peizhiT]["Scale"])
		for i=1,listNum do
			checkbutOpen.topMenuListBut[i]:SetChecked(not PIGA["PigLayout"][peizhiT]["HideBut"][ListIndex[i]])
		end
		if self.daojishiTime then self.daojishiTime:PIGSetValue(PIGA["PigLayout"][peizhiT]["daojishiTime"]) end
	end);
	fujiF:HookScript("OnShow", function ()
		checkbutOpen:SetChecked(PIGA["PigLayout"][peizhiT]["Open"]);
		if PIGA["PigLayout"][peizhiT]["Open"] then checkbutOpen.F:Show() end
	end);
end
for i=1,#GNLsitsName do
	if GNLsits[GNLsitsName[i]].yes then
		if i>1 then PIGLine(fujiF,"TOP",-GNLsits[GNLsitsName[i]].OptionsTop[1]) end
		add_Options(GNLsitsName[i])
	end
end
function PigLayoutFun.TopBar()
	for i=1,#GNLsitsName do
		if GNLsits[GNLsitsName[i]].yes then
			add_barUI(GNLsitsName[i])
		end
	end
end