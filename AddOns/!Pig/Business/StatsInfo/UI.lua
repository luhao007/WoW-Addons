local addonName, PD = ...;
local BusinessInfo=PD.BusinessInfo
--=========================
function BusinessInfo.StatsInfo_ADDUI()
	if not PIGA["StatsInfo"]["Open"] then return end
	if _G[GnUI] then return end
	local L=PD.locale
	local Data=PD.Data
	local PlayerInfo=Data.PlayerInfo
	local Fun=PD.Fun
	local PIGGetRaceAtlas=Fun.PIGGetRaceAtlas
	local PlayerInfo=PD.Data.PlayerInfo
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGDiyBut=Create.PIGDiyBut
	local PIGFontString=Create.PIGFontString
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.StatsInfoData)
	local Width,Height,biaotiH  = 860, 540, 21;
	--
	Create.PIGModbutton(GnName,GnIcon,GnUI,FrameLevel)
	local StatsUI=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,60},{Width,Height},GnUI,true)
	StatsUI:PIGSetBackdrop()
	StatsUI:PIGClose()
	StatsUI:PIGSetMovableNoSave()
	StatsUI.butW=46
	StatsUI.hang_Height=19
	BusinessInfo.StatsUI=StatsUI
	StatsUI.setbut=PIGDiyBut(StatsUI,{"TOPRIGHT",StatsUI,"TOPRIGHT",-50,-1},{20,nil,nil,nil,132054})
	StatsUI.setbut:HookScript("OnClick", function (self)
		PD.UpdateOptionsUI()
		Create.Show_TabBut(BusinessInfo.fuFrame,BusinessInfo.fuFrameBut)
		Create.Show_TabBut_R(BusinessInfo.RTabFrame,BusinessInfo.Tab2_F,BusinessInfo.Tab2_But)
	end);
	StatsUI.title = PIGFontString(StatsUI,{"TOP", StatsUI, "TOP", 0, -3},GnName)
	StatsUI.F=PIGOptionsList_RF(StatsUI,biaotiH,"Left")
	--
	StatsUI:RegisterEvent("PLAYER_LEVEL_UP");
	StatsUI:HookScript("OnEvent",function (self, event)
		if event=="PLAYER_LEVEL_UP" then
			PIGA["StatsInfo"]["Players"][self.allname][5]=UnitLevel("player") or 1
		end
	end)
	--
	StatsUI.allname = PlayerInfo.AllName
	local race_icon = PIGGetRaceAtlas(PlayerInfo.RaceData.raceFile,PlayerInfo.gender)
	local level = UnitLevel("player")
	PIGA["StatsInfo"]["Players"][StatsUI.allname]={PlayerInfo.englishFaction,PlayerInfo.RaceData.raceId,race_icon,PlayerInfo.ClassData.classId,level}
	--任务目录左侧
	function BusinessInfo.addhangMode1(ly,LF)
		local Parent=LF:GetParent()
		local hang_NUM  = hang_NUM or 14
		local hang_Height = StatsUI.hang_Height-3
		local ScrollF = Create.PIGScrollFrame(LF,hang_Height*2+4)
		function ScrollF.Update_Hang(hangL, elementData)
			if not hangL.highlight then
				hangL.highlight = hangL:CreateTexture(nil,"HIGHLIGHT");
				hangL.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
				hangL.highlight:SetBlendMode("ADD")
				hangL.highlight:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,-1);
				hangL.highlight:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,1);
				hangL.highlight:SetAlpha(0.3);
				hangL.highlight1 = hangL:CreateTexture();
				hangL.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
				hangL.highlight1:SetDrawLayer("BORDER", -1)
				hangL.highlight1:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,-1);
				hangL.highlight1:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,1);
				hangL.highlight1:SetAlpha(0.8);
				hangL.highlight1:Hide();
				hangL.Faction = hangL:CreateTexture();
				hangL.Faction:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
				hangL.Faction:SetPoint("TOPLEFT", hangL, "TOPLEFT", 3,-2);
				hangL.Faction:SetSize(hang_Height,hang_Height);
				hangL.Race = hangL:CreateTexture();
				hangL.Race:SetPoint("LEFT", hangL.Faction, "RIGHT", 1,0);
				hangL.Race:SetSize(hang_Height,hang_Height);
				hangL.Class = hangL:CreateTexture();
				hangL.Class:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
				hangL.Class:SetPoint("LEFT", hangL.Race, "RIGHT", 1,0);
				hangL.Class:SetSize(hang_Height,hang_Height);
				hangL.level = PIGFontString(hangL,{"LEFT", hangL.Class, "RIGHT", 2, 0},1,"OUTLINE")
				hangL.level:SetTextColor(1,0.843,0, 1);
				hangL.nameDQ = hangL:CreateTexture();
				hangL.nameDQ:SetTexture("interface/common/indicator-green.blp")
				hangL.nameDQ:SetPoint("LEFT", hangL.level, "RIGHT", 1,0);
				hangL.nameDQ:SetSize(hang_Height+2,hang_Height+2);
				if ly~="trade" then
					hangL.guanchaC = CreateFrame("Button",nil, hangL);
					hangL.guanchaC:SetSize(hang_Height,hang_Height);
					hangL.guanchaC:SetPoint("TOPRIGHT", hangL, "TOPRIGHT", -15,-2);
					hangL.guanchaC:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
					hangL.guanchaC.tex = hangL.guanchaC:CreateTexture();
					hangL.guanchaC.tex:SetTexture(133122)
					hangL.guanchaC.tex:SetPoint("CENTER", hangL.guanchaC, "CENTER", 0,0);
					hangL.guanchaC.tex:SetSize(hang_Height,hang_Height);
					hangL.guanchaC:HookScript("OnMouseDown", function (self)
						self.tex:SetPoint("CENTER", hangL.guanchaC, "CENTER", 1.5,-1.5);
					end);
					hangL.guanchaC:HookScript("OnMouseUp", function (self)
						self.tex:SetPoint("CENTER", hangL.guanchaC, "CENTER", 0,0);
					end);
					hangL.guanchaC:SetScript("OnClick", function (self)
						PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
						Fun.lixian_chakan(hangL.allname,PIGA["StatsInfo"]["Players"][hangL.allname],PIGA["StatsInfo"]["Items"][hangL.allname])
					end)
				end
				hangL.name = PIGFontString(hangL,{"TOPLEFT", hangL.Faction, "BOTTOMLEFT", 0, -1},nil,"OUTLINE")
				hangL:SetScript("OnClick", function (self)
					PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
					Parent.SelectName=hangL.allname
					Parent:ClickUpdateList()
				end)
			end
			local idX=elementData.id
			local dataX=elementData.data
			hangL.highlight1:SetShown(Parent.SelectName==dataX[1])
			if dataX[2]=="Alliance" then
				hangL.Faction:SetTexCoord(0,0.5,0,1);
			elseif dataX[2]=="Horde" then
				hangL.Faction:SetTexCoord(0.5,1,0,1);
			end
			hangL.Race:SetAtlas(dataX[4]);
			local className, classFile, classID = PIGGetClassInfo(dataX[5])
			hangL.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
			hangL.level:SetText(dataX[6]);
			hangL.name:SetText(Fun.PruningServerName(dataX[1]));
			hangL.allname=dataX[1]
			local color = PIG_CLASS_COLORS[classFile];
			hangL.name:SetTextColor(color.r, color.g, color.b, 1);
			if hangL.guanchaC then hangL.guanchaC:SetShown(not dataX[7]) end
			hangL.nameDQ:SetShown(dataX[7])
		end
		function ScrollF:Update_list()
		    local view = self.ScrollBox:GetView()
		    if not self.dataProvider then
		        self.dataProvider = CreateDataProvider()
		        view:SetDataProvider(self.dataProvider)
			end
			self.dataProvider:Flush()
			local cdmulu={};
			local PlayerData = PIGA["StatsInfo"]["Players"]
			local PlayerSH = PIGA["StatsInfo"]["PlayerSH"]
			Parent.SelectName=Parent.SelectName or StatsUI.allname
		   	for k,v in pairs(PlayerData) do
		   		if PlayerData[k] and not PlayerSH[k] then
			   		if k==StatsUI.allname then
			   			table.insert(cdmulu,1,{k,v[1],v[2],v[3],v[4],v[5],true})
			   		else
			   			table.insert(cdmulu,{k,v[1],v[2],v[3],v[4],v[5]})
			   		end
			   	end
		   	end
			-- local SyncPlayers=Data.SyncData.StatsInfo.Players
			-- for k,v in pairs(SyncPlayers) do
			-- 	if not PlayerData[k] then
			-- 		print(k)
			-- 		table.insert(cdmulu,{k,v[1],v[2],v[3],v[4],v[5]})
		   	-- 	end
			-- end	
			local ItemsNum = #cdmulu;
		    for i = 1,#cdmulu,1 do
		        self.dataProvider:Insert({id=i,data=cdmulu[i]});
		    end
		end
		Parent:HookScript("OnShow", function(self)
			Parent:ClickUpdateList()
		end)
		return ScrollF
	end
	BusinessInfo.FBCD(StatsUI)
	BusinessInfo.SkillCD(StatsUI)
	BusinessInfo.Token(StatsUI)
	BusinessInfo.Item(StatsUI)
	BusinessInfo.Mail(StatsUI)
	BusinessInfo.Trade(StatsUI)
	BusinessInfo.AH(StatsUI)
	BusinessInfo.Time(StatsUI)
	BusinessInfo.Player(StatsUI)
	BusinessInfo.Admin(StatsUI)
end