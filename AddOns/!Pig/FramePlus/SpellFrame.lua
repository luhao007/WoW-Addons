local _, addonTable = ...;
local FramePlusfun=addonTable.FramePlusfun
----
local match = _G.string.match
local Data=addonTable.Data
local Fun = addonTable.Fun
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGDiyBut=Create.PIGDiyBut
local PIGFontString=Create.PIGFontString
---
local iconxx={"newplayerchat-chaticon-newcomer",294475}
iconxx[2] =PIG_MaxTocversion(30000) and PIG_MaxTocversion(20000,true) and "bags-greenarrow" or 294475
local function add_butF(id,gnname,tooltip,classFilename)
	local but = CreateFrame("CheckButton",nil, SpellBookFrame, "SpellBookSkillLineTabTemplate");
	but:SetNormalTexture(iconxx[id+1]);
	but.tooltip = gnname;
	if PIG_MaxTocversion(50000) then
		but:SetPoint("BOTTOMLEFT",SpellBookFrame,"BOTTOMRIGHT",-31,90+(id*50))
	else
		but:SetPoint("BOTTOMLEFT",SpellBookFrame,"BOTTOMRIGHT",0,70+(id*50))
	end
	if NDui or ElvUI then
		local regions = {but:GetRegions()}
		for k,v in pairs(regions) do
			v:SetTexCoord(0.1,0.9,0.1,0.9)
			if v:GetTexture()==136831 then v:Hide() end
		end
	end
	but:Show()
	local EextData={
		["ElvUI"]={true,{0,0,0,0}},
		["NDui"]={Fun.IsNDui("Skins","BlizzardSkins"),{0,0,0,0}},
	}
	local fui =PIGFrame(SpellBookFrame,{"TOPLEFT",SpellBookFrame,"TOPRIGHT",8,-14},nil,nil,nil,nil,EextData)
	fui:SetPoint("BOTTOMLEFT", SpellBookFrame, "BOTTOMRIGHT", 8, 74);
	if PIG_MaxTocversion(50000,true) then
		fui:SetPoint("TOPLEFT",SpellBookFrame,"TOPRIGHT",39,0);
		fui:SetPoint("BOTTOMLEFT", SpellBookFrame, "BOTTOMRIGHT", 39, 0);
	end
	fui:SetWidth(384)
	fui:PIGSetBackdrop()
	fui:Hide()
	fui:PIGClose()
	if id==1 then
		fui.biaotiT = PIGFontString(fui,{"TOPLEFT",fui,"TOPLEFT",26,-6},tooltip)
		fui.biaotiT1 = PIGFontString(fui,{"LEFT",fui.biaotiT,"RIGHT",2,0})
		fui.CZ = PIGDiyBut(fui,{"TOPLEFT", fui, "TOPLEFT", 6,-6},{18,nil,nil,nil,"common-icon-undo"})
		PIGEnter(fui.CZ,"如果显示异常，请点此重置未学技能数据")
		fui.CZ:SetScript("OnClick", function (self)
			wipe(PIGA["FramePlus"]["SpellData"][classFilename])
			PIG_OptionsUI:ErrorMsg("已重置未学技能数据")
			fui:UpdateShowList()
			fui:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		end);
	else
		fui.biaotiT = PIGFontString(fui,{"TOPLEFT",fui,"TOPLEFT",6,-6},tooltip)
	end
	fui.error = PIGFontString(fui,{"CENTER",fui,"CENTER",0,0})
	fui.butlist={}
	fui:SetScript("OnHide", function() but:SetChecked(false) if fui.hideui then fui.hideui() end end)
	fui:SetScript("OnShow", function() but:SetChecked(true) end)
	but:SetScript("OnClick", function (self)
		if fui:IsShown() then
			fui:Hide()
		else
			fui:Show()
		end
	end)
	return fui
end
local NoSpellList={
	818,--基础营火
	3273,--急救
	2550,--烹饪
	6603,--攻击
	2508,--寻找矿物
	2383,--寻找草药
	2656,--熔炼
	13262,--"分解"
	-- "战斗宠物""公会福利""初级" "中级" "高级" "专家级" "大师级" "宗师级"
}
local function IsNoSpellList(spid)
	for i=1,#NoSpellList do
		if spid==NoSpellList[i] then
			return true
		end
	end
	return false
