local _, addonTable = ...;
local GeneralFun=addonTable.GeneralFun
----自动对话
local cfff = CreateFrame("Frame")
local function duorenwuduihua()
	--交任务
	if PIGA['Interaction']['AutoJiaorenwu'] then
			local activeQuestCount =C_GossipInfo.GetNumActiveQuests()
			local gossipActiveQuests = { C_GossipInfo.GetActiveQuests() };
			for i=1,activeQuestCount do
				if gossipActiveQuests[i] then
					for _,vv in pairs(gossipActiveQuests[i]) do
						if (vv.isComplete) then
							C_GossipInfo.SelectActiveQuest(vv.questID)
						end
					end
				end
			end
	end
	--接任务
	if PIGA['Interaction']['AutoJierenwu'] then
			local availableQuestCount  = C_GossipInfo.GetNumAvailableQuests();
			local gossipAvailableQuests = { C_GossipInfo.GetAvailableQuests() };
			for i=1,availableQuestCount do
				if gossipAvailableQuests[i] then
					for _,vv in pairs(gossipAvailableQuests[i]) do
						if (not vv.isTrivial) then
							C_GossipInfo.SelectAvailableQuest(vv.questID)
						end
					end
				end
			end
	end
end
local NoDialogue = {
	33662,--取消奥杜尔BUFF
	37119,--取消ICCBUFF
	35646,--虫洞
}
local function IsNoDialogue(npcID)
	for i=1,#NoDialogue do
		if npcID==NoDialogue[i] then
			return true
		end
	end
	return false
end
cfff:SetScript("OnEvent", function(self,event)
	if IsShiftKeyDown() then return end
	local targetGUID =UnitGUID("NPC")
	if targetGUID then
		if PIGisSecret(targetGUID) then return end
		local unitType, _, _, _, _, npcID = strsplit("-", targetGUID)
		if unitType and npcID and unitType=="Creature" then
			if IsNoDialogue(tonumber(npcID)) then return end
		end
	end
	if event=="QUEST_DETAIL" then--接
		if PIGA['Interaction']['AutoJierenwu'] then
			AcceptQuest()
		end
	elseif event=="QUEST_PROGRESS" then--交
		if PIGA['Interaction']['AutoJiaorenwu'] then
			if (IsQuestCompletable()) then
				CompleteQuest();
			end
		end
	elseif event=="QUEST_COMPLETE" then
		if PIGA['Interaction']['AutoJiaorenwu'] then
			if GetNumQuestChoices() <= 1 then
				GetQuestReward(1);
			end
		end
	elseif event=="QUEST_GREETING" then--多任务
		duorenwuduihua()
	elseif event=="GOSSIP_SHOW" then--对话/任务
		local kejierenwu = C_GossipInfo.GetNumActiveQuests() --返回此 NPC 提供的任务（您尚未参与）的数量
		local jiaofurenwu = C_GossipInfo.GetNumAvailableQuests() --返回你最终应该交给这个 NPC 的活动任务的数量。
		local zongjirenwu=kejierenwu+jiaofurenwu
		if zongjirenwu>0 then
			duorenwuduihua()
		else
			if PIGA['Interaction']['AutoDialogue'] then
				local options = C_GossipInfo.GetOptions() --NPC对话选项
				local zongjirenwu=#options
				if zongjirenwu==1 then
					C_GossipInfo.SelectOption(options[1].gossipOptionID)
				else
					if PIGA["Interaction"]["AutoDialogueIndex"]>0 then
						for k,v in pairs(options) do
							if (v.orderIndex+1)==PIGA["Interaction"]["AutoDialogueIndex"] then
								C_GossipInfo.SelectOption(v.gossipOptionID)
							end
						end
					end
				end
			end
		end	
	end
end)
function GeneralFun.Interaction_AutoDialogue()
	if PIGA['Interaction']['AutoDialogue'] or PIGA['Interaction']['AutoJierenwu'] or PIGA['Interaction']['AutoJiaorenwu'] then
		cfff:RegisterEvent("GOSSIP_SHOW")
		cfff:RegisterEvent("QUEST_DETAIL")--显示任务详情时
		cfff:RegisterEvent("QUEST_FINISHED")--任务框架更改
		cfff:RegisterEvent("QUEST_PROGRESS")--当玩家与 NPC 谈论任务状态并且尚未点击完成按钮时触发
		cfff:RegisterEvent("QUEST_GREETING")-- 与提供或接受多个任务（即有多个活动或可用任务）的 NPC 交谈时触发
		cfff:RegisterEvent("QUEST_COMPLETE") --任务对话框显示了奖励和完成按钮可用
	else
		cfff:UnregisterEvent("GOSSIP_SHOW")
		cfff:UnregisterEvent("QUEST_DETAIL")
		cfff:UnregisterEvent("QUEST_FINISHED")
		cfff:UnregisterEvent("QUEST_PROGRESS")
		cfff:UnregisterEvent("QUEST_GREETING")
		cfff:UnregisterEvent("QUEST_COMPLETE") 
	end
end