local _, PD = ...;
local Fun=PD.Fun
local Data=PD.Data
local Create=PD.Create
local PigLayoutFun=PD.PigLayoutFun
---
local function ActionBar_HideShijiu()
	if PIGA["PigLayout"]["ActionBar"]["HideShijiu"] then
		MainMenuBarRightEndCap:Hide();--隐藏右侧鹰标 
		MainMenuBarLeftEndCap:Hide();--隐藏左侧鹰标 
	else
		MainMenuBarRightEndCap:Show();
		MainMenuBarLeftEndCap:Show();
	end
end
local function ActionBar_HideBG_Main()
	local AlphaV=PIGA["PigLayout"]["ActionBar"]["HideBarBG"] and 0 or 1
	local StanceBarLeft=StanceBarLeft or StanceBar.BackgroundArtLeft
	local StanceBarRight=StanceBarRight or StanceBar.BackgroundArtRight
	local StanceBarMiddle=StanceBarMiddle or StanceBar.BackgroundArtMiddle
	local SlidingActionBarTexture0=SlidingActionBarTexture0 or MainMenuBarTexture3
	local SlidingActionBarTexture1=SlidingActionBarTexture1 or MainMenuBarTexture3
	MainMenuBarTexture0:SetAlpha(AlphaV);
	MainMenuBarTexture1:SetAlpha(AlphaV);
	MainMenuBarTexture2:SetAlpha(AlphaV);
	MainMenuBarTexture3:SetAlpha(AlphaV);
	StanceBarLeft:SetAlpha(AlphaV);
	StanceBarRight:SetAlpha(AlphaV);
	StanceBarMiddle:SetAlpha(AlphaV);
	SlidingActionBarTexture0:SetAlpha(AlphaV);
	SlidingActionBarTexture1:SetAlpha(AlphaV);
	if PIGA["PigLayout"]["ActionBar"]["Layout"]>1 then
		MainMenuBarTexture2:SetAlpha(0);
		MainMenuBarTexture3:SetAlpha(0);
		MainMenuBarTexture0:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 1, 0);
		MainMenuBarTexture1:SetPoint("BOTTOMLEFT", MainMenuBarTexture0, "BOTTOMRIGHT", 0, 0);
		StanceBarLeft:SetAlpha(0);
		StanceBarRight:SetAlpha(0);
		StanceBarMiddle:SetAlpha(0);
		SlidingActionBarTexture0:SetAlpha(0);
		SlidingActionBarTexture1:SetAlpha(0);
	end
end
local function ActionBar_HideBG_ExpWatch()
	local AlphaV=PIGA["PigLayout"]["ActionBar"]["HideBarExpBG"] and 0 or 1
	local MainMenuXPBarTexture0=MainMenuXPBarTexture0 or MainStatusTrackingBarContainer.MainMenuBarFrameTexture1
	local MainMenuXPBarTexture1=MainMenuXPBarTexture1 or MainStatusTrackingBarContainer.MainMenuBarFrameTexture2
	local MainMenuXPBarTexture2=MainMenuXPBarTexture2 or MainStatusTrackingBarContainer.MainMenuBarFrameTexture3
	local MainMenuXPBarTexture3=MainMenuXPBarTexture3 or MainStatusTrackingBarContainer.MainMenuBarFrameTexture4
	local WatchBarTexture0=ReputationWatchBar and ReputationWatchBar.StatusBar.WatchBarTexture0 or SecondaryStatusTrackingBarContainer.StandaloneFrameTexture1
	local WatchBarTexture1=ReputationWatchBar and ReputationWatchBar.StatusBar.WatchBarTexture1 or SecondaryStatusTrackingBarContainer.StandaloneFrameTexture2
	local WatchBarTexture2=ReputationWatchBar and ReputationWatchBar.StatusBar.WatchBarTexture2 or SecondaryStatusTrackingBarContainer.StandaloneFrameTexture3
	local WatchBarTexture3=ReputationWatchBar and ReputationWatchBar.StatusBar.WatchBarTexture3 or SecondaryStatusTrackingBarContainer.StandaloneFrameTexture4
	local XPBarTexture0=ReputationWatchBar and ReputationWatchBar.StatusBar.XPBarTexture0 or MainStatusTrackingBarContainer.StandaloneFrameTexture1
	local XPBarTexture1=ReputationWatchBar and ReputationWatchBar.StatusBar.XPBarTexture1 or MainStatusTrackingBarContainer.StandaloneFrameTexture2
	local XPBarTexture2=ReputationWatchBar and ReputationWatchBar.StatusBar.XPBarTexture2 or MainStatusTrackingBarContainer.StandaloneFrameTexture3
	local XPBarTexture3=ReputationWatchBar and ReputationWatchBar.StatusBar.XPBarTexture3 or MainStatusTrackingBarContainer.StandaloneFrameTexture4
	MainMenuXPBarTexture0:SetAlpha(AlphaV);
	MainMenuXPBarTexture1:SetAlpha(AlphaV);
	MainMenuXPBarTexture2:SetAlpha(AlphaV);
	MainMenuXPBarTexture3:SetAlpha(AlphaV);
	WatchBarTexture0:SetAlpha(AlphaV);
	WatchBarTexture1:SetAlpha(AlphaV);
	WatchBarTexture2:SetAlpha(AlphaV);
	WatchBarTexture3:SetAlpha(AlphaV);
	XPBarTexture0:SetAlpha(AlphaV);
	XPBarTexture1:SetAlpha(AlphaV);
	XPBarTexture2:SetAlpha(AlphaV);
	XPBarTexture3:SetAlpha(AlphaV);
	MainMenuMaxLevelBar0:SetAlpha(AlphaV);
	MainMenuMaxLevelBar1:SetAlpha(AlphaV);
	MainMenuMaxLevelBar2:SetAlpha(AlphaV);
	MainMenuMaxLevelBar3:SetAlpha(AlphaV);
	if PIGA["PigLayout"]["ActionBar"]["Layout"]>1 then
		MainMenuXPBarTexture0:SetAlpha(0);
		MainMenuXPBarTexture3:SetAlpha(0);
		MainMenuXPBarTexture1:SetPoint("BOTTOM", MainMenuExpBar, "BOTTOM", -128, 0);
		MainMenuXPBarTexture2:SetPoint("BOTTOM", MainMenuExpBar, "BOTTOM", 128, 0);
		WatchBarTexture2:SetAlpha(0);
		WatchBarTexture3:SetAlpha(0);
		WatchBarTexture0:ClearAllPoints();
		WatchBarTexture0:SetPoint("LEFT", ReputationWatchBar.StatusBar, "LEFT", -4, 0);
	end
end
local function ActionBar_Scale(ly)
	if PIGA["PigLayout"]["ActionBar"]["Scale"] then
		MainMenuBar:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"]);
		VerticalMultiBarsContainer:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"]);
		for i=1, 12 do
			_G["MultiBarLeftButton"..i]:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"])
			--_G["MultiBarRightButton"..i]:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"])
		end
	else
		if ly then
			MainMenuBar:SetScale(1);
			VerticalMultiBarsContainer:SetScale(1);
			for i=1, 12 do
				_G["MultiBarLeftButton"..i]:SetScale(1)
				--_G["MultiBarRightButton"..i]:SetScale(1)
			end
		end
	end
end

