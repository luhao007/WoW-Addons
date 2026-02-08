local _, addonTable = ...;
local FramePlusfun=addonTable.FramePlusfun
local ActionFun=addonTable.Fun.ActionFun
local PIGUseKeyDown=ActionFun.PIGUseKeyDown
local Update_State=ActionFun.Update_State
----
local Data=addonTable.Data
local butW = ActionButton1:GetWidth()
local PIGSkillinfo={
	["bookType"]=PIG_GetSpellBookType(),
	["Width"]=butW,
	["Height"]=butW,
}
local IsCurrentSpell=IsCurrentSpell or C_Spell and C_Spell.IsCurrentSpell
local GetSpellTexture=GetSpellTexture or C_Spell and C_Spell.GetSpellTexture
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
-----------------------
local function PIG_ADDON_LOADED(BlizzardName,addfun)
	if IsAddOnLoaded(BlizzardName) then
		addfun()
	else
		local jiazaiui = CreateFrame("Frame")
		jiazaiui:RegisterEvent("ADDON_LOADED")
		jiazaiui:SetScript("OnEvent", function(self, event, arg1)
			if event=="ADDON_LOADED" then
				if arg1==BlizzardName then
					self:UnregisterEvent("ADDON_LOADED")
					if InCombatLockdown() then
						jiazaiui:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						addfun()
					end
				end
			elseif event=="PLAYER_REGEN_ENABLED" then
				self:UnregisterEvent("PLAYER_REGEN_ENABLED")
				addfun()				
			end
		end)
	end
end
local function ADD_Skill_QK_Button(fujiui,uiname,ly)
	if fujiui.ButList then return end
	fujiui.ButList={}
	local function addqkbut(id)
		local But = CreateFrame("CheckButton",nil, fujiui, "SecureActionButtonTemplate");
		But.icon = But:CreateTexture()
		But.icon:SetSize(54,54);
		But.icon:SetAllPoints(But)
		But.start = But:CreateTexture(nil, "OVERLAY");
		But.start:SetTexture(130724);
		But.start:SetBlendMode("ADD");
		But.start:SetAllPoints(But)
		But.start:Hide();
		But:SetSize(PIGSkillinfo.Width,PIGSkillinfo.Height);
		But:SetScale(0.88)
		But:Hide();
		fujiui.ButList[id]=But
		PIGUseKeyDown(But)
		But:SetAttribute("type", "spell");
		But.Type="spell"
		-----------
		if ElvUI then
			But.icon:SetTexCoord(0.1,0.9,0.1,0.9)
		else
			But.Border = But:CreateTexture(nil, "BACKGROUND");
			But.Border:SetDrawLayer("BACKGROUND", -8)
			if not IsAddOnLoaded("alaTradeSkill") then
				But.Border:SetTexture(136831);
			end
			if ly=="Mainline" then
				But.Border:SetSize(PIGSkillinfo.Width*1.8,PIGSkillinfo.Height*1.8);
				But.Border:SetPoint("LEFT",But,"LEFT",-2,-6);
			else
				But.Border:SetSize(PIGSkillinfo.Width*1.9,PIGSkillinfo.Height*1.9);
				But.Border:SetPoint("LEFT",But,"LEFT",-2,-5);
				But:RegisterEvent("CRAFT_CLOSE") 
			end
		end
		hooksecurefunc(But, "SetChecked", function(self,bool)
			if bool then
				self.start:Show();
			else
				self.start:Hide();
			end
		end)
		But:RegisterEvent("TRADE_SKILL_CLOSE")
		But:RegisterEvent("ACTIONBAR_UPDATE_STATE");
		But:HookScript("OnEvent", function(self)
			Update_State(self)
		end)
		return But
	end
	fujiui:HookScript("OnShow", function(self)
		if InCombatLockdown() then return end
		local Skill_List = Data.Get_Skill_Info()
		local leftOffset=0
		if ly~="Mainline" then
			leftOffset=-37
		end
		if ElvUI then
			if PIG_MaxTocversion(20000) then

			elseif PIG_MaxTocversion(30000) then
				--leftOffset=leftOffset+5
			end
		end
		for id=1, #Skill_List.top do
			local But = fujiui.ButList[id] or addqkbut(id)
			But.SimID=Skill_List.top[id][2]
			But.Isfumo=Skill_List.top[id][3]
			But.icon:SetTexture(GetSpellTexture(Skill_List.top[id][2]));
			But:SetAttribute("spell", Skill_List.top[id][2]);
			But:ClearAllPoints();
			if id==1 then
				But:SetPoint("TOPLEFT",fujiui,"TOPRIGHT",leftOffset,-46);
			else
				But:SetPoint("TOP", fujiui.ButList[id-1], "BOTTOM", 0, -16);
			end
			But:Show();
		end
		local topallnum=#Skill_List.top
		for id=(1+topallnum), #Skill_List.bot+topallnum do
			local But = fujiui.ButList[id] or addqkbut(id)
			But.SimID=Skill_List.bot[id-topallnum][2]
			But.icon:SetTexture(GetSpellTexture(Skill_List.bot[id-topallnum][2]));
			But:SetAttribute("spell", Skill_List.bot[id-topallnum][2]);
			But:ClearAllPoints();
			if id==(topallnum+1) then
				But:SetPoint("BOTTOMLEFT",fujiui,"BOTTOMRIGHT",leftOffset,70);
			else
				But:SetPoint("BOTTOM", fujiui.ButList[id-1], "TOP", 0, 16);
			end
			But:Show();
		end
	end);
