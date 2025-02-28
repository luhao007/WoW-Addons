local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local L=addonTable.locale
local Fun=addonTable.Fun
local Create=addonTable.Create
local PIGLine=Create.PIGLine
local PIGFrame=Create.PIGFrame
local PIGFontString=Create.PIGFontString
local PIGOptionsList_R=Create.PIGOptionsList_R
--------
local match = _G.string.match
local Data=addonTable.Data
local BusinessInfo=addonTable.BusinessInfo
local disp_time=Fun.disp_time
local GetContainerNumSlots =GetContainerNumSlots or C_Container and C_Container.GetContainerNumSlots
local GetContainerItemID=GetContainerItemID or C_Container and C_Container.GetContainerItemID
local GetSpellInfo=GetSpellInfo or C_Spell and C_Spell.GetSpellInfo
local GetItemNameByID=GetItemNameByID or C_Item and C_Item.GetItemNameByID
---
function BusinessInfo.SkillCD()
	local StatsInfo = StatsInfo_UI
	PIGA["StatsInfo"]["SkillData"][StatsInfo.allname]=PIGA["StatsInfo"]["SkillData"][StatsInfo.allname] or {}
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsInfo.F,"专\n业",StatsInfo.butW,"Left")
	---
	local playerSkill={}
	local Skill_Learned={}
	local Spell_ItemID={
		[18560]=14342,
		[11480]=20761,
		[19566]=15846,

		[56005]=41600,
		[56002]=41593,
		[56001]=41594,
		[56003]=41595,
		[60893]=38351,
		[32766]=20761,
		[66663]=20761,
		
	}
	local IsItemID={[19566]=15846}
	local Skill_list = {
	    [1] = {IsCD = {}, spellid = 2018, icon = 136241}, -- 锻造
	    [2] = {IsCD = {}, spellid = 2108, icon = 133611}, -- 制皮
	    [3] = {IsCD = {}, spellid = 2259, icon = 136240}, -- 炼金术
	    [4] = {IsCD = {}, spellid = 2575, icon = 136248}, -- 采矿
	    [5] = {IsCD = {}, spellid = 3908, icon = 136249}, -- 裁缝
	    [6] = {IsCD = {}, spellid = 4036, icon = 136243}, -- 工程学
	    [7] = {IsCD = {}, spellid = 7411, icon = 136244}, -- 附魔
	    [8] = {IsCD = {}, spellid = 8613, icon = 134366}, -- 剥皮
	    [9] = {IsCD = {}, spellid = 13614, icon = 136246}, -- 草药学
	    [10] = {IsCD = {}, spellid = 25229, icon = 134071}, -- 珠宝加工
	    [11] = {IsCD = {}, spellid = 45357, icon = 237171}, -- 铭文
	}
	-- {13399,133651,11020},--培植种子
	-- {21935,135863,17716},--雪王9000型
	-- {26265,134249,21540},--制造艾露恩之石
	if tocversion<20000 then
		table.insert(Skill_list[5].IsCD,18560)
		table.insert(Skill_list[3].IsCD,{11480,11479,17187,17559,17560,17561,17562,17563,17564,17565,17566,25146})
		table.insert(Skill_list[2].IsCD,19566)
	elseif tocversion<30000 then
		table.insert(Skill_list[5].IsCD,26751)
		table.insert(Skill_list[5].IsCD,31373)
		table.insert(Skill_list[5].IsCD,36686)
		table.insert(Skill_list[3].IsCD,{32766,32765,29688,28566,28567,28568,28569,28580,28581,28582,28583,28584,28585})
		table.insert(Skill_list[10].IsCD,47280)
		table.insert(Skill_list[2].IsCD,19566)
	elseif tocversion<40000 then
		table.insert(Skill_list[5].IsCD,56005)
		table.insert(Skill_list[5].IsCD,56002)
		table.insert(Skill_list[5].IsCD,56001)
		table.insert(Skill_list[5].IsCD,56003)
		table.insert(Skill_list[3].IsCD,60893)
		table.insert(Skill_list[3].IsCD,{66663,66662,66658,66664,53774,53775,53776,53781,53777,53782,53773,53771,53779,53780,53783,53784})
		table.insert(Skill_list[10].IsCD,47280)
		table.insert(Skill_list[10].IsCD,62242)
		table.insert(Skill_list[11].IsCD,61177)
		table.insert(Skill_list[4].IsCD,55208)
		table.insert(Skill_list[2].IsCD,19566)
	else
	end
	for k,v in pairs(Skill_list) do
		local Skillname=PIGGetSpellInfo(v.spellid)
		v.name=Skillname
	end
	local function GetSkillItemID(ItemName)
		for i=1,#Skill_list do
			for ix=1,#Skill_list[i].IsCD do
				if type(Skill_list[i].IsCD[ix])=="table" then
				else
					if Spell_ItemID[Skill_list[i].IsCD[ix]] then
						if ItemName==GetItemNameByID(Spell_ItemID[Skill_list[i].IsCD[ix]]) then
							return Skill_list[i].IsCD[ix]
						end
					end
				end
			end
		end
		return false
	end
	local function GetBagItemID(ItemID)
		for Bagid=0,NUM_BAG_SLOTS,1 do
			local numberOfSlots = GetContainerNumSlots(Bagid);
			for Slots=1,numberOfSlots,1 do
				if GetContainerItemID(Bagid, Slots)==ItemID then
					return true
				end
			end
		end
		return false
	end
	local function GetSkillIndex_1(name)
		if name then
			for i=1,#Skill_list do
				if Skill_list[i].name==name then
					return i
				end
			end
		end
		return 0
	end
	local function GetSkillIndex(Learned)
		table.clear(playerSkill)
		playerSkill[0]={}
		for i=1,2 do
			local SkillId=GetSkillIndex_1(Learned[i])
			if SkillId>0 then
				playerSkill[i]={SkillId,Skill_list[SkillId].IsCD}
			else
				playerSkill[i]={SkillId,{}}
			end
		end
		for i=1,2 do
			if #playerSkill[i][2]>0 then
				for ix=1,#playerSkill[i][2] do
					if PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0] and PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0][playerSkill[i][2][ix]] then
						playerSkill[0][playerSkill[i][2][ix]]=PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0][playerSkill[i][2][ix]]
					end
				end
			end
		end
		PIGA["StatsInfo"]["SkillData"][StatsInfo.allname]=playerSkill
	end
	----
	local hang_Height,hang_NUM,numButtons  = 19.4, 11, 6;
	fujiF.Skill=PIGFrame(fujiF)
	fujiF.Skill:SetPoint("TOPLEFT",fujiF,"TOPLEFT",4,-32);
	fujiF.Skill:SetPoint("BOTTOMRIGHT",fujiF,"BOTTOMRIGHT",-4,4);
	fujiF.Skill:PIGSetBackdrop(0)
	fujiF.Skill.Scroll = CreateFrame("ScrollFrame",nil,fujiF.Skill, "FauxScrollFrameTemplate");  
	fujiF.Skill.Scroll:SetPoint("TOPLEFT",fujiF.Skill,"TOPLEFT",2,0);
	fujiF.Skill.Scroll:SetPoint("BOTTOMRIGHT",fujiF.Skill,"BOTTOMRIGHT",-20,2);
	fujiF.Skill.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fujiF.Skill.Update_List)
	end)
	fujiF.Skill.listbut={}
	for id = 1, hang_NUM, 1 do
		local hang = CreateFrame("Frame", nil, fujiF.Skill);
		fujiF.Skill.listbut[id]=hang
		hang:SetSize(fujiF.Skill:GetWidth()-18,hang_Height*2+4);
		if id==1 then
			hang:SetPoint("TOPLEFT", fujiF.Skill.Scroll, "TOPLEFT", 0, 0);
		else
			hang:SetPoint("TOPLEFT", fujiF.Skill.listbut[id-1], "BOTTOMLEFT", 0, 0);
		end
		if id~=hang_NUM then
			hang.line = PIGLine(hang,"BOT",0,nil,nil,{0.5,0.5,0.5,0.2})
		end
		hang.Faction = hang:CreateTexture();
		hang.Faction:SetTexture("interface/glues/charactercreate/ui-charactercreate-factions.blp");
		hang.Faction:SetPoint("TOPLEFT", hang, "TOPLEFT", 0,-2);
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
		hang.nameDQ = hang:CreateTexture();
		hang.nameDQ:SetTexture("interface/common/indicator-green.blp")
		hang.nameDQ:SetPoint("LEFT", hang.level, "RIGHT", 1,0);
		hang.nameDQ:SetSize(hang_Height,hang_Height);
		hang.name = PIGFontString(hang,{"TOPLEFT", hang.Faction, "BOTTOMLEFT", 0, -2})
		hang.SkillBut={}
		for ixx=1,2 do
			local hangSkill = CreateFrame("Frame", nil, hang);
			hang.SkillBut[ixx]=hangSkill
			if ixx==1 then
				hangSkill:SetPoint("TOPLEFT", hang, "TOPLEFT", 180,-1.6);
			else
				hangSkill:SetPoint("TOPLEFT", hang.SkillBut[ixx-1], "BOTTOMLEFT", 0, -1);
			end
			hangSkill:SetSize(hang_Height,hang_Height);
			hangSkill.icon = hangSkill:CreateTexture();
			hangSkill.icon:SetPoint("LEFT", hangSkill, "LEFT", 0,0);
			hangSkill.icon:SetSize(hang_Height,hang_Height);
			hangSkill.name = PIGFontString(hangSkill,{"LEFT",hangSkill.icon, "RIGHT", 0, 0})
		end
		hang.TimeCDBut={}
		for butID=1,numButtons do
			hang.TimeCDBut[butID]={}
			local CDbut = hang:CreateTexture();
			hang.TimeCDBut[butID].icon=CDbut
			CDbut:SetPoint("TOPLEFT", hang, "TOPLEFT", (butID-1)*128+260,-3);
			CDbut:SetSize(hang_Height,hang_Height);
			CDbut:SetTexture(134400);
			hang.TimeCDBut[butID].name=PIGFontString(hang,{"LEFT",CDbut, "RIGHT", 0, 0})
			hang.TimeCDBut[butID].cd = PIGFontString(hang,{"TOPLEFT",CDbut, "BOTTOMLEFT", 0, -2})
		end
		function hang.SetSkillIconName(dataT)
			for ixx=1,2 do
				local hangSkill=hang.SkillBut[ixx]
				hangSkill.icon:SetTexture(134400);
				hangSkill.name:SetText("|cffa4a4a4"..UNKNOWN.."|r");
			end
			for butID=1,numButtons do
				local CDbut=hang.TimeCDBut[butID]
				CDbut.icon:Hide()
				CDbut.name:SetText("");
				CDbut.cd:SetText("");
			end
			if dataT then
				local NewCDdata = {}
				for ixx=1,2 do
					if dataT[ixx] then
						local hangSkill=hang.SkillBut[ixx]
						if dataT[ixx][1]>0 then
							hangSkill.icon:SetTexture(Skill_list[dataT[ixx][1]].icon);
							hangSkill.name:SetText(Skill_list[dataT[ixx][1]].name);
							for cdid=1,#dataT[ixx][2] do
								table.insert(NewCDdata,dataT[ixx][2][cdid])
							end
						else
							hangSkill.icon:SetTexture(130775);
							hangSkill.icon:SetDesaturated(true)
							hangSkill.name:SetText("|cffa4a4a4"..TRADE_SKILLS_UNLEARNED_TAB.."|r");
						end
					end
				end
				for butID=1,numButtons do
					local SpellID=NewCDdata[butID]
					if SpellID then
						local CDdataX=dataT[0] or {}
						local CDbut=hang.TimeCDBut[butID]
						if type(SpellID)=="table" then
							SpellID=SpellID[1]
						end
						local Skillname,iconid=PIGGetSpellInfo(SpellID)
						if Skillname:match("转化") then Skillname="转化" end
						CDbut.icon:Show()
						if Spell_ItemID[SpellID] then
							CDbut.icon:SetTexture(C_Item.GetItemIconByID(Spell_ItemID[SpellID]));
						else
							CDbut.icon:SetTexture(134400);
						end
						if CDdataX[SpellID] then
							CDbut.icon:SetDesaturated(false)
							CDbut.name:SetText(Skillname);
							if CDdataX[SpellID] then
								if GetServerTime()>=CDdataX[SpellID] then
									CDbut.cd:SetText("|cff00ff00已就绪|r");
								else
									CDbut.cd:SetText(disp_time(CDdataX[SpellID]-GetServerTime()));
								end
							else
								CDbut.cd:SetText("|cffff0000CD"..UNKNOWN.."|r");
							end
						else
							CDbut.icon:SetDesaturated(true)
							CDbut.name:SetText("|cffa4a4a4"..Skillname.."|r");
							CDbut.cd:SetText("|cffa4a4a4N/A|r");
						end
						SpellID=nil
						Skillname=nil	
					end
				end
			end
		end
	end
	fujiF.Skill:HookScript("OnShow", function(self)
		self.Update_List();
	end)
	function fujiF.Skill.Update_List()
		if not fujiF:IsVisible() then return end
		local self=fujiF.Skill.Scroll
		for id = 1, hang_NUM, 1 do
			local fujik = fujiF.Skill.listbut[id]
			fujik:Hide();
			fujik.nameDQ:Hide()
		end
		local cdmulu={};
		local PlayerData = PIGA["StatsInfo"]["Players"]
		local PlayerSH = PIGA["StatsInfo"]["PlayerSH"]
		local SkillData=PIGA["StatsInfo"]["SkillData"]
		if PlayerData[StatsInfo.allname] and not PlayerSH[StatsInfo.allname] then
			local dangqianC=PlayerData[StatsInfo.allname]
			table.insert(cdmulu,{StatsInfo.allname,dangqianC[1],dangqianC[2],dangqianC[3],dangqianC[4],dangqianC[5],SkillData[StatsInfo.allname],true})
		end
	   	for k,v in pairs(PlayerData) do
	   		if k~=StatsInfo.allname and PlayerData[k] and not PlayerSH[k] then
	   			table.insert(cdmulu,{k,v[1],v[2],v[3],v[4],v[5],SkillData[k]})
	   		end
	   	end
		local ItemsNum = #cdmulu;
		if ItemsNum>0 then
		    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
		    local offset = FauxScrollFrame_GetOffset(self);
		    for id = 1, hang_NUM do
				local dangqian = id+offset;
				if cdmulu[dangqian] then
					local fujik = fujiF.Skill.listbut[id]
					fujik:Show();
					if cdmulu[dangqian][2]=="Alliance" then
						fujik.Faction:SetTexCoord(0,0.5,0,1);
					elseif cdmulu[dangqian][2]=="Horde" then
						fujik.Faction:SetTexCoord(0.5,1,0,1);
					end
					fujik.Race:SetAtlas(cdmulu[dangqian][4]);
					local className, classFile, classID = PIGGetClassInfo(cdmulu[dangqian][5])
					fujik.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
					fujik.level:SetText(cdmulu[dangqian][6]);
					if cdmulu[dangqian][8] then
						fujik.nameDQ:Show()
					end
					fujik.name:SetText(cdmulu[dangqian][1]);
					local color = PIG_CLASS_COLORS[classFile];
					fujik.name:SetTextColor(color.r, color.g, color.b, 1);
					fujik.SetSkillIconName(cdmulu[dangqian][7])
				end
			end
		end
	end
	fujiF:RegisterEvent("PLAYER_ENTERING_WORLD")
	fujiF:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player"); 
	if tocversion<40000 then         
		fujiF:RegisterEvent("TRADE_SKILL_UPDATE")
	else
		fujiF:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
	end
	fujiF.CDspellID={}
	fujiF:SetScript("OnEvent", function(self,event,arg1,_,arg3)
		if event=="PLAYER_ENTERING_WORLD" then
			table.clear(Skill_Learned)
			if tocversion<40000 then
				for skillIndex = 1, GetNumSkillLines() do
					local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier,skillMaxRank, isAbandonable= GetSkillLineInfo(skillIndex)
					if isAbandonable then
						if not Skill_Learned[1] then
							Skill_Learned[1]=skillName
						elseif not Skill_Learned[2] then
							Skill_Learned[2]=skillName
							break
						end
					end
				end
			else
			end
			GetSkillIndex(Skill_Learned)
			table.clear(fujiF.CDspellID)
			for i=1,2 do
				if #playerSkill[i][2]>0 then
					for ix=1,#playerSkill[i][2] do
						if type(playerSkill[i][2][ix])=="table" then
							for ixx=1,#playerSkill[i][2][ix] do
								--if IsPlayerSpell(SpellID) or IsItemID[SpellID] and GetBagItemID(IsItemID[SpellID]) then
								table.insert(fujiF.CDspellID,playerSkill[i][2][ix][ixx])
							end
						else
							table.insert(fujiF.CDspellID,playerSkill[i][2][ix])
						end
					end
				end
			end
		elseif event=="TRADE_SKILL_UPDATE" or event=="TRADE_SKILL_LIST_UPDATE" then
			C_Timer.After(0.4,function()
				if tocversion<40000 then
					for j=1,GetNumTradeSkills() do
						local Skillname,skillType= GetTradeSkillInfo(j);
						if skillType~= "header" then
							local SpellID= GetSkillItemID(Skillname)
							if SpellID then
								local Cooldown = GetTradeSkillCooldown(j);
								if Cooldown then
									PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0][SpellID]=Cooldown+GetServerTime()
								else
									PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0][SpellID]=GetServerTime()
								end
							end
						end
					end
				else
					-- local prof1, prof2, archaeology, fishing, cooking = GetProfessions()
					-- local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof1)
					-- --print(name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset)
					-- for _, id in pairs(C_TradeSkillUI.GetAllRecipeIDs()) do
					-- 	local recipeInfo = C_TradeSkillUI.GetRecipeInfo(id)
					-- 	for k,v in pairs(recipeInfo) do
					-- 		print(k,v)
					-- 	end
					-- 	--print(recipeInfo.recipeID, recipeInfo.name)
					-- end
				end
			end)
		elseif event=="UNIT_SPELLCAST_SUCCEEDED" then
			C_Timer.After(0.4,function()
				for ix=1,#fujiF.CDspellID do
					if arg3==fujiF.CDspellID[ix] then
						local start, duration = PIGGetSpellCooldown(arg3);
						print(fujiF.CDspellID[ix], duration)
						PIGA["StatsInfo"]["SkillData"][StatsInfo.allname][0][arg3]=GetServerTime()+duration
						return
					end
				end
			end)
		end
	end)
end
