local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
---
local PigLayoutFun=addonTable.PigLayoutFun
function PigLayoutFun.Options_ActionBar(openxx)
if not openxx then return end
---
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
---
local RTabFrame =PigLayoutFun.RTabFrame
--
local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,ACTIONBARS_LABEL..L["LIB_LAYOUT"],100)
--
fujiF.Box_1 = PIGFrame(fujiF,{"TOP", fujiF, "TOP", 0, -10},{fujiF:GetWidth()-20, 100})
fujiF.Box_1:PIGSetBackdrop(0)
local function ActionBar_HideShijiu()
	if PIGA["PigLayout"]["ActionBar"]["HideShijiu"] then
		MainMenuBarRightEndCap:Hide();--隐藏右侧鹰标 
		MainMenuBarLeftEndCap:Hide();--隐藏左侧鹰标 
	else
		MainMenuBarRightEndCap:Show();
		MainMenuBarLeftEndCap:Show();
	end
end
fujiF.Box_1.HideShijiu=PIGCheckbutton(fujiF.Box_1,{"TOPLEFT",fujiF.Box_1,"TOPLEFT",10,-10},{"隐藏狮鹫图标","隐藏动作条两边的狮鹫图标"})
fujiF.Box_1.HideShijiu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["PigLayout"]["ActionBar"]["HideShijiu"]=true;
	else
		PIGA["PigLayout"]["ActionBar"]["HideShijiu"]=false;
	end
	ActionBar_HideShijiu()
end)
--主动作条缩放比例
local function ActionBar_bili(ly)
	if PIGA["PigLayout"]["ActionBar"]["Scale"] then
		MainMenuBar:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"]);
		VerticalMultiBarsContainer:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"]);
		for i=1, 12 do
			_G["MultiBarLeftButton"..i]:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"])
			--_G["MultiBarRightButton"..i]:SetScale(PIGA["PigLayout"]["ActionBar"]["ScaleV"])
		end
	else
		if ly then
			MainMenuBar:SetScale(1);
			VerticalMultiBarsContainer:SetScale(1);
			for i=1, 12 do
				_G["MultiBarLeftButton"..i]:SetScale(1)
				--_G["MultiBarRightButton"..i]:SetScale(1)
			end
		end
	end
end
fujiF.Box_1.ActionBar_bili = PIGCheckbutton(fujiF.Box_1,{"LEFT",fujiF.Box_1.HideShijiu,"RIGHT",200,0},{"缩放动作条","启用缩放动作条,注意此设置和系统高级里面的UI缩放不同，只调整动作条比例"})
fujiF.Box_1.ActionBar_bili:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["PigLayout"]["ActionBar"]["Scale"]=true	
	else
		PIGA["PigLayout"]["ActionBar"]["Scale"]=false
	end
	fujiF.Box_1.ActionBar_bili.Slider:SetEnabled(PIGA["PigLayout"]["ActionBar"]["Scale"])
	ActionBar_bili(true)
end);
-------
fujiF.Box_1.ActionBar_bili.Slider = PIGSlider(fujiF.Box_1,{"LEFT",fujiF.Box_1.ActionBar_bili,"RIGHT",96,0},{0.6, 1.4, 0.01,{["Right"]="%"}})
fujiF.Box_1.ActionBar_bili.Slider.Slider:HookScript("OnValueChanged", function(self, arg1)
	PIGA["PigLayout"]["ActionBar"]["ScaleV"]=arg1;
	ActionBar_bili()
end)
--移动右边动作条
local function IS_bar34Show()
	local ACTIONBAR_1,ACTIONBAR_2,ACTIONBAR_3,ACTIONBAR_4 = GetActionBarToggles()
	if ACTIONBAR_4 and ACTIONBAR_3 then
		return true
	end
	return false