end
local function IsActionInfoX(spid)
	for actionID = 1, 120 do
		local actionType, id, subType = GetActionInfo(actionID)
		if actionType then
			if actionType=="spell" then
				if id==spid then return true end
			elseif actionType=="macro" then
				local lActionText = GetActionText(actionID);
				local hongSpellID = GetMacroSpell(id)
				if hongSpellID and hongSpellID==spid then return true end
			end
		end
	end
	local numForms = GetNumShapeshiftForms();
	for i=1, numForms do
		local icon, active, castable, spellID =GetShapeshiftFormInfo(i)
		if spellID and spellID==spid then return true end
	end
	return false
end
local function GetSpellData(ly,classFilename)
	local yixueSpellList = {}
	if PIG_MaxTocversion(40000) then
		if ly=="no" then
			yixueSpellList=PIGA["FramePlus"]["SpellData"][classFilename] or {}
		else
			local oldVar = GetCVar("ShowAllSpellRanks")
			if oldVar=="1" then
				ShowAllSpellRanksCheckbox:Click()
				ly.hideui=function()
					ShowAllSpellRanksCheckbox:Click()
				end
			else
				ly.hideui=nil
			end
			local numTabs = GetNumSpellTabs()
			for i=1,numTabs do
				local name, texture, tabOffset, numEntries = GetSpellTabInfo(i)
				for slot=tabOffset + 1, tabOffset + numEntries do
					local spellName, spellSubName, spellID = GetSpellBookItemName(slot, BOOKTYPE_SPELL)
					if spellID and IsPlayerSpell(spellID) then
						local isPassive = IsPassiveSpell(slot, BOOKTYPE_SPELL)
						if not isPassive and not IsNoSpellList(spellID) and not IsActionInfoX(spellID) then
							table.insert(yixueSpellList,slot)
						end
					end
				end
			end
		end
	else
		local numTabs = 2--GetNumSpellTabs()
		for i=1,numTabs do
			local name, texture, tabOffset, numEntries = GetSpellTabInfo(i)
			for slot=tabOffset + 1, tabOffset + numEntries do
				local spellType, spellID = GetSpellBookItemInfo(slot, BOOKTYPE_SPELL)
				if spellID then
					if ly=="no" then
						if spellType=="FUTURESPELL" then
							local texture = GetSpellTexture(slot, SpellBookFrame.bookType);
							local texture = texture or 134400
							local levelLearned = C_Spell.GetSpellLevelLearned(spellID)
							local levelLearned = levelLearned or 1
							local spellName, spellSubName = GetSpellBookItemName(slot, BOOKTYPE_SPELL)
							table.insert(yixueSpellList,{spellID,texture,levelLearned})
						end
					else
						if IsPlayerSpell(spellID) and spellType=="SPELL" then
							local isPassive = IsPassiveSpell(slot, BOOKTYPE_SPELL)
							if not isPassive and not IsNoSpellList(spellID) and not IsActionInfoX(spellID) then
								table.insert(yixueSpellList,slot)
							end
						end
					end
				end
			end
		end
	end
	if ly=="no" and yixueSpellList then
		table.sort(yixueSpellList, function(a, b)
		    local aNum = tonumber(a[3])
		    local bNum = tonumber(b[3])
		    return aNum < bNum
		end)
	end
	return yixueSpellList
