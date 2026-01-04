local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
--
local Fun=addonTable.Fun
local Data=addonTable.Data
---
local fuFrame = PIGOptionsList(L["FRAMEP_TABNAME"],"TOP")
--
local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
--
local FramePlusfun={}
addonTable.FramePlusfun=FramePlusfun
--
local FramePlusF,FramePlustabbut =PIGOptionsList_R(RTabFrame,GENERAL,70)
FramePlusF:Show()
FramePlustabbut:Selected(true)
----------------------
FramePlusF.BuffTime = PIGCheckbutton_R(FramePlusF,{"优化自身BUFF时间显示","精确显示自身BUFF/DEBUFF时间"},true)
FramePlusF.BuffTime:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["BuffTime"]=true;
		FramePlusfun.BuffTime()
	else
		PIGA["FramePlus"]["BuffTime"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end);
----
FramePlusF.Skill_QKbut = PIGCheckbutton_R(FramePlusF,{"专业界面快速切换按钮","在专业界面显示便捷切换专业按钮"},true)
FramePlusF.Skill_QKbut:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Skill_QKbut"]=true;
		FramePlusfun.Skill_QKbut()
	else
		PIGA["FramePlus"]["Skill_QKbut"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end);
FramePlusF.GemUIplus = PIGCheckbutton_R(FramePlusF,{"增强镶嵌宝石页面","在镶嵌宝石页面显示已有的宝石"},true)
FramePlusF.GemUIplus:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["GemUIplus"]=true;
	else
		PIGA["FramePlus"]["GemUIplus"]=false
	end
	PIG_OptionsUI.RLUI:Show()
