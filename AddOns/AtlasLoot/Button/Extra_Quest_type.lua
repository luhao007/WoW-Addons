local AtlasLoot = _G.AtlasLoot
local Quest = AtlasLoot.Button:AddExtraType("Quest")

local QUEST_ICONS = {
	[0] = "Interface\\GossipFrame\\AvailableQuestIcon",       -- normal
	[1] = "Interface\\GossipFrame\\DailyQuestIcon",           -- daily
	[2] = "Interface\\GossipFrame\\AvailableLegendaryQuestIcon", -- legendary
}

function Quest.OnSet(mainButton, descFrame)
	local typeVal = mainButton.__atlaslootinfo.extraType[2]
	descFrame.info = typeVal

	QuestEventListener:AddCallback(typeVal, function()
		local name = C_QuestLog.GetTitleForQuestID(typeVal)
		descFrame:AddIcon(QUEST_ICONS[0])
		descFrame:AddText(name)
	end)
end

function Quest.OnEnter(descFrame, tooltip)
	if not descFrame.info then return end
	tooltip:SetHyperlink("quest:"..descFrame.info)
end