--动作条布局
local HHH=28
local WWW=HHH*0.84
local Old_MicroBut = {}
local GameMenu = {}
local PIG_MICRO_BUTTONS = {}
local New_PIG_MICRO_BUTTONS = {}
local BlizzardIcon={}
local BlizzardIconSet={}
local PIG_MicroButNum,Old_MicroButNum=0,0
local function GetMicroButData()
	if PIG_MaxTocversion(30000) then
		Old_MicroBut = {
			"CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"GuildMicroButton",
			"WorldMapMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton",
		}
	elseif PIG_MaxTocversion(40000) then
		Old_MicroBut = {
			"CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"AchievementMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"GuildMicroButton",
			"CollectionsMicroButton",
			"PVPMicroButton",
			"LFGMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton",
		}
	elseif PIG_MaxTocversion(50000) then
		Old_MicroBut = {
			"CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"AchievementMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"GuildMicroButton",
			"EJMicroButton",
			"CollectionsMicroButton",
			"PVPMicroButton",
			"LFGMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton",
		}
	elseif PIG_MaxTocversion(60000) then
		Old_MicroBut = {
			"CharacterMicroButton",
			"SpellbookMicroButton",
			"TalentMicroButton",
			"AchievementMicroButton",
			"QuestLogMicroButton",
			"SocialsMicroButton",
			"GuildMicroButton",
			"EJMicroButton",
			"CollectionsMicroButton",
			"PVPMicroButton",
			"LFGMicroButton",
			"MainMenuMicroButton",
			"HelpMicroButton",
			"StoreMicroButton",
		}
	end
	Old_MicroButNum=#Old_MicroBut
	local Diy_MicroBut = {"MacroMicroButton","MainMenuBarBackpackButton"}
	--重建菜单列表
	for i=1,Old_MicroButNum do
		--不要添加聊天和系统地图
		if Old_MicroBut[i]~="HelpMicroButton" and Old_MicroBut[i]~="WorldMapMicroButton" then
			local pigmname = Old_MicroBut[i]
			if Old_MicroBut[i]=="SocialsMicroButton" then
				pigmname="FriendsMicroButton"
			end
			if PIG_MaxTocversion(40000) then
				if Old_MicroBut[i]=="MainMenuMicroButton" then
					table.insert(PIG_MICRO_BUTTONS,"PIG_EJMicroButton");
					GameMenu["PIG_EJMicroButton"]="EJMicroButton";
				end
			end
			table.insert(PIG_MICRO_BUTTONS,"PIG_"..pigmname)
			if PIG_MaxTocversion(20000) then
				if Old_MicroBut[i]=="GuildMicroButton" then
					table.insert(PIG_MICRO_BUTTONS,"PIG_LFGMicroButton");
					GameMenu["PIG_LFGMicroButton"]="LFGMicroButton"
				end
			end
			GameMenu["PIG_"..pigmname]=pigmname
			pigmname=nil
		end	
	end
	for i=1,#Diy_MicroBut do
		table.insert(PIG_MICRO_BUTTONS,"PIG_"..Diy_MicroBut[i])
		GameMenu["PIG_"..Diy_MicroBut[i]]=Diy_MicroBut[i]
	end
	PIG_MicroButNum=#PIG_MICRO_BUTTONS
	--默认图标
	BlizzardIcon = {	
		["PIG_SpellbookMicroButton"]={Normal="hud-microbutton-Spellbook-Up",Pushed="hud-microbutton-Spellbook-Down",Disabled="hud-microbutton-Spellbook-Disabled"},
		["PIG_TalentMicroButton"]={Normal="hud-microbutton-Talents-Up",Pushed="hud-microbutton-Talents-Down",Disabled="hud-microbutton-Talents-Disabled"},
		["PIG_AchievementMicroButton"]={Normal="hud-microbutton-Achievement-Up",Pushed="hud-microbutton-Achievement-Down",Disabled="hud-microbutton-Achievement-Disabled"},
		["PIG_QuestLogMicroButton"]={Normal="hud-microbutton-Quest-Up",Pushed="hud-microbutton-Quest-Down",Disabled="hud-microbutton-Quest-Disabled"},
		["PIG_GuildMicroButton"]={Normal="hud-microbutton-Socials-Up",Pushed="hud-microbutton-Socials-Down",Disabled="hud-microbutton-Socials-Disabled"},
		["PIG_CollectionsMicroButton"]={Normal="hud-microbutton-Mounts-Up",Pushed="hud-microbutton-Mounts-Down",Disabled="hud-microbutton-Mounts-Disabled"},	
		["PIG_LFGMicroButton"]={Normal="hud-microbutton-LFG-Up",Pushed="hud-microbutton-LFG-Down",Disabled="hud-microbutton-LFG-Disabled"},
		["PIG_MainMenuMicroButton"]={Normal="hud-microbutton-MainMenu-Up",Pushed="hud-microbutton-MainMenu-Down",Disabled="hud-microbutton-MainMenu-Disabled"},
		["PIG_EJMicroButton"]={Normal="hud-microbutton-EJ-Up",Pushed="hud-microbutton-EJ-Down",Disabled="hud-microbutton-EJ-Disabled"},
		["PIG_StoreMicroButton"]={Normal="hud-microbutton-BStore-Up",Pushed="hud-microbutton-BStore-Down",Disabled="hud-microbutton-BStore-Disabled"},
		["PIG_CharacterMicroButton"]={Normal="hud-microbutton-Character-Up",Pushed="hud-microbutton-Character-Down",Disabled="",icon={"MicroButtonPortrait",{WWW*0.17,-HHH*0.14,-WWW*0.162,HHH*0.14},nil,"groupfinder-waitdot"}},
		["PIG_PVPMicroButton"]={Normal="hud-microbutton-Character-Up",Pushed="hud-microbutton-Character-Down",Disabled="",icon={"PVPMicroButtonTexture",{WWW*0.22,-HHH*0.18,-WWW*0.20,HHH*0.17},"communities-create-button-wow-alliance"}},
		["PIG_MacroMicroButton"]={Normal="hud-microbutton-Character-Up",Pushed="hud-microbutton-Character-Down",Disabled="",icon={"diy",{WWW*0.22,-HHH*0.19,-WWW*0.19,HHH*0.18},136377}},
		["PIG_MainMenuBarBackpackButton"]={Normal="hud-microbutton-Character-Up",Pushed="hud-microbutton-Character-Down",Disabled="",icon={"MainMenuBarBackpackButtonIconTexture",{WWW*0.12,-HHH*0.07,-WWW*0.11,HHH*0.09}}},
	}
	local factionGroup = UnitFactionGroup("player")
	if factionGroup=="Horde" then
		BlizzardIcon.PIG_PVPMicroButton.icon[2],BlizzardIcon.PIG_PVPMicroButton.icon[3]={WWW*0.18,-HHH*0.23,-WWW*0.19,HHH*0.17},"communities-create-button-wow-horde"
	end
	BlizzardIconSet = {
		["PIG_FriendsMicroButton"]="socialqueuing-icon-group",
	}
end
----------
local function SetIconTextureXY(fujik,tex1,pointXY)
	if fujik and tex1 and pointXY then
		tex1:ClearAllPoints();
		tex1:SetPoint("TOPLEFT",fujik,"TOPLEFT",pointXY[1],pointXY[2]);
		tex1:SetPoint("BOTTOMRIGHT",fujik,"BOTTOMRIGHT",pointXY[3],pointXY[4]);
	end
end
local function SetEnableDisable(bizbut)
	local playerLevel = UnitLevel("player");
	local minLevel=bizbut.minLevel or 10
	if PIG_MaxTocversion(50000) and playerLevel < minLevel or C_SpecializationInfo and C_SpecializationInfo.CanPlayerUseTalentSpecUI and not C_SpecializationInfo.CanPlayerUseTalentSpecUI() then
		bizbut:Disable();
		if bizbut and bizbut.icon then
			bizbut.icon:SetDesaturated(true)
		end
	else
		bizbut:Enable();
		if bizbut and bizbut.icon then
			bizbut.icon:SetDesaturated(false)
		end
	end
end
local function Update_TalentMicroButtonAlert()
	if not TalentMicroButtonAlert then return end
	TalentMicroButtonAlert:ClearAllPoints()
	if PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="TOP" then
		TalentMicroButtonAlert:SetPoint('TOP', TalentMicroButton, 'BOTTOM', 0, 0)
	else
		TalentMicroButtonAlert:SetPoint('BOTTOM', TalentMicroButton, 'TOP', 0, 10)
	end