end);
if PIG_MaxTocversion(60000) then
	FramePlusF.NoUseSpell = PIGCheckbutton_R(FramePlusF,{"未使用技能提示","技能页增加未使用技能提示"},true)
	FramePlusF.NoUseSpell:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["NoUseSpell"]=true;
			FramePlusfun.NoUseSpell()
		else
			PIGA["FramePlus"]["NoUseSpell"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
end
if PIG_MaxTocversion(40000) then
	FramePlusF.Spell = PIGCheckbutton_R(FramePlusF,{"未学习技能提示","技能页增加未学习技能提示"},true)
	FramePlusF.Spell:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["SpellOpen"]=true;
			FramePlusfun.Spell()
		else
			PIGA["FramePlus"]["SpellOpen"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
end
if PIG_MaxTocversion(20000) then
	local tooltip = "整合追踪类技能，点击小地图追踪技能按钮选择其他追踪技能！";
	FramePlusF.Tracking = PIGCheckbutton_R(FramePlusF,{"整合追踪技能",tooltip},true)
	FramePlusF.Tracking:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["Tracking"]=true
			FramePlusfun.Tracking()
		else
			PIGA["FramePlus"]["Tracking"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
end
--
FramePlusF:HookScript("OnShow", function(self)
	self.BuffTime:SetChecked(PIGA["FramePlus"]["BuffTime"])
	self.Skill_QKbut:SetChecked(PIGA["FramePlus"]["Skill_QKbut"])
	self.GemUIplus:SetChecked(PIGA["FramePlus"]["GemUIplus"])
	if self.NoUseSpell then self.NoUseSpell:SetChecked(PIGA["FramePlus"]["NoUseSpell"]) end
	if self.Spell then self.Spell:SetChecked(PIGA["FramePlus"]["SpellOpen"]) end
	if self.Tracking then self.Tracking:SetChecked(PIGA["FramePlus"]["Tracking"]) end
end)

---界面扩展-------------
local FrameExtF =PIGOptionsList_R(RTabFrame,L["FRAMEP_TABNAME2"],90)
FrameExtF.Merchant = PIGCheckbutton_R(FrameExtF,{"商人界面扩展","扩展商人界面为两列"})
FrameExtF.Merchant:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Merchant"]=true;
		FramePlusfun.Merchant()
	else
		PIGA["FramePlus"]["Merchant"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
FrameExtF.Friends = PIGCheckbutton_R(FrameExtF,{FRIEND.."界面扩展","扩展"..FRIEND.."界面为两列"},true)
FrameExtF.Friends:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Friends"]=true;
		FramePlusfun.Friends()
	else
		PIGA["FramePlus"]["Friends"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
FrameExtF.Macro = PIGCheckbutton_R(FrameExtF,{MACRO.."界面扩展","扩展"..MACRO.."界面为两列"},true)
FrameExtF.Macro:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Macro"]=true;
	else
		PIGA["FramePlus"]["Macro"]=false
	end
	PIG_OptionsUI.RLUI:Show()
end)
---
if PIG_MaxTocversion() then
	FrameExtF.Quest = PIGCheckbutton_R(FrameExtF,{"任务界面扩展",""},true)
	if PIG_MaxTocversion(30000) then
		FrameExtF.Quest.tooltip= "扩展任务界面为两列,左边任务列表，右边任务详情,显示任务等级\n提示任务奖励最贵物品";
	else
		FrameExtF.Quest.tooltip= "任务列表显示任务等级\n提示任务奖励最贵物品";
	end
	FrameExtF.Quest:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["Quest"]=true;
			FramePlusfun.Quest()
		else
			PIGA["FramePlus"]["Quest"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end);
	--
	FrameExtF.Skill = PIGCheckbutton_R(FrameExtF,{"专业界面扩展","扩展专业技能界面为两列；左边配方列表，右边配方详情"},true)
	FrameExtF.Skill:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["Skill"]=true;
			FramePlusfun.Skill()
		else
			PIGA["FramePlus"]["Skill"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
	if PIG_MaxTocversion(40000) then
		FrameExtF.Trainer = PIGCheckbutton_R(FrameExtF,{"训练师界面扩展","扩展训练师界面为两列"},true)
		FrameExtF.Trainer:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["Trainer"]=true;
				FramePlusfun.Trainer()
			else
				PIGA["FramePlus"]["Trainer"]=false
				PIG_OptionsUI.RLUI:Show()
			end
		end)
		FrameExtF.Talent = PIGCheckbutton_R(FrameExtF,{"天赋界面扩展"," "},true)
		if PIG_MaxTocversion(30000) then
			FrameExtF.Talent.tooltip= "在一页显示三系天赋";
		else
			FrameExtF.Talent.tooltip= "在一页显示三系天赋和雕文";
		end
		FrameExtF.Talent:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["Talent"]=true;
				FramePlusfun.Talent()
			else
				PIGA["FramePlus"]["Talent"]=false
				PIG_OptionsUI.RLUI:Show()
			end
		end)
	end
end
FrameExtF:HookScript("OnShow", function(self)
	self.Merchant:SetChecked(PIGA["FramePlus"]["Merchant"])
	self.Friends:SetChecked(PIGA["FramePlus"]["Friends"])
	self.Macro:SetChecked(PIGA["FramePlus"]["Macro"])
	if self.Quest then self.Quest:SetChecked(PIGA["FramePlus"]["Quest"]) end
	if self.Skill then self.Skill:SetChecked(PIGA["FramePlus"]["Skill"]) end
	if self.Trainer then self.Trainer:SetChecked(PIGA["FramePlus"]["Trainer"]) end
	if self.Talent then self.Talent:SetChecked(PIGA["FramePlus"]["Talent"]) end
end)

--角色信息界面
local CharacterF =PIGOptionsList_R(RTabFrame,CHARACTER_BUTTON,90)
---
CharacterF.Character_Durability = PIGCheckbutton_R(CharacterF,{DISPLAY..EQUIPSET_EQUIP..DURABILITY,CHARACTER_BUTTON.."界面显示装备耐久剩余值"})
CharacterF.Character_Durability:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Character_Durability"]=true;
		FramePlusfun.Character_ADD()
	else
		PIGA["FramePlus"]["Character_Durability"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
CharacterF.Character_ItemLevel = PIGCheckbutton_R(CharacterF,{DISPLAY..STAT_AVERAGE_ITEM_LEVEL,DISPLAY..STAT_AVERAGE_ITEM_LEVEL.."，背包银行物品需要显示装等请在背包内设置"})
CharacterF.Character_ItemLevel:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Character_ItemLevel"]=true
		FramePlusfun.Character_ADD()
	else
		PIGA["FramePlus"]["Character_ItemLevel"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
CharacterF.Character_ItemColor = PIGCheckbutton_R(CharacterF,{DISPLAY_BORDERS..PET_BATTLE_STAT_QUALITY,"根据品质染色装备边框"})
CharacterF.Character_ItemColor:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Character_ItemColor"]=true
		FramePlusfun.Character_ADD()
	else
		PIGA["FramePlus"]["Character_ItemColor"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
CharacterF.Character_ItemList = PIGCheckbutton_R(CharacterF,{DISPLAY.."装备列表",CHARACTER_BUTTON.."界面右侧显示装备列表"})
CharacterF.Character_ItemList:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Character_ItemList"]=true
		FramePlusfun.Character_ADD()
	else
		PIGA["FramePlus"]["Character_ItemList"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)

--角色信息UI扩展
local newText=Fun.Delmaohaobiaodain(REPAIR_COST)
if PIG_MaxTocversion(30000) then
	CharacterF.Shuxingtishi=CHARACTER_INFO.."扩展("..PAPERDOLL_SIDEBAR_STATS.."/"..EQUIPMENT_MANAGER.."/"..newText.."/"..COMBAT_RATING_NAME6.."说明"..")"
elseif PIG_MaxTocversion(40000) then
	CharacterF.Shuxingtishi=CHARACTER_INFO.."扩展("..EQUIPMENT_MANAGER.."/"..newText.."/"..COMBAT_RATING_NAME6.."说明"..")"
elseif PIG_MaxTocversion() then
	CharacterF.Shuxingtishi="常驻"..DISPLAY..PAPERDOLL_SIDEBAR_STATS
else
	CharacterF.Shuxingtishi=CHARACTER_INFO..DISPLAY..newText
end
CharacterF.Character_Shuxing = PIGCheckbutton_R(CharacterF,{CharacterF.Shuxingtishi})
CharacterF.Character_Shuxing:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Character_Shuxing"]=true
		FramePlusfun.Character_Shuxing()
	else
		PIGA["FramePlus"]["Character_Shuxing"]=false
		PIG_OptionsUI.RLUI:Show()
	end
	_G[Data.QuickButUIname].ButList[5]()
end)
CharacterF:HookScript("OnShow", function(self)
	self.Character_Durability:SetChecked(PIGA["FramePlus"]["Character_Durability"])
	self.Character_ItemLevel:SetChecked(PIGA["FramePlus"]["Character_ItemLevel"])
	self.Character_ItemColor:SetChecked(PIGA["FramePlus"]["Character_ItemColor"])
	self.Character_ItemList:SetChecked(PIGA["FramePlus"]["Character_ItemList"])
	self.Character_Shuxing:SetChecked(PIGA["FramePlus"]["Character_Shuxing"])
end)
local LootRollF =PIGOptionsList_R(RTabFrame,LOOT,90)
LootRollF.Loot = PIGCheckbutton_R( LootRollF,{SLASH_TEXTTOSPEECH_LOOT..UIOPTIONS_MENU.."扩展",SLASH_TEXTTOSPEECH_LOOT..UIOPTIONS_MENU.."物品显示在一页，并且可以通报"},true)
LootRollF.Loot:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["Loot"]=true;
		 FramePlusfun.Loot()
	else
		PIGA["FramePlus"]["Loot"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end)
---
function FramePlusfun.LootMasterErr() end
if PIG_MaxTocversion() then
	--修复队长分配错误
	function FramePlusfun.LootMasterErr()
		if PIGA["FramePlus"]["LootMasterErr"] then
			local old_MasterLooterFrame_Show=MasterLooterFrame_Show
			MasterLooterFrame_Show=function(selectedLootButton)
				MasterLooterFrame:ClearAllPoints();
				old_MasterLooterFrame_Show(selectedLootButton)
			end
		end
	end
	LootRollF.Loot.LootMasterErr = PIGCheckbutton(LootRollF.Loot,{"LEFT",LootRollF.Loot.Text,"RIGHT",100,0},{"修复队长分配错误"})
	LootRollF.Loot.LootMasterErr:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["LootMasterErr"]=true;
			 FramePlusfun.LootMasterErr()
		else
			PIGA["FramePlus"]["LootMasterErr"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
	LootRollF.Roll = PIGCheckbutton_R( LootRollF,{LOOT_ROLL..UIOPTIONS_MENU.."扩展","合并"..LOOT_ROLL.."物品到一起，并且可以移动"},true)
	LootRollF.Roll:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["FramePlus"]["Roll"]=true;
			 FramePlusfun.Roll()
		else
			PIGA["FramePlus"]["Roll"]=false
			PIG_OptionsUI.RLUI:Show()
		end
	end)
	local Scaleinfo = {0.8,2,0.01,{["Right"]="%"}}
	local function ISopenUI(Funx)
		if _G[FramePlusfun.RollListUIname] then Funx() end
	end
	LootRollF.Roll.SliderT = PIGFontString( LootRollF.Roll,{"LEFT", LootRollF.Roll.Text,"RIGHT",20,0},"缩放")
	LootRollF.Roll.Slider = PIGSlider(LootRollF.Roll,{"LEFT", LootRollF.Roll.SliderT,"RIGHT",4,0},Scaleinfo)	
	function LootRollF.Roll.Slider:PIGOnValueChange(arg1)
		if InCombatLockdown() then PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT) return end
		PIGA["FramePlus"]["RollScale"]=arg1;
		ISopenUI(FramePlusfun.RollDebugUI)
	end
	LootRollF.Debug = PIGButton(LootRollF,{"LEFT", LootRollF.Roll.Slider,"RIGHT",80,0},{50,22},"测试")
	LootRollF.Debug:SetScript("OnClick", function (self)
		ISopenUI(FramePlusfun.RollDebugUI)
	end)
	LootRollF.CZ = PIGButton(LootRollF,{"LEFT", LootRollF.Debug,"RIGHT",40,0},{50,22},"重置")
	LootRollF.CZ:SetScript("OnClick", function (self)
		PIGA["FramePlus"]["RollScale"]=addonTable.Default["FramePlus"]["RollScale"]
		LootRollF.Roll.Slider:PIGSetValue(PIGA["FramePlus"]["RollScale"])
		ISopenUI(FramePlusfun.RollCZ)
	end)
end
LootRollF:HookScript("OnShow", function(self)
	self.Loot:SetChecked(PIGA["FramePlus"]["Loot"])
	if self.Roll then
		if self.Loot.LootMasterErr then self.Loot.LootMasterErr:SetChecked(PIGA["FramePlus"]["LootMasterErr"]) end
		self.Roll:SetChecked(PIGA["FramePlus"]["Roll"])  self.Roll.Slider:PIGSetValue(PIGA["FramePlus"]["RollScale"]) 
	end
end)
--小部件
local UIWidgetF =PIGOptionsList_R(RTabFrame,"小部件",90)
UIWidgetF.Open = PIGCheckbutton(UIWidgetF,{"TOPLEFT",UIWidgetF,"TOPLEFT",20,-20},{"移动小部件(占塔/战场积分)","移动屏幕顶部中央的小部件(占塔/战场积分)"})
UIWidgetF.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["UIWidget"]=true;
		FramePlusfun.UIWidget()
	else
		PIGA["FramePlus"]["UIWidget"]=false
		PIG_OptionsUI.RLUI:Show()
	end
end);
UIWidgetF.pianyiX = PIGSlider(UIWidgetF,{"TOPLEFT",UIWidgetF,"TOPLEFT",20,-60},{-700,700,1,{["Right"]="X偏移%s"}})
function UIWidgetF.pianyiX:PIGOnValueChange(arg1)
	PIGA["FramePlus"]["UIWidgetPointX"]=arg1;
	FramePlusfun.UIWidget()
end
UIWidgetF.pianyiY = PIGSlider(UIWidgetF,{"TOPLEFT",UIWidgetF.pianyiX,"BOTTOMLEFT",0,-10},{-500,15,1,{["Right"]="Y偏移%s"}})
function UIWidgetF.pianyiY:PIGOnValueChange(arg1)
	PIGA["FramePlus"]["UIWidgetPointY"]=arg1
	FramePlusfun.UIWidget()
end
function FramePlusfun.UIWidget()
	if not PIGA["FramePlus"]["UIWidget"] then return end
	UIWidgetTopCenterContainerFrame:SetPoint("TOP", 0+PIGA["FramePlus"]["UIWidgetPointX"], -15+PIGA["FramePlus"]["UIWidgetPointY"]);
end
--
UIWidgetF:HookScript("OnShow", function (self)
	self.Open:SetChecked(PIGA["FramePlus"]["UIWidget"])
	self.pianyiX:PIGSetValue(PIGA["FramePlus"]["UIWidgetPointX"])
	self.pianyiY:PIGSetValue(PIGA["FramePlus"]["UIWidgetPointY"])
end);
--
local FrameMovF =PIGOptionsList_R(RTabFrame,"移动/缩放",90)
local BlizzardUIList={
	{true,  nil, "CharacterFrame",nil,"角色信息"},
	{true,  nil, "SpellBookFrame",nil,"技能书"},
	{false, nil, "QuestLogFrame",nil,"任务日志"},
	{false, nil, "FriendsFrame",nil,"社交"},
	{false, nil, "LFGParentFrame",nil,"寻求组队(60)"},
	{false, nil, "PVEFrame",nil,"队伍查找器"},
	{false, nil, "MailFrame",nil,"邮箱"},
	{false, nil, "ChannelFrame",nil,"聊天频道"},
	{false, nil, "AddonList",nil,"插件列表"},
	{false, nil, "MerchantFrame",nil,"商人"},
	{false, nil, "GossipFrame",nil,"NPC对话"},
	{false, nil, "QuestFrame",nil,"NPC对话(任务)"},
	{false, nil, "BankFrame",nil,"银行"},
	{false, nil, "LootFrame",nil,"掉落列表"},
	{false, nil, "WorldMapFrame",nil,"世界地图"},
	{false, nil, "WorldMapFrame", "WorldMapTitleButton", "世界地图(mini模式)"},
	{false, nil, "GameMenuFrame",nil, "ESC菜单"},
	{false, nil, "SettingsPanel",nil, "设置选项"},
	{false, nil, "HelpFrame",nil, "客服支持"},
	{false, nil, "ContainerFrameCombinedBags",{"ContainerFrameCombinedBags","TitleContainer"}, "整合背包",true},
	{false, "Blizzard_MacroUI","MacroFrame",nil,"宏命令"},
	{false, "Blizzard_AchievementUI","AchievementFrame",{"AchievementFrame","Header"},"成就"},
	{false, "Blizzard_Communities","CommunitiesFrame",nil,"公会与社区"},
	{true,  "Blizzard_Collections","CollectionsJournal",nil,"战团/藏品"},
	{false, "Blizzard_EncounterJournal","EncounterJournal",nil,"冒险手册"},
	{false, "Blizzard_TradeSkillUI","TradeSkillFrame",nil,"专业"},
	{false, "Blizzard_ProfessionsBook","ProfessionsBookFrame",nil,"专业(新版)"},
	{false, "Blizzard_Professions","ProfessionsFrame",nil,"专业(新版)"},
	{false, "Blizzard_CraftUI","CraftFrame",nil,"附魔"},
	{false, "Blizzard_TrainerUI","ClassTrainerFrame",nil,"训练师"},
	{false, "Blizzard_InspectUI","InspectFrame",nil,"观察"},
	{false, "Blizzard_GuildBankUI","GuildBankFrame",nil,"公会银行"},
	{false, "Blizzard_Calendar","CalendarFrame",nil,"日历"},
	{false, "Blizzard_AuctionUI","AuctionFrame",nil,"拍卖行"},
	{false, "Blizzard_AuctionHouseUI","AuctionHouseFrame",nil,"拍卖行(新版)"},
	{false, "Blizzard_TalentUI","PlayerTalentFrame",nil,"天赋"},
	{false, "Blizzard_PlayerSpells","PlayerSpellsFrame",nil,"天赋(新版)"},--有BUG
}
FramePlusfun.BlizzardUIList=BlizzardUIList
FrameMovF.MoveF = PIGFrame(FrameMovF,{"TOPLEFT",FrameMovF,"TOPLEFT",0,-30})
FrameMovF.MoveF:SetPoint("BOTTOMRIGHT",FrameMovF,"BOTTOMRIGHT",0,0);
FrameMovF.MoveF:PIGSetBackdrop(0)
FrameMovF.MoveF.BlizzardUI_Move = PIGCheckbutton(FrameMovF.MoveF,{"BOTTOMLEFT",FrameMovF.MoveF,"TOPLEFT",40,2},{"解锁(移动)暴雪界面","解锁下方列表界面，拖动界面标题栏移动"})
FrameMovF.MoveF.BlizzardUI_Move:SetScript("OnClick", function (self)
	if InCombatLockdown() then self:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move"]) PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
	if self:GetChecked() then
		PIGA["FramePlus"]["BlizzardUI_Move"]=true;
		FramePlusfun.BlizzardUI_Move()
	else
		PIGA["FramePlus"]["BlizzardUI_Move"]=false
		PIG_OptionsUI.RLUI:Show()
	end
	FrameMovF.MoveF.ScrollF:UpdateShowList()
end);
FrameMovF.MoveF.BlizzardUI_Move.Save = PIGCheckbutton(FrameMovF.MoveF,{"LEFT",FrameMovF.MoveF.BlizzardUI_Move.Text,"RIGHT",60,0},{"保存移动后位置","保存移动后位置\n注意:个别UI涉及到安全保护可能无法战斗中移动/保存位置"})
FrameMovF.MoveF.BlizzardUI_Move.Save:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["FramePlus"]["BlizzardUI_Move_Save"]=true	
	else
		PIGA["FramePlus"]["BlizzardUI_Move_Save"]=false
	end
end);
FrameMovF.MoveF.CZ = PIGButton(FrameMovF.MoveF,{"BOTTOMRIGHT",FrameMovF.MoveF,"TOPRIGHT",0,2},{170,22},"重置暴雪界面位置/缩放")
FrameMovF.MoveF.CZ:SetScript("OnClick", function ()
	PIGA["Blizzard_UI"]=addonTable.Default["Blizzard_UI"]
	PIGA["FramePlus"]["BlizzardUI_Not"]=addonTable.Default["BlizzardUI_Not"]
	PIG_print("已重置暴雪UI位置/缩放")
	PIG_OptionsUI.RLUI:Show()
end);
FrameMovF.MoveF.ScrollF=Create.PIGScrollFrame_old(FrameMovF.MoveF,{0,0,0,0})
FrameMovF.MoveF.butList={}
local ButNumC,hangLHH,hangLWW=21,22,FrameMovF.MoveF:GetWidth()-16
local function UpdatehangEnter(uix,highlight)
	uix:HookScript("OnEnter", function ()
		highlight:Show()
	end);
	uix:HookScript("OnLeave", function ()
		highlight:Hide()
	end);
end
for i=1,ButNumC do
	local hangL = CreateFrame("Frame", nil, FrameMovF.MoveF,"BackdropTemplate");
	FrameMovF.MoveF.butList[i]=hangL
	hangL:SetBackdrop({bgFile = "interface/chatframe/chatframebackground.blp"});
	hangL:SetSize(hangLWW,hangLHH);
	hangL:SetBackdropColor(0.2, 0.2, 0.2, 0.2);
	if i==1 then
		hangL:SetPoint("TOPLEFT",FrameMovF.MoveF,"TOPLEFT",0,0);
	else
		hangL:SetPoint("TOP",FrameMovF.MoveF.butList[i-1],"BOTTOM",0,0);
	end
	hangL.highlight = hangL:CreateTexture(nil,"HIGHLIGHT");
	hangL.highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
	hangL.highlight:SetBlendMode("ADD")
	hangL.highlight:SetAllPoints(hangL)
	hangL.highlight:SetAlpha(0.6);
	hangL.highlight:Hide();
	UpdatehangEnter(hangL,hangL.highlight)
	hangL.nameText = PIGFontString(hangL,{"LEFT",hangL,"LEFT",4,0},"UI")
	hangL.Check = PIGCheckbutton(hangL,{"LEFT",hangL,"LEFT",290,0},{"解锁移动"},{15,15})
	hangL.Check:HookScript("OnClick", function (self)
		if PIGA["FramePlus"]["BlizzardUI_Not"][self:GetParent().uiname] then
			PIGA["FramePlus"]["BlizzardUI_Not"][self:GetParent().uiname]=nil
		else
			PIGA["FramePlus"]["BlizzardUI_Not"][self:GetParent().uiname]=true
		end
		PIG_OptionsUI.RLUI:Show()
	end);
	hangL.scale = PIGSlider(hangL,{"LEFT",hangL,"LEFT",390,0},{0.6,1.8,0.01,{["Right"]="缩放%d%%"}})
	hangL.scale:SetHeight(hangLHH)
	function hangL.scale:PIGOnValueChange(arg1)
		if hangL.protection and InCombatLockdown() then 
			PIG_OptionsUI:ErrorMsg("战斗中无法设置")
			return
		end
		local MovingUIName=self:GetParent().uiname
		if PIGA["FramePlus"]["BlizzardUI_Not"][MovingUIName] then return end
		if _G[MovingUIName] then 
			_G[MovingUIName]:SetScale(arg1);
		end
		PIGA["Blizzard_UI"][MovingUIName]=PIGA["Blizzard_UI"][MovingUIName] or {}
		if arg1==1 then PIGA["Blizzard_UI"][MovingUIName]["Scale"]=nil return end
		PIGA["Blizzard_UI"][MovingUIName]["Scale"]=arg1
	end
end
function FrameMovF.MoveF.ScrollF:UpdateShowList()
    for i = 1, ButNumC do
        local hangL = FrameMovF.MoveF.butList[i]
        hangL:Hide()
    end
   	local TotalNum = #BlizzardUIList
   	local offset = self:GetScrollFrameOffset(TotalNum, ButNumC, hangLHH)
    for i = 1, ButNumC do
        local Index = i + offset
        if BlizzardUIList[Index] then
        	local hangL = FrameMovF.MoveF.butList[i]
        	hangL:Show()
        	hangL.uiname=BlizzardUIList[Index][3]
        	hangL.protection=BlizzardUIList[Index][1]
        	hangL.nameText:SetText(BlizzardUIList[Index][5]..BlizzardUIList[Index][3])
        	if PIGA["FramePlus"]["BlizzardUI_Move"] then
				hangL.nameText:SetTextColor(1, 1, 1, 0.9)
    		else
				hangL.nameText:SetTextColor(0.5, 0.5, 0.5, 0.9)
    		end
        	hangL.scale:SetEnabled(PIGA["FramePlus"]["BlizzardUI_Move"])
        	hangL.Check:SetChecked(not PIGA["FramePlus"]["BlizzardUI_Not"][BlizzardUIList[Index][3]])
			hangL.Check:SetEnabled(PIGA["FramePlus"]["BlizzardUI_Move"])
			hangL.scale:PIGSetValue(PIGA["Blizzard_UI"][BlizzardUIList[Index][3]] and PIGA["Blizzard_UI"][BlizzardUIList[Index][3]]["Scale"] or 1)
        end
    end
end
FrameMovF.MoveF:HookScript("OnShow", function (self)
	self.ScrollF:UpdateShowList()
	self.BlizzardUI_Move:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move"])
	self.BlizzardUI_Move.Save:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move_Save"])
end);

--==================================
addonTable.FramePlus = function()
	FramePlusfun.BuffTime()
	FramePlusfun.Skill_QKbut()
	FramePlusfun.Tracking()
	FramePlusfun.GemUIplus()
	FramePlusfun.Loot()
	FramePlusfun.LootMasterErr()
	FramePlusfun.Roll()
	FramePlusfun.Merchant()
	FramePlusfun.Friends()
	FramePlusfun.Macro()
	FramePlusfun.Quest()
	FramePlusfun.Skill()
	FramePlusfun.Trainer()
	FramePlusfun.NoUseSpell()
	FramePlusfun.Spell()
	FramePlusfun.Character_ADD()
	FramePlusfun.Talent()
	FramePlusfun.Character_Shuxing()
	FramePlusfun.BlizzardUI_Move()
	FramePlusfun.UIWidget()
end