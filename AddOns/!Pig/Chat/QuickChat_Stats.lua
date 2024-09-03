local _, addonTable = ...;
local L=addonTable.locale
-------------------------------------------
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGFontString=Create.PIGFontString
local QuickChatfun=addonTable.QuickChatfun
function QuickChatfun.QuickBut_Stats()
	local fuFrame=QuickChatFFF_UI
	local fuWidth = fuFrame.Width
	local Width,Height = fuWidth,fuWidth
	local ziframe = {fuFrame:GetChildren()}
	if PIGA["Chat"]["QuickChat_style"]==1 then
		fuFrame.playerStats = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate"); 
	elseif PIGA["Chat"]["QuickChat_style"]==2 then
		fuFrame.playerStats = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
	end
	fuFrame.playerStats:SetSize(Width,Height);
	fuFrame.playerStats:SetFrameStrata("LOW")
	fuFrame.playerStats:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
	fuFrame.playerStats:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	fuFrame.playerStats.Tex = fuFrame.playerStats:CreateTexture(nil);
	fuFrame.playerStats.Tex:SetTexture(666623)
	fuFrame.playerStats.Tex:SetSize(Width,Height+2);
	fuFrame.playerStats.Tex:SetPoint("CENTER",fuFrame.playerStats,"CENTER",0,-2);
	fuFrame.playerStats:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1,-3);
	end);
	fuFrame.playerStats:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,-2);
	end);
	PIGEnter(fuFrame.playerStats,"|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00"..CHAT_ANNOUNCE..PAPERDOLL_SIDEBAR_STATS.."\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00"..PARTY.."/"..RAID_MEMBERS..INFO.."|r")
	fuFrame.playerStats:HookScript("OnEnter", function (self)	
		fuFrame:PIGEnterAlpha()
	end);
	fuFrame.playerStats:HookScript("OnLeave", function (self)
		fuFrame:PIGLeaveAlpha()
	end);
	local TalentData=addonTable.Data.TalentData
	fuFrame.playerStats:SetScript("OnClick", function(self, event)
		if event=="LeftButton" then
			local shuxintxt = TalentData.Player_Stats()
			local editBoxXX = ChatEdit_ChooseBoxForSend()
	        ChatEdit_ActivateChat(editBoxXX)
			editBoxXX:Insert(shuxintxt)
		else
			if fuFrame.playerStats.RF:IsShown() then
				fuFrame.playerStats.RF:Hide()
			else
				fuFrame.playerStats.RF:Show()
			end
		end
	end);
	---
	local OptionsW,OptionsH,OptionsJG,BottomHHH,uifu = 200,400,14,40,fuFrame.playerStats.RF
	fuFrame.playerStats.RF=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{OptionsW*MAX_PARTY_MEMBERS,OptionsH},"Pig_playerStatsUI",true)
	local uifu = fuFrame.playerStats.RF
	uifu:PIGSetBackdrop()
	uifu:PIGClose()
	uifu:PIGSetMovable()
	uifu.ButLsit={}
	uifu.biaoti = PIGFontString(uifu,{"TOP", uifu, "TOP", 0, -2},"成员信息")
	for id = 1, MAX_PARTY_MEMBERS, 1 do
		local playerbut=PIGFrame(uifu,{"BOTTOMLEFT",uifu,"BOTTOMLEFT",OptionsW*(id-1),0},{OptionsW,OptionsH-20})
		playerbut:PIGSetBackdrop(0,0.6,nil,{1,1,0})
		uifu.ButLsit[id]=playerbut
		playerbut.name = PIGFontString(playerbut,{"TOP", playerbut, "TOP", 0, -2},"")
		playerbut.model = CreateFrame("PlayerModel", nil, playerbut);
		playerbut.model:SetSize(OptionsW,OptionsH-100);
		playerbut.model:SetPoint("BOTTOM",playerbut,"BOTTOM",0,0);
		playerbut.model:SetUnit("Party"..id)
		
	end
	uifu:SetScript("OnShow", function (self)
		for id = 1, MAX_PARTY_MEMBERS, 1 do
			uifu.ButLsit[id].name:SetText(GetUnitName("Party"..id, true))
			uifu.ButLsit[id].model:SetUnit("Party"..id)
		end
	end)
	uifu:RegisterEvent("GROUP_ROSTER_UPDATE")
	uifu:RegisterEvent("PLAYER_ENTERING_WORLD")
	uifu:HookScript("OnEvent",function(self, event,arg1,_,_,_,arg5)
		-- RaidR:Update_DongjieBUT()
		-- if not PIGA["GDKP"]["Dongjie"] then
		-- 	C_Timer.After(0.8,function()
		-- 		RaidR:GetRiadPlayerInfo()
		-- 		RaidR:RaidInfoShow()
		-- 		RaidR.PlayerList:PlayerList_UP()
		-- 	end)
		-- end
	end)
end