end
--移动小地图时间
local TimeManagerWWW = 50
local function Update_TimeManager()
	if PIGA["PigLayout"]["MicroMenu"]["MoveTime"] then
		TimeManagerClockButton:SetParent(UIParent)
		TimeManagerClockButton:SetFrameStrata("MEDIUM")
		local regions = {TimeManagerClockButton:GetRegions()}
		for k,v in pairs(regions) do
			if not v:GetName() then
				v:Hide()
			end
		end
		TimeManagerClockButton:SetSize(TimeManagerWWW,22);
		Create.PIGSetFont(TimeManagerClockTicker,16,PIGA["PigLayout"]["TopBar"]["FontMiaobian"])
		TimeManagerClockTicker:ClearAllPoints()
		TimeManagerClockTicker:SetAllPoints(TimeManagerClockButton)
	end
end
local function GetButListMiddleV(New_num)
	local pianyiV=-WWW*0.5
	local TimepianyiV=0
	if PIGA["PigLayout"]["MicroMenu"]["MoveTime"] then
		New_num=New_num-1
		TimepianyiV=(TimeManagerWWW+PIGA["PigLayout"]["MicroMenu"]["Interval"])*0.5
	end
	local banzhi = New_num*0.5
	pianyiV = pianyiV+TimepianyiV+banzhi*(WWW+PIGA["PigLayout"]["MicroMenu"]["Interval"])
	return -pianyiV
end
local function UpdateMicroBut_UIScaleXY()
	if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
	local New_num =#New_PIG_MICRO_BUTTONS
	local mubiaobut,mubiaoPointL,mubiaoPointR=1,"LEFT","RIGHT"
	local pianyiV =0
	for i=1,New_num do
		_G[New_PIG_MICRO_BUTTONS[i]]:ClearAllPoints();
	end
	for i=1,New_num do
		local MicroBut = _G[New_PIG_MICRO_BUTTONS[i]]
		if PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="TOP" then
			mubiaobut=1
			mubiaoPointL,mubiaoPointR="LEFT","RIGHT"
			pianyiV =GetButListMiddleV(New_num)
		elseif PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="BOTTOM" then
			mubiaobut=1
			mubiaoPointL,mubiaoPointR="LEFT","RIGHT"
			pianyiV =GetButListMiddleV(New_num)
		elseif PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="TOPLEFT" then
			mubiaobut=1
			mubiaoPointL,mubiaoPointR="LEFT","RIGHT"
		elseif PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="TOPRIGHT" then
			mubiaobut=New_num
			mubiaoPointL,mubiaoPointR="RIGHT","LEFT"
		elseif PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="BOTTOMLEFT" then
			mubiaobut=1
			mubiaoPointL,mubiaoPointR="LEFT","RIGHT"
		elseif PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=="BOTTOMRIGHT" then
			mubiaobut=New_num
			mubiaoPointL,mubiaoPointR="RIGHT","LEFT"
		end
		if i==mubiaobut then
			MicroBut:SetPoint(PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"],UIParent,PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"],PIGA["PigLayout"]["MicroMenu"]["AnchorPointX"]+pianyiV,PIGA["PigLayout"]["MicroMenu"]["AnchorPointY"]);
		else
			if mubiaoPointL=="RIGHT" then
				MicroBut:SetPoint(mubiaoPointL,_G[New_PIG_MICRO_BUTTONS[i+1]],mubiaoPointR,PIGA["PigLayout"]["MicroMenu"]["Interval"],0);
			else
				MicroBut:SetPoint(mubiaoPointL,_G[New_PIG_MICRO_BUTTONS[i-1]],mubiaoPointR,PIGA["PigLayout"]["MicroMenu"]["Interval"],0);
			end
		end
		MicroBut:SetScale(PIGA["PigLayout"]["MicroMenu"]["Scale"])
	end
	Update_TalentMicroButtonAlert()
end