end
local function Pig_BarRight()
	if Pig_OptionsUI.IsOpen_ElvUI("actionbar","enable") then return end
	if Pig_OptionsUI.IsOpen_NDui("Actionbar","Enable") then return end
	if not PIGA["PigLayout"]["ActionBar"]["BarRight"] then return end
	local function Pig_MultiBar_Update()
		if InCombatLockdown() then
			VerticalMultiBarsContainer:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			for i=1, 12 do
				_G["MultiBarLeftButton"..i]:ClearAllPoints();
				_G["MultiBarLeftButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomLeftButton"..i],"TOP",0,6);
				_G["MultiBarRightButton"..i]:ClearAllPoints();
				_G["MultiBarRightButton"..i]:SetPoint("BOTTOM",_G["MultiBarBottomRightButton"..i],"TOP",0,6);
			end
			VerticalMultiBarsContainer:SetSize(1, 1);
			VerticalMultiBarsContainer:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end
	Pig_MultiBar_Update()
	VerticalMultiBarsContainer:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			Pig_MultiBar_Update()
		end
	end);
	--姿态条
	local function StanceBar_Update()
		if InCombatLockdown() then
			StanceBarFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			if IS_bar34Show() then
				StanceButton1:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", 60, 6)
			end
			StanceBarFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end
	StanceBar_Update()
	StanceBarFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			StanceBar_Update()
		end
	end);
	---图腾条
	local function MultiCastBar_Point(self)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			if not ElvUI then
				self:SetMovable(true)
				self:ClearAllPoints();
				self:SetPoint("BOTTOMLEFT", self:GetParent(),"TOPLEFT", MULTICASTACTIONBAR_XPOS, MULTICASTACTIONBAR_YPOS+42)
				self:SetUserPlaced(true)
				self:UnregisterEvent("PLAYER_REGEN_ENABLED");
			end
		end 
	end
	local function MultiCastBar_Update(self)
		if IS_bar34Show() then
			MultiCastBar_Point(self)
		else
			self:SetMovable(true)
			self:SetUserPlaced(false)
			self:SetMovable(false)
		end
	end
	if MultiCastActionBarFrame then
		MultiCastBar_Update(MultiCastActionBarFrame)
		local function jiazaiMultiCast()
			MultiCastBar_Update(MultiCastActionBarFrame)
		end
		MultiCastActionBarFrame:HookScript("OnEvent", function (self,event)
			if event=="PLAYER_ENTERING_WORLD" then
				C_Timer.After(0.4,jiazaiMultiCast)
				C_Timer.After(1,jiazaiMultiCast)
				C_Timer.After(2,jiazaiMultiCast)
				C_Timer.After(5,jiazaiMultiCast)
			end
			if event=="PLAYER_REGEN_ENABLED" then
				MultiCastBar_Update(self)
			end
		end);
		UIParent:HookScript("OnShow", function(self)
			C_Timer.After(0.1,jiazaiMultiCast)
			C_Timer.After(0.2,jiazaiMultiCast)
		end)
	end
	--宠物动作条
	local function PetBar_Update()
		if InCombatLockdown() then
			PetActionBarFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			PetActionBarFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
			if IS_bar34Show() then
				if StanceBarFrame:IsShown() then
					PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", 260, 6)
				else
					PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", 60, 6)
				end	
			end
		end
	end
	PetBar_Update()
	if PetActionBarFrame.UpdatePositionValues then
		hooksecurefunc(PetActionBarFrame, "UpdatePositionValues", function()
			PetBar_Update()
		end)
	elseif ShowPetActionBar then
		hooksecurefunc("ShowPetActionBar", function()
			PetBar_Update()
		end)
	end
	PetActionBarFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_REGEN_ENABLED" then
			PetBar_Update()
		end
	end);
	---整体
	hooksecurefunc("MainMenuBar_UpdateExperienceBars",function(newLevel)
		StanceBar_Update()
		PetBar_Update()
		if MultiCastActionBarFrame then
			MultiCastBar_Update(MultiCastActionBarFrame)
		end
	end);
	hooksecurefunc("MultiActionBar_Update",function()	
		Pig_MultiBar_Update()
		StanceBar_Update()
		PetBar_Update()
		if MultiCastActionBarFrame then
			MultiCastBar_Update(MultiCastActionBarFrame)
		end
	end);
