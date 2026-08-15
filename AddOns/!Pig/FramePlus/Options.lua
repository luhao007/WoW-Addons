local addonName, PD = ...;
local L=PD.locale
---
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGDiyBut=Create.PIGDiyBut
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
--
local Fun=PD.Fun
local Data=PD.Data
local AudioData=PD.Audio.Data.QuestEnd
--
local FramePlusfun={}
FramePlusfun.AudioData=AudioData
PD.FramePlusfun=FramePlusfun
---
function FramePlusfun.LootMasterErr()--修复队长分配错误
	if PIG_MaxTocversion() then
		if PIGA["FramePlus"]["LootMasterErr"] then
			local old_MasterLooterFrame_Show=MasterLooterFrame_Show
			MasterLooterFrame_Show=function(selectedLootButton)
				MasterLooterFrame:ClearAllPoints();
				old_MasterLooterFrame_Show(selectedLootButton)
			end
		end
	end
end
function FramePlusfun.UIWidget()
	if not PIGA["FramePlus"]["UIWidget"] then return end
	UIWidgetTopCenterContainerFrame:SetPoint("TOP", 0+PIGA["FramePlus"]["UIWidgetPointX"], -15+PIGA["FramePlus"]["UIWidgetPointY"]);
end
--==============
PD.FramePlus = function()
	FramePlusfun.QuestsEnd()
	FramePlusfun.QuestLevel()
	FramePlusfun.QuestSellMax()
	FramePlusfun.BuffTime()
	FramePlusfun.Skill_QKbut()
	FramePlusfun.Tracking()
	FramePlusfun.GemUIplus()
	FramePlusfun.Loot()
	FramePlusfun.LootMasterErr()
	FramePlusfun.Roll()
	FramePlusfun.Merchant()
	FramePlusfun.PetStable()
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
function PD.addOptions_FramePlus()
	local fuFrame = PIGOptionsList(L["FRAMEP_TABNAME"],"TOP")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)

	local FramePlusF,FramePlustabbut =PIGOptionsList_R(RTabFrame,GENERAL,70)
	FramePlusF:Show()
	FramePlustabbut:Selected(true)
	FramePlusF:HookScript("OnShow", function()
		if FramePlusF.QuestsEnd then return end
		---任务提示音
		FramePlusF.QuestsEnd =PIGCheckbutton_R(FramePlusF,{"任务完成提示音","任务完成提示音"},true)
		FramePlusF.QuestsEnd:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Common"]["QuestsEnd"]=true;	
			else
				PIGA["Common"]["QuestsEnd"]=false;
			end
			FramePlusfun.QuestsEnd()
		end);
		FramePlusF.QuestsEnd.xiala=PIGDownMenu(FramePlusF.QuestsEnd,{"LEFT",FramePlusF.QuestsEnd.Text, "RIGHT", 4,0},{180,24})
		function FramePlusF.QuestsEnd.xiala:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#AudioData,1 do
			    info.text, info.arg1 = AudioData[i][1], i
			    info.checked = i==PIGA["Common"]["QuestsEndAudio"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function FramePlusF.QuestsEnd.xiala:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Common"]["QuestsEndAudio"]=arg1
			PIGCloseDropDownMenus()
		end
		FramePlusF.QuestsEnd.PlayBut =PIGDiyBut(FramePlusF.QuestsEnd,{"LEFT",FramePlusF.QuestsEnd.xiala,"RIGHT",8,0},{24,24,nil,nil,"chatframe-button-icon-speaker-on",130757});
		FramePlusF.QuestsEnd.PlayBut:SetScript("OnClick", function()
			PIG_PlaySoundFile(AudioData[PIGA["Common"]["QuestsEndAudio"]])
		end)
		FramePlusF.QuestsEnd:SetChecked(PIGA["Common"]["QuestsEnd"]);
		FramePlusF.QuestsEnd.xiala:PIGDownMenu_SetText(AudioData[PIGA["Common"]["QuestsEndAudio"]][1])

		FramePlusF.QuestLevel = PIGCheckbutton_R(FramePlusF,{"任务界面显示任务等级"},true)
		FramePlusF.QuestLevel:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["QuestLevel"]=true;
				FramePlusfun.QuestLevel()
			else
				PIGA["FramePlus"]["QuestLevel"]=false
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		FramePlusF.QuestSellMax = PIGCheckbutton_R(FramePlusF,{"任务奖励显示最贵卖价"},true)
		FramePlusF.QuestSellMax:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["QuestSellMax"]=true;
				FramePlusfun.QuestSellMax()
			else
				PIGA["FramePlus"]["QuestSellMax"]=false
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		FramePlusF.QuestLevel:SetChecked(PIGA["FramePlus"]["QuestLevel"])
		FramePlusF.QuestSellMax:SetChecked(PIGA["FramePlus"]["QuestSellMax"])
		----
		if PIG_MaxTocversion(120000) then
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
			FramePlusF.BuffTime:SetChecked(PIGA["FramePlus"]["BuffTime"])
		end
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
		FramePlusF.Skill_QKbut:SetChecked(PIGA["FramePlus"]["Skill_QKbut"])
		FramePlusF.GemUIplus:SetChecked(PIGA["FramePlus"]["GemUIplus"])
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
			FramePlusF.NoUseSpell:SetChecked(PIGA["FramePlus"]["NoUseSpell"])
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
			FramePlusF.Spell:SetChecked(PIGA["FramePlus"]["SpellOpen"])
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
			FramePlusF.Tracking:SetChecked(PIGA["FramePlus"]["Tracking"])
		end
		FramePlusF.wupinLV = PIGCheckbutton_R(FramePlusF,{DISPLAY..STAT_AVERAGE_ITEM_LEVEL},true)
		FramePlusF.wupinLV:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["BagBank"]["wupinLV"]=true
			else
				PIGA["BagBank"]["wupinLV"]=false
			end
			PIG_OptionsUI.RLUI:Show()
		end)
		FramePlusF.wupinRanse = PIGCheckbutton_R(FramePlusF,{DISPLAY_BORDERS..COLORBLIND_ITEM_QUALITY},true)
		FramePlusF.wupinRanse:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["BagBank"]["wupinRanse"]=true
			else
				PIGA["BagBank"]["wupinRanse"]=false
			end
			PIG_OptionsUI.RLUI:Show()
		end)
		--
		FramePlusF.wupinLV:SetChecked(PIGA["BagBank"]["wupinLV"])
		FramePlusF.wupinRanse:SetChecked(PIGA["BagBank"]["wupinRanse"])
	end)
	---界面扩展-------------
	local FrameExtF =PIGOptionsList_R(RTabFrame,L["FRAMEP_TABNAME2"],90)
	FrameExtF:HookScript("OnShow", function()
		if FrameExtF.Merchant then return end
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
		FrameExtF.Merchant:SetChecked(PIGA["FramePlus"]["Merchant"])
		FrameExtF.Friends:SetChecked(PIGA["FramePlus"]["Friends"])
		FrameExtF.Macro:SetChecked(PIGA["FramePlus"]["Macro"])
		---
		if PIG_MaxTocversion(50000,true) and PIG_MaxTocversion(60000) then
			FrameExtF.PetStable = PIGCheckbutton_R(FrameExtF,{"兽栏界面扩展","扩展兽栏界面"},true)
			FrameExtF.PetStable:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["FramePlus"]["PetStable"]=true;
					FramePlusfun.PetStable()
				else
					PIGA["FramePlus"]["PetStable"]=false
					PIG_OptionsUI.RLUI:Show()
				end
			end)
			FrameExtF.PetStable:SetChecked(PIGA["FramePlus"]["PetStable"])
		end
		if PIG_MaxTocversion() then
			FrameExtF.Skill = PIGCheckbutton_R(FrameExtF,{TRADE_SKILLS.."界面扩展","扩展"..TRADE_SKILLS.."界面为两列"},true)
			FrameExtF.Skill:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["FramePlus"]["Skill"]=true;
					FramePlusfun.Skill()
				else
					PIGA["FramePlus"]["Skill"]=false
					PIG_OptionsUI.RLUI:Show()
				end
			end)
			FrameExtF.Skill:SetChecked(PIGA["FramePlus"]["Skill"])
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
			FrameExtF.Trainer:SetChecked(PIGA["FramePlus"]["Trainer"])

			if PIG_MaxTocversion() then
				local Questtooltip= "扩展"..QUESTS_LABEL.."界面为两列";
				if PIG_MaxTocversion(29999,true) then
					Questtooltip= "增加全部展开/折叠按钮";
				end
				FrameExtF.Quest = PIGCheckbutton_R(FrameExtF,{QUESTS_LABEL.."界面扩展","扩展"..QUESTS_LABEL.."界面为两列"},true)
				FrameExtF.Quest:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["FramePlus"]["Quest"]=true;
						FramePlusfun.Quest()
					else
						PIGA["FramePlus"]["Quest"]=false
						PIG_OptionsUI.RLUI:Show()
					end
				end);
				FrameExtF.Quest:SetChecked(PIGA["FramePlus"]["Quest"])
			end
			if PIG_MaxTocversion(40000) then
				local Talenttooltip= "在一页显示三系天赋";
				if PIG_MaxTocversion(29999,true) then
					Talenttooltip= Talenttooltip.."和雕文";
				end
				FrameExtF.Talent = PIGCheckbutton_R(FrameExtF,{TALENT.."界面扩展",Talenttooltip},true)
				FrameExtF.Talent:SetScript("OnClick", function (self)
					if self:GetChecked() then
						PIGA["FramePlus"]["Talent"]=true;
						FramePlusfun.Talent()
					else
						PIGA["FramePlus"]["Talent"]=false
						PIG_OptionsUI.RLUI:Show()
					end
				end)
				FrameExtF.Talent:SetChecked(PIGA["FramePlus"]["Talent"])
			end
		end
	end)

	--角色信息界面
	local CharacterF =PIGOptionsList_R(RTabFrame,CHARACTER_BUTTON,90)
	CharacterF:HookScript("OnShow", function()
		if CharacterF.Character_Durability then return end
		CharacterF.Character_Durability = PIGCheckbutton_R(CharacterF,{DISPLAY..EQUIPSET_EQUIP..DURABILITY,CHARACTER_BUTTON.."界面显示装备耐久剩余值"},true)
		CharacterF.Character_Durability:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["Character_Durability"]=true;
				FramePlusfun.Character_ADD()
			else
				PIGA["FramePlus"]["Character_Durability"]=false
				PIG_OptionsUI.RLUI:Show()
			end
		end)
		CharacterF.Character_ItemList = PIGCheckbutton_R(CharacterF,{DISPLAY.."装备列表",CHARACTER_BUTTON.."界面右侧显示装备列表"},true)
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
		if PIG_MaxTocversion(40000) then
			CharacterF.Shuxingtishi=CHARACTER_INFO.."扩展("..PAPERDOLL_SIDEBAR_STATS.."/"..EQUIPMENT_MANAGER.."/"..newText.."/"..COMBAT_RATING_NAME6.."说明"..")"
		elseif PIG_MaxTocversion() then
			CharacterF.Shuxingtishi="常驻"..DISPLAY..PAPERDOLL_SIDEBAR_STATS
		else
			CharacterF.Shuxingtishi=CHARACTER_INFO..DISPLAY..newText
		end
		CharacterF.Character_Shuxing = PIGCheckbutton_R(CharacterF,{CharacterF.Shuxingtishi},true)
		CharacterF.Character_Shuxing:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["Character_Shuxing"]=true
				FramePlusfun.Character_Shuxing()
			else
				PIGA["FramePlus"]["Character_Shuxing"]=false
				PIG_OptionsUI.RLUI:Show()
			end
			Fun.QuickBut_Update()
		end)
		CharacterF.Character_Durability:SetChecked(PIGA["FramePlus"]["Character_Durability"])
		CharacterF.Character_ItemList:SetChecked(PIGA["FramePlus"]["Character_ItemList"])
		CharacterF.Character_Shuxing:SetChecked(PIGA["FramePlus"]["Character_Shuxing"])
	end)
	--ROLL点
	local LootRollF =PIGOptionsList_R(RTabFrame,LOOT,90)
	LootRollF:HookScript("OnShow", function()
		if LootRollF.Loot then return end
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
		LootRollF.Loot:SetChecked(PIGA["FramePlus"]["Loot"])
		if PIG_MaxTocversion() then--修复队长分配错误
			LootRollF.LootMasterErr = PIGCheckbutton_R(LootRollF,{"修复队长分配错误"},true)
			LootRollF.LootMasterErr:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["FramePlus"]["LootMasterErr"]=true;
					 FramePlusfun.LootMasterErr()
				else
					PIGA["FramePlus"]["LootMasterErr"]=false
					PIG_OptionsUI.RLUI:Show()
				end
			end)
			LootRollF.LootMasterErr:SetChecked(PIGA["FramePlus"]["LootMasterErr"])

			LootRollF.Roll = PIGCheckbutton(LootRollF,{"TOPLEFT", LootRollF, "TOPLEFT", 20, -300},{LOOT_ROLL..UIOPTIONS_MENU.."扩展","合并"..LOOT_ROLL.."物品到一起，并且可以移动"})
			LootRollF.Roll:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["FramePlus"]["Roll"]=true;
					 FramePlusfun.Roll()
				else
					PIGA["FramePlus"]["Roll"]=false
					PIG_OptionsUI.RLUI:Show()
				end
				LootRollF.SetF:SetShown(PIGA["FramePlus"]["Roll"])
			end)
			LootRollF.Roll:SetChecked(PIGA["FramePlus"]["Roll"])

			LootRollF.SetF = PIGFrame(LootRollF,{"TOPLEFT", LootRollF, "TOPLEFT", 0, -330})
			LootRollF.SetF:SetPoint("BOTTOMRIGHT", LootRollF, "BOTTOMRIGHT", 0, 0);
			LootRollF.SetF:PIGSetBackdrop(0)
			LootRollF.SetF:SetShown(PIGA["FramePlus"]["Roll"])
			local function ISopenUI(Funx)
				if _G[FramePlusfun.RollListUIname] then Funx() end
			end
			LootRollF.SetF.Slider = PIGSlider(LootRollF.SetF,{"TOPLEFT", LootRollF.SetF, "TOPLEFT", 20, -20},{0.8,2,0.01,{["Right"]="缩放%d%%"}})	
			function LootRollF.SetF.Slider:PIGOnValueChange(arg1)
				if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT) return end
				PIGA["FramePlus"]["RollScale"]=arg1;
				ISopenUI(FramePlusfun.RollDebugUI)
			end
			LootRollF.SetF.Slider:PIGSetValue(PIGA["FramePlus"]["RollScale"]) 
			LootRollF.SetF.CZ = PIGButton(LootRollF.SetF,{"LEFT", LootRollF.SetF.Slider,"RIGHT",80,0},{60,22},RESET)
			LootRollF.SetF.CZ:SetScript("OnClick", function (self)
				PIGA["FramePlus"]["RollScale"]=PD.Default["FramePlus"]["RollScale"]
				LootRollF.SetF.Slider:PIGSetValue(PIGA["FramePlus"]["RollScale"])
				ISopenUI(FramePlusfun.RollCZ)
			end)
			LootRollF.SetF.Debug = PIGButton(LootRollF.SetF,{"TOPLEFT", LootRollF.SetF.Slider,"BOTTOMLEFT",0,-20},{60,22},"测试")
			LootRollF.SetF.Debug:SetScript("OnClick", function (self)
				ISopenUI(FramePlusfun.RollDebugUI)
			end)
		end
	end);
	--小部件
	local UIWidgetF =PIGOptionsList_R(RTabFrame,"小部件",90)
	UIWidgetF:HookScript("OnShow", function()
		if UIWidgetF.Open then return end
		UIWidgetF.Open = PIGCheckbutton(UIWidgetF,{"TOPLEFT",UIWidgetF,"TOPLEFT",20,-20},{"移动小部件(占塔/战场积分)","移动屏幕顶部中央的小部件(占塔/战场积分)"})
		UIWidgetF.Open:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["UIWidget"]=true;
				FramePlusfun.UIWidget()
			else
				PIGA["FramePlus"]["UIWidget"]=false
				PIG_OptionsUI.RLUI:Show()
			end
			UIWidgetF.SetF.UpdateSetUI()
		end);
		UIWidgetF.Open:SetChecked(PIGA["FramePlus"]["UIWidget"])

		UIWidgetF.SetF = PIGFrame(UIWidgetF,{"TOPLEFT", UIWidgetF, "TOPLEFT", 0, -50})
		UIWidgetF.SetF:SetPoint("BOTTOMRIGHT", UIWidgetF, "BOTTOMRIGHT", 0, 0);
		UIWidgetF.SetF:PIGSetBackdrop(0)

		UIWidgetF.SetF.pianyiX = PIGSlider(UIWidgetF.SetF,{"TOPLEFT",UIWidgetF.SetF,"TOPLEFT",20,-20},{-500,500,1,{["Right"]="X偏移%s"}},400)
		function UIWidgetF.SetF.pianyiX:PIGOnValueChange(arg1)
			PIGA["FramePlus"]["UIWidgetPointX"]=arg1;
			FramePlusfun.UIWidget()
		end
		UIWidgetF.SetF.pianyiY = PIGSlider(UIWidgetF.SetF,{"TOPLEFT",UIWidgetF.SetF.pianyiX,"BOTTOMLEFT",0,-10},{-500,500,1,{["Right"]="Y偏移%s"}},400)
		function UIWidgetF.SetF.pianyiY:PIGOnValueChange(arg1)
			PIGA["FramePlus"]["UIWidgetPointY"]=arg1
			FramePlusfun.UIWidget()
		end
		UIWidgetF.SetF.CZ = PIGButton(UIWidgetF.SetF,{"BOTTOMRIGHT",UIWidgetF.SetF,"TOPRIGHT",-20,10},{60,22},RESET)
		UIWidgetF.SetF.CZ:SetScript("OnClick", function (self)
			PIGA["FramePlus"]["UIWidgetPointX"]=PD.Default["FramePlus"]["UIWidgetPointX"]
			PIGA["FramePlus"]["UIWidgetPointY"]=PD.Default["FramePlus"]["UIWidgetPointY"]
			FramePlusfun.UIWidget()
			UIWidgetF.SetF.UpdateSetUI()
		end)

		function UIWidgetF.SetF.UpdateSetUI()
			UIWidgetF.SetF:SetShown(PIGA["FramePlus"]["UIWidget"])
			UIWidgetF.SetF.pianyiX:PIGSetValue(PIGA["FramePlus"]["UIWidgetPointX"])
			UIWidgetF.SetF.pianyiY:PIGSetValue(PIGA["FramePlus"]["UIWidgetPointY"])
		end
		UIWidgetF.SetF.UpdateSetUI()
	end);
	--移动/缩放----
	local FrameMovF =PIGOptionsList_R(RTabFrame,"移动/缩放",90)
	FrameMovF:HookScript("OnShow", function()
		if FrameMovF.OpenMove then return end
		local BlizzardUIList=FramePlusfun.BlizzardUIList
		FrameMovF.OpenMove = PIGCheckbutton(FrameMovF,{"TOPLEFT",FrameMovF,"TOPLEFT",20,-10},{"解锁(移动)暴雪界面","解锁下方列表界面，拖动界面标题栏移动"})
		FrameMovF.OpenMove:SetScript("OnClick", function (self)
			if InCombatLockdown() then self:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move"]) PIGErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
			if self:GetChecked() then
				PIGA["FramePlus"]["BlizzardUI_Move"]=true;
				FramePlusfun.BlizzardUI_Move()
			else
				PIGA["FramePlus"]["BlizzardUI_Move"]=false
				PIG_OptionsUI.RLUI:Show()
			end
			FrameMovF.MoveF:SetShown(PIGA["FramePlus"]["BlizzardUI_Move"])
		end);
		FrameMovF.OpenMove:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move"])

		FrameMovF.MoveF = PIGFrame(FrameMovF,{"TOPLEFT",FrameMovF,"TOPLEFT",0,-30})
		FrameMovF.MoveF:SetPoint("BOTTOMRIGHT",FrameMovF,"BOTTOMRIGHT",0,0);
		FrameMovF.MoveF:PIGSetBackdrop(0)
		FrameMovF.MoveF:Hide()
		FrameMovF.MoveF.Save = PIGCheckbutton(FrameMovF.MoveF,{"BOTTOMLEFT",FrameMovF.MoveF,"TOPLEFT",240,2},{"保存移动后位置","保存移动后位置\n注意:个别UI涉及到安全保护可能无法战斗中移动/保存位置"})
		FrameMovF.MoveF.Save:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["BlizzardUI_Move_Save"]=true	
			else
				PIGA["FramePlus"]["BlizzardUI_Move_Save"]=false
			end
		end);
		FrameMovF.MoveF.Save:SetChecked(PIGA["FramePlus"]["BlizzardUI_Move_Save"])
		FrameMovF.MoveF.CZ = PIGButton(FrameMovF.MoveF,{"BOTTOMRIGHT",FrameMovF.MoveF,"TOPRIGHT",-20,4},{150,20},"重置所有位置/缩放")
		FrameMovF.MoveF.CZ:SetScript("OnClick", function ()
			if InCombatLockdown() then PIGErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
			PIGA["Blizzard_UI"]={}
			PIGA["FramePlus"]["BlizzardUI_Not"]={}
			PIGprint("已重置暴雪UI位置/缩放")
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
		function FrameMovF.MoveF.ScrollF:UpdateShowList()
			for k,v in pairs(FrameMovF.MoveF.butList) do
				v:Hide()
			end
		   	local TotalNum = #BlizzardUIList
		   	local offset = self:GetScrollFrameOffset(TotalNum, ButNumC, hangLHH)
		    for i = 1, ButNumC do
		        local Index = i + offset
		        if BlizzardUIList[Index] then
		        	if not FrameMovF.MoveF.butList[i] then
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
								PIGErrorMsg("战斗中无法设置")
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
		FrameMovF.MoveF:HookScript("OnShow", function()
			FrameMovF.MoveF.ScrollF:UpdateShowList()
		end)
		FrameMovF.MoveF:SetShown(PIGA["FramePlus"]["BlizzardUI_Move"])
	end);
end