local UpdateMicroButFun = {
	["PIG_TalentMicroButton"]=function()
		local bizbut = _G[GameMenu["PIG_TalentMicroButton"]]
		bizbut:Show()
		SetEnableDisable(bizbut)
	end,
	["PIG_AchievementMicroButton"]=function(but)
		if PIGA["PigLayout"]["MicroMenu"]["HideBut"]["PIG_AchievementMicroButton"] then
			local bizbut = _G[GameMenu["PIG_AchievementMicroButton"]]
			bizbut:Hide()
		end
	end,
	["PIG_GuildMicroButton"]=function(but)
		local bizbut = _G[GameMenu["PIG_GuildMicroButton"]]
		bizbut:Show()
		bizbut:SetHighlightTexture("hud-microbutton-highlight")
		if IsInGuild() then
			bizbut:Enable();
			if but and but.icon then
				but.icon:SetDesaturated(false)
			end
			if ( CommunitiesFrame and CommunitiesFrame:IsShown() ) or ( GuildFrame and GuildFrame:IsShown() and FriendsFrame:IsShown()) then
				bizbut:SetButtonState("PUSHED", true);
			else
				bizbut:SetButtonState("NORMAL");
			end
		else
			bizbut:Disable();
			if but and but.icon then
				but.icon:SetDesaturated(true)
			end
		end
	end,
	["PIG_MainMenuMicroButton"]=function()
		if GameMenuFrame and GameMenuFrame:IsShown() then
			MainMenuMicroButton:SetButtonState("PUSHED", true);
			MainMenuMicroButton_SetPushed();
		else
			MainMenuMicroButton:SetButtonState("NORMAL");
			MainMenuMicroButton_SetNormal();
		end
		MainMenuMicroButton:ClearAllPoints()
	    MainMenuMicroButton:SetPoint('TOPLEFT', PIG_MainMenuMicroButton, 'TOPLEFT', 0, 0)
	    MainMenuMicroButton:SetPoint('BOTTOMRIGHT', PIG_MainMenuMicroButton, 'BOTTOMRIGHT', 0, 0)
	    MainMenuMicroButton:SetHitRectInsets(0,0,0,0);
	end,
	["PIG_PVPMicroButton"]=function(self)
		local bizbut = _G[GameMenu["PIG_PVPMicroButton"]]
		SetEnableDisable(bizbut)
	end,
	["PIG_LFGMicroButton"]=function(self)
		local bizbut = _G[GameMenu["PIG_LFGMicroButton"]]
		SetEnableDisable(bizbut)
	end,
}
local MicroButLoadFun = {
	["PIG_FriendsMicroButton"]=function()
		local bizbut = _G[GameMenu["PIG_FriendsMicroButton"]]
		bizbut.TextureXY={-WWW*0.02,-HHH*0.05,WWW*0.1,HHH*0.05}
		SetIconTextureXY(bizbut,bizbut:GetNormalTexture(),bizbut.TextureXY)
		SetIconTextureXY(bizbut,bizbut:GetPushedTexture(),bizbut.TextureXY)
		SetIconTextureXY(bizbut,bizbut:GetDisabledTexture(),bizbut.TextureXY)
	end,
	["PIG_GuildMicroButton"]=function()
		local bizbut = _G[GameMenu["PIG_GuildMicroButton"]]
		bizbut:HookScript("OnEnter", function(self)
			if not IsInGuild() then
				if ( CommunitiesFrame_IsEnabled() ) then
					bizbut.tooltipText = MicroButtonTooltipText(GUILD_AND_COMMUNITIES, "TOGGLEGUILDTAB");
				elseif ( IsInGuild() ) then
					bizbut.tooltipText = MicroButtonTooltipText(GUILD, "TOGGLEGUILDTAB");
				else
					bizbut.tooltipText = MicroButtonTooltipText(LOOKINGFORGUILD, "TOGGLEGUILDTAB");
				end
				bizbut.newbieText = NEWBIE_TOOLTIP_GUILDTAB;
				GameTooltip_SetDefaultAnchor(GameTooltip, self);
				GameTooltip_AddNewbieTip(self, self.tooltipText, 1.0, 1.0, 1.0, self.newbieText);
				GameTooltip:AddLine(ERR_GUILD_PLAYER_NOT_IN_GUILD, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
				GameTooltip:Show();
			end
		end)
	end,
	["PIG_LFGMicroButton"]=function()
		if C_LFGList.GetPremadeGroupFinderStyle()==1 then
		else
			EventUtil.ContinueOnAddOnLoaded("Blizzard_GroupFinder_VanillaStyle", function()
				local bizbut = _G[GameMenu["PIG_LFGMicroButton"]]
				bizbut:RegisterForClicks("LeftButtonUp","RightButtonUp")
				bizbut:HookScript("OnClick", function (self,button)
					if self.LeftClickFun and button=="LeftButton" then
						self.LeftClickFun(self,button,true)
					else
						ToggleLFGParentFrame();
					end
				end);
				bizbut.tooltipText = MicroButtonTooltipText(LFG_BUTTON, "TOGGLEGROUPFINDER");
				bizbut.newbieText = NEWBIE_TOOLTIP_LFGPARENT;
				bizbut:HookScript("OnEnter", function(self)
					GameTooltip_AddNewbieTip(self, self.tooltipText, 1.0, 1.0, 1.0, self.newbieText);
				end)
			end)
		end
	end,
	["PIG_EJMicroButton"]=function()
		local bizbut = _G[GameMenu["PIG_EJMicroButton"]]
		bizbut.openui= _G["AtlasLoot_GUI-Frame"]
		bizbut.tooltipText = MicroButtonTooltipText(VIEW..ITEMS..BATTLE_PET_SOURCE_1,"");
		bizbut.newbieText = VIEW..ITEMS.."("..TRANSMOG_SOURCE_1.."/"..TRANSMOG_SOURCE_2..CONTRIBUTION_REWARD_TOOLTIP_TITLE.."/"..TRANSMOG_SOURCE_3.."/"..TRANSMOG_SOURCE_4.."/"..TRANSMOG_SOURCE_5..CONTRIBUTION_REWARD_TOOLTIP_TITLE.."/"..TRANSMOG_SOURCE_6..CREATE_PROFESSION..")";
		bizbut:HookScript("OnEnter", function(self)
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
			GameTooltip_AddNewbieTip(self, self.tooltipText, 1.0, 1.0, 1.0, self.newbieText);
			if not self.openui then
				GameTooltip:AddLine("没有安装AtlasLoot", RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
				GameTooltip:Show();
			end
		end)
		bizbut:HookScript("OnClick", function (self,button)
			if self.openui then
				local uidaq = QF_AtlasLootUI or self.openui
				if uidaq:IsShown() then
					uidaq:Hide()
				else
					uidaq:Show()
				end
			else
				PIGErrorMsg("没有安装AtlasLoot", "R")
			end
		end);
	end,
	["PIG_MacroMicroButton"]=function()
		local bizbut = _G[GameMenu["PIG_MacroMicroButton"]]
		bizbut.tooltipText = MicroButtonTooltipText(MACROS,"");
		bizbut.newbieText = MACRO_HELP_TEXT_LINE3;
		bizbut:HookScript("OnEnter", function(self)
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
			GameTooltip_AddNewbieTip(self, self.tooltipText, 1.0, 1.0, 1.0, self.newbieText);
		end)
		bizbut:SetAttribute("type", "macro")
		bizbut:SetAttribute("macrotext", "/macro")
	end,
}
local function Update_MicroMenu()
	if PIGA["PigLayout"]["ActionBar"]["Layout"]<2 then return end
	GetMicroButData()

	--处理系统原生
	if not PIGA["PigLayout"]["MicroMenu"]["HideBut"]["PIG_FriendsMicroButton"] then
		FriendsMicroButtonCount:SetTextColor(0, 1, 0, 1);
		FriendsMicroButtonCount:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
		FriendsMicroButtonCount:ClearAllPoints();
		FriendsMicroButtonCount:SetPoint("BOTTOMRIGHT",FriendsMicroButton,"BOTTOMRIGHT",1,1);
	end
	if not PIGA["PigLayout"]["MicroMenu"]["HideBut"]["PIG_MainMenuBarBackpackButton"] then
		MainMenuBarBackpackButton.PigLayoutOpen=true
		local regions = {MainMenuBarBackpackButton:GetRegions()}
		for _,v1 in pairs(regions) do
			if v1~=MainMenuBarBackpackButtonIconTexture and v1~=MainMenuBarBackpackButtonCount then
				v1:ClearAllPoints()
			end
		end
		MainMenuBarBackpackButtonIconTexture:SetDrawLayer("OVERLAY", 5)
		MainMenuBarBackpackButtonCount:SetDrawLayer("OVERLAY", 7)
		MainMenuBarBackpackButtonCount:ClearAllPoints();
		MainMenuBarBackpackButtonCount:SetPoint("BOTTOMRIGHT",MainMenuBarBackpackButton,"BOTTOMRIGHT",1,1);
		MainMenuBarBackpackButton.Count:SetText(MainMenuBarBackpackButton.freeSlots);
		MainMenuBarBackpackButton.Count:SetFont(ChatFontNormal:GetFont(), 12,"OUTLINE")
		hooksecurefunc("MainMenuBarBackpackButton_UpdateFreeSlots", function()
			MainMenuBarBackpackButton.Count:SetText(MainMenuBarBackpackButton.freeSlots);
		end)
	else
		MainMenuBarBackpackButton:ClearAllPoints();
	end
	if MinimapToggleButton then
		MinimapToggleButton:SetSize(28,28);
		MinimapToggleButton:SetPoint("CENTER",MinimapCluster,"TOPRIGHT",-16,-16);
		MinimapToggleButton:SetNormalTexture("orderhall-commandbar-mapbutton-up")
		MinimapToggleButton:SetPushedTexture("orderhall-commandbar-mapbutton-down")
		MinimapToggleButton:SetScript("OnClick", function(self)
			ToggleWorldMap();
		end)
		MainMenuMicroButton:SetScript("OnUpdate",nil)
	end
	--MainMenuBarPerformanceBar延迟颜色
	local HideList = {SocialsMicroButton,WorldMapMicroButton,HelpMicroButton,CharacterBag0Slot,CharacterBag1Slot,
		CharacterBag2Slot,CharacterBag3Slot,KeyRingButton,MainMenuBarPerformanceBar,MainMenuBarPerformanceBarFrameButton}
	for i=1,#HideList do
		if HideList[i] then
			HideList[i]:ClearAllPoints();
			HideList[i]:Hide()
		end
	end
	if KeyRingButton then
		hooksecurefunc("MainMenuBar_UpdateKeyRing", function()
			KeyRingButton:Hide()
		end)
	end
	for i=1,Old_MicroButNum do
		_G[Old_MicroBut[i]]:ClearAllPoints();
		if _G[Old_MicroBut[i].."Flash"] then
			_G[Old_MicroBut[i].."Flash"]:ClearAllPoints();
			_G[Old_MicroBut[i].."Flash"]:SetPoint("TOPLEFT",_G[Old_MicroBut[i]],"TOPLEFT",-WWW*0.11,HHH*0.12);
			_G[Old_MicroBut[i].."Flash"]:SetPoint("BOTTOMRIGHT",_G[Old_MicroBut[i]],"BOTTOMRIGHT",WWW*1.23,-HHH*0.84);
		end
	end
	local function CZPoints(fujik,uix)
		if not fujik or not uix then return end
		uix:SetParent(fujik)
	    uix:ClearAllPoints()
	    uix:SetPoint('TOPLEFT', fujik, 'TOPLEFT', 0, 0)
	    uix:SetPoint('BOTTOMRIGHT', fujik, 'BOTTOMRIGHT', 0, 0)
	    uix:SetHitRectInsets(0,0,0,0);
	end
	hooksecurefunc("MoveMicroButtons", function()
		CZPoints(PIG_CharacterMicroButton,CharacterMicroButton)
		CZPoints(PIG_PVPMicroButton,PVPMicroButton)
	end)

	EventUtil.ContinueOnAddOnLoaded("Blizzard_TimeManager", function()
		Update_TimeManager()
	end)
	hooksecurefunc("UpdateMicroButtons", function()
		for i=1,PIG_MicroButNum do
			if UpdateMicroButFun[PIG_MICRO_BUTTONS[i]] then
				UpdateMicroButFun[PIG_MICRO_BUTTONS[i]]()
		    end
		end
	end)
	for i=1,PIG_MicroButNum do
		if not PIGA["PigLayout"]["MicroMenu"]["HideBut"][PIG_MICRO_BUTTONS[i]] then
			table.insert(New_PIG_MICRO_BUTTONS,PIG_MICRO_BUTTONS[i])
		end
	end
	if PIGA["PigLayout"]["MicroMenu"]["MoveTime"] then
		table.insert(New_PIG_MICRO_BUTTONS,(#New_PIG_MICRO_BUTTONS*0.5)+1,"TimeManagerClockButton")
	end
	for i=1,#New_PIG_MICRO_BUTTONS do
		local MicroBut=CreateFrame("Frame", New_PIG_MICRO_BUTTONS[i], UIParent);
		MicroBut:SetSize(WWW,HHH);
		local BlizzardName = GameMenu[New_PIG_MICRO_BUTTONS[i]]
		local BlizzardBut = _G[BlizzardName]
		if BlizzardBut then
			BlizzardBut:SetParent(MicroBut)
			BlizzardBut:Show()
		else
			local MicroButType = {"Button",nil}--"SecureHandlerClickTemplate"
			if New_PIG_MICRO_BUTTONS[i]=="PIG_MacroMicroButton" then
				MicroButType[2]="SecureActionButtonTemplate"
			end
			BlizzardBut = CreateFrame(MicroButType[1],BlizzardName,MicroBut, MicroButType[2]);
			BlizzardBut:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
		end
		BlizzardBut:ClearAllPoints()
	    BlizzardBut:SetPoint('TOPLEFT', MicroBut, 'TOPLEFT', 0, 0)
	    BlizzardBut:SetPoint('BOTTOMRIGHT', MicroBut, 'BOTTOMRIGHT', 0, 0)
	    BlizzardBut:SetHitRectInsets(0,0,0,0);
		if MicroButLoadFun[New_PIG_MICRO_BUTTONS[i]] then
			MicroButLoadFun[New_PIG_MICRO_BUTTONS[i]]()
	    end
	    if UpdateMicroButFun[New_PIG_MICRO_BUTTONS[i]] then
			UpdateMicroButFun[New_PIG_MICRO_BUTTONS[i]]()
	    end
		--icon
		local diyicon = Data.DiyIcon and Data.DiyIcon[New_PIG_MICRO_BUTTONS[i]]
		if diyicon then
			local regions = {BlizzardBut:GetRegions()}
		    for _,v1 in pairs(regions) do
		    	if v1~=FriendsMicroButtonCount and v1~=MainMenuBarBackpackButtonIconTexture and v1~=MainMenuBarBackpackButtonCount then
		    		v1:ClearAllPoints()
		    	end
		    end
		    BlizzardBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
		    if not BlizzardBut.icon then
	    		BlizzardBut.icon = BlizzardBut:CreateTexture()
			end
			local Atlasinfo = C_Texture.GetAtlasInfo(diyicon.icon)
			if Atlasinfo then
				BlizzardBut.icon:SetAtlas(diyicon.icon)
			else
				if not PIGSetAtlas(BlizzardBut.icon,diyicon.icon) then
					BlizzardBut.icon:SetTexture(diyicon.icon)
				end
			end
			if diyicon.point then
				SetIconTextureXY(BlizzardBut,BlizzardBut.icon,{diyicon.point[1],diyicon.point[2],diyicon.point[3],diyicon.point[4]})
				BlizzardBut.XY={diyicon.point[1],diyicon.point[2],diyicon.point[3],diyicon.point[4]}
			else
				SetIconTextureXY(BlizzardBut,BlizzardBut.icon,{0,0,0,0})
				BlizzardBut.XY={0,0,0,0}
			end
		else
			BlizzardBut:SetHighlightTexture("hud-microbutton-highlight")
			local blizzardicon = BlizzardIcon[New_PIG_MICRO_BUTTONS[i]]
			if blizzardicon then
				if blizzardicon.Normal then BlizzardBut:SetNormalAtlas(blizzardicon.Normal) end
				if blizzardicon.Pushed then BlizzardBut:SetPushedAtlas(blizzardicon.Pushed) end
				if blizzardicon.Disabled then BlizzardBut:SetDisabledAtlas(blizzardicon.Disabled) end
				if blizzardicon.icon then
					if blizzardicon.icon[1]=="diy" then
						BlizzardBut.icon = BlizzardBut:CreateTexture(nil,"OVERLAY")
						PIGSetTexAtlas(BlizzardBut.icon,blizzardicon.icon[3])
						SetIconTextureXY(BlizzardBut,BlizzardBut.icon,{blizzardicon.icon[2][1],blizzardicon.icon[2][2],blizzardicon.icon[2][3],blizzardicon.icon[2][4]})
						BlizzardBut.XY={blizzardicon.icon[2][1],blizzardicon.icon[2][2],blizzardicon.icon[2][3],blizzardicon.icon[2][4]}
					else
						BlizzardBut.icon=_G[blizzardicon.icon[1]]
						SetIconTextureXY(BlizzardBut,_G[blizzardicon.icon[1]],{blizzardicon.icon[2][1],blizzardicon.icon[2][2],blizzardicon.icon[2][3],blizzardicon.icon[2][4]})
						BlizzardBut.XY={blizzardicon.icon[2][1],blizzardicon.icon[2][2],blizzardicon.icon[2][3],blizzardicon.icon[2][4]}
						if blizzardicon.icon[3] then
							PIGSetTexAtlas(BlizzardBut.icon,blizzardicon.icon[3])
						end
					end	
				end
			end
		end
		BlizzardBut:HookScript("OnMouseDown", function(self)
			if self:IsEnabled() and self.icon then
				self.icon:SetPoint("TOPLEFT",self,"TOPLEFT",BlizzardBut.XY[1]-1.5,BlizzardBut.XY[2]-1.5);
				self.icon:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",BlizzardBut.XY[3]-1.5,BlizzardBut.XY[4]-1.5);
			end
		end);
		BlizzardBut:HookScript("OnMouseUp", function(self)
			if self:IsEnabled() and self.icon then
				self.icon:SetPoint("TOPLEFT",self,"TOPLEFT",BlizzardBut.XY[1],BlizzardBut.XY[2]);
				self.icon:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",BlizzardBut.XY[3],BlizzardBut.XY[4]);
			end
		end);
	end
	UpdateMicroBut_UIScaleXY()
end
---
local function IS_bar34Show()
	local onoff = {}
	local ACTIONBAR_2,ACTIONBAR_3,ACTIONBAR_4,ACTIONBAR_5 = GetActionBarToggles()
	onoff[2]=ACTIONBAR_2
	onoff[3]=ACTIONBAR_3
	onoff[4]=ACTIONBAR_4
	onoff[5]=ACTIONBAR_5
	return onoff
end
local function Update_1_3(WidthX)
	MainMenuBarPageNumber:ClearAllPoints();
	MainMenuBarPageNumber:SetPoint("BOTTOM", ActionBarUpButton, "TOP", -3, -3);
	local WidthXALL = (WidthX+6)*12
	MainMenuBar:SetWidth(WidthXALL+8);
	MainMenuExpBar:SetSize(WidthXALL,8)
	ActionBar_HideBG_Main()
	ReputationWatchBar:SetWidth(WidthXALL);
	ReputationWatchBar.StatusBar:SetWidth(WidthXALL);
	ReputationWatchBar:SetPoint("BOTTOM", MainMenuBar, "TOP", 0, -2);
	ActionBar_HideBG_ExpWatch()
	if ReputationWatchBar_Update then
		hooksecurefunc("ReputationWatchBar_Update", function(newLevel)
			ActionBar_HideBG_ExpWatch()
		end)
	else
		hooksecurefunc("MainMenuBar_UpdateExperienceBars", function(newLevel)
			ActionBar_HideBG_ExpWatch()
		end)
	end
	hooksecurefunc("MainMenuTrackingBar_Configure", function(newLevel)
		ActionBar_HideBG_ExpWatch()
	end)
	for i=1, 12 do
		_G["MultiBarBottomRightButton"..i]:ClearAllPoints();
		_G["MultiBarBottomRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomLeftButton"..i],"TOP",0,6);
	end
	MainMenuBarLeftEndCap:ClearAllPoints();
	MainMenuBarLeftEndCap:SetPoint("BOTTOMRIGHT", MainMenuBarArtFrame, "BOTTOMLEFT", 34, 0);
	MainMenuBarRightEndCap:ClearAllPoints();
	MainMenuBarRightEndCap:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMRIGHT", -34, 0);
end
local function Update_Vertical(mode,WidthX)
	VerticalMultiBarsContainer:UnregisterEvent("PLAYER_REGEN_ENABLED");
	if mode==1 then
		VerticalMultiBarsContainer:SetWidth(1);
	elseif mode==2 then
		VerticalMultiBarsContainer:SetWidth(WidthX);
	end
end
local function Update_BarLayout6LR()
	_G["MultiBarLeftButton12"]:ClearAllPoints();
	_G["MultiBarLeftButton12"]:SetPoint("BOTTOMRIGHT",MainMenuBarArtFrame,"BOTTOMLEFT",-PIGA["PigLayout"]["ActionBar"]["LRInterval"],4);
	_G["MultiBarRightButton12"]:ClearAllPoints();
	_G["MultiBarRightButton12"]:SetPoint("BOTTOMLEFT",MainMenuBarArtFrame,"BOTTOMRIGHT",PIGA["PigLayout"]["ActionBar"]["LRInterval"],4);
end
local function ActionBar_Layout()
	if Fun.IsElvUI("actionbar","enable") then return end
	if Fun.IsNDui("Actionbar","Enable") then return end
	if PIGA["PigLayout"]["ActionBar"]["Layout"]==0 then return end
	--主动作条
	local function Update_MultiBar()
		if InCombatLockdown() then
			VerticalMultiBarsContainer:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			local WidthX = ActionButton1:GetWidth()
			if PIGA["PigLayout"]["ActionBar"]["Layout"]==1 then
				for i=1, 12 do
					_G["MultiBarLeftButton"..i]:ClearAllPoints();
					_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomLeftButton"..i],"TOP",0,6);
					_G["MultiBarRightButton"..i]:ClearAllPoints();
					_G["MultiBarRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
				end
				Update_Vertical(1,WidthX)
			elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==2 then
				Update_1_3(WidthX)
			elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==3 then
				Update_1_3(WidthX)
				Update_Vertical(2,WidthX)
				for i=1, 12 do
					_G["MultiBarLeftButton"..i]:ClearAllPoints();
					_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
				end
			elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==4 then
				Update_1_3(WidthX)
				Update_Vertical(1,WidthX)
				for i=1, 12 do
					_G["MultiBarLeftButton"..i]:ClearAllPoints();
					_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
					_G["MultiBarRightButton"..i]:ClearAllPoints();
					_G["MultiBarRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarLeftButton"..i],"TOP",0,6);
				end
			elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==5 then
				Update_1_3(WidthX)
				Update_Vertical(1,WidthX)
				Update_BarLayout6LR()	
				for i=11, 1,-1 do
					if i==8 or i==4 then
						_G["MultiBarLeftButton"..i]:ClearAllPoints();
						_G["MultiBarLeftButton"..i]:SetPoint("BOTTOMRIGHT",_G["MultiBarLeftButton"..(i+4)],"TOPRIGHT",0,6);
						_G["MultiBarRightButton"..i]:ClearAllPoints();
						_G["MultiBarRightButton"..i]:SetPoint("BOTTOMRIGHT",_G["MultiBarRightButton"..(i+4)],"TOPRIGHT",0,6);
					else
						_G["MultiBarLeftButton"..i]:ClearAllPoints();
						_G["MultiBarLeftButton"..i]:SetPoint("RIGHT",_G["MultiBarLeftButton"..(i+1)],"LEFT",-6,0);
						_G["MultiBarRightButton"..i]:ClearAllPoints();
						_G["MultiBarRightButton"..i]:SetPoint("LEFT",_G["MultiBarRightButton"..(i+1)],"RIGHT",6,0);
					end
				end
			end
		end
	end
	Update_MultiBar()
	VerticalMultiBarsContainer:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			Update_MultiBar()
		end
	end);
	local function Update_BarPoint(BarUI)
		--print(StanceBarFrame:IsVisible(),MultiCastSummonSpellButton:IsVisible())
		local Xoffset= 10
		if BarUI==PetActionButton1 then
			if StanceBarFrame:IsVisible() then
				local sswww=StanceButton1:GetWidth()
				Xoffset= Xoffset+sswww*3+20
			elseif MultiCastSummonSpellButton and MultiCastSummonSpellButton:IsVisible() then
				local sswww=MultiCastSummonSpellButton:GetWidth()
				Xoffset= Xoffset+sswww*6+20
			end
		end
		local barOpen = IS_bar34Show()
		if BarUI==MultiCastActionBarFrame then
			MultiCastActionBarFrame:SetMovable(true)
		end
		BarUI:ClearAllPoints();
		MainMenuBarVehicleLeaveButton:ClearAllPoints();--取消飞行
		if PIGA["PigLayout"]["ActionBar"]["Layout"]==1 and barOpen[5] then
			BarUI:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", Xoffset, 6)
			MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", -36, 6)
		elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==2 or PIGA["PigLayout"]["ActionBar"]["Layout"]==5 and barOpen[3] then
			BarUI:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1,"TOPLEFT", Xoffset, 6)
			MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1,"TOPLEFT", -36, 6)
		elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==3 and barOpen[5] then
			BarUI:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", Xoffset, 6)
			MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", -36, 6)
		elseif PIGA["PigLayout"]["ActionBar"]["Layout"]==4 and barOpen[4] and barOpen[5] then
			BarUI:SetPoint("BOTTOMLEFT", MultiBarRightButton1,"TOPLEFT", Xoffset, 6)
			MainMenuBarVehicleLeaveButton:SetPoint("BOTTOMLEFT", MultiBarRightButton1,"TOPLEFT", -36, 6)
		end
		if BarUI==MultiCastActionBarFrame then
			MultiCastActionBarFrame:SetUserPlaced(true)
		end
	end
	--姿态条
	local function Update_StanceBar()
		if InCombatLockdown() then
			StanceBarFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			StanceBarFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			Update_BarPoint(StanceButton1)
		end
	end
	Update_StanceBar()
	StanceBarFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			Update_StanceBar()
		end
	end);
	--宠物动作条
	local function Update_PetBar()
		if InCombatLockdown() then
			PetActionBarFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			PetActionBarFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			Update_BarPoint(PetActionButton1)
		end
	end
	Update_PetBar()
	if PetActionBarFrame.UpdatePositionValues then
		hooksecurefunc(PetActionBarFrame, "UpdatePositionValues", function()
			Update_PetBar()
		end)
	elseif ShowPetActionBar then
		hooksecurefunc("ShowPetActionBar", function()
			Update_PetBar()
		end)
	end
	PetActionBarFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			Update_PetBar()
		end
	end);
	---图腾条
	local function Update_MultiCastBar()
		if not MultiCastActionBarFrame then return end
		if InCombatLockdown() then
			MultiCastActionBarFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			MultiCastActionBarFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			Update_BarPoint(MultiCastActionBarFrame)
		end
	end
	if MultiCastActionBarFrame then
		Update_MultiCastBar()
		MultiCastActionBarFrame:HookScript("OnEvent", function (self,event)
			if event=="PLAYER_ENTERING_WORLD" then
				Update_MultiCastBar()
			elseif event=="PLAYER_REGEN_ENABLED" then
				Update_MultiCastBar()
			end
		end);
		UIParent:HookScript("OnShow", function(self)
			Update_MultiCastBar()
		end)
	end
	---整体
	hooksecurefunc("MainMenuBar_UpdateExperienceBars",function(newLevel)
		Update_StanceBar()
		Update_PetBar()
		Update_MultiCastBar()
	end);
	hooksecurefunc("MultiActionBar_Update",function()	
		Update_MultiBar()
		Update_StanceBar()
		Update_PetBar()
		Update_MultiCastBar()
	end);
	Update_MicroMenu()
