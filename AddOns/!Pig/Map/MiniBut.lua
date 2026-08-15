local addonName, PD = ...;
local Mapfun=PD.Mapfun
local Data=PD.Data
local UIname="PIG_MiniMapBut"
Data.MiniMapButUIname=UIname
function PD.MiniMapBut_Add()
	if not PIGA["Map"]["MinimapBut"] then return end
	if Mapfun.MiniMapBut then return end
	local L=PD.locale
	-------
	local Create = PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGFontString=Create.PIGFontString
	local Fun = PD.Fun
	---小地图按钮
	local ButW= 32
	local MiniMapBut = CreateFrame("Button",UIname,UIParent);
	Mapfun.MiniMapBut=MiniMapBut
	MiniMapBut:SetMovable(true)
	MiniMapBut:EnableMouse(true)
	MiniMapBut:RegisterForClicks("LeftButtonUp","RightButtonUp")
	MiniMapBut:RegisterForDrag("LeftButton")
	MiniMapBut:SetFrameStrata("MEDIUM")
	MiniMapBut:SetFrameLevel(MiniMapBut:GetFrameLevel()+1);
	MiniMapBut.Border = MiniMapBut:CreateTexture(nil,"BORDER");
	MiniMapBut.icon = MiniMapBut:CreateTexture(nil, "BACKGROUND");
	MiniMapBut.icon:SetPoint("CENTER", 0, 0);
	MiniMapBut.error = MiniMapBut:CreateTexture(nil, "BORDER");
	MiniMapBut.error:SetTexture("interface/common/voicechat-muted.blp");
	MiniMapBut.error:SetSize(18,18);
	MiniMapBut.error:SetAlpha(0.7);
	MiniMapBut.error:SetPoint("CENTER", 0, 0);
	MiniMapBut.error:Hide();
	MiniMapBut:SetScript("OnLeave", function()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	MiniMapBut:SetScript("OnEnter", function(self)
		self.Update_Enter()
	end);
	Mapfun.EntertispBox=PIGA["Map"]["EntertispBox"]
	function MiniMapBut.Update_Enter(laiyuan)
		GameTooltip:ClearLines();
		if laiyuan then
			GameTooltip:SetOwner(laiyuan, "ANCHOR_BOTTOMLEFT",-2,16);
		else
			GameTooltip:SetOwner(MiniMapBut, "ANCHOR_TOPRIGHT",-24,0);
		end
		GameTooltip:AddLine("|cffFF00FF"..addonName.."|r-"..PIGGetAddOnMetadata(addonName, "Version"))
		GameTooltip:AddLine(MiniMapBut.TooltipV)
		GameTooltip:Show()
		if Mapfun.EntertispBox then
			MiniMapBut.Box:Show();
			MiniMapBut.Box.xiaoshidaojishi = 1.5;
			MiniMapBut.Box.zhengzaixianshi = true;
		end
	end
	local function GetMinimapScale()
		if MinimapCluster and MinimapCluster.GetSettingValue and Enum.EditModeMicroMenuSetting.Size then
			local Value=MinimapCluster:GetSettingValue(Enum.EditModeMicroMenuSetting.Size)/100
			return Value>0 and Value or 1
		else
			return 1
		end
	end
	local function YDButtonP(mode,xpos,ypos)
		if mode==1 or mode==3 then
			MiniMapBut:ClearAllPoints();
			if mode==1 then
				if Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") then
					local xpos=xpos or PIGA["Map"]["MinimapPoint_NDui"][1]
					local ypos=ypos or PIGA["Map"]["MinimapPoint_NDui"][2]
					MiniMapBut:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMLEFT",xpos,ypos)
					PIGA["Map"]["MinimapPoint_NDui"][1]=xpos
					PIGA["Map"]["MinimapPoint_NDui"][2]=ypos
				elseif Fun.IsElvUI() then
					local xpos=xpos or PIGA["Map"]["MinimapPoint_ElvUI"][1]
					local ypos=ypos or PIGA["Map"]["MinimapPoint_ElvUI"][2]
					PIGA["Map"]["MinimapPoint_ElvUI"][1]=xpos
					PIGA["Map"]["MinimapPoint_ElvUI"][2]=ypos
					local function ElvUIPoint(Coun)
						if MinimapPanel and MinimapPanel:IsVisible() then
							local PanelH = MinimapPanel:GetHeight()
							MinimapPanel:SetPoint("TOPLEFT",Minimap,"BOTTOMLEFT",PanelH,0)
							MiniMapBut:ClearAllPoints();
							MiniMapBut:SetWidth(PanelH);
							MiniMapBut:SetPoint("TOPRIGHT",MinimapPanel,"TOPLEFT",0,0)
							MiniMapBut:SetPoint("BOTTOMRIGHT",MinimapPanel,"BOTTOMLEFT",0,0)
							MiniMapBut.icon:SetSize(PanelH,PanelH);
						else
							Coun=Coun+1
							if Coun<10 then
								C_Timer.After(0.2,function() ElvUIPoint(Coun) end)
							else
								MiniMapBut:SetPoint("BOTTOMLEFT",Minimap,"BOTTOMLEFT",xpos,ypos)
							end
						end
					end
					ElvUIPoint(0)
				else
					local xpos=xpos or PIGA["Map"]["MinimapPos"]
					local left, bottom, width, height = Minimap:GetScaledRect()
					local minimapScale = GetMinimapScale()
					local UIScale = UIParent:GetEffectiveScale()
					local banjing = (width*0.5)/minimapScale/UIScale+10
					local pianyi =MiniMapBut.pianyi
					MiniMapBut:SetPoint("TOPLEFT",Minimap,"TOPLEFT",pianyi-2-(banjing*cos(xpos)),(banjing*sin(xpos))-pianyi)
					PIGA["Map"]["MinimapPos"]=xpos
				end
			elseif mode==3 then
				if xpos and xpos then
					MiniMapBut:SetPoint("CENTER",UIParent,"CENTER",xpos,ypos)
					PIGA["Map"]["MinimapPointXY"][1]=xpos
					PIGA["Map"]["MinimapPointXY"][2]=ypos	
				else
					local xpos=PIGA["Map"]["MinimapPointXY"][1] or PD.Default["Map"]["MinimapPointXY"][1]
					local ypos=PIGA["Map"]["MinimapPointXY"][2] or PD.Default["Map"]["MinimapPointXY"][2]
					MiniMapBut:SetPoint("CENTER",UIParent,"CENTER",xpos,ypos)
				end
			end
		end
	end
	local function GetPositionData(mode)
		local UIScale = UIParent:GetEffectiveScale()
		local xpos,ypos = GetCursorPosition()
		xpos = xpos/UIScale
		ypos = ypos/UIScale
		local Pigleft, Pigbottom, Pigwidth, Pigheight  = MiniMapBut:GetScaledRect()
		Pigwidth, Pigheight=Pigwidth or ButW, Pigheight or ButW
	    Pigwidth = Pigwidth/UIScale
		local Pigwidth2 = Pigwidth*0.5
		if mode==3 then
			local MinibutW3 = Pigwidth2-4
			local WowWidth2=GetScreenWidth()*0.5;
			local WowHeight2=GetScreenHeight()*0.5;
			local xpos = xpos-WowWidth2
			local ypos = ypos-WowHeight2
			if xpos>WowWidth2-MinibutW3 then xpos=WowWidth2-MinibutW3 end
			if xpos<-WowWidth2+MinibutW3 then xpos=-WowWidth2+MinibutW3 end
			if ypos>WowHeight2-MinibutW3 then ypos=WowHeight2-MinibutW3 end
			if ypos<-WowHeight2+MinibutW3 then ypos=-WowHeight2+MinibutW3 end
			return xpos,ypos
		else
			local left, bottom, width, height = Minimap:GetScaledRect()
			left = left/UIScale
		    bottom = bottom/UIScale
		    width = width/UIScale
		   	height = height/UIScale
		    Pigheight = Pigheight/UIScale
		    local Pigheight2 = Pigheight*0.5
			return xpos,ypos,left, bottom, width, height,Pigheight,Pigheight2
		end
	end
	local function YDButtonP_OnUpdate()	
		local mode = PIGA["Map"]["MinimapPointMode"]
		if mode==3 then
			local xpos,ypos=GetPositionData(mode)
			YDButtonP(mode,xpos,ypos)
			MiniMapBut.Box:UpdateMiniMapButBox_3(mode,xpos,ypos)
		else
		   	local xpos,ypos,left, bottom, width, height,Pigheight,Pigheight2=GetPositionData(mode)
			if Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") or Fun.IsElvUI() then
				local xpos = xpos-left-Pigwidth2
				local ypos = ypos-bottom-Pigheight2
				if xpos<0 then xpos=0 end--X左边
				local rightbianp = width-Pigwidth
				if xpos>rightbianp then--X右边
					xpos=rightbianp
				end
				if ypos<0 then ypos=0 end--下
				local topbianp = height-Pigheight
				if ypos>topbianp then
					ypos=topbianp
				end
				YDButtonP(mode,xpos,ypos)
			else
				local xpos = left-xpos+width*0.5
				local ypos = ypos-bottom-width*0.5
				YDButtonP(mode,math.deg(math.atan2(ypos,xpos)))
			end
		end
	end
	function MiniMapBut:ClickShowSet()
		PD.UpdateOptionsUI(nil,function(uix)
			if uix:IsShown() then	
				self.Box:Hide();
			end
		end)
	end
	function MiniMapBut:ClickShowSNF()
		if self.Box:IsShown() then	
			self.Box:Hide();
		else
			PD.UpdateOptionsUI(false)
			self.Box:Show();
			self.Box.xiaoshidaojishi = 1.5;
			self.Box.zhengzaixianshi = true;
		end
	end
	function MiniMapBut.Update_Click(button)
		GameTooltip:Hide()
		if button=="LeftButton" then
			if IsControlKeyDown() then
				PIG_BugcollectUI:Show()
				MiniMapBut.error:Hide();
			elseif IsShiftKeyDown() then
				ReloadUI()
			else
				if PIGA["Map"]["MiniButShouNa_YN"]==1 then
					MiniMapBut:ClickShowSNF()
				else
					MiniMapBut:ClickShowSet()
				end
			end
		elseif button=="RightButton" then
			MiniMapBut:ClickShowSet()
		end
	end
	MiniMapBut:SetScript("OnClick", function(self, button)
		PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
		self.Update_Click(button)
	end)
	local MiniMapButYD = CreateFrame("Frame")
	MiniMapButYD:Hide();
	function MiniMapBut.RegistrationEvent(ONOFF)
		if ONOFF then
			MiniMapButYD:SetScript("OnUpdate",YDButtonP_OnUpdate)
			MiniMapBut:SetScript("OnDragStart", function(self)
				self:LockHighlight();MiniMapButYD:Show();
			end)
			MiniMapBut:SetScript("OnDragStop", function(self)
				self:UnlockHighlight();MiniMapButYD:Hide();
			end)
		else
			MiniMapButYD:SetScript("OnUpdate",nil)
			MiniMapBut:SetScript("OnDragStart",nil)
			MiniMapBut:SetScript("OnDragStop",nil)
		end
	end
	function MiniMapBut:CZMinimapInfo()
		PIGA["Map"]["MinimapPos"]=PD.Default["Map"]["MinimapPos"]
		PIGA["Map"]["MinimapPointXY"]=CopyTable(PD.Default["Map"]["MinimapPointXY"])
		PIGA["Map"]["MinimapPoint_NDui"]=CopyTable(PD.Default["Map"]["MinimapPoint_NDui"])
		PIGA["Map"]["MinimapPoint_ElvUI"]=CopyTable(PD.Default["Map"]["MinimapPoint_ElvUI"])
		YDButtonP(PIGA["Map"]["MinimapPointMode"]);
	end
	MiniMapBut.Box = PIGFrame(MiniMapBut,nil,{200, 100});
	MiniMapBut.Box:PIGSetBackdrop(0.9)
	MiniMapBut.Box:Hide();
	MiniMapBut.Box.tishi = PIGFontString(MiniMapBut.Box,nil,L["MAP_NIMIBUT_TIPS3"])
	MiniMapBut.Box.tishi:SetPoint("TOPLEFT", MiniMapBut.Box, "TOPLEFT", 6, -6);
	MiniMapBut.Box.tishi:SetPoint("BOTTOMRIGHT", MiniMapBut.Box, "BOTTOMRIGHT", -6, 6);
	MiniMapBut.Box.tishi:Hide();
	function MiniMapBut.Box:UpdateMiniMapButBox_3(mode,xpos,ypos)
		self:ClearAllPoints();
		if mode == 1 then--小地图
			self:SetPoint("TOPRIGHT", MiniMapBut, "BOTTOMLEFT", -2, 20);
		elseif mode == 2 then--聊天框
			self:SetPoint("BOTTOMLEFT", MiniMapBut, "TOPRIGHT", 2, 2);
		elseif mode == 3 then--自由		
			if not xpos or not ypos then
				xpos,ypos=GetPositionData(mode)
			end
			local Pointinfo = {"RIGHT", "LEFT", "TOP", "BOTTOM", -2, 25}
			if xpos<0 then
				Pointinfo[1]="LEFT"
				Pointinfo[2]="RIGHT"
			end
			if ypos<0 then
				Pointinfo[3]="BOTTOM"
				Pointinfo[4]="TOP"
				Pointinfo[6]=0
			end
			self:SetPoint(Pointinfo[3]..Pointinfo[1], MiniMapBut, Pointinfo[4]..Pointinfo[2], Pointinfo[5], Pointinfo[6]);
		end
	end
	MiniMapBut.Box:SetScript("OnUpdate", function(self, ssss)
		if self.zhengzaixianshi==nil then
			return;
		else
			if self.zhengzaixianshi==true then
				if self.xiaoshidaojishi<= 0 then
					self:Hide();
					self.zhengzaixianshi = nil;
				else
					self.xiaoshidaojishi = self.xiaoshidaojishi - ssss;	
				end
			end
		end
	end)
	MiniMapBut.Box:SetScript("OnEnter", function(self)
		self.zhengzaixianshi = nil;
	end)
	MiniMapBut.Box:SetScript("OnLeave", function(self)
		self.xiaoshidaojishi = 1.5;
		self.zhengzaixianshi = true;
	end)
	--刷新按钮位置
	function Mapfun.UpdateMiniButPoint()
		if not PIGA["Map"]["MinimapBut"] then MiniMapBut:Hide() return end
		if PIGA["Map"]["MiniButShouNa_YN"]==2 then
			MiniMapBut:SetParent(Minimap)
			MiniMapBut:SetFrameStrata("MEDIUM")
		elseif PIGA["Map"]["MiniButShouNa_YN"]==1 then
			MiniMapBut:SetParent(UIParent)		
		end
		if PIGA["Map"]["MiniButShouNa_YN"]==1 then 
			MiniMapBut.TooltipV=L["MAP_NIMIBUT_TIPS1"]
		else
			MiniMapBut.TooltipV=L["MAP_NIMIBUT_TIPS2"]
		end
		local mode = PIGA["Map"]["MinimapPointMode"]
		MiniMapBut:ClearNormalTexture()
		MiniMapBut:ClearPushedTexture()
		MiniMapBut.RegistrationEvent(false)
		if Fun.IsElvUI() or Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") then
			MiniMapBut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
			MiniMapBut.icon:SetTexture("Interface/AddOns/"..addonName.."/Media/logo32R.blp");
		else
			MiniMapBut:SetHighlightTexture("Interface/Minimap/UI-Minimap-ZoomButton-Highlight");
			MiniMapBut.icon:SetTexture("Interface/AddOns/"..addonName.."/Media/logo32.blp");
		end
		if mode == 1 or mode == 3 then
			MiniMapBut.pianyi = 0
			if mode == 1 then--小地图
				if Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") then
					MiniMapBut.RegistrationEvent(true)
					MiniMapBut.Border:Hide()
					MiniMapBut:SetSize(ButW-8,ButW-8);
					MiniMapBut.icon:SetSize(ButW-8,ButW-8);
				elseif Fun.IsElvUI() then
					
				else
					local minimapScale = GetMinimapScale()
					MiniMapBut:SetScale(minimapScale)
					MiniMapBut.RegistrationEvent(true)
					MiniMapBut:SetSize(ButW,ButW);
					if PIG_MaxTocversion(120000,true) then
						MiniMapBut.icon:SetSize(ButW-10,ButW-10);
					else
						MiniMapBut.icon:SetSize(ButW-13,ButW-13);
					end
					MiniMapBut.icon:SetDrawLayer("BACKGROUND",1)
					MiniMapBut.Border:SetDrawLayer("BORDER",1)
					MiniMapBut.Border:SetTexture("Interface/Minimap/MiniMap-TrackingBorder");
					MiniMapBut.Border:SetSize(56,56);
					MiniMapBut.Border:ClearAllPoints();	
					if PIG_MaxTocversion(120000,true) then
						MiniMapBut.Border:SetPoint("TOPLEFT", -2, 1);
					else
						MiniMapBut.Border:SetPoint("TOPLEFT", -1, 0);
					end
					MiniMapBut.Border:Show()
					if PIG_MaxTocversion() then
						MiniMapBut.pianyi = 56
					else
						MiniMapBut.pianyi = 82
					end
				end
			elseif mode == 3 then--自由
				MiniMapBut.RegistrationEvent(true)
				MiniMapBut.Border:Hide()
				MiniMapBut:SetSize(ButW,ButW);
				if Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") then
					MiniMapBut.icon:SetSize(ButW,ButW);
				elseif Fun.IsElvUI() then
					MiniMapBut.icon:SetSize(ButW,ButW);
				else
					MiniMapBut.icon:SetSize(ButW-10,ButW-10);
				end
			end
			YDButtonP(mode);
		elseif mode == 2 then--聊天框
			MiniMapBut.icon:SetDrawLayer("ARTWORK",1)
			MiniMapBut.Border:Hide()
			MiniMapBut:ClearAllPoints();
			if Fun.IsNDui() and not Fun.IsNDui("Map","DisableMinimap") then
				MiniMapBut:SetSize(ButW-11,ButW-11);
				MiniMapBut.icon:SetSize(ButW-11,ButW-11);
				MiniMapBut:SetPoint("TOP",ChatFrameChannelButton,"BOTTOM",0,-2);
			elseif Fun.IsElvUI() then
				MiniMapBut:SetSize(ButW-14,ButW-14);
				MiniMapBut.icon:SetSize(ButW-14,ButW-14);
				MiniMapBut:SetPoint("RIGHT",ChatFrameChannelButton,"LEFT",0,0);
			else
				MiniMapBut:SetSize(ButW-6,ButW-4);
				MiniMapBut.icon:SetSize(ButW-16,ButW-16);
				local pbutxx=FriendsMicroButton or ChatFrameChannelButton
				MiniMapBut:SetPoint("BOTTOM",pbutxx,"TOP",0,2);
				MiniMapBut:SetNormalAtlas("chatframe-button-up")
				MiniMapBut:SetPushedAtlas("chatframe-button-down")
			end
		end
		MiniMapBut.Box:UpdateMiniMapButBox_3(mode,xpos,ypos)
	end
	Mapfun.UpdateMiniButPoint()
	PD.MiniMapBut_Collect()
end

--收纳功能
local ExcludeButlist = {
	"MiniMapTrackingFrame",
	"MiniMapMeetingStoneFrame",
	"MiniMapMailFrame",
	"MiniMapBattlefieldFrame",
	"MiniMapWorldMapButton",
	"MiniMapPing",
	"MinimapBackdrop",
	"MinimapZoomIn",
	"MinimapZoomOut",
	"LFGMinimapFrame",
	"BookOfTracksFrame",
	"GatherNote",
	"FishingExtravaganzaMini",
	"MiniNotePOI",
	"RecipeRadarMinimapIcon",
	"FWGMinimapPOI",
	"CartographerNotesPOI",
	"MBB_MinimapButtonFrame",
	"EnhancedFrameMinimapButton",
	"GFW_TrackMenuFrame",
	"GFW_TrackMenuButton",
	"TDial_TrackingIcon",
	"TDial_TrackButton",
	"MiniMapTracking",
	"GatherMatePin",
	"HandyNotesPin",
	"TimeManagerClockButton",
	"GameTimeFrame",
	"DA_Minimap",
	"ElvConfigToggle",
	"MiniMapInstanceDifficulty",
	"MinimapZoneTextButton",
	"GuildInstanceDifficulty",
	"MiniMapVoiceChatFrame",
	"MiniMapRecordingButton",
	"QueueStatusMinimapButton",
	"GatherArchNote",
	"ZGVMarker",
	"QuestPointerPOI",
	"poiMinimap",
	"MiniMapLFGFrame",
	"PremadeFilter_MinimapButton",
	"QuestieFrame",
	"Guidelime",
	"MiniMapBattlefieldFrame",
	"MinimapLayerFrame",
	"NWBNaxxMarkerMini",
	"NWBMini",
	"SexyMapCustomBackdrop",
	"SexyMapCoordFrame",
	"SexyMapPingFrame",
	"SexyMapZoneTextButton",
	"QueueStatusButton",
	"MinimapPanel",
	"RecycleBinToggleButton",
	"BFGPSButton",
	--"LibDBIcon10_HandyNotes_NPCs",
	"ElvUI_MinimapHolder",
	"ElvUI_MinimapClickHandler",
	"NDuiMinimapDifficulty",
	--"EA_MinimapOption",--EventAlertMod
	--"LibDBIcon10_DetailsStreamer",
}
for i=1,10 do
	table.insert(ExcludeButlist,"GatherLite"..i)
end
for i=1,10 do
	table.insert(ExcludeButlist,"Spy_MapNoteList_mini"..i)
end
Mapfun.MiniBoxList={};
Mapfun.MiniBoxList_Show={};
local function IsNoExclude(uiname)
	for x=1,#ExcludeButlist do
		if uiname:match(ExcludeButlist[x]) then
			return false;
		end
	end
	return true
end
local function IsNoDIYExclude(uiname)
	local datax = PIGA["Map"]["MinimapBpaichu"]
	for x=1,#datax do
		if uiname:match(datax[x]) then
			return true;
		end
	end
	return false
end
Mapfun.IsNoDIYExclude=IsNoDIYExclude
local function InsertButToBox(data,uiname,butx)
	local Point1,Point3,Point4,Point5 = PIGGetPoint(butx)
	for x=1,#data do
		if uiname==data[x][1] then
			if Point1 then
				data[x][2],data[x][3],data[x][4],data[x][5]=Point1,Point3,Point4,Point5
				return
			end
		end
	end
	if Point1 then
		table.insert(data,{uiname,Point1,Point3,Point4,Point5})
	end
end
local function UpdateCollectBut(set)
	if not PIGA["Map"]["MinimapBut"] then return end
	if not Mapfun.MiniMapBut then return end
	local MiniMapBut=Mapfun.MiniMapBut
	if RecycleBinToggleButton then--如果玩家NDui收纳功能启用
		MiniMapBut.Box.tishi:SetText("|cffFF0000NDui收纳功能启用,已禁用"..addonName.."收纳功能|r")
		MiniMapBut.Box.tishi:Show();
		return 
	end
	if PIGA["Error"]["ErrorTishi"] then
		table.insert(ExcludeButlist,"LibDBIcon10_BugSack")
	end
	if PIGA["Map"]["MiniButShouNa_YN"]==2 then
		for i=1,#Mapfun.MiniBoxList do
			local buxxx=_G[Mapfun.MiniBoxList[i][1]]
			buxxx:SetParent(Minimap)
			buxxx:ClearAllPoints();
			buxxx:SetPoint(Mapfun.MiniBoxList[i][2], Minimap, Mapfun.MiniBoxList[i][3], Mapfun.MiniBoxList[i][4], Mapfun.MiniBoxList[i][5])
		end
		return
	end
	local children = {Minimap:GetChildren()};
	for i=1,#children do
		local uiname = children[i]:GetName()
		if uiname and _G[uiname] then
			if IsNoExclude(uiname) then
				InsertButToBox(Mapfun.MiniBoxList,uiname,children[i])
			end
		end
	end
	Mapfun.MiniBoxList_Show={}
	local paichudata = PIGA["Map"]["MinimapBpaichu"]
	for i=1,#Mapfun.MiniBoxList do
		local buxxx=_G[Mapfun.MiniBoxList[i][1]]
		if IsNoDIYExclude(Mapfun.MiniBoxList[i][1]) then
			if set and buxxx then
				buxxx:SetParent(Minimap)
				buxxx:ClearAllPoints();
				buxxx:SetPoint(Mapfun.MiniBoxList[i][2], Minimap, Mapfun.MiniBoxList[i][3], Mapfun.MiniBoxList[i][4], Mapfun.MiniBoxList[i][5])
			end
		else
			buxxx:SetParent(MiniMapBut.Box)
			table.insert(Mapfun.MiniBoxList_Show,Mapfun.MiniBoxList[i][1])
		end
	end
	MiniMapBut.Box.tishi:Show();
	local meipaishu=PIGA["Map"]["MiniButShouNa_hang"];--每排按钮数
	local miniButNum=#Mapfun.MiniBoxList_Show
	if miniButNum>0 then
		MiniMapBut.Box.tishi:Hide()
		local hangshuV = math.ceil(miniButNum/meipaishu)
		MiniMapBut.Box:SetSize(meipaishu*(32+6)+6, hangshuV*(32+6)+6)
		for i=1,miniButNum do
			local buxxx=_G[Mapfun.MiniBoxList_Show[i]]
			buxxx:HookScript("OnEnter", function()
				MiniMapBut.Box.zhengzaixianshi = nil;
			end)
			buxxx:HookScript("OnLeave", function()
				MiniMapBut.Box.xiaoshidaojishi = 1.5;
				MiniMapBut.Box.zhengzaixianshi = true;
			end)
			-- buxxx:HookScript("PostClick", function ()
			-- 	MiniMapBut.Box:Hide();
			-- end);
			buxxx:ClearAllPoints();
			if i==1 then
				buxxx:SetPoint("TOPLEFT", MiniMapBut.Box, "TOPLEFT", 6, -6)
			else
				local tmp1,tmp2 = math.modf((i-1)/meipaishu)
				if tmp2==0 then
					buxxx:SetPoint("TOP", _G[Mapfun.MiniBoxList_Show[i-meipaishu]], "BOTTOM", 0, -6)
				else
					buxxx:SetPoint("LEFT", _G[Mapfun.MiniBoxList_Show[i-1]], "RIGHT", 6, 0)
				end
			end
			buxxx:Show()
		end
	end
end
Mapfun.UpdateCollectBut=UpdateCollectBut
function PD.MiniMapBut_Collect()
	C_Timer.After(0.6, UpdateCollectBut);
	C_Timer.After(1, UpdateCollectBut);
	C_Timer.After(6, UpdateCollectBut);
	C_Timer.After(14, UpdateCollectBut);
end