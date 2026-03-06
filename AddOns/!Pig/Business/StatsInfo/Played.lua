local addonName, addonTable = ...;
local L=addonTable.locale
local Create=addonTable.Create
local fmod=math.fmod
local gsub = _G.string.gsub
local PIGLine=Create.PIGLine
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGCheckbutton=Create.PIGCheckbutton
local PIGFontString=Create.PIGFontString
local PIGOptionsList_R=Create.PIGOptionsList_R
--------
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.Player(StatsInfo)
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsInfo.F,"角\n色",StatsInfo.butW,"Left")
	fujiF:HookScript("OnShow", function(self)
		self.add_uifun()
		fujiF.gengxin_List();
	end)
	---------
	local oldChatFrame_DisplayTimePlayed
	if ChatFrameUtil and ChatFrameUtil.DisplayTimePlayed then
		oldChatFrame_DisplayTimePlayed=ChatFrameUtil.DisplayTimePlayed
	else
		oldChatFrame_DisplayTimePlayed=ChatFrame_DisplayTimePlayed
	end
	local function SetBZFun(set)
		if set=="-" then
			if ChatFrameUtil and ChatFrameUtil.DisplayTimePlayed then
				ChatFrameUtil.DisplayTimePlayed=function() end
			else
				ChatFrame_DisplayTimePlayed=function() end
			end
		else
			if ChatFrameUtil and ChatFrameUtil.DisplayTimePlayed then
				ChatFrameUtil.DisplayTimePlayed=oldChatFrame_DisplayTimePlayed
			else
				ChatFrame_DisplayTimePlayed=oldChatFrame_DisplayTimePlayed
			end
		end
	end
	fujiF:RegisterEvent("PLAYER_ENTERING_WORLD");
	fujiF:RegisterEvent("TIME_PLAYED_MSG")
	fujiF:SetScript("OnEvent", function(self,event,totalTimePlayed, timePlayedThisLevel)
		if event=="PLAYER_ENTERING_WORLD" then
			C_Timer.After(6, function()
				SetBZFun("-")
				RequestTimePlayed()
			end)
		elseif event=="TIME_PLAYED_MSG" then
			PIGA["StatsInfo"]["Played"][StatsInfo.allname]={totalTimePlayed, timePlayedThisLevel}
			SetBZFun("+")
		end
	end)
	function fujiF.add_uifun()
		if fujiF.Player then return end
		local hang_Height,hang_NUM,UIWWW  = 24, 17,fujiF:GetWidth();
		fujiF.Player=PIGFrame(fujiF)
		fujiF.Player:SetPoint("TOPLEFT",fujiF,"TOPLEFT",2,-2);
		fujiF.Player:SetPoint("BOTTOMLEFT",fujiF,"BOTTOMLEFT",0,2);
		fujiF.Player:SetWidth(UIWWW-20)
		fujiF.Player.alltimeTXT = PIGFontString(fujiF.Player,{"TOPLEFT", fujiF.Player, "TOPLEFT", 10, -4})
		fujiF.Player.alltimeTXT:SetTextColor(0, 1, 0, 1);
		fujiF.Player.lineTOP = PIGLine(fujiF.Player,"TOP",-24,nil,nil,{0.3,0.3,0.3,0.8})
		fujiF.Player.Scroll = CreateFrame("ScrollFrame",nil,fujiF.Player, "FauxScrollFrameTemplate");  
		fujiF.Player.Scroll:SetPoint("TOPLEFT",fujiF.Player.lineTOP,"BOTTOMLEFT",2,-2);
		fujiF.Player.Scroll:SetPoint("BOTTOMRIGHT",fujiF.Player,"BOTTOMRIGHT",-2,2);
		fujiF.Player.Scroll:SetScale(0.8);
		fujiF.Player.Scroll:SetScript("OnVerticalScroll", function(self, offset)
		    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fujiF.gengxin_List)
		end)
		fujiF.Player.ButList={}
		for id = 1, hang_NUM, 1 do
			local hang = CreateFrame("Frame", nil, fujiF.Player);
			fujiF.Player.ButList[id]=hang
			hang:SetSize(fujiF.Player:GetWidth()-18,hang_Height+4);
			if id==1 then
				hang:SetPoint("TOPLEFT", fujiF.Player.Scroll, "TOPLEFT", 0, 0);
			else
				hang:SetPoint("TOPLEFT", fujiF.Player.ButList[id-1], "BOTTOMLEFT", 0, 0);
			end
			if id~=hang_NUM then
				hang.line = PIGLine(hang,"BOT",0,nil,nil,{0.3,0.3,0.3,0.6})
			end
			hang.Faction = hang:CreateTexture();
			hang.Faction:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
			hang.Faction:SetPoint("LEFT", hang, "LEFT", 0,0);
			hang.Faction:SetSize(hang_Height,hang_Height);
			hang.Race = hang:CreateTexture();
			hang.Race:SetPoint("LEFT", hang.Faction, "RIGHT", 1,0);
			hang.Race:SetSize(hang_Height,hang_Height);
			hang.Class = hang:CreateTexture();
			hang.Class:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
			hang.Class:SetPoint("LEFT", hang.Race, "RIGHT", 1,0);
			hang.Class:SetSize(hang_Height,hang_Height);
			hang.level = PIGFontString(hang,{"LEFT", hang.Class, "RIGHT", 2, 0},1)
			hang.level:SetTextColor(1,0.843,0, 1);
			hang.name = PIGFontString(hang,{"LEFT", hang.level, "RIGHT", 0, 0})
			hang.nameDQ = hang:CreateTexture();
			hang.nameDQ:SetTexture("interface/common/indicator-green.blp")
			hang.nameDQ:SetPoint("LEFT", hang.name, "RIGHT", 1,0);
			hang.nameDQ:SetSize(hang_Height-2,hang_Height-2);
			hang.barWWW =PIGFrame(hang,{"LEFT", hang, "LEFT", 330,0},{10,hang_Height-4})
			hang.barWWW.no = PIGFontString(hang.barWWW,{"LEFT", 5, 0},nil,"OUTLINE")
			hang.GetTime = PIGButton(hang,{"RIGHT", hang.barWWW, "LEFT", -6,0},{40,hang_Height-4},UPDATE);
			hang.GetTime:SetScript("OnClick", function (self)
				RequestTimePlayed()
			end);
		end
		local maxwwww=500
		function fujiF.gengxin_List()
			if not fujiF:IsVisible() then return end
			for id = 1, hang_NUM, 1 do
				local hang = fujiF.Player.ButList[id]
				hang:Hide();
				hang.barWWW:SetWidth(40)
				hang.nameDQ:Hide()
				hang.GetTime:Hide()
			end
			local cdmulu={};
			local PlayerData = PIGA["StatsInfo"]["Players"]
			local PlayerSH = PIGA["StatsInfo"]["PlayerSH"]
			local PlayedData = PIGA["StatsInfo"]["Played"]
	   		for pname,_ in pairs(PlayerData) do
	   			if not PlayerSH[pname] then
	   				local totalTimePlayed, timePlayedThisLevel=PlayedData[pname] and PlayedData[pname][1],PlayedData[pname] and PlayedData[pname][2]
			   		if pname==StatsInfo.allname then
			   			table.insert(cdmulu,{pname,PlayerData[pname],totalTimePlayed, timePlayedThisLevel,true})
			   		else
			   			table.insert(cdmulu,{pname,PlayerData[pname],totalTimePlayed, timePlayedThisLevel})
			   		end
			   	end
		   	end
		   	--
		   	local datanum=#cdmulu
		   	if datanum==0 then return end
		   	table.sort(cdmulu, function(a, b)
			    local timeA = a[3] or 0
			    local timeB = b[3] or 0
			    return timeA > timeB
			end)
			local jishuchuB,alltimenum=cdmulu[1][3],0
		    FauxScrollFrame_Update(fujiF.Player.Scroll, datanum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(fujiF.Player.Scroll);
		    for id = 1, hang_NUM do
				local dangqian = id+offset;
				if cdmulu[dangqian] then
					local hang = fujiF.Player.ButList[id]
					hang:Show();
					hang.allname=cdmulu[dangqian][1]
					hang.name:SetText(cdmulu[dangqian][1]);
					if cdmulu[dangqian][2][1]=="Alliance" then
						hang.Faction:SetTexCoord(0,0.5,0,1);
					elseif cdmulu[dangqian][2][1]=="Horde" then
						hang.Faction:SetTexCoord(0.5,1,0,1);
					end
					hang.Race:SetAtlas(cdmulu[dangqian][2][3]);
					local className, classFile, classID = PIGGetClassInfo(cdmulu[dangqian][2][4])
					hang.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
					hang.level:SetText("("..cdmulu[dangqian][2][5]..")");
					local color = PIG_CLASS_COLORS[classFile];
					hang.name:SetTextColor(color.r, color.g, color.b, 1);
					if cdmulu[dangqian][5] then
						hang.nameDQ:Show()
						if PIGA["StatsInfo"]["PlayedAutoTime"] then hang.GetTime:Show() end
					end
					if cdmulu[dangqian][3] then
						alltimenum=alltimenum+cdmulu[dangqian][3]
						if cdmulu[dangqian][3]/jishuchuB*maxwwww>40 then
							hang.barWWW:SetWidth(cdmulu[dangqian][3]/jishuchuB*maxwwww)
						end
						local d, h, m, s = ChatFrame_TimeBreakDown(cdmulu[dangqian][3]);
						hang.barWWW.no:SetText(GAME..TIME_LABEL.." "..format(TIME_DAYHOURMINUTESECOND, d, h, m, s))
						hang.barWWW.no:SetTextColor(0.8, 0.8, 0.8, 1);
						hang.barWWW:PIGSetBackdrop(1,1,{0.4, 0.8, 0.8})
					else
						hang.barWWW.no:SetText(UNKNOWN)
						hang.barWWW.no:SetTextColor(0.5, 0.5, 0.5, 1);
						hang.barWWW:PIGSetBackdrop(1,1,{0.2, 0.2, 0.2})
					end
				end
			end
			local d, h, m, s = ChatFrame_TimeBreakDown(alltimenum);
			fujiF.Player.alltimeTXT:SetText(format(TIME_PLAYED_TOTAL, format(TIME_DAYHOURMINUTESECOND, d, h, m, s)))
		end
	end
end
