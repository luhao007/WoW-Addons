local _, addonTable = ...;
local FramePlusfun=addonTable.FramePlusfun

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
function FramePlusfun.Trainer()
	if not PIGA["FramePlus"]["Trainer"] then return end
	if PIG_MaxTocversion(40000,true) then return end
	if NDui then return end
	PIG_ADDON_LOADED("Blizzard_TrainerUI",function()
		UIPanelWindows["ClassTrainerFrame"].width = 713
		ClassTrainerFrame:SetWidth(713)
		ClassTrainerFrame:SetHeight(487)
		if ElvUI then
		else
			local regions = {_G["ClassTrainerFrame"]:GetRegions()}
			regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
			regions[2]:SetSize(512, 512)
			regions[3]:ClearAllPoints()
			regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
			regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
			regions[3]:SetSize(256, 512)
			regions[9]:Hide()
			ClassTrainerFrameBottomLeft:SetAlpha(0)
			ClassTrainerFrameBottomRight:SetAlpha(0)
			ClassTrainerHorizontalBarLeft:SetAlpha(0)
			ClassTrainerFrame.FilterDropdown:ClearAllPoints()
			ClassTrainerFrame.FilterDropdown:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 200, -72)
			-- 替换左侧列表纹理
			local RecipeInset = ClassTrainerFrame:CreateTexture(nil, "ARTWORK")
			RecipeInset:SetSize(304, 361)
			RecipeInset:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 16, -72)
			RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
			-- 右侧底部纹理
			local DetailsInset = ClassTrainerFrame:CreateTexture(nil, "ARTWORK")
			DetailsInset:SetSize(302, 337)
			DetailsInset:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 349, -74)
			DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
		end
		--选中高亮条宽度
		hooksecurefunc(_G["ClassTrainerSkillHighlightFrame"], "Show", function()
			_G["ClassTrainerSkillHighlightFrame"]:SetWidth(290)
		end)
		-- 列表增加高度
		ClassTrainerListScrollFrame:ClearAllPoints()
		ClassTrainerListScrollFrame:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 20, -75)
		ClassTrainerListScrollFrame:SetSize(300, 335)
		-- 细节移到右边增加高度
		ClassTrainerDetailScrollFrame:ClearAllPoints()
		ClassTrainerDetailScrollFrame:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 352, -74)
		ClassTrainerDetailScrollFrame:SetSize(298, 336)
		ClassTrainerDetailScrollFrameTop:SetAlpha(0)
		ClassTrainerDetailScrollFrameBottom:SetAlpha(0)
		--按钮位置
		ClassTrainerCancelButton:SetSize(80, 22)
		ClassTrainerCancelButton:SetText(CLOSE)
		ClassTrainerCancelButton:ClearAllPoints()
		ClassTrainerCancelButton:SetPoint("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMRIGHT", -42, 54)
		ClassTrainerTrainButton:ClearAllPoints()
		ClassTrainerTrainButton:SetPoint("RIGHT", ClassTrainerCancelButton, "LEFT", -1, 0)
		-- 训练费用
		ClassTrainerMoneyFrame:SetPoint("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMLEFT", 480, 56)
		-- 增加目录可显示数
		for i = CLASS_TRAINER_SKILLS_DISPLAYED + 1, CLASS_TRAINER_SKILLS_DISPLAYED+11 do
			if not _G["ClassTrainerSkill" .. i] then
				local button = CreateFrame("Button", "ClassTrainerSkill" .. i, ClassTrainerFrame, "ClassTrainerSkillButtonTemplate")
				button:SetID(i)
				button:Hide()
				button:ClearAllPoints()
				button:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
			end
		end
		hooksecurefunc("ClassTrainer_SetToClassTrainer", function()
			if CLASS_TRAINER_SKILLS_DISPLAYED==11 then  
				_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 10
				ClassTrainerListScrollFrame:SetHeight(335)
				ClassTrainerDetailScrollFrame:SetHeight(335)
			end
		end)
		hooksecurefunc("ClassTrainer_SetToTradeSkillTrainer", function()
			if CLASS_TRAINER_SKILLS_DISPLAYED==10 then  
				_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + 11
				ClassTrainerListScrollFrame:SetHeight(335)
				ClassTrainerDetailScrollFrame:SetHeight(335)
			end
		end)
	end)
end