end
function FramePlusfun.NoUseSpell()
	if PIG_MaxTocversion(60000,true) then return end
	if not PIGA["FramePlus"]["NoUseSpell"] then return end
	if SpellBookFrame.weituochuF then return end
	----
	local weituochuF=add_butF(0,"未使用","尚未拖动到动作条技能")
	SpellBookFrame.weituochuF=weituochuF
	---====
	local butmaxnum,butname=70,"PIG_SpellBookNoList"
	for i=1,butmaxnum do
		local spellbut = CreateFrame("CheckButton", "PIG_SpellBookNoList"..i, weituochuF);--, "SpellButtonTemplate"
		weituochuF.butlist[i]=spellbut
		if i==1 then
			spellbut:SetPoint("TOPLEFT",weituochuF,"TOPLEFT",14,-30);
		else
			if (i - 1) % 7 == 0 then
				spellbut:SetPoint("TOP",weituochuF.butlist[i-7],"BOTTOM",0,-12);
			else
				spellbut:SetPoint("LEFT",weituochuF.butlist[i-1],"RIGHT",16,0);
			end
		end
		spellbut:SetSize(37,37);
		spellbut.iconTexture = spellbut:CreateTexture();
		spellbut.iconTexture:SetAllPoints(spellbut)
		spellbut:SetScript("OnEvent",nil)
		spellbut:SetScript("OnEnter",function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetSpellBookItem(self.slot, SpellBookFrame.bookType)
			GameTooltip:Show();
		end)
		spellbut:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		spellbut:SetScript("OnMouseDown",function(self)
			if InCombatLockdown() then
				PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
				return
			end
			local slotType = GetSpellBookItemInfo(self.slot, SpellBookFrame.bookType);
			local slot = self.slot
			if (not slot or slot > MAX_SPELLS or not self.iconTexture:IsShown() or (slotType == "FUTURESPELL")) then
				return;
			end
			self:SetChecked(false);
			PickupSpellBookItem(slot, SpellBookFrame.bookType);
		end)
		function spellbut:UpdateButton()
			if self.TextBackground then self.TextBackground:ClearAllPoints();end
			if self.TextBackground2 then self.TextBackground2:ClearAllPoints();end
			local texture = GetSpellTexture(self.slot, SpellBookFrame.bookType);
			if texture then
				spellbut.iconTexture:SetTexture(texture);
				self:Show();
			end
		end
	end
	function weituochuF:UpdateShowList()
		if SpellBookFrame.weixuexiF then SpellBookFrame.weixuexiF:Hide() end
		self.error:SetText("没有未使用技能")
		for i=1,butmaxnum do
			self.butlist[i]:Hide();
		end
		local SpellData=GetSpellData(weituochuF)
		for i=1,#SpellData do
			self.error:SetText("")
			self.butlist[i].slot=SpellData[i]
			self.butlist[i]:UpdateButton()
		end
		self:Show()
	end
	weituochuF:HookScript("OnShow", function(self)
		self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
		self:UpdateShowList()
	end)
	weituochuF:HookScript("OnHide", function(self)
		self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
	end)
	weituochuF:SetScript("OnEvent", function(self,event,arg1)
		self:UpdateShowList()
	end)