end
local function ADD_Skill_QK()
	if PIG_MaxTocversion() then
		ADD_Skill_QK_Button(TradeSkillFrame,"Skill")
	else
		ADD_Skill_QK_Button(ProfessionsFrame,"Skill","Mainline") 
	end
end
---
local function ADD_Craft_QK()	
	ADD_Skill_QK_Button(CraftFrame,"Craft")
end
function FramePlusfun.Skill_QKbut()
	if not PIGA["FramePlus"]["Skill_QKbut"] then return end
	if NDui then return end
	if PIG_MaxTocversion() then
		PIG_ADDON_LOADED("Blizzard_TradeSkillUI",ADD_Skill_QK)
		PIG_ADDON_LOADED("Blizzard_CraftUI",ADD_Craft_QK)
	else
		PIG_ADDON_LOADED("Blizzard_Professions",ADD_Skill_QK)
	end
end
--专业/附魔界面扩展
local function TradeSkillFunc()
	if TRADE_SKILLS_DISPLAYED==8 then	
			UIPanelWindows["TradeSkillFrame"].width = 13	
			TradeSkillFrame:SetWidth(713)
			TradeSkillFrame:SetHeight(487)

			-- 扩展配方列表到最高
			TradeSkillListScrollFrame:ClearAllPoints()
			TradeSkillListScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 25, -75)
			TradeSkillListScrollFrame:SetSize(295, 336)

			--配方详情移到右边增加高度
			TradeSkillDetailScrollFrame:ClearAllPoints()
			TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 352, -74)
			TradeSkillDetailScrollFrame:SetSize(298, 336)
			-- 增加配方列表目录数
			local oldTradeSkillsDisplayed = TRADE_SKILLS_DISPLAYED
			for i = 1 + 1, TRADE_SKILLS_DISPLAYED do
				_G["TradeSkillSkill" .. i]:ClearAllPoints()
				_G["TradeSkillSkill" .. i]:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
			end
			_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
			for i = oldTradeSkillsDisplayed + 1, TRADE_SKILLS_DISPLAYED do
				local button = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
				button:SetID(i)
				button:Hide()
				button:ClearAllPoints()
				button:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
			end
			--选中高亮条宽度
			hooksecurefunc(_G["TradeSkillHighlightFrame"], "Show", function()
				_G["TradeSkillHighlightFrame"]:SetWidth(290)
			end)
			--技能点数条位置
			TradeSkillRankFrame:ClearAllPoints()
			TradeSkillRankFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 84, -36)
			TradeSkillRankFrameSkillRank:ClearAllPoints()
			TradeSkillRankFrameSkillRank:SetPoint("CENTER", TradeSkillRankFrame, "CENTER", 0, 0)
			--调整关闭按钮位置
			TradeSkillCancelButton:SetSize(80, 22)
			TradeSkillCancelButton:ClearAllPoints()
			TradeSkillCancelButton:SetPoint("BOTTOMRIGHT", TradeSkillFrame, "BOTTOMRIGHT", -42, 54)
			--调整全部制造按钮位置
			TradeSkillCreateButton:ClearAllPoints()
			TradeSkillCreateButton:SetPoint("RIGHT", TradeSkillCancelButton, "LEFT", -1, 0)
			--分类下拉菜单位置
			local SlotDropDown=TradeSkillInvSlotDropDown or TradeSkillInvSlotDropdown or CreateFrame("Frame")
			if SlotDropDown then
				SlotDropDown:ClearAllPoints()
				SlotDropDown:SetPoint("TOPRIGHT", TradeSkillFrame, "TOPRIGHT", -60, -44)
				-- local SubDropDown=TradeSkillSubClassDropDown or TradeSkillSubClassDropdown	
				-- if SubDropDown then
				-- 	SubDropDown:SetPoint("RIGHT", SlotDropDown, "RIGHT", -5, 0)
				-- end
			end
			--材料齐备
			if TradeSkillFrameAvailableFilterCheckButton then
				TradeSkillFrameAvailableFilterCheckButton:ClearAllPoints()
				TradeSkillFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 84, -50)
			end
			--搜索位置
			local SearchBox=TradeSkillFrameEditBox or TradeSkillFrameSearchBox
			if SearchBox then
				SearchBox:ClearAllPoints()
				SearchBox:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 190, -50)
			end
			if TradeSkillFrame.FilterDropdown then
				TradeSkillFrame.FilterDropdown:SetPoint("TOPRIGHT", TradeSkillFrame, "TOPRIGHT", -220, -48)
			end
			if TradeSearchInputBox then
				TradeSearchInputBox:ClearAllPoints()
				TradeSearchInputBox:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 200, -52)
			end
			--纹理更新
			if ElvUI then
				TradeSkillFrame:HookScript("OnShow", function(self)
					if ElvUI then
						SlotDropDown:ClearAllPoints()
						SlotDropDown:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 530, -30)
						self.backdrop:SetPoint("TOPLEFT",self,"TOPLEFT",0,0);
						self.backdrop:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-32,42);
					end	
				end);
			else
				local regions = {TradeSkillFrame:GetRegions()}
				if PIG_MaxTocversion(20000) then
					--隐藏全部折叠附近纹理
					TradeSkillExpandTabLeft:Hide()
					TradeSkillExpandTabRight:Hide()
					TradeSkillSkillBorderLeft:Hide()
					regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
					regions[2]:SetSize(512, 512)

					regions[3]:ClearAllPoints()
					regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
					regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
					regions[3]:SetSize(256, 512)
					regions[4]:Hide()
					regions[5]:Hide()
					regions[8]:Hide()
					regions[9]:Hide()
					regions[10]:Hide()
				elseif PIG_MaxTocversion(30000) then
					--隐藏全部折叠附近纹理
					TradeSkillExpandTabLeft:Hide()
					TradeSkillHorizontalBarLeft:Hide()
					regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
					regions[2]:SetSize(512, 512)

					regions[3]:ClearAllPoints()
					regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
					regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
					regions[3]:SetSize(256, 512)
					regions[5]:Hide()
					regions[6]:Hide()
					regions[8]:Hide()
				elseif PIG_MaxTocversion() then
					--隐藏全部折叠附近纹理
					TradeSkillExpandTabLeft:Hide()
					TradeSkillExpandTabRight:Hide()
					TradeSkillHorizontalBarLeft:Hide()
					--regions[2]:Hide()
					regions[5]:Hide()
					regions[6]:Hide()
					--regions[7]:Hide()--标题
					--regions[8]:Hide()
					regions[9]:Hide()

					regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
					regions[3]:SetSize(512, 512)

					regions[4]:ClearAllPoints()
					regions[4]:SetPoint("TOPLEFT", regions[3], "TOPRIGHT", 0, 0)
					regions[4]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
					regions[4]:SetSize(256, 512)
				end
				if not IsAddOnLoaded("alaTradeSkill") then
					--调整配方列表底部纹理
					TradeSkillFrame.RecipeInset = TradeSkillFrame:CreateTexture(nil, "ARTWORK")
					TradeSkillFrame.RecipeInset:SetSize(304, 361)
					TradeSkillFrame.RecipeInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 16, -72)
					TradeSkillFrame.RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
					-- 调整配方详细页纹理
					TradeSkillFrame.DetailsInset = TradeSkillFrame:CreateTexture(nil, "ARTWORK")
					TradeSkillFrame.DetailsInset:SetSize(302, 339)
					TradeSkillFrame.DetailsInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 348, -72)
					TradeSkillFrame.DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
				end
			end
	end
