local _, PD = ...;
local L=PD.locale
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
local Create = PD.Create
local GeneralFun=PD.GeneralFun
function GeneralFun.Common_AFK()
	local Pig_AFKData = {}
	Pig_AFKData.cameraYawMoveSpeed=GetCVar("cameraYawMoveSpeed")
	Pig_AFKData.cameraPitchMoveSpeed=GetCVar("cameraPitchMoveSpeed")
	if not PIGA["Other"]["AFK"]["Open"] or GeneralFun.Pig_AFKOpen then return end
	GeneralFun.Pig_AFKOpen=true
	local PIGFontString=Create.PIGFontString
	local WowWidth=GetScreenWidth();
	local WowHeight=GetScreenHeight();
	local AFKUI = CreateFrame("Frame",nil, WorldFrame,"BackdropTemplate");
	AFKUI:SetBackdrop({
		bgFile = "interface/characterframe/ui-party-background.blp",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,});
	AFKUI:SetBackdropColor(0, 0, 0, 0.5);
	AFKUI:SetBackdropBorderColor(0, 0, 0, 0.8);
	AFKUI:SetSize(WowWidth,100);
	AFKUI:SetPoint("BOTTOM",WorldFrame,"BOTTOM",0,0);
	AFKUI:Hide()
	local zijiinfo="|cff00FFFF"..FRIENDS_LIST_REALM.."|r"..PlayerInfo.Realm.."   |cff00FFFF"..RACE..":|r"..PlayerInfo.RaceData.raceName.."   |cff00FFFF"..SHOW_PLAYER_NAMES..":|r"..PlayerInfo.Name
	AFKUI.info = PIGFontString(AFKUI,{"CENTER", AFKUI, "CENTER", 0, 0},zijiinfo,"OUTLINE",28)
	AFKUI.info:SetTextColor(1, 1, 0, 1);
	
	AFKUI.zhenying = AFKUI:CreateTexture()
	AFKUI.zhenying:SetTexture(131148);
	AFKUI.zhenying:SetSize(50,50);
	AFKUI.zhenying:SetPoint("RIGHT", AFKUI.info,"LEFT",-10, 0);
	local englishFaction, _ = UnitFactionGroup("player")
	if englishFaction=="Alliance" then
		AFKUI.zhenying:SetTexCoord(0,0.5,0,1);
	elseif englishFaction=="Horde" then
		AFKUI.zhenying:SetTexCoord(0.5,1,0,1);
	end
	----
	local WowWidth=800;
	local WowHeight=500;
	AFKUI.moxingjuli = -0.4
	AFKUI.downV = -0.5
	if raceID==7 then
		AFKUI.moxingjuli=-0.8
		AFKUI.downV = -0.3
	end
	AFKUI.ModelUI = CreateFrame("PlayerModel", nil, AFKUI);
	AFKUI.ModelUI:SetSize(WowWidth,WowHeight);
	AFKUI.ModelUI:SetPoint("BOTTOMRIGHT",AFKUI,"TOPRIGHT",0,0);
	AFKUI.ModelUI:SetUnit("player")
	-- fileID =CharacterModelFrame:GetModelFileID();
	-- print(fileID)
	-- AFKUI.ModelUI:SetModel(1011653)
	AFKUI.ModelUI:SetCamera(1)
	--AFKUI.ModelUI:SetScale(0.8);
	--AFKUI.ModelUI:ClearModel();--清空模型
	AFKUI.ModelUI:SetPortraitZoom(AFKUI.moxingjuli);--模型视角远近
	--AFKUI.ModelUI:SetPosition(0,0,0.9);--相对于左下角定位模型Z,X,Y
	--AFKUI.ModelUI:SetFacing(3.1415926)--模型角度
	--AFKUI.ModelUI:SetAnimation(69);
	--AFKUI.ModelUI:SetSequence(69);
	AFKUI.ModelUI:SetScript("OnAnimStarted", function(self)
		local hasAnimation = self:HasAnimation(69);--检查模型是否支持与给定动画
		if hasAnimation then
			AFKUI.ModelUI:SetAnimation(69);
		end
	end);
	AFKUI.ModelUI:SetScript("OnAnimFinished", function(self) 
		self:SetAnimation(69); 
	end);
	AFKUI.title = PIGFontString(AFKUI,{"TOP", WorldFrame, "TOP", 0, -100},"","OUTLINE",50)
	AFKUI.title:SetTextColor(1, 1, 0, 1);
	UIParent:HookScript("OnShow", function(self)
		SetCVar("cameraYawMoveSpeed",Pig_AFKData.cameraYawMoveSpeed)
		AFKUI:Hide()
		MoveViewLeftStop()
	end)
	AFKUI.pxulie=1
	local function weizhibiandong()
		if AFKUI:IsShown() then
			if AFKUI.pxulie then
				if AFKUI.pxulie==1 then
					AFKUI.ModelUI:SetPosition(0,0,AFKUI.downV);	
					AFKUI.pxulie=2
				elseif AFKUI.pxulie==2 then
					AFKUI.ModelUI:SetPosition(0,-0.6,AFKUI.downV);
					AFKUI.pxulie=3
				elseif AFKUI.pxulie==3 then
					AFKUI.ModelUI:SetPosition(0,0.6,AFKUI.downV);
					AFKUI.pxulie=1
				end
			end
			C_Timer.After(10,weizhibiandong)
		end
	end
	local function Stopzhuandong()
		SetCVar("cameraYawMoveSpeed",Pig_AFKData.cameraYawMoveSpeed)--旋转速度
		MoveViewLeftStop()
		AFKUI:Hide()
		UIParent:Show()
	end
	local LIKAIMSG=string.format(MARKED_AFK_MESSAGE,DEFAULT_AFK_MESSAGE)

	AFKUI:RegisterEvent("CHAT_MSG_AFK");
	AFKUI:RegisterEvent("CHAT_MSG_SYSTEM");
	AFKUI:RegisterEvent("PLAYER_REGEN_DISABLED");
	AFKUI:RegisterEvent("PLAYER_LEAVING_WORLD")
	AFKUI:RegisterEvent("PLAYER_LOGOUT")
	AFKUI:RegisterEvent("CVAR_UPDATE");
	AFKUI:SetScript("OnEvent", function(self,event,arg1,arg2)
		if event=="CVAR_UPDATE" then
			if arg1=="cameraYawMoveSpeed"  then
				Pig_AFKData.cameraYawMoveSpeed=arg2
			elseif arg1=="cameraPitchMoveSpeed" then
				Pig_AFKData.cameraPitchMoveSpeed=arg2
			end
		elseif event=="PLAYER_REGEN_DISABLED" or event=="PLAYER_LEAVING_WORLD" or event=="PLAYER_LOGOUT" then
			self:RegisterEvent("CVAR_UPDATE")
			if not InCombatLockdown() then
				Stopzhuandong()
			end
		elseif event=="CHAT_MSG_AFK" or event=="CHAT_MSG_SYSTEM" then
			if not InCombatLockdown() then
				if arg1==LIKAIMSG then
					self:UnregisterEvent("CVAR_UPDATE")
					SetCVar("cameraYawMoveSpeed",6)
					MoveViewLeftStart()
					UIParent:Hide()
					self:Show()
					self.title:SetText(PIGA["Other"]["AFK"]["TispTXT"]);
					self.pxulie=1
					weizhibiandong()
				elseif arg1==CLEARED_AFK then
					self:RegisterEvent("CVAR_UPDATE")
					Stopzhuandong()
				end
			end
		end
	end)
	--
	Create.PIGaddQuickBut(19,{
		Open=function()
			return PIGA["QuickBut"]["Open"] and PIGA["Other"]["AFK"]["Open"] and PIGA["Other"]["AFK"]["QuickBut"]
		end,
		Icon=132802,
		Tooltip = L["COMMON_AFK"],
		Template="SecureActionButtonTemplate",
		fun=function(but)
			PD.Fun.ActionFun.PIGUseKeyDown(but)
			but:SetAttribute("type", "macro")
			but:HookScript("PreClick",  function (self)
				if InCombatLockdown() then
					PIGErrorMsg(ERR_NOT_IN_COMBAT)
				else
					local inInstance, instanceType = IsInInstance()
					if inInstance then
						PIGErrorMsg(ERR_NOT_IN_COMBAT)
					else
						but:SetAttribute("macrotext", [=[/AFK]=])
					end
				end
			end);
			but:HookScript("PostClick",  function (self)
				if not InCombatLockdown() then
					but:SetAttribute("macrotext", [=[/PIGprint("..ERR_NOT_IN_COMBAT..")]=])
				end
			end);
		end
	})
end