end
fujiF.Box_1.BarRight=PIGCheckbutton(fujiF.Box_1,{"TOPLEFT",fujiF.Box_1.HideShijiu,"BOTTOMLEFT",0,-20},{"移动右边动作条到下方","移动右边竖向动作条到下方动作条之上"})
fujiF.Box_1.BarRight:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["PigLayout"]["ActionBar"]["BarRight"]=true
		Pig_BarRight()
	else
		PIGA["PigLayout"]["ActionBar"]["BarRight"]=false
		Pig_Options_RLtishi_UI:Show()
	end
end)
-- ---pig微型菜单
-- local WWW,HHH=20,24
-- local butList =MICRO_BUTTONS
-- --隐藏系统
-- for i=1,#butList do
-- 	_G[butList[i]]:ClearAllPoints();
-- end
-- local PIG_MICRO_BUTTONS = {}
-- for i=1,#butList do
-- 	if butList[i]~="SocialsMicroButton" then
-- 		table.insert(PIG_MICRO_BUTTONS,"PIG_"..butList[i])
-- 	end
-- end
-- table.insert(PIG_MICRO_BUTTONS,"PIGMacroMicroButton")
-- local iconList = {
-- 	["PIG_CharacterMicroButton"]="poi-transmogrifier",
-- 	["PIG_SpellbookMicroButton"]="hud-microbutton-Spellbook-Up",
-- 	["PIG_TalentMicroButton"]="hud-microbutton-Talents-Up",
-- 	["PIG_AchievementMicroButton"]="hud-microbutton-Achievement-Up",
-- 	["PIG_QuestLogMicroButton"]="QuestTurnin",
-- 	["PIG_GuildMicroButton"]="hud-microbutton-Socials-Up",
-- 	["PIG_CollectionsMicroButton"]="hud-microbutton-Mounts-Up",
-- 	["PIG_PVPMicroButton"]="CrossedFlags",
-- 	["PIG_LFGMicroButton"]="groupfinder-eye-frame",
-- 	["PIG_MainMenuMicroButton"]="Gamepad_Ltr_Menu_32",
-- 	["PIG_HelpMicroButton"]="NPE_TurnIn",
-- 	--["PIGMacroMicroButton"]=136377,
-- 	["PIGMacroMicroButton"]=4708813,
-- }
-- -- Interface/HUD/UIMicroMenu2x
-- 	-- ["Interface/HUD/UIMicroMenu2x"]={
-- 	-- 	["UI-HUD-MicroMenu-Achievements-Disabled"]={16, 20.5, 0.000976562, 0.0634766, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Achievements-Down"]={16, 20.5, 0.000976562, 0.0634766, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Achievements-Mouseover"]={16, 20.5, 0.000976562, 0.0634766, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Achievements-Up"]={16, 20.5, 0.000976562, 0.0634766, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-AdventureGuide-Disabled"]={16, 20.5, 0.000976562, 0.0634766, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-AdventureGuide-Down"]={16, 20.5, 0.000976562, 0.0634766, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-AdventureGuide-Mouseover"]={16, 20.5, 0.0654297, 0.12793, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-AdventureGuide-Up"]={16, 20.5, 0.0654297, 0.12793, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Collections-Disabled"]={16, 20.5, 0.0654297, 0.12793, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Collections-Down"]={16, 20.5, 0.0654297, 0.12793, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Collections-Mouseover"]={16, 20.5, 0.129883, 0.192383, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Collections-Up"]={16, 20.5, 0.129883, 0.192383, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Communities-Icon-Notification"]={19, 19, 0.581055, 0.618164, 0.822266, 0.896484, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GameMenu-Disabled"]={16, 20.5, 0.129883, 0.192383, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GameMenu-Down"]={16, 20.5, 0.129883, 0.192383, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GameMenu-Mouseover"]={16, 20.5, 0.129883, 0.192383, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GameMenu-Up"]={16, 20.5, 0.129883, 0.192383, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Groupfinder-Disabled"]={16, 20.5, 0.194336, 0.256836, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Groupfinder-Down"]={16, 20.5, 0.194336, 0.256836, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Groupfinder-Mouseover"]={16, 20.5, 0.194336, 0.256836, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Groupfinder-Up"]={16, 20.5, 0.194336, 0.256836, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-Disabled"]={16, 20.5, 0.194336, 0.256836, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-Down"]={16, 20.5, 0.194336, 0.256836, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-Mouseover"]={16, 20.5, 0.258789, 0.321289, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-Up"]={16, 20.5, 0.258789, 0.321289, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Highlightalert"]={16, 20.5, 0.323242, 0.385742, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Questlog-Disabled"]={16, 20.5, 0.387695, 0.450195, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Questlog-Down"]={16, 20.5, 0.387695, 0.450195, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Questlog-Mouseover"]={16, 20.5, 0.387695, 0.450195, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Questlog-Up"]={16, 20.5, 0.387695, 0.450195, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Shop-Disabled"]={16, 20.5, 0.387695, 0.450195, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Shop-Mouseover"]={16, 20.5, 0.452148, 0.514648, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Shop-Down"]={16, 20.5, 0.452148, 0.514648, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-Shop-Up"]={16, 20.5, 0.452148, 0.514648, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpecTalents-Disabled"]={16, 20.5, 0.452148, 0.514648, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpecTalents-Down"]={16, 20.5, 0.452148, 0.514648, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpecTalents-Mouseover"]={16, 20.5, 0.452148, 0.514648, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpecTalents-Up"]={16, 20.5, 0.516602, 0.579102, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpellbookAbilities-Disabled"]={16, 20.5, 0.516602, 0.579102, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpellbookAbilities-Down"]={16, 20.5, 0.516602, 0.579102, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpellbookAbilities-Mouseover"]={16, 20.5, 0.516602, 0.579102, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-SpellbookAbilities-Up"]={16, 20.5, 0.516602, 0.579102, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLGreen-Down"]={16, 20.5, 0.516602, 0.579102, 0.822266, 0.982422, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLGreen-Up"]={16, 20.5, 0.581055, 0.643555, 0.00195312, 0.162109, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLRed-Down"]={16, 20.5, 0.581055, 0.643555, 0.166016, 0.326172, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLRed-Up"]={16, 20.5, 0.581055, 0.643555, 0.330078, 0.490234, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLYellow-Down"]={16, 20.5, 0.581055, 0.643555, 0.494141, 0.654297, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-StreamDLYellow-Up"]={16, 20.5, 0.581055, 0.643555, 0.658203, 0.818359, false, false, "2x"},
-- 	-- 	["UI-HUD-MicroMenu-ButtonBG-Down"]={32, 41, 0.0654297, 0.12793, 0.330078, 0.490234, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-ButtonBG-Up"]={32, 41, 0.0654297, 0.12793, 0.494141, 0.654297, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Portrait-Shadow"]={32, 41, 0.323242, 0.385742, 0.330078, 0.490234, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Portrait-Down"]={32, 41, 0.323242, 0.385742, 0.166016, 0.326172, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-GuildColor-Disabled"]={32, 41, 0.258789, 0.321289, 0.00195312, 0.162109, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-GuildColor-Down"]={32, 41, 0.258789, 0.321289, 0.166016, 0.326172, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-GuildColor-Mouseover"]={32, 41, 0.258789, 0.321289, 0.330078, 0.490234, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-GuildCommunities-GuildColor-Up"]={32, 41, 0.258789, 0.321289, 0.494141, 0.654297, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Professions-Disabled"]={32, 41, 0.323242, 0.385742, 0.494141, 0.654297, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Professions-Down"]={32, 41, 0.323242, 0.385742, 0.658203, 0.818359, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Professions-Mouseover"]={32, 41, 0.323242, 0.385742, 0.822266, 0.982422, false, false, "1x"},
-- 	-- 	["UI-HUD-MicroMenu-Professions-Up"]={32, 41, 0.387695, 0.450195, 0.00195312, 0.162109, false, false, "1x"},
-- 	-- }
-- for i=1,#PIG_MICRO_BUTTONS do
-- 	local MicroBut = CreateFrame("Button",PIG_MICRO_BUTTONS[i],UIParent, "SecureActionButtonTemplate");
-- 	--MicroBut:SetNormalTexture(136377)
-- 	--MicroBut:SetNormalTexture(130810)
-- 	--MicroBut:SetPushedTexture(136377)
-- 	if type(iconList[PIG_MICRO_BUTTONS[i]])=="number" then
-- 		print(PIG_MICRO_BUTTONS[i],iconList[PIG_MICRO_BUTTONS[i]])
-- 		MicroBut:SetNormalTexture(iconList[PIG_MICRO_BUTTONS[i]])
-- 	else
		
-- 		MicroBut:SetNormalAtlas(iconList[PIG_MICRO_BUTTONS[i]])
-- 	end
	
	
-- 	MicroBut:SetSize(WWW,HHH);
-- 	if i==1 then
-- 		MicroBut:SetPoint("TOP",UIParent,"TOP",-(#butList)*0.5*(WWW+3),-500);
-- 	else
-- 		MicroBut:SetPoint("LEFT",_G[PIG_MICRO_BUTTONS[i-1]],"RIGHT",3,0);
-- 	end
-- 	-- MicroBut:SetAttribute("type", "macro")
-- 	-- MicroBut:SetAttribute("macrotext", "/macro")
-- 	MicroBut.tooltipText = MicroButtonTooltipText(MACROS, "TOGGLEHELP");
-- 	MicroBut.newbieText = MACRO_HELP_TEXT_LINE3;
-- end
-- 	-- local butListTex = {
-- 	-- 	{"UI-ChatIcon-App","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"socialqueuing-icon-group","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"socialqueuing-icon-eye","groupfinder-eye-frame","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- 	{"QuestNormal","SmallQuestBang","SmallQuestBang"},
-- 	-- }
-- 	-- GameMenuButtonAddons:ClearAllPoints();
-- 	-- GameMenuButtonAddons:SetPoint("TOP",GameMenuButtonOptions,"BOTTOM",0,-1);
-- 	-- GameMenuButtonMacros:SetParent(UIParent)
-- 	-- GameMenuButtonMacros:ClearAllPoints();
-- 	-- GameMenuButtonMacros:SetNormalTexture(136377)
-- 	-- GameMenuButtonMacros:SetPushedTexture(136377)
-- 	-- GameMenuButtonMacros:SetText("")
-- 	-- GameMenuButtonMacros.Left:Hide()
-- 	-- GameMenuButtonMacros.Right:Hide()
-- 	-- GameMenuButtonMacros.Middle:Hide()
-- 	-- function GameMenuButtonMacros:UpdateMicroButton()
-- 	-- 	if MacroFrame and MacroFrame:IsShown() then
-- 	-- 		self:GetNormalTexture():SetPoint("TOPLEFT",self,"TOPLEFT",-1.5,-1.5);
-- 	-- 		self:GetNormalTexture():SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-1.5,-1.5);
-- 	-- 	else
-- 	-- 		self:GetNormalTexture():SetPoint("TOPLEFT",self,"TOPLEFT",0,0);
-- 	-- 		self:GetNormalTexture():SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",0,0);
-- 	-- 	end
-- 	-- end
-- 	hooksecurefunc("UpdateMicroButtons", function(self)
-- 		print(1111)
-- 	end)
-- 	--table.insert(butList,"GameMenuButtonMacros")
-- 	-- local ButMacro = CreateFrame("Button","PIGMacroMicroButton",UIParent, "SecureActionButtonTemplate,MainMenuBarMicroButton");
-- 	-- ButMacro:SetNormalTexture(136377)
-- 	-- ButMacro:SetPushedTexture(136377)
-- 	-- ButMacro:SetSize(WWW,HHH);
-- 	-- ButMacro:SetPoint("BOTTOMLEFT",HelpMicroButton,"BOTTOMRIGHT",-3,0);
-- 	-- ButMacro:SetAttribute("type", "macro")
-- 	-- ButMacro:SetAttribute("macrotext", "/macro")
-- 	-- ButMacro.tooltipText = MicroButtonTooltipText(MACROS, "TOGGLEHELP");
-- 	-- ButMacro.newbieText = MACRO_HELP_TEXT_LINE3;
-- 	-- table.insert(butList,"PIGMacroMicroButton")
	
-- 	-- hooksecurefunc(GuildMicroButton,"UpdateMicroButton", function(self)
-- 	-- 	if FriendsFrame and FriendsFrame:IsShown() and GuildFrame and GuildFrame:IsShown() then
-- 	-- 		self:SetButtonState("PUSHED", true);
-- 	-- 	else
-- 	-- 		self:SetButtonState("NORMAL");
-- 	-- 	end
-- 	-- end)
-- 	-- MainMenuBarPerformanceBarFrame:Hide()
-- 	-- MainMenuBarPerformanceBar:ClearAllPoints();
-- 	-- MainMenuBarPerformanceBar:SetPoint("TOP",MainMenuMicroButton,"TOP",3,-6);

-- 	-- _G[butList[1]]:ClearAllPoints();
-- 	-- _G[butList[1]]:SetPoint("TOP",UIParent,"TOP",-(#butList)*0.5*WWW,0);
-- 	-- for i=1,#butList do
-- 	-- 	local MicroBut = _G[butList[i]]
-- 	-- 	MicroBut:ClearAllPoints();
-- 	-- 	MicroBut:SetHitRectInsets(0,0,0,0);
-- 	-- 	MicroBut:SetSize(WWW,HHH);
-- 	-- 	if not MicroBut.Flash then
-- 	-- 		MicroBut.Flash=MicroBut:CreateTexture(butList[i].."Flash")
-- 	-- 		MicroBut.Flash:SetTexture("Interface/Buttons/Micro-Highlight");
-- 	-- 		MicroBut.Flash:Hide()
-- 	-- 	end
-- 	-- 	MicroBut.Flash:SetPoint("TOPLEFT",MicroBut,"TOPLEFT",-2,5);
-- 	-- 	MicroBut.Flash:SetSize(WWW*2.2,HHH*2.04);
-- 	-- 	MicroBut:SetHighlightAtlas("bags-roundhighlight");
-- 	-- 	-- local NormalTex=MicroBut:GetNormalTexture()
-- 	-- 	-- local PushedTex=MicroBut:GetPushedTexture()
-- 	-- 	-- local DisabledTex=MicroBut:GetDisabledTexture()
-- 	-- 	-- MicroBut.mask = MicroBut:CreateMaskTexture()
-- 	-- 	-- if yuanxing then
-- 	-- 	-- 	MicroBut.mask:SetAllPoints(NormalTex)
-- 	-- 	-- 	MicroBut.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")--圆形
-- 	-- 	-- else
-- 	-- 	-- 	MicroBut.mask:SetPoint("TOPLEFT",NormalTex,"TOPLEFT",-2,2);
-- 	-- 	-- 	MicroBut.mask:SetPoint("BOTTOMRIGHT",NormalTex,"BOTTOMRIGHT",2,-2);
-- 	-- 	-- 	MicroBut.mask:SetTexture("Interface/ChatFrame/UI-ChatIcon-HotS", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")--六边形
-- 	-- 	-- end
-- 	-- 	-- NormalTex:AddMaskTexture(MicroBut.mask)
-- 	-- 	-- PushedTex:AddMaskTexture(MicroBut.mask)
-- 	-- 	-- if DisabledTex then DisabledTex:AddMaskTexture(MicroBut.mask) end
-- 	-- 	-- if MicroBut==CharacterMicroButton then
-- 	-- 	-- 	MicroButtonPortrait:AddMaskTexture(MicroBut.mask)
-- 	-- 	-- 	MicroButtonPortrait:SetScale(0.88)
-- 	-- 	-- 	MicroButtonPortrait:SetPoint("TOP",MicroBut,"TOP",0,2);
-- 	-- 	-- 	HelpOpenWebTicketButton:SetPoint("CENTER",MicroBut,"CENTER",-1,-WWW);
-- 	-- 	-- elseif MicroBut==PVPMicroButton then
-- 	-- 	-- 	MicroBut.texture:ClearAllPoints();
-- 	-- 	-- 	MicroBut.texture:SetPoint("TOPLEFT",MicroBut,"TOPLEFT",-WWW*0.15,0);
-- 	-- 	-- 	MicroBut.texture:SetPoint("BOTTOMRIGHT",MicroBut,"BOTTOMRIGHT",WWW*0.88,-HHH*0.6);
-- 	-- 	-- 	MicroBut.texture:AddMaskTexture(MicroBut.mask)
-- 	-- 	-- end
-- 	-- 	-- if MicroBut==LFGMicroButton then
-- 	-- 	-- 	NormalTex:SetTexCoord(0.15,0.85,0.51,0.88)
-- 	-- 	-- 	PushedTex:SetTexCoord(0.15,0.85,0.51,0.88)
-- 	-- 	-- 	DisabledTex:SetTexCoord(0.15,0.85,0.51,0.88)
-- 	-- 	-- elseif MicroBut==GameMenuButtonMacros then
-- 	-- 	-- 	--MicroBut:GetHighlightTexture():SetTexCoord(0,1,0,1)
-- 	-- 	-- else
-- 	-- 	-- 	NormalTex:SetTexCoord(0.15,0.85,0.46,0.92)
-- 	-- 	-- 	PushedTex:SetTexCoord(0.15,0.85,0.46,0.92)
-- 	-- 	-- 	if DisabledTex then DisabledTex:SetTexCoord(0.15,0.85,0.46,0.92) end
-- 	-- 	-- end
-- 	-- end
-- 	-- local function SetButPointFUN()
-- 	-- 	SocialsMicroButton:Hide()
-- 	-- 	GuildMicroButton:Show()
-- 	-- 	TalentMicroButton:Show()
-- 	-- 	local playerLevel = UnitLevel("player");
-- 	-- 	if ( playerLevel < SHOW_SPEC_LEVEL ) then
-- 	-- 		TalentMicroButton:Disable();
-- 	-- 	else
-- 	-- 		TalentMicroButton:Enable();
-- 	-- 	end
-- 	-- 	for i=2,#butList do
-- 	-- 		if butList[i]=="GuildMicroButton" then
-- 	-- 			_G[butList[i]]:SetPoint("BOTTOMLEFT",_G[butList[i-2]],"BOTTOMRIGHT",2,0);
-- 	-- 		else
-- 	-- 			_G[butList[i]]:SetPoint("BOTTOMLEFT",_G[butList[i-1]],"BOTTOMRIGHT",2,0);
-- 	-- 		end
-- 	-- 	end
-- 	-- 	--GameMenuButtonMacros:UpdateMicroButton()
-- 	-- end
-- 	-- SetButPointFUN()
-- 	-- hooksecurefunc("UpdateMicroButtons", function()
-- 	-- 	if InCombatLockdown() then return end
-- 	-- 	SetButPointFUN()
-- 	-- end)
---
fujiF.Box_1:HookScript("OnShow", function(self)
	self.HideShijiu:SetChecked(PIGA["PigLayout"]["ActionBar"]["HideShijiu"])
	self.BarRight:SetChecked(PIGA["PigLayout"]["ActionBar"]["BarRight"])
	self.ActionBar_bili:SetChecked(PIGA["PigLayout"]["ActionBar"]["Scale"]);
	self.ActionBar_bili.Slider:SetEnabled(PIGA["PigLayout"]["ActionBar"]["Scale"])
	self.ActionBar_bili.Slider:PIGSetValue(PIGA["PigLayout"]["ActionBar"]["ScaleV"])	
end)
----
ActionBar_HideShijiu()
Pig_BarRight()
ActionBar_bili()
end