end
local function CraftFunc()
	if CRAFTS_DISPLAYED==8 then  
		UIPanelWindows["CraftFrame"].width = 713
		--重新设置附魔框架大小
		CraftFrame:SetWidth(713)
		CraftFrame:SetHeight(487)
		--纹理调整替换
		if ElvUI then

		else
			local regions = {_G["CraftFrame"]:GetRegions()}
			regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
			regions[2]:SetSize(512, 512)
			regions[3]:ClearAllPoints()
			regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
			regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
			regions[3]:SetSize(256, 512)
			regions[4]:Hide()
			regions[5]:Hide()
			regions[9]:Hide()
			regions[10]:Hide()
			CraftSkillBorderLeft:SetAlpha(0)
			CraftSkillBorderRight:SetAlpha(0)
			---
			if PIG_MaxTocversion(20000,true) and PIG_MaxTocversion(30000) then
				local DropDown=CraftFrameFilterDropDown or CraftFrame.Dropdown
				CraftFrameAvailableFilterCheckButton:ClearAllPoints()
				CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 84, -42)
				DropDown:ClearAllPoints()
				DropDown:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 498, -40)
			end
			-- 替换左侧列表纹理
			local RecipeInset = CraftFrame:CreateTexture(nil, "ARTWORK")
			RecipeInset:SetSize(304, 361)
			RecipeInset:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 16, -72)
			RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
			-- 右侧底部纹理
			local DetailsInset = CraftFrame:CreateTexture(nil, "ARTWORK")
			DetailsInset:SetSize(302, 339)
			DetailsInset:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 348, -72)
			DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
		end
		--技能点数条位置
		CraftRankFrame:ClearAllPoints()
		CraftRankFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 184, -47)
		-- 附魔框架标题位置
		CraftFrameTitleText:ClearAllPoints()
		CraftFrameTitleText:SetPoint("TOP", CraftFrame, "TOP", 0, -18)
		-- 附魔列表增加高度
		CraftListScrollFrame:ClearAllPoints()
		CraftListScrollFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 25, -75)
		CraftListScrollFrame:SetSize(295, 336)

		-- 增加附魔目录可显示数
		local oldCraftsDisplayed = CRAFTS_DISPLAYED
		Craft1Cost:ClearAllPoints()
		Craft1Cost:SetPoint("RIGHT", Craft1, "RIGHT", -30, 0)
		for i = 1 + 1, CRAFTS_DISPLAYED do
			_G["Craft" .. i]:ClearAllPoints()
			_G["Craft" .. i]:SetPoint("TOPLEFT", _G["Craft" .. (i-1)], "BOTTOMLEFT", 0, 1)
			_G["Craft" .. i .. "Cost"]:ClearAllPoints()
			_G["Craft" .. i .. "Cost"]:SetPoint("RIGHT", _G["Craft" .. i], "RIGHT", -30, 0)
		end
		_G.CRAFTS_DISPLAYED = _G.CRAFTS_DISPLAYED + 14
		for i = oldCraftsDisplayed + 1, CRAFTS_DISPLAYED do
			local button = CreateFrame("Button", "Craft" .. i, CraftFrame, "CraftButtonTemplate")
			button:SetID(i)
			button:Hide()
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", _G["Craft" .. (i-1)], "BOTTOMLEFT", 0, 1)
			_G["Craft" .. i .. "Cost"]:ClearAllPoints()
			_G["Craft" .. i .. "Cost"]:SetPoint("RIGHT", _G["Craft" .. i], "RIGHT", -30, 0)
		end
		
		-- 选中高亮条宽度
		hooksecurefunc(_G["CraftHighlightFrame"], "Show", function()
			_G["CraftHighlightFrame"]:SetWidth(290)
		end)
		-- 附魔材料细节移到右边增加高度
		CraftDetailScrollFrame:ClearAllPoints()
		CraftDetailScrollFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 352, -74)
		CraftDetailScrollFrame:SetSize(298, 336)
		-- 细节滚动条隐藏
		CraftDetailScrollFrameTop:SetAlpha(0)
		CraftDetailScrollFrameBottom:SetAlpha(0)
		
		-- 关闭按钮位置
		CraftCancelButton:SetSize(80, 22)
		CraftCancelButton:SetText(CLOSE)
		CraftCancelButton:ClearAllPoints()
		CraftCancelButton:SetPoint("BOTTOMRIGHT", CraftFrame, "BOTTOMRIGHT", -42, 54)
		-- 附魔按钮
		CraftCreateButton:ClearAllPoints()
		CraftCreateButton:SetPoint("RIGHT", CraftCancelButton, "LEFT", -1, 0)
		
		-- 训练宠物
		CraftFramePointsLabel:ClearAllPoints()
		CraftFramePointsLabel:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 500, -46)
		CraftFramePointsText:ClearAllPoints()
		CraftFramePointsText:SetPoint("LEFT", CraftFramePointsLabel, "RIGHT", 3, 0)
	end
end
function FramePlusfun.Skill()
	if not PIGA["FramePlus"]["Skill"] then return end
	if NDui then return end
	if PIG_MaxTocversion() then
		PIG_ADDON_LOADED("Blizzard_TradeSkillUI",TradeSkillFunc)
		PIG_ADDON_LOADED("Blizzard_CraftUI",CraftFunc)
	end
end