local AtlasLoot = _G.AtlasLoot
local Achievement = AtlasLoot.Button:AddExtraType("Achievement")

function Achievement.OnSet(mainButton, descFrame)
	local typeVal = mainButton.__atlaslootinfo.extraType[2]
	descFrame.info = typeVal
	local _, name = GetAchievementInfo(typeVal)

	descFrame:AddIcon("Interface\\AchievementFrame\\UI-Achievement-TinyShield")
	descFrame:AddText(name)
end

function Achievement.OnEnter(descFrame, tooltip)
	if not descFrame.info then return end
	tooltip:SetHyperlink(GetAchievementLink(descFrame.info))
end

function Achievement.OnClick(descFrame)
	if not descFrame.info then return end
	if not C_AddOns.IsAddOnLoaded("Blizzard_AchievementUI") then
		C_AddOns.LoadAddOn("Blizzard_AchievementUI")
	end
	ShowUIPanel(AchievementFrame)
	AchievementFrame_SelectAchievement(descFrame.info)
end
