local _, PD = ...;
local L=PD.locale
local Create=PD.Create
local Data=PD.Data
local PigLayoutFun=PD.PigLayoutFun
local HHH=PigLayoutFun.HHH
local SetEvent_MenuList=PigLayoutFun.SetEvent_MenuList
---
local LeaveParty=C_PartyInfo and C_PartyInfo.LeaveParty or LeaveParty
local gnnameui="topMenu"
--add倒计时
PigLayoutFun.morenCD=10
local DoCountFun=C_PartyInfo and C_PartyInfo.DoCountdown
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
	if iconV[1]=="txt" or iconV[1]=="icontxt" then
		uif.icon:SetAtlas(iconV[4])
	else
		if type(iconV[1])=="number" then
			uif.icon:SetTexture(iconV[1]);
		else
			uif.icon:SetAtlas(iconV[1])
		end
		if iconV[2] then
			iconV[2][1](uif,iconV[2][2],iconV[2][3],iconV[2][4],iconV[2][5],iconV[2][6],iconV[2][7])
		end
	end
end
PigLayoutFun.UpdateIcon=UpdateIcon
---
local MenuList = {
	["Index"]={"LEAVE","EnterExit","CONVERT_TO","RESET","TIME","COMBATLOG","ROLE","READY","COUNTDOWN"},
	["Tips"] = {
		["LEAVE"]=KEY_BUTTON1.."-|cffFFFFff"..PARTY_LEAVE.."|r\n"..KEY_BUTTON2.."-|cffFFFFff"..INSTANCE_PARTY_LEAVE.."|r",--"离开队伍/离开副本队伍/离开地下堡
		["EnterExit"]=TELEPORT_OUT_OF_DUNGEON.."/"..TELEPORT_TO_DUNGEON,
		["CONVERT_TO"]=CONVERT_TO_RAID,--"切换团队/小队"
		["RESET"]=RESET..INSTANCE,--"重置副本"
		["TIME"]=L["TIME"],
		["COMBATLOG"]=COMBATLOGDISABLED,--战斗记录
		["ROLE"]=ROLE_POLL,--职责确认
		["READY"]=READY_CHECK,--就位确认
		["COUNTDOWN"]=KEY_BUTTON1.."-|cffFFFFff倒计时|r\n"..KEY_BUTTON2.."-|cffFFFFff设置倒数时长|r",
	},
	["Icon"] = {
		["LEAVE"]={"common-icon-rotateleft",{UpdateIcon_Coord,0,1,-0.02,0.92}},
		["EnterExit"]={"Dungeon",{UpdateIcon_Size,HHH,HHH}},
		["CONVERT_TO"]={"groupfinder-waitdot",{UpdateIcon_Size,HHH-6,HHH-4}},
		["RESET"]={"common-icon-undo",{UpdateIcon_Coord,0,1,0,1}},
		["TIME"]={"txt",30,{0,1,0},"CrossedFlagsWithTimer"},
		["COMBATLOG"]={518450,{UpdateIcon_Coord,0.1,0.9,0.06,0.9}},
		["ROLE"]={136815},
		["READY"]={136814},
		["COUNTDOWN"]={516773,{UpdateIcon_Coord,0.13,0.87,0.14,0.86}},
	},
	["IconON"] = {
		["COMBATLOG"]={518449},
		["CONVERT_TO"]={"socialqueuing-icon-group",{UpdateIcon_Size,HHH,HHH}}
	},
	["Click"] = {
		["LEAVE"]=function(butui,button) if button=="LeftButton" then LeaveParty() else ConfirmOrLeaveLFGParty() end end,
		["EnterExit"]=function(butui,button) 
		if ( IsAllowedToUserTeleport() ) then
			if ( IsInLFDBattlefield() ) then
				local _, instanceType = IsInInstance();
				if ( instanceType ~= "arena" and instanceType ~= "pvp" ) then
					LFGTeleport(false);
				end
			elseif ( IsInLFGDungeon() ) then
				LFGTeleport(true);
			else
				LFGTeleport(false);
			end
		end end,
		["CONVERT_TO"]=function() if PIG_MaxTocversion(120000,true) and InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end if IsInRaid(LE_PARTY_CATEGORY_HOME) then PIG_ConvertToParty() elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then PIG_ConvertToRaid() end end,
		["RESET"]=function() StaticPopup_Show("CONFIRM_RESET_INSTANCES"); end,
		["TIME"]=function(butui,button) if button=="LeftButton" then butui:CZ_times() else TimeManagerClockButton_OnClick(TimeManagerClockButton) end end,
		["COMBATLOG"]=function(butui,button) if button=="LeftButton" then  else butui.RClick() end end,
		["ROLE"]=function() InitiateRolePoll() end,
		["READY"]=function() DoReadyCheck() end,
		["COUNTDOWN"]=function(butui,button)
			if button=="LeftButton" then
				DoCountFun(PigLayoutFun.morenCD)
			else
				local timelist={3,5,10,30,60,180,300,600}
				local timelistCN={"倒数3秒","倒数5秒","倒数10秒","倒数30秒","倒数1分钟","倒数3分钟","倒数5分钟","倒数10分钟"}
				local GeneratorFunction=function(dropdown, rootDescription,...)
					rootDescription:SetTag("PIG_MENU_COUNTDOWN");
					for ixx=1,#timelist do
						rootDescription:CreateButton(timelistCN[ixx], function(timex) DoCountFun(timex) end, timelist[ixx]);
					end
				end
				MenuUtil.CreateContextMenu(butui, GeneratorFunction);
			end
		end,
	},
	["Event"] = {
		["LEAVE"]=SetEvent_MenuList,
		["EnterExit"]=function(butui)
			butui:RegisterEvent("PLAYER_ENTERING_WORLD")
			butui:HookScript("OnEvent", function(self)
				self.Tooltip=self.old_Tooltip
				self:Disable();	
				C_Timer.After(3,function()			
					if ( IsAllowedToUserTeleport() ) then
						if ( IsInLFDBattlefield() ) then
							local _, instanceType = IsInInstance();
							if ( instanceType ~= "arena" and instanceType ~= "pvp" ) then
								self.Tooltip=TELEPORT_TO_DUNGEON
								self:Enable()
							end
						elseif ( IsInLFGDungeon() ) then
							self.Tooltip=TELEPORT_OUT_OF_DUNGEON
							self:Enable()
						else
							self.Tooltip=TELEPORT_TO_DUNGEON
							self:Enable()
						end
					end
				end)
			end);
		end,
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
		["TIME"]=function(butui,fujiUIx,set)
			butui.Text:SetPoint("CENTER", 0, 1.4);
			butui.MR_TextPoint[4]=1.4
			butui.Text:SetFont(ChatFontNormal:GetFont(), 16,PIGA["PigLayout"]["TopBar"]["FontMiaobian"])
			local Coord_B = {0,0.248,0.683,0.916}
			local Coord_R = {0,0.248,0.403,0.629}
			local xParent=butui:GetParent()
			butui:SetHeight(xParent:GetHeight())
			butui:SetNormalTexture("interface/helpframe/cs_helptextures.blp")
			butui:GetNormalTexture():SetTexCoord(Coord_B[1],Coord_B[2],Coord_B[3],Coord_B[4]);
			function xParent:TimeShowBGFun()
				if butui.TimerMode==2 then
					butui.TimeBGHide=false
				else
					butui.TimeBGHide=not PIGA["PigLayout"][gnnameui]["TimeBGHide"]
				end
				butui:GetNormalTexture():SetShown(butui.TimeBGHide)
			end
			xParent:TimeShowBGFun()
			---
			local _TimeBreakDown=ChatFrameUtil.TimeBreakDown
			local SetFormattedText=SetFormattedText
			local combatTime=0
			local inInstanceTime=0
			butui.InCombatLock=false
			local LoginTime=GetServerTime()
			function butui:CZ_times()
				if butui.TimerMode==1 or butui.TimerMode==3 then
					combatTime = 0
					self.Text:SetText("00:00");
				else
					self.Text:SetText(GameTime_GetLocalTime());
				end
			end
			butui:CZ_times()

			butui.UpdateUI = CreateFrame("Frame",nil,butui)
			butui.UpdateUI:Hide()
			butui.UpdateUI.oldtime=0

			local OnUpdate_ModeFun={
				[1]=function(self,elapsed)
					combatTime = combatTime + elapsed
					self.oldtime=self.oldtime+elapsed
					if self.oldtime>1 then
						self.oldtime=0
						local dd, dh, dm, ds = _TimeBreakDown(combatTime);
						butui.Text:SetFormattedText("%02d:%02d", dm, ds);
					end
				end,
				[2]=function(self,elapsed)
					self.oldtime=self.oldtime+elapsed
					if self.oldtime>1 then
						self.oldtime=0
						butui.Text:SetText(GameTime_GetLocalTime());
					end
				end,
			}
			local function CZ_CombatLock(CombatY)
				if butui.TimerMode==1 then
					if CombatY then
						butui.Text:SetTextColor(1, 1, 0, 0.8);
						butui.UpdateUI:SetScript("OnUpdate", OnUpdate_ModeFun[1])
						if butui.TimeBGHide then
							butui:GetNormalTexture():SetTexCoord(Coord_R[1],Coord_R[2],Coord_R[3],Coord_R[4]);
						end
					else
						butui.Text:SetTextColor(0, 1, 0, 0.8);
						butui.UpdateUI:SetScript("OnUpdate", nil)
						if butui.TimeBGHide then
							butui:GetNormalTexture():SetTexCoord(Coord_B[1],Coord_B[2],Coord_B[3],Coord_B[4]);
						end
					end
				else
					if CombatY then
						butui.Text:SetTextColor(1, 1, 0, 0.8);
						butui.UpdateUI:SetScript("OnUpdate", OnUpdate_ModeFun[1])
						if butui.TimeBGHide then
							butui:GetNormalTexture():SetTexCoord(Coord_R[1],Coord_R[2],Coord_R[3],Coord_R[4]);
						end
					else
						butui.Text:SetTextColor(0, 1, 0, 0.8);
						butui.UpdateUI:SetScript("OnUpdate", OnUpdate_ModeFun[2])
						if butui.TimeBGHide then
							butui:GetNormalTexture():SetTexCoord(Coord_B[1],Coord_B[2],Coord_B[3],Coord_B[4]);
						end
					end
				end	
			end
			function PigLayoutFun.UpdateTimerMode()
				butui.TimerMode=PIGA["PigLayout"][gnnameui]["TimerMode"]
				butui:CZ_times()
				butui.UpdateUI:Hide()
				xParent:TimeShowBGFun()
				if butui.TimerMode==2 then
					butui:UnregisterEvent("PLAYER_REGEN_DISABLED")
					butui:UnregisterEvent("PLAYER_REGEN_ENABLED")
					butui.Text:SetTextColor(0, 1, 0, 0.8);
					butui.UpdateUI:SetScript("OnUpdate", OnUpdate_ModeFun[2])
				elseif butui.TimerMode==1 or butui.TimerMode==3 then
					butui:RegisterEvent("PLAYER_REGEN_DISABLED")
					butui:RegisterEvent("PLAYER_REGEN_ENABLED")
					CZ_CombatLock(InCombatLockdown())
				end
				butui.UpdateUI:Show()
				function butui.TimerModeTooltip()
					if butui.TimerMode==1 or butui.TimerMode==3 then
						GameTooltip:AddLine("点击重置计时器")
					end
					if butui.inInstance then
						local d, h, m, s = _TimeBreakDown(GetServerTime()-inInstanceTime);
						GameTooltip:AddLine("本次进本时长: "..format("%02d时%02d分", h, m))
					end
					local d, h, m, s = _TimeBreakDown(GetServerTime()-LoginTime);
					GameTooltip:AddLine("本次登录时长: "..format("%02d时%02d分", h, m))
					if butui.TimerMode==1 or butui.TimerMode==3 then
						GameTooltip:AddLine("当前时间: "..GameTime_GetLocalTime());
					end
				end
			end
			--
			butui:RegisterEvent("PLAYER_ENTERING_WORLD")
			butui:HookScript("OnEvent", function (self,event,arg1,arg2)
				if event=="PLAYER_REGEN_DISABLED" then
					CZ_CombatLock(true)
				elseif event=="PLAYER_REGEN_ENABLED" then
					combatTime=0
					CZ_CombatLock(false)
				elseif event=="PLAYER_ENTERING_WORLD" then
					local inInstance, instanceType =IsInInstance()
					self.inInstance=inInstance
					PigLayoutFun.UpdateTimerMode()
					if arg1 or arg2 then
					else
						self:CZ_times()
						inInstanceTime = GetServerTime()
					end
				end	
			end)
		end,
		["COMBATLOG"]=function(butui,barUIxx) 
			Data.topMenuUIWCLBut=butui
			function butui:WCLFun(Open)
				if Open then
					if butui.ON_1 then UpdateIcon(butui,butui.ON_1) else self.icon:SetDesaturated(false) end
					butui.Tooltip=COMBAT_LOG..SLASH_TEXTTOSPEECH_ON.."\n"..COMBATLOGENABLED
				else
					if butui.ON_1 then UpdateIcon(butui,butui.OFF) else self.icon:SetDesaturated(true) end
					butui.Tooltip=COMBAT_LOG..SLASH_TEXTTOSPEECH_OFF--COMBATLOGDISABLED
				end
			end
		end,
		["ROLE"]=SetEvent_MenuList,
		["READY"]=SetEvent_MenuList,
		["COUNTDOWN"]=function(butui)
			butui:RegisterForClicks("AnyUp");
			PigLayoutFun.morenCD=PIGA["PigLayout"][gnnameui]["daojishiTime"]
			local fuBar = butui:GetParent()
			local CountdownOpen,CountdownAudio,CountdownEnd,CountdownEndAudio
			local FrameUI = CreateFrame("Frame")
			local jishiCDok={}
			local function PIGStartTimer_BigNumberOnUpdate(self, elapsed)
				if not TimerTrackerTimer1.time then
					self:SetScript("OnUpdate", nil)
					if CountdownEnd then
						PIG_PlaySoundFile(CountdownEndAudio)
					end
				elseif TimerTrackerTimer1.time<6 then
					if CountdownOpen then
						if not jishiCDok[TimerTrackerTimer1.time] then
							jishiCDok[TimerTrackerTimer1.time]=true
							PIG_PlaySoundFile(CountdownAudio,TimerTrackerTimer1.time)
						end
					end
				end
			end
			TimerTracker:HookScript("OnEvent", function (self,event)
				if event == "START_PLAYER_COUNTDOWN" then
					CountdownOpen,CountdownAudio,CountdownEnd,CountdownEndAudio=fuBar.GetAudioData()
					jishiCDok={}
					FrameUI:SetScript("OnUpdate", PIGStartTimer_BigNumberOnUpdate);
					FrameUI:Show();
				end
			end)
		end
	},
}
if PIG_MaxTocversion(100000,true) then
	MenuList.Tips["LEAVE"]=MenuList.Tips["LEAVE"].."\n".."shift+"..KEY_BUTTON1.."-|cffFFFFff"..INSTANCE_WALK_IN_LEAVE.."|r"
	MenuList.Icon["EnterExit"]={"Dungeon",{UpdateIcon_Size,HHH+6,HHH+6}}
	MenuList.Icon["CONVERT_TO"]={"groupfinder-waitdot",{UpdateIcon_Coord_Size,0,1,0,1,HHH-6,HHH-4}}
	MenuList.Icon["RESET"]={"GM-raidMarker-reset",{UpdateIcon_Coord,0.1,0.9,0.04,0.84}}
	MenuList.Icon["COMBATLOG"]={"Ping_SpotGlw_Assist_In",{UpdateIcon_Coord,0,1,0,1}}
	MenuList.Icon["ROLE"]={"GM-icon-roles",{UpdateIcon_Coord,0.17,0.82,0.16,0.78}}
	MenuList.Icon["READY"]={"GM-icon-readyCheck",{UpdateIcon_Coord,0.236,0.764,0.20,0.73}}
	MenuList.Icon["COUNTDOWN"]={"GM-icon-countdown",{UpdateIcon_Coord,0.24,0.76,0.20,0.74}}
	MenuList.IconON["CONVERT_TO"]={"GM-icon-assistActive",{UpdateIcon_Coord_Size,0.16,0.84,0.23,0.78,HHH,HHH}}
	MenuList.IconON["COMBATLOG"]=nil
end
---
local barname="工具条"
PigLayoutFun.GNLsits[gnnameui]={
	["barname"]=barname,["MenuData"]=MenuList,["OptionsTop"]={0,46},["PointXY"]={"TOP",0,0}
}
function PigLayoutFun.ToolBarFun()
	PigLayoutFun.add_barUI(gnnameui)
end
function PigLayoutFun.addOptions_ToolBar()
	PigLayoutFun.add_Options(gnnameui,barname)
end