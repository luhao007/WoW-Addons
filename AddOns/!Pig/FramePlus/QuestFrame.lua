local _, addonTable = ...;
local FramePlusfun=addonTable.FramePlusfun
--任务界面扩展--------------------
function FramePlusfun.Quest()
	local Create=addonTable.Create
	local PIGButton=Create.PIGButton
	if not PIGA["FramePlus"]["Quest"] then return end
	if NDui then return end
	if PIG_MaxTocversion(20000,true) and QuestLogFrame and not QuestLogFrame.allopen then
		QuestLogFrame.allopen = PIGButton(QuestLogFrame,{"TOPLEFT",QuestLogFrame,"TOPLEFT",185,-38.6},{24,23},"+",nil,nil,nil,nil,0);
		QuestLogFrame.allopen:SetScript("OnClick", function(self)
			ExpandQuestHeader(0)
		end)
		QuestLogFrame.allopen.alloff = PIGButton(QuestLogFrame.allopen,{"LEFT",QuestLogFrame.allopen,"RIGHT",6,1.6},{24,23},"-",nil,nil,nil,nil,0);
		QuestLogFrame.allopen.alloff:SetScript("OnClick", function(self)
			CollapseQuestHeader(0) 
		end)
		if PIG_MaxTocversion() then
			QuestLogFrame.allopen:SetPoint("TOPLEFT",QuestLogFrame,"TOPLEFT",180,-40);
		end
	end
	local maxWWW = 250
	if PIG_MaxTocversion() then
		local function gengxinLVQR()--显示任务等级
			local numEntries, numQuests = GetNumQuestLogEntries();
			if (numEntries == 0) then return end
			for i = 1, QUESTS_DISPLAYED, 1 do
				local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);		
				if (questIndex <= numEntries) then
					local title, level, questTag, isHeader = GetQuestLogTitle(questIndex)
					if not isHeader then	
						if PIG_MaxTocversion(30000) then
							QuestLogDummyText:SetText(" ["..level.."]"..title)
							local questLogTitle = _G["QuestLogTitle"..i.."NormalText"]
							local questCheck = _G["QuestLogTitle"..i.."Check"]
							questLogTitle:SetText(" ["..level.."]"..title)
							questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+2, 0);
						elseif PIG_MaxTocversion() then
							local questLogbut = _G["QuestLogListScrollFrameButton"..i]
							if not QuestLogDummyText then
								QuestLogDummyText = questLogbut:CreateFontString();
								QuestLogDummyText:SetFontObject(GameFontNormal);
							end
							QuestLogDummyText:SetText(" ["..level.."]"..title)
							questLogbut.normalText:SetText(" ["..level.."]"..title)
							local PIG_tempWidth = 0
							PIG_tempWidth = 275 - 15 - questLogbut.tag:GetWidth();
							if ( QuestLogDummyText:GetWidth() > PIG_tempWidth ) then
								PIG_tempWidth = PIG_tempWidth;
							else
								PIG_tempWidth = QuestLogDummyText:GetWidth();
							end
							questLogbut.normalText:SetWidth(PIG_tempWidth+14);
							questLogbut.check:SetPoint("LEFT", questLogbut.normalText, "RIGHT", -16, 0);
							PIG_tempWidth=nil
						end		
					end
				end  
			end
		end
		QuestLogListScrollFrame:HookScript("OnMouseWheel", function()
		    gengxinLVQR()
		end)
		hooksecurefunc("QuestLog_Update", function()
			gengxinLVQR()
		end)
		if PIG_MaxTocversion(30000) then
			if QUESTS_DISPLAYED==6 then 
				local xssdadas = 714
				UIPanelWindows["QuestLogFrame"].width = xssdadas
				--缩放任务框架以匹配新纹理
				QuestLogFrame:SetWidth(xssdadas)
				QuestLogFrame:SetHeight(487)

				--任务日志标题移到中间
				QuestLogTitleText:ClearAllPoints();
				QuestLogTitleText:SetPoint("TOP", QuestLogFrame, "TOP", 0, -18);

				-- 任务详细说明移到右边，并增加高度
				QuestLogDetailScrollFrame:ClearAllPoints();
				QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogListScrollFrame,"TOPRIGHT", 30, 0);
				QuestLogDetailScrollFrame:SetHeight(335);

				-- 任务目录增加高度
				QuestLogListScrollFrame:SetHeight(335);

				-- 增加可显示任务目录数
				local oldQuestsDisplayed = QUESTS_DISPLAYED;
				QUESTS_DISPLAYED = QUESTS_DISPLAYED + 16;
				for i = oldQuestsDisplayed + 1, QUESTS_DISPLAYED do
				    local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate");
				    button:SetID(i);
				    button:Hide();
				    button:ClearAllPoints();
				    button:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i-1)], "BOTTOMLEFT", 0, 1);
				end

				--更换纹理
				local regions = { QuestLogFrame:GetRegions() }
				regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
				regions[3]:SetSize(512,512)

				regions[4]:ClearAllPoints()
				regions[4]:SetPoint("TOPLEFT", regions[3], "TOPRIGHT", 0, 0)
				regions[4]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
				regions[4]:SetSize(256,512)

				regions[5]:Hide()
				regions[6]:Hide()
				--调整放弃任务按钮大小位置
				QuestLogFrameAbandonButton:SetSize(110, 21)
				QuestLogFrameAbandonButton:SetText(ABANDON_QUEST_ABBREV)
				QuestLogFrameAbandonButton:ClearAllPoints()
				QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", QuestLogFrame, "BOTTOMLEFT", 17, 54)
				--调整共享任务按钮大小
				QuestFramePushQuestButton:SetSize(100, 21)
				QuestFramePushQuestButton:SetText(SHARE_QUEST_ABBREV)
				QuestFramePushQuestButton:ClearAllPoints()
				QuestFramePushQuestButton:SetPoint("LEFT", QuestLogFrameAbandonButton, "RIGHT", -3, 0)
				-- 增加显示地图按钮
				logMapButton = PIGButton(QuestLogFrame,{"LEFT", QuestFramePushQuestButton, "RIGHT", -3, 0},{80, 21},SHOW_MAP,nil,nil,nil,nil,0);
				logMapButton:SetScript("OnClick", ToggleWorldMap)
				-- 调整没有任务文字提示位置
				QuestLogNoQuestsText:ClearAllPoints();
				QuestLogNoQuestsText:SetPoint("TOP", QuestLogListScrollFrame, 0, -90);
				--隐藏没有任务时纹理
				local txset = { EmptyQuestLogFrame:GetRegions();}
				txset[1]:Hide();
				txset[2]:Hide();
				txset[3]:Hide();
				txset[4]:Hide();
			end
		end
	end
	--最贵卖价
	local rewardsFrame = QuestInfoFrame.rewardsFrame
	local rewardButtons = rewardsFrame.RewardButtons;
	QuestFrame:HookScript("OnEvent", function(self,event)
		if event == "QUEST_COMPLETE" then
			C_Timer.After(0.2,function()
				if not self:IsShown() then return end
				self.junkGGG={0,0}
				for index,butui in pairs(rewardButtons) do
					if butui.junkcoin then butui.junkcoin:Hide() end
					local questItem = QuestInfo_GetRewardButton(rewardsFrame, index);
					if questItem and questItem.objectType == "item" then
						local ItemLink=GetQuestItemLink(questItem.type, index)
						if ItemLink then
							local sellPrice= select(11, C_Item.GetItemInfo(ItemLink))
							if sellPrice and sellPrice>0 then
								if sellPrice>self.junkGGG[2] then
									self.junkGGG[2]=sellPrice
									self.junkGGG[1]=index
								end
							end
						end
					end
				end
				if self.junkGGG[1]>0 then
					local butui=rewardButtons[self.junkGGG[1]]
					if not butui.junkcoin then
						butui.junkcoin = butui:CreateTexture(nil, "OVERLAY");
						butui.junkcoin:SetAtlas("bags-junkcoin")
						butui.junkcoin:SetSize(20,18);
						butui.junkcoin:SetPoint("BOTTOMRIGHT", butui,"BOTTOMRIGHT",0, 0);
					end
					butui.junkcoin:Show()
				end
			end)
		end
	end)
end