end

function PigLayoutFun.ActionBarFun(openxx)
	if not openxx then return end
	ActionBar_HideShijiu()
	ActionBar_HideBG_Main()
	ActionBar_HideBG_ExpWatch()
	ActionBar_Scale()
	ActionBar_Layout()
end
function PigLayoutFun.addOptions_ActionBar(openxx)
	if not openxx then return end
	---
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGFrame=Create.PIGFrame
	local PIGButton=Create.PIGButton
	local PIGSlider = Create.PIGSlider
	local PIGDownMenu=Create.PIGDownMenu
	local PIGFontString=Create.PIGFontString
	local PIGOptionsList_R=Create.PIGOptionsList_R
	---
	local L=PD.locale
	
	local PIGSetAtlas=Fun.PIGSetAtlas
	local RTabFrame =PigLayoutFun.RTabFrame
	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,ACTIONBARS_LABEL..L["LIB_LAYOUT"],90)

	fujiF.PailieT = PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-20},"经典版本暴雪已增加编辑模式，动作条布局请在编辑模式调整")
	fujiF.PailieT:SetTextColor(0, 1, 0, 1);
	fujiF.PailieT:SetJustifyH("LEFT");
	if fujiF.PailieT then return end
	--
	fujiF.HideShijiu=PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-20},{"隐藏狮鹫图标","隐藏动作条两边的狮鹫图标"})
	fujiF.HideShijiu:SetChecked(PIGA["PigLayout"]["ActionBar"]["HideShijiu"])
	fujiF.HideShijiu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"]["ActionBar"]["HideShijiu"]=true;
		else
			PIGA["PigLayout"]["ActionBar"]["HideShijiu"]=false;
		end
		ActionBar_HideShijiu()
	end)
	
	fujiF.HideBarBG = PIGCheckbutton(fujiF,{"LEFT",fujiF.HideShijiu,"RIGHT",160,0},{"隐藏动作条1背景"})
	fujiF.HideBarBG:SetChecked(PIGA["PigLayout"]["ActionBar"]["HideBarBG"])
	fujiF.HideBarBG:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"]["ActionBar"]["HideBarBG"]=true	
		else
			PIGA["PigLayout"]["ActionBar"]["HideBarBG"]=false
		end
		ActionBar_HideBG_Main()
	end);

	fujiF.HideBarExpBG = PIGCheckbutton(fujiF,{"LEFT",fujiF.HideBarBG,"RIGHT",160,0},{"隐藏经验/声望背景"})
	fujiF.HideBarExpBG:SetChecked(PIGA["PigLayout"]["ActionBar"]["HideBarExpBG"])
	fujiF.HideBarExpBG:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"]["ActionBar"]["HideBarExpBG"]=true	
		else
			PIGA["PigLayout"]["ActionBar"]["HideBarExpBG"]=false
		end
		ActionBar_HideBG_ExpWatch()
	end);

	fujiF.ActionBar_Scale = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF.HideShijiu,"BOTTOMLEFT",0,-20},{"缩放动作条","启用缩放动作条,注意此设置和系统高级里面的UI缩放不同，只调整动作条比例"})
	fujiF.ActionBar_Scale:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"]["ActionBar"]["Scale"]=true	
		else
			PIGA["PigLayout"]["ActionBar"]["Scale"]=false
		end
		fujiF.ActionBar_Scale.Slider:SetEnabled(PIGA["PigLayout"]["ActionBar"]["Scale"])
		ActionBar_Scale(true)
	end);
	-------
	fujiF.ActionBar_Scale.Slider = PIGSlider(fujiF,{"LEFT",fujiF.ActionBar_Scale.Text,"RIGHT",10,0},{0.4, 1.8, 0.01,{["Right"]="%d%%"}},200)
	function fujiF.ActionBar_Scale.Slider:PIGOnValueChange(arg1)
		PIGA["PigLayout"]["ActionBar"]["ScaleV"]=arg1;
		ActionBar_Scale()
	end
	fujiF.ActionBar_Scale:SetChecked(PIGA["PigLayout"]["ActionBar"]["Scale"]);
	fujiF.ActionBar_Scale.Slider:SetEnabled(PIGA["PigLayout"]["ActionBar"]["Scale"])
	fujiF.ActionBar_Scale.Slider:PIGSetValue(PIGA["PigLayout"]["ActionBar"]["ScaleV"])

	--
	fujiF.LayoutT = PIGFontString(fujiF,{"TOPLEFT",fujiF.ActionBar_Scale,"BOTTOMLEFT",0,-30},"布局模式")
	fujiF.Layout=PIGDownMenu(fujiF,{"LEFT", fujiF.LayoutT, "RIGHT", 2, 0},{360})
	local xyList = {
		[0]="①暴雪布局(默认)",
		[1]="②暴雪布局(右侧竖向动作条移到底部)",
		[2]="③底部3行+右侧2列(分离微型菜单/背包)",
		[3]="④底部4行+右侧1列(分离微型菜单/背包)",
		[4]="⑤底部5行(分离微型菜单/背包)",
		[5]="⑥底部5行(左1+中3+右1)(分离微型菜单/背包)",
		[6]="⑦不控制动作条(分离微型菜单/背包)",
	}
	function fujiF.Layout:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=0,#xyList do
		 	info.text, info.arg1 = xyList[i], i
		 	info.checked = i == PIGA["PigLayout"]["ActionBar"]["Layout"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function fujiF.Layout:PIGDownMenu_SetValue(value,arg1)
		self:PIGDownMenu_SetText(value)
		PIGA["PigLayout"]["ActionBar"]["Layout"]=arg1
		PIG_OptionsUI.RLUI:Show()
		PIGCloseDropDownMenus()
	end
	fujiF.Layout:PIGDownMenu_SetText(xyList[PIGA["PigLayout"]["ActionBar"]["Layout"]])

	fujiF.setF = PIGFrame(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 4, -130})
	fujiF.setF:PIGSetBackdrop(0)
	fujiF.setF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", -4, 4);
	fujiF.setF:SetShown(PIGA["PigLayout"]["ActionBar"]["Layout"]~=0 and PIGA["PigLayout"]["ActionBar"]["Layout"]~=1)
	fujiF.setF.MicroMenuT = PIGFontString(fujiF.setF,{"TOPLEFT",fujiF.setF,"TOPLEFT",10,-8},"微型菜单设置")
	fujiF.setF.ListBut={}
	for i=1,PIG_MicroButNum do
		local pindaol = PIGCheckbutton(fujiF.setF,nil,{"点击显示或隐藏按钮"},nil,nil,i)
		pindaol:SetChecked(not PIGA["PigLayout"]["MicroMenu"]["HideBut"][PIG_MICRO_BUTTONS[i]])
		pindaol.Text:SetText("")
		pindaol:SetHitRectInsets(0,-20,0,0);
		pindaol.icon = pindaol:CreateTexture();
		pindaol.icon:SetSize(20,22);
		pindaol.icon:SetPoint("LEFT",pindaol,"RIGHT",0,0);
		fujiF.setF.ListBut[i]=pindaol
		if i==1 then
			pindaol:SetPoint("TOPLEFT",fujiF.setF,"TOPLEFT",10,-34);
		elseif i==12 then
			pindaol:SetPoint("TOPLEFT",fujiF.setF.ListBut[1],"BOTTOMLEFT",0,-10);
		else
			pindaol:SetPoint("LEFT", fujiF.setF.ListBut[i-1], "RIGHT", 36, 0);
		end
		pindaol:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["PigLayout"]["MicroMenu"]["HideBut"][PIG_MICRO_BUTTONS[i]]=nil;
			else
				PIGA["PigLayout"]["MicroMenu"]["HideBut"][PIG_MICRO_BUTTONS[i]]=true;
			end
			PIG_OptionsUI.RLUI:Show()
		end);
		local diyicon = Data.DiyIcon and Data.DiyIcon[PIG_MICRO_BUTTONS[i]]
		if diyicon then
			local Atlasinfo = C_Texture.GetAtlasInfo(diyicon.icon)
			if Atlasinfo then
				pindaol.icon:SetAtlas(diyicon.icon)
			else
				if not PIGSetAtlas(pindaol.icon,diyicon.icon) then
					pindaol.icon:SetTexture(diyicon.icon)
				end
			end
		else
			local blizzardicon = BlizzardIcon[PIG_MICRO_BUTTONS[i]]
			if blizzardicon then
				if blizzardicon.icon then
					if blizzardicon.icon[1]=="diy" then
						PIGSetTexAtlas(pindaol.icon,blizzardicon.icon[3])
					else
						if blizzardicon.icon[3] then
							PIGSetTexAtlas(pindaol.icon,blizzardicon.icon[3])
						elseif blizzardicon.icon[4] then
							PIGSetTexAtlas(pindaol.icon,blizzardicon.icon[4])
						else
							PIGSetTexAtlas(pindaol.icon,_G[blizzardicon.icon[1]]:GetTexture())
						end
					end
				else
					pindaol.icon:SetAtlas(blizzardicon.Normal)
				end
			elseif BlizzardIconSet[PIG_MICRO_BUTTONS[i]] then
				pindaol.icon:SetAtlas(BlizzardIconSet[PIG_MICRO_BUTTONS[i]])
			end
		end
	end
	fujiF.setF.Scale = PIGSlider(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -80},{0.6, 1.8, 0.01,{["Right"]="缩放%d%%"}},200)
	function fujiF.setF.Scale:PIGOnValueChange(arg1)
		PIGA["PigLayout"]["MicroMenu"]["Scale"]=arg1;
		UpdateMicroBut_UIScaleXY()
	end
	fujiF.setF.Interval = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.Scale, "RIGHT", 80, 0},{-6, 30, 1,{["Right"]="按钮间距%d"}},200)
	function fujiF.setF.Interval:PIGOnValueChange(arg1)
		PIGA["PigLayout"]["MicroMenu"]["Interval"]=arg1;
		UpdateMicroBut_UIScaleXY()
	end
	fujiF.setF.AnchorPointT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF.Scale, "BOTTOMLEFT", 0, -10},"定位锚点")
	fujiF.setF.AnchorPoint=PIGDownMenu(fujiF.setF,{"LEFT", fujiF.setF.AnchorPointT, "RIGHT", 0, 0},{120,nil})
	local xyList = PigLayoutFun.xyList
	local xyListName = PigLayoutFun.xyListName
	function fujiF.setF.AnchorPoint:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#xyList do
		 	info.text, info.arg1 = xyListName[xyList[i]], xyList[i]
		 	info.checked = xyList[i] == PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function fujiF.setF.AnchorPoint:PIGDownMenu_SetValue(value,arg1)
		self:PIGDownMenu_SetText(value)
		PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=arg1
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointX"]=0
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointY"]=0
		UpdateMicroBut_UIScaleXY(true)
		fujiF.setF.Update_SetUI()
		PIGCloseDropDownMenus()
	end
	
	fujiF.setF.AnchorPointX = PIGSlider(fujiF.setF,{"TOPLEFT", fujiF.setF.AnchorPointT, "BOTTOMLEFT", 0, -10},{-2000, 2000, 1,{["Right"]="X偏移%d"}},500)
	function fujiF.setF.AnchorPointX:PIGOnValueChange(arg1)
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointX"]=arg1;
		UpdateMicroBut_UIScaleXY()
	end
	fujiF.setF.AnchorPointY = PIGSlider(fujiF.setF,{"TOPLEFT", fujiF.setF.AnchorPointX, "BOTTOMLEFT", 0, -10},{-2000, 2000, 1,{["Right"]="Y偏移%d"}},500)
	function fujiF.setF.AnchorPointY:PIGOnValueChange(arg1)
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointY"]=arg1;
		UpdateMicroBut_UIScaleXY()
	end
	
	fujiF.setF.MoveTime = PIGCheckbutton(fujiF.setF,{"LEFT",fujiF.setF.AnchorPoint,"RIGHT",40,0},{"小地图时间移动到微型菜单中间"})
	fujiF.setF.MoveTime:SetChecked(PIGA["PigLayout"]["MicroMenu"]["MoveTime"])
	fujiF.setF.MoveTime:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["PigLayout"]["MicroMenu"]["MoveTime"]=true;
		else
			PIGA["PigLayout"]["MicroMenu"]["MoveTime"]=false
		end
		PIG_OptionsUI.RLUI:Show()
	end);
	if PIGA["PigLayout"]["ActionBar"]["Layout"]==5 then
		fujiF.setF.LRIntervalT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF.AnchorPointY, "BOTTOMLEFT", 0, -10},"⑥布局左右左右动作条间距")
		fujiF.setF.LRInterval = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.LRIntervalT, "RIGHT", 0, 0},{0, 400, 1})
		function fujiF.setF.LRInterval:PIGOnValueChange(arg1)
			PIGA["PigLayout"]["ActionBar"]["LRInterval"]=arg1;
			Update_BarLayout6LR()
		end
	end
	fujiF.setF.CZBUT = PIGButton(fujiF.setF,{"LEFT",fujiF.setF.MoveTime.Text,"RIGHT",40,0},{60,22},RESET)
	fujiF.setF.CZBUT:SetScript("OnClick", function ()
		PIGA["PigLayout"]["MicroMenu"]["Scale"]=PD.Default["PigLayout"]["MicroMenu"]["Scale"]
		PIGA["PigLayout"]["MicroMenu"]["Interval"]=PD.Default["PigLayout"]["MicroMenu"]["Interval"]
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointX"]=0;
		PIGA["PigLayout"]["MicroMenu"]["AnchorPointY"]=0;
		PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]=PD.Default["PigLayout"]["MicroMenu"]["AnchorPoint"]
		UpdateMicroBut_UIScaleXY()
		PIGA["PigLayout"]["ActionBar"]["LRInterval"]=PD.Default["PigLayout"]["ActionBar"]["LRInterval"]
		if PIGA["PigLayout"]["ActionBar"]["Layout"]==5 then
			Update_BarLayout6LR()
		end
		fujiF.setF.Update_SetUI()
	end)
	function fujiF.setF.Update_SetUI()
		fujiF.setF.Scale:PIGSetValue(PIGA["PigLayout"]["MicroMenu"]["Scale"])
		fujiF.setF.Interval:PIGSetValue(PIGA["PigLayout"]["MicroMenu"]["Interval"])
		fujiF.setF.AnchorPoint:PIGDownMenu_SetText(xyListName[PIGA["PigLayout"]["MicroMenu"]["AnchorPoint"]])
		fujiF.setF.AnchorPointX:PIGSetValue(PIGA["PigLayout"]["MicroMenu"]["AnchorPointX"])
		fujiF.setF.AnchorPointY:PIGSetValue(PIGA["PigLayout"]["MicroMenu"]["AnchorPointY"])
		if fujiF.setF.LRInterval then fujiF.setF.LRInterval:PIGSetValue(PIGA["PigLayout"]["ActionBar"]["LRInterval"]) end
	end
	fujiF.setF.Update_SetUI()
end