end
function FramePlusfun.Spell()
	if PIG_MaxTocversion(40000,true) then return end
	if not PIGA["FramePlus"]["SpellOpen"] then return end
	if SpellBookFrame.weixuexiF then return end
	----
	local GetSpecialization = GetSpecialization or C_SpecializationInfo and C_SpecializationInfo.GetSpecialization
	local GetSpecializationInfo = GetSpecializationInfo or C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo
	------
	local className, classFilename, classId = UnitClass("player")
	local weixuexiF=add_butF(1,"未学习","尚未学习技能",classFilename)
	SpellBookFrame.weixuexiF=weixuexiF
	PIGA["FramePlus"]["SpellData"][classFilename]=PIGA["FramePlus"]["SpellData"][classFilename] or {}
	local hangmaxnum,hangeH,scrlwww=19,20.6,weixuexiF:GetWidth()-21
	weixuexiF.ScrollFF=Create.PIGScrollFrame_old(weixuexiF,{4,-26,-2,4})
	for i=1,hangmaxnum do
		local spellbut = PIGFrame(weixuexiF,nil,{scrlwww,hangeH})
		weixuexiF.butlist[i]=spellbut
		spellbut:PIGSetBackdrop(0.6)
		if i==1 then
			spellbut:SetPoint("TOPLEFT",weixuexiF,"TOPLEFT",4,-26);
		else
			spellbut:SetPoint("TOPLEFT",weixuexiF.butlist[i-1],"BOTTOMLEFT",0,0);
		end
		spellbut.ok = PIGFontString(spellbut,{"LEFT",spellbut,"LEFT",2,0})
		spellbut.icon = spellbut:CreateTexture();
		spellbut.icon:SetSize(hangeH,hangeH);
		spellbut.icon:SetPoint("LEFT", 98, 0);
		spellbut.name = PIGFontString(spellbut,{"LEFT",spellbut.icon,"RIGHT",1,0},"")
		spellbut.levelLearned = PIGFontString(spellbut,{"RIGHT",spellbut.icon,"LEFT",-1,0},"")
		spellbut.levelLearned:SetWidth(30);
		spellbut.levelLearned:SetJustifyH("RIGHT")
		spellbut:SetScript("OnEnter",function(self)
			if not self.spellID then return end
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			if type(self.spellID)=="number" then
				GameTooltip:SetHyperlink("spell:"..self.spellID)
			else
				GameTooltip:AddLine("|cffFFFFFF"..self.spellID.."|r")
				GameTooltip:AddLine(self.tisptxt1, nil, nil, nil, true)
			end
			GameTooltip:Show();
		end)
		spellbut:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		function spellbut:UpdateButton(Data,leveldq,nonext)
			spellbut.spellID=Data[1]
			spellbut.tisptxt1=Data[5]
			spellbut.icon:SetTexture(Data[2]);
			spellbut.levelLearned:SetText("lv"..Data[3])
			if PIG_MaxTocversion(40000) then
				if Data[4] and Data[4]~="" then
					spellbut.name:SetText(Data[1].." ("..Data[4]..") |cff808080"..GetMoneyString(Data[6] or 0).."|r")
				else
					spellbut.name:SetText(Data[1].." |cff808080"..GetMoneyString(Data[6] or 0).."|r")
				end
			else
				local Namespekk=GetSpellInfo(Data[1])
				local Subtext=GetSpellSubtext(Data[1])
				if Subtext and Subtext~="" then
					spellbut.name:SetText(Namespekk.."("..Subtext..")")
				else
					spellbut.name:SetText(Namespekk)
				end
			end
			if leveldq>=Data[3] then
				if nonext then
					spellbut.ok:SetText("|cffFF0000缺前置|r")
				else
					spellbut.ok:SetText("可学习")
				end
				spellbut.ok:SetTextColor(0, 1, 0, 1)
				spellbut.levelLearned:SetTextColor(0, 1, 0, 1)
				spellbut.name:SetTextColor(0, 1, 0, 1)
			else
				if (Data[3]-leveldq)<2 then
					spellbut.ok:SetText("下级可学")
					spellbut.ok:SetTextColor(1, 1, 0, 1)
					spellbut.levelLearned:SetTextColor(1, 1, 0, 1)
					spellbut.name:SetTextColor(1, 1, 0, 1)
				elseif (Data[3]-leveldq)<3 then
					spellbut.ok:SetText("")
					spellbut.ok:SetTextColor(1, 0.686, 0.37647)
					spellbut.levelLearned:SetTextColor(1, 0.686, 0.37647)
					spellbut.name:SetTextColor(1, 0.686, 0.37647)
				elseif (Data[3]-leveldq)<4 then
					spellbut.ok:SetText("")
					spellbut.ok:SetTextColor(1, 0.5, 0.3137)
					spellbut.levelLearned:SetTextColor(1, 0.5, 0.3137)
					spellbut.name:SetTextColor(1, 0.5, 0.3137)
				else
					spellbut.ok:SetText("")
					spellbut.ok:SetTextColor(1, 0, 0, 1)
					spellbut.levelLearned:SetTextColor(1, 0, 0, 1)
					spellbut.name:SetTextColor(1, 0, 0, 1)
				end
			end
			self:Show();	
		end
	end
	weixuexiF.allhuafei=0
	weixuexiF.NewData={}
	local function GetIsPlayerSpellData()
		local NewData={}
		local oldVar = GetCVar("ShowAllSpellRanks")
		if oldVar=="0" then
			ShowAllSpellRanksCheckbox:Click()
			weixuexiF.hideui=true
		end
		local numTabs = GetNumSpellTabs()
		for i=1,numTabs do
			local name, texture, tabOffset, numEntries = GetSpellTabInfo(i)
			for slot=tabOffset + 1, tabOffset + numEntries do
				local spellName, spellSubName, spellID = GetSpellBookItemName(slot, BOOKTYPE_SPELL)
				if spellID and IsPlayerSpell(spellID) then
					if spellID==921 then
						spellSubName=string.format(LEVEL_GAINED,"1")
					end
					if NewData[spellName] then
						table.insert(NewData[spellName], spellSubName)
					else
						NewData[spellName]={spellSubName}
					end
				end
			end
		end
		if weixuexiF.hideui then ShowAllSpellRanksCheckbox:Click() weixuexiF.hideui=nil end
		return NewData
	end
	local function IsPlayerSpellOK(spname,levelLsit)
		for i=1,#levelLsit do
			if spname==levelLsit[i] then
				return true
			end
		end
		return false
	end
	local function IsNextLv(level,newData,PlayerSpellData)
		if level>=newData[3] then
			if newData[4] and newData[4]:match("^等级%s*(%d+)$") then--有等级
				if newData[7] and #newData[7]>0 then
					if not PlayerSpellData[newData[1]] then
						local levelnum = tonumber(newData[4]:match("%d+"))
						if levelnum>1 then
							return true
						end
					end
				end
			end
		end
		return false
	end
	local function addspellData_1(level,newData)
		table.insert(weixuexiF.NewData,newData)
		if level>=newData[3] and newData[6] then
			weixuexiF.allhuafei=weixuexiF.allhuafei+newData[6]
		end
	end
	function weixuexiF.ScrollFF:UpdateShowList()
		if SpellBookFrame.weituochuF then SpellBookFrame.weituochuF:Hide() end
		weixuexiF.allhuafei=0
		weixuexiF.biaotiT1:SetText("")
		for i=1,hangmaxnum do
			weixuexiF.butlist[i]:Hide();
		end
		local SpellData=GetSpellData("no",classFilename)
		if #SpellData==0 then
			weixuexiF.error:SetText("请先拜访你的"..MINIMAP_TRACKING_TRAINER_CLASS) weixuexiF:Show() 
			return 
		end
		local level = UnitLevel("player")
		local TotalNum = #SpellData
		local PlayerSpellData=GetIsPlayerSpellData()
		if TotalNum>0 then
			--print(2222,#PIGA["FramePlus"]["SpellData"][classFilename])
			weixuexiF.error:SetText("")
			wipe(weixuexiF.NewData)
			for i=1,TotalNum do
				if PlayerSpellData[SpellData[i][1]] then--存在已学
					if SpellData[i][4] and SpellData[i][4]:match("^等级%s*(%d+)$") then--有等级
					    if not IsPlayerSpellOK(SpellData[i][4],PlayerSpellData[SpellData[i][1]]) then
					    	addspellData_1(level,SpellData[i])
						end
					else--没有等级直接判断
						if not PlayerSpellData[SpellData[i][1]] then
							addspellData_1(level,SpellData[i])
					    end
					end
				else
					addspellData_1(level,SpellData[i])
				end
			end
			weixuexiF.biaotiT1:SetText("(可学花费"..GetMoneyString(weixuexiF.allhuafei).."/"..GetMoneyString(GetMoney())..")")
			if weixuexiF.allhuafei<GetMoney() then
				weixuexiF.biaotiT1:SetTextColor(0, 1, 0, 1)
			else
				weixuexiF.biaotiT1:SetTextColor(1, 0, 0, 1)
			end
		else
			weixuexiF.error:SetText("没有未学技能")
		end
		local TotalNum = #weixuexiF.NewData
	    local offset = self:GetScrollFrameOffset(TotalNum, hangmaxnum, hangeH)
	   	for i = 1, hangmaxnum do
	        local dataIndex = i + offset
	        if weixuexiF.NewData[dataIndex] then
				weixuexiF.butlist[i]:UpdateButton(weixuexiF.NewData[dataIndex],level,IsNextLv(level,weixuexiF.NewData[dataIndex],PlayerSpellData))
			end
		end
		weixuexiF:Show()
	end
	weixuexiF.UpdateShowList=weixuexiF.ScrollFF.UpdateShowList
	weixuexiF:HookScript("OnShow", function(self)
		self.ScrollFF:UpdateShowList()
	end)
	local function SaveSpellData()
		if not ClassTrainerFrame:IsShown() then return end
		local old_available = GetTrainerServiceTypeFilter("available")
		local old_unavailable = GetTrainerServiceTypeFilter("unavailable")
		local old_used = GetTrainerServiceTypeFilter("used")
		SetTrainerServiceTypeFilter("available",true)
		SetTrainerServiceTypeFilter("unavailable",true)
		SetTrainerServiceTypeFilter("used",true)
		local numTrainerServices = GetNumTrainerServices();
		if numTrainerServices<#PIGA["FramePlus"]["SpellData"][classFilename] then return end
		wipe(PIGA["FramePlus"]["SpellData"][classFilename])
		for index=1,numTrainerServices do
			local serviceName, serviceSubText, serviceType, isExpanded = GetTrainerServiceInfo(index);
			if ( serviceType ~= "header" ) then
				--local link = GetTrainerServiceItemLink(index)
				local texture = GetTrainerServiceIcon(index)
				local texture = texture or 134400
				local levelLearned = GetTrainerServiceLevelReq(index);
				local levelLearned = levelLearned or 1
				local serviceCost, talentCost, professionCost = GetTrainerServiceCost(index)
				local serviceDescription = GetTrainerServiceDescription(index)
				local adddataX={
					serviceName,
					texture,
					levelLearned,
					serviceSubText,
					serviceDescription,
					serviceCost,
					{},
				}
				local numRequirements = GetTrainerServiceNumAbilityReq(index);
				for ix=1,numRequirements do
					local ability, hasReq = GetTrainerServiceAbilityReq(index, ix);
					table.insert(adddataX[7],ability)
				end
				--print(serviceName, serviceSubText)
				table.insert(PIGA["FramePlus"]["SpellData"][classFilename],adddataX)
			end
		end
		SetTrainerServiceTypeFilter("available",old_available)
		SetTrainerServiceTypeFilter("unavailable",old_unavailable)
		SetTrainerServiceTypeFilter("used",old_used)
		if #PIGA["FramePlus"]["SpellData"][classFilename]>20 then
			weixuexiF:UnregisterEvent("TRAINER_UPDATE");
			weixuexiF:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
		end
	end
	weixuexiF:RegisterEvent("PLAYER_ENTERING_WORLD");
	weixuexiF:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			if #PIGA["FramePlus"]["SpellData"][classFilename]>20 then return end
			self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	    elseif event == "UPDATE_MOUSEOVER_UNIT" then
	    	if UnitExists("mouseover") then
				local tooltipText = GameTooltipTextLeft2:GetText()
				if tooltipText and string.find(tooltipText:lower(), className..TUTORIAL_TITLE14) then
					self:RegisterEvent("TRAINER_UPDATE");
				    self.kaishipname=UnitName("mouseover")
				    if self.kaiTicker then self.kaiTicker:Cancel() end
				    self.kaiTicker=C_Timer.NewTimer(60,function()
				    	self:UnregisterEvent("TRAINER_UPDATE");
					end)
				else
					local mubiaoGUID=UnitGUID("mouseover")
					if mubiaoGUID then
						local unitType, _, serverID, instanceID, zoneID, npcID = strsplit("-", mubiaoGUID);
						if npcID=="28471" or npcID=="28472" or npcID=="28474" then
							self:RegisterEvent("TRAINER_UPDATE");
						    self.kaishipname=UnitName("mouseover")
						    if self.kaiTicker then self.kaiTicker:Cancel() end
						    self.kaiTicker=C_Timer.NewTimer(60,function()
						    	self:UnregisterEvent("TRAINER_UPDATE");
							end)
						end
					end
				end
			end
		elseif event == "TRAINER_UPDATE" and self.kaishipname==UnitName("npc") then
			if self.kaishiOK then self.kaishiOK:Cancel() end
		    self.kaishiOK=C_Timer.NewTimer(0.6,function()
		    	SaveSpellData()
		    	C_Timer.After(0.2,SaveSpellData)
		    	C_Timer.After(0.4,SaveSpellData)
		    end)
	    end
	end)
end