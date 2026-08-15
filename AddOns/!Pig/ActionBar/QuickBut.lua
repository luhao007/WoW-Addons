local addonName, PD = ...;
local L=PD.locale
----------
local Create = PD.Create
local PIGFrame=Create.PIGFrame
local PIGDiyBut=Create.PIGDiyBut
local PIGButton=Create.PIGButton
local PIGCheckbutton=Create.PIGCheckbutton
local PIGQuickBut=Create.PIGQuickBut
local PIGLine=Create.PIGLine
local PIGEnter=Create.PIGEnter
local PIGSlider = Create.PIGSlider
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGDownMenu=Create.PIGDownMenu
--------------
local Fun=PD.Fun
local ActionFun=Fun.ActionFun
local PIGUseKeyDown=ActionFun.PIGUseKeyDown
local Update_Attribute=ActionFun.Update_Attribute
local Update_Icon=ActionFun.Update_Icon
local Update_Cooldown=ActionFun.Update_Cooldown
local Update_Count=ActionFun.Update_Count
local Update_bukeyong=ActionFun.Update_bukeyong
local Update_State=ActionFun.Update_State
local Update_PostClick=ActionFun.Update_PostClick
local loadingButInfo=ActionFun.loadingButInfo
local Update_OnEnter=ActionFun.Update_OnEnter
local Cursor_Fun=ActionFun.Cursor_Fun
local Update_Macro=ActionFun.Update_Macro
----
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
local bagData=Data.bagData
local bagID=Data.bagData["bagID"]
---
local GetMapInfo=C_Map.GetMapInfo or C_Map and C_Map.GetMapInfo
local GetItemInfo=GetItemInfo or C_Item and C_Item.GetItemInfo
local GetItemCount=GetItemCount or C_Item and C_Item.GetItemCount
local GetItemIcon=GetItemIcon or C_Item and C_Item.GetItemIconByID
local IsUsableSpell=IsUsableSpell or C_Spell and C_Spell.IsSpellUsable
local GetItemCooldown=C_Container.GetItemCooldown
local PIGbookType=PIG_GetSpellBookType()
---功能动作条===========
local ActionBarfun=PD.ActionBarfun
function ActionBarfun.addOptions_QuickBut()
	local fuFrame=ActionBarfun.fuFrame
	local fuFrameBut=ActionBarfun.fuFrameBut
	local RTabFrame=ActionBarfun.RTabFrame
	local QuickButF,QuickButTabBut =PIGOptionsList_R(RTabFrame,L["ACTION_TABNAME2"],100)
	function ActionBarfun.RightButClick(Button)
		if Button=="RightButton" then
			Create.Show_TabBut(fuFrame,fuFrameBut)
			Create.Show_TabBut_R(RTabFrame,QuickButF,QuickButTabBut)
		end
	end
	--
	QuickButF.Open=PIGCheckbutton(QuickButF,{"TOPLEFT",QuickButF,"TOPLEFT",10,-12},{L["ACTION_TABNAME2"],"在屏幕上创建一条"..L["ACTION_TABNAME2"].."，以便快捷使用某些功能。\n你可以自定义需要显示的按钮"})
	QuickButF.Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["QuickBut"]["Open"]=true;
			Fun.QuickBut_Update()
		else
			PIGA["QuickBut"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		QuickButF.SetF:SetShown(PIGA["QuickBut"]["Open"])
		QuickButF.ModF:SetShown(PIGA["QuickBut"]["Open"])
	end)
	QuickButF.CZBUT = PIGButton(QuickButF,{"TOPRIGHT",QuickButF,"TOPRIGHT",-20,-12},{60,22},RESET);  
	QuickButF.CZBUT:SetScript("OnClick", function ()
		StaticPopup_Show ("CHONGZHI_QUICKBUT");
	end);
	StaticPopupDialogs["CHONGZHI_QUICKBUT"] = {
		text = "此操作将|cffff0000重置|r"..L["ACTION_TABNAME2"].."配置。\n确定重置?",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["QuickBut"] = CopyTable(PD.Default["QuickBut"])
			PIGA_Per["QuickBut"] = CopyTable(PD.Default_Per["QuickBut"])
			PIG_OptionsUI.RLUI:Show()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	QuickButF:SetScript("OnShow", function (self)
		QuickButF.Open:SetChecked(PIGA["QuickBut"]["Open"])
		if not QuickButF.SetF then
			QuickButF.SetF = PIGFrame(QuickButF)
			QuickButF.SetF:PIGSetBackdrop(0)
			QuickButF.SetF:SetHeight(60)
			QuickButF.SetF:SetPoint("TOPLEFT",QuickButF,"TOPLEFT",0,-40);
			QuickButF.SetF:SetPoint("TOPRIGHT",QuickButF,"TOPRIGHT",0,0);
			QuickButF.SetF:Hide()

			QuickButF.SetF.Lock=PIGCheckbutton(QuickButF.SetF,{"TOPLEFT",QuickButF.SetF,"TOPLEFT",20,-20},{LOCK_FRAME,LOCK_FOCUS_FRAME})
			QuickButF.SetF.Lock:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["Lock"]=true
				else
					PIGA["QuickBut"]["Lock"]=false;
				end
				Fun.QuickBut_Update()
			end)
			--
			local xiayiinfo = {0.6,1.4,0.01,{["Right"]="缩放%d%%"}}
			QuickButF.SetF.suofang = PIGSlider(QuickButF.SetF,{"LEFT",QuickButF.SetF.Lock,"RIGHT",90,0},xiayiinfo)
			function QuickButF.SetF.suofang:PIGOnValueChange(arg1)
				PIGA["QuickBut"]["bili"]=arg1;
				Fun.QuickBut_Update()
			end
			local Showtiaojian,pailieName,paiNum,PailieFun,ShowHideNumFun,ShowHideEvent=unpack(Fun.ActionFun.UIdata)
			QuickButF.SetF.PailieT = PIGFontString(QuickButF.SetF,{"LEFT",QuickButF.SetF.suofang,"RIGHT",90,0},"排列")
			QuickButF.SetF.Pailie=PIGDownMenu(QuickButF.SetF,{"LEFT",QuickButF.SetF.PailieT,"RIGHT",2,0},{80,24})
			function QuickButF.SetF.Pailie:PIGDownMenu_Update_But()
				local info = {}
				info.func = self.PIGDownMenu_SetValue
				for i=1,2,1 do
				    info.text, info.arg1 = pailieName[i], i
				    info.checked = i==PIGA["QuickBut"]["Pailie"]
					self:PIGDownMenu_AddButton(info)
				end 
			end
			function QuickButF.SetF.Pailie:PIGDownMenu_SetValue(value,arg1,arg2)
				self:PIGDownMenu_SetText(value)
				PIGA["QuickBut"]["Pailie"] = arg1;
				Fun.QuickBut_Update()
				PIGCloseDropDownMenus()
			end
			QuickButF.SetF.CZBUT = PIGButton(QuickButF.SetF,{"TOPRIGHT",QuickButF.SetF,"TOPRIGHT",-20,-20},{80,22},RESET_POSITION)
			QuickButF.SetF.CZBUT:SetScript("OnClick", function ()
				Create.PIG_ResPoint(Data.QuickButUIname)
				PIGA["QuickBut"]["bili"]=1
				QuickButF.SetF.suofang:PIGSetValue(1)
				Fun.QuickBut_Update()
			end)
			QuickButF.SetF.Lock:SetChecked(PIGA["QuickBut"]["Lock"])
			QuickButF.SetF.suofang:PIGSetValue(PIGA["QuickBut"]["bili"])
			QuickButF.SetF.Pailie:PIGDownMenu_SetText(pailieName[PIGA["QuickBut"]["Pailie"]])

			--
			QuickButF.ModF = PIGFrame(QuickButF)
			QuickButF.ModF:PIGSetBackdrop(0)
			QuickButF.ModF:SetPoint("TOPLEFT",QuickButF.SetF,"BOTTOMLEFT",0,1);
			QuickButF.ModF:SetPoint("BOTTOMRIGHT",QuickButF,"BOTTOMRIGHT",0,0);
			QuickButF.ModF:Hide()
			local BGbroadcast_tooltip = {BATTLEFIELDS..BATTLENET_BROADCAST,string.format(L["ACTION_ADDQUICKBUTTIS"],BATTLEFIELDS..BATTLENET_BROADCAST).."\n注意:战况广播按钮战场外不显示"}
			QuickButF.ModF.BGbroadcast=PIGCheckbutton_R(QuickButF.ModF,BGbroadcast_tooltip,true)
			QuickButF.ModF.BGbroadcast:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["BGbroadcast"]=true;
				else
					PIGA["QuickBut"]["BGbroadcast"]=false;
				end
				Fun.QuickBut_Update()
			end)
			--饰品
			QuickButF.ModF.QKButTrinket = PIGCheckbutton_R(QuickButF.ModF,{INVTYPE_TRINKET..CHAT_MODERATE,string.format(L["ACTION_ADDQUICKBUTTIS"],INVTYPE_TRINKET..CHAT_MODERATE)},true)
			QuickButF.ModF.QKButTrinket:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["Trinket"]=true
				else
					PIGA["QuickBut"]["Trinket"]=false
				end
				Fun.QuickBut_Update()
			end)
			if PIG_MaxTocversion(20000) and C_Engraving and C_Engraving.IsEngravingEnabled() then
				-- QuickButF.ModF.QKButRune = PIGCheckbutton_R(QuickButF.ModF,{RUNES..CHAT_MODERATE,string.format(L["ACTION_ADDQUICKBUTTIS"],RUNES..CHAT_MODERATE)},true)
				-- QuickButF.ModF.QKButRune:SetScript("OnClick", function (self)
				-- 	if self:GetChecked() then
				-- 		PIGA["QuickBut"]["Rune"]=true
				-- 	else
				-- 		PIGA["QuickBut"]["Rune"]=false
				-- 	end
				-- 	Fun.QuickBut_Update()
				-- end)
				-- QuickButF.ModF.QKButRune.RuneShow = PIGCheckbutton(QuickButF.ModF.QKButRune,{"LEFT",QuickButF.ModF.QKButRune.Text,"RIGHT",20,0},{SHOW.."当前使用的符文"})
				-- QuickButF.ModF.QKButRune.RuneShow:SetScript("OnClick", function (self)
				-- 	if self:GetChecked() then
				-- 		PIGA["QuickBut"]["RuneShow"]=true
				-- 		if AutoRuneListUI then AutoRuneListUI:GetParent():UpDatePoints(true) end
				-- 	else
				-- 		PIGA["QuickBut"]["RuneShow"]=false
				-- 		if AutoRuneListUI then AutoRuneListUI:Hide() end
				-- 	end
				-- 	Fun.QuickBut_Update()
				-- end)
			end
			----
			QuickButF.ModF.QKButEquip = PIGCheckbutton_R(QuickButF.ModF,{EQUIPMENT_MANAGER,string.format(L["ACTION_ADDQUICKBUTTIS"],EQUIPMENT_MANAGER)},true)
			QuickButF.ModF.QKButEquip.errt = PIGFontString(QuickButF.ModF.QKButEquip,{"LEFT", QuickButF.ModF.QKButEquip.Text, "RIGHT", 2, 0},"需打开界面优化/角色信息/人物信息扩展功能","OUTLINE")
			QuickButF.ModF.QKButEquip.errt:SetTextColor(1, 0, 0); 
			QuickButF.ModF.QKButEquip.errt:Hide()
			QuickButF.ModF.QKButEquip:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["Equip"]=true
				else
					PIGA["QuickBut"]["Equip"]=false
				end
				Fun.QuickBut_Update()
			end)
			QuickButF.ModF.AddonList = PIGCheckbutton_R(QuickButF.ModF,{ADDONS..CHAT_MODERATE,string.format(L["ACTION_ADDQUICKBUTTIS"],ADDONS..CHAT_MODERATE)},true)
			QuickButF.ModF.AddonList:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["AddonList"]=true
				else
					PIGA["QuickBut"]["AddonList"]=false
				end
				Fun.QuickBut_Update()
			end)
			local Lushi_tooltip = {TUTORIAL_TITLE31.."/"..TRADE_SKILLS,string.format(L["ACTION_ADDQUICKBUTTIS"],TUTORIAL_TITLE31.."/"..TRADE_SKILLS)}
			QuickButF.ModF.Lushi=PIGCheckbutton_R(QuickButF.ModF,Lushi_tooltip,true)
			QuickButF.ModF.Lushi:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["Lushi"]=true;
				else
					PIGA["QuickBut"]["Lushi"]=false;
				end
				Fun.QuickBut_Update()
			end)
			QuickButF.ModF.Spell=PIGCheckbutton_R(QuickButF.ModF,{CLASS..BINDING_HEADER_ACTIONBAR,string.format(L["ACTION_ADDQUICKBUTTIS"],CLASS..BINDING_HEADER_ACTIONBAR)},true)
			QuickButF.ModF.Spell:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["QuickBut"]["Spell"]=true;
				else
					PIGA["QuickBut"]["Spell"]=false;
				end
				Fun.QuickBut_Update()
			end)

			QuickButF.ModF.Lushi:SetChecked(PIGA["QuickBut"]["Lushi"])
			QuickButF.ModF.Spell:SetChecked(PIGA["QuickBut"]["Spell"])
			QuickButF.ModF.BGbroadcast:SetChecked(PIGA["QuickBut"]["BGbroadcast"])
			QuickButF.ModF.QKButTrinket:SetChecked(PIGA["QuickBut"]["Trinket"])
			if QuickButF.ModF.QKButRune then
				QuickButF.ModF.QKButRune:SetChecked(PIGA["QuickBut"]["Rune"])
				QuickButF.ModF.QKButRune.RuneShow:SetChecked(PIGA["QuickBut"]["RuneShow"])
			end
			QuickButF.ModF.QKButEquip:SetChecked(PIGA["QuickBut"]["Equip"])
			QuickButF.ModF.AddonList:SetChecked(PIGA["QuickBut"]["AddonList"])
			if PIG_MaxTocversion(30000) then
				QuickButF.ModF.QKButEquip:SetEnabled(PIGA["FramePlus"]["Character_Shuxing"])
				QuickButF.ModF.QKButEquip.errt:SetShown(not PIGA["FramePlus"]["Character_Shuxing"])
			end
		end
		QuickButF.SetF:SetShown(PIGA["QuickBut"]["Open"])
		QuickButF.ModF:SetShown(PIGA["QuickBut"]["Open"])
	end)
end

---
local arrow_pulp=0
if PIG_MaxTocversion() then
	arrow_pulp=90
end
local function GetAngle_V(oldV,endV)
	if endV then
		if oldV>=360 then
			return oldV-360
		end
		return oldV
	else
		if oldV+arrow_pulp>=360 then
			return oldV+arrow_pulp-360
		end
		return oldV+arrow_pulp
	end
end
--战场通告
local function BGbroadcastIcon()
	local englishFaction = UnitFactionGroup("player")
	return englishFaction=="Horde" and 130705 or 130704
end
local QuickBut_index=1
Create.PIGaddQuickBut(QuickBut_index,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["BGbroadcast"]
	end,
	Icon=BGbroadcastIcon(),
	Tooltip = KEY_BUTTON1.."-|cff00FFFF通报当前位置来犯人,(来几人就点几次)\r|r"..KEY_BUTTON2.."-|cff00FFFF报告位置安全|r",
	fun=function(but)
		local direnshuliangpig, hanhuaTimejiange
		local function Update_ShowFun()
			local inInstance, instanceType =IsInInstance()
			if instanceType=="pvp" then
				Data.QKData[QuickBut_index].Hide=nil
			else
				Data.QKData[QuickBut_index].Hide=true
			end
			Fun.QuickBut_Update()
		end
		Update_ShowFun()
		but:RegisterEvent("PLAYER_ENTERING_WORLD")
		but:HookScript("OnEvent", function (self, event,arg1, arg2)
			if event=="PLAYER_ENTERING_WORLD" then
				if InCombatLockdown() then return end
				if arg1 or arg2 then
				else
					Update_ShowFun()
				end
			end
		end)
		but:SetScript("OnClick", function (self, event)
			local inInstance, instanceType = IsInInstance();
			if instanceType=="pvp" then
				if event=="RightButton" then
					SendChatMessage(GetMinimapZoneText().."已安全，机动人员请机动支援！", "instance_chat") 
				else
					if not direnshuliangpig or not hanhuaTimejiange or GetTime()-hanhuaTimejiange>10 then
						direnshuliangpig=0;
					end;
					hanhuaTimejiange=GetTime(); direnshuliangpig=direnshuliangpig+1; SendChatMessage(GetMinimapZoneText().."有"..direnshuliangpig.."个敌人来袭，请求支援！", "instance_chat"); 
				end
			end
		end);
	end,
})
--炉石专业按钮----
Create.PIGaddQuickBut(7,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["Lushi"]
	end,
	Icon=134414,
	Tooltip = KEY_BUTTON1.."-|cff00FFFF使用炉石|r\rShift+"..KEY_BUTTON1.."-|cff00FFFF选择炉石\r|r"..KEY_BUTTON2.."-|cff00FFFF专业技能|r",
	Template="SecureActionButtonTemplate",
	fun=function(General,QuickButUI)
		General.cooldown = CreateFrame("Cooldown", nil, General, "CooldownFrameTemplate")
		General.cooldown:SetAllPoints()
		General.start = General:CreateTexture(nil, "OVERLAY");
		General.start:SetTexture(130724);
		General.start:SetBlendMode("ADD");
		General.start:SetAllPoints(General)
		General.start:Hide();
		General.arrow = General:CreateTexture(nil,"ARTWORK");
		General.arrow:SetDrawLayer("ARTWORK", 7)
		if PIG_MaxTocversion() then
			General.arrow:SetAtlas("bag-arrow")
			General.arrow:SetSize(11,16);
		else
			General.arrow:SetAtlas("UI-HUD-ActionBar-Flyout-Mouseover");
			General.arrow:SetSize(16,8);
		end
		----------
		local function gengxinlushiCD()
			if General.lushiitemID then
				local start, duration= GetItemCooldown(General.lushiitemID)
				if start and duration then
		 			General.cooldown:SetCooldown(start, duration);
		 		end
		 	end
	 	end
	 	local function SetAttributeItem()
			General:SetAttribute("type1", "item");
			General:SetAttribute("item1", General.lushiItemlink);
			General:SetNormalTexture(GetItemIcon(General.lushiitemID))
			gengxinlushiCD()
		end	
		local function UpdateIconAttribute(itemID)
			local itemID=itemID or PIGA_Per["QuickBut"]["LushiID"]
			local _, SpellID = PIGGetItemSpell(itemID)
			local lushiName,Itemlink = GetItemInfo(itemID)
			if not lushiName and General.lushijisuqi<10 then
				General.lushijisuqi=General.lushijisuqi+1
				return C_Timer.After(0.01, UpdateIconAttribute);
			end
			if lushiName and SpellID then
				General.lushiSpellID=SpellID
				General.lushiitemID=itemID
				General.lushiItemlink=Itemlink
				if InCombatLockdown() then
					General:RegisterEvent("PLAYER_REGEN_ENABLED")
				else
					SetAttributeItem()
				end
			end
		end	
		local function Skill_Button_Genxin()
			if InCombatLockdown() then return end
	 		local Skill_List = Data.Get_Skill_Info(true)
			if #Skill_List.top>0 then
				General:SetAttribute("type2", "spell");
				General:SetAttribute("spell2", Skill_List.top[1][2]);
			end
		end
		Skill_Button_Genxin()
		General:RegisterEvent("PLAYER_ENTERING_WORLD")
		General:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
		General:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
		General:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		General:HookScript("OnEvent", function(self,event,arg1,_,arg3)
			if event=="PLAYER_ENTERING_WORLD" then
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")
				General.lushijisuqi=0
				UpdateIconAttribute()
				Skill_Button_Genxin()
			elseif event=="PLAYER_REGEN_ENABLED" then
				self:UnregisterEvent("PLAYER_REGEN_ENABLED")
				SetAttributeItem()
			elseif event=="SPELL_UPDATE_COOLDOWN" then
				C_Timer.After(0.01, gengxinlushiCD);
			else
				if arg3==self.lushiSpellID then 
					if event=="UNIT_SPELLCAST_START" then
				 		self.start:Show();
				 	end
				 	if event=="UNIT_SPELLCAST_STOP" then
				 		self.start:Hide();
					end
				end
			end
		end)
		--内容页
		local butW = QuickButUI.butWWW+4
		local gaoNum,kuanNum = 5,6
		local General_List = PIGFrame(General, nil, {(butW+6)*kuanNum+6,(butW+6)*gaoNum+6},"PIG_QuickBut_General",true);
		General_List:PIGSetBackdrop()
		General_List:SetScale(PIGA["QuickBut"]["bili"]);
		General_List:SetFrameLevel(33)
		General_List:SetScale(0.8)
		General_List.Close=PIGDiyBut(General_List,{"BOTTOM",General_List,"TOP",0,0},{26})
		General_List.Close:HookScript("OnClick",function(self)
			General_List:Hide();
		end)
		General:HookScript("OnClick",function(self,button)
			if button == "LeftButton" and IsShiftKeyDown() then
				if General_List:IsShown() then
					General_List:Hide();
				else
					General_List:Show();
				end
			end
		end)
		hooksecurefunc(QuickButUI, "UpdateShowHide", function(self)
			General_List:ClearAllPoints();
			General.arrow:ClearAllPoints();
			General_List.Close:ClearAllPoints();
			if PIGA["QuickBut"]["Pailie"]==1 then
				local WowHeight=GetScreenHeight();
				local offset = General:GetBottom() or 200
				General_List:ClearAllPoints()
				if offset>(WowHeight*0.5) then
					General.arrow:SetPoint("BOTTOM",0,-1);
					General_List.Angle_Play=GetAngle_V(180)
					General_List.Angle_End=GetAngle_V(General_List.Angle_Play+180,true)	
					SetClampedTextureRotation(General.arrow,General_List.Angle_Play);
					General_List:SetPoint("TOP", General, "BOTTOM", 0, -4);
					General_List.Close:SetPoint("TOP",General_List,"BOTTOM",0,0)
				else
					General.arrow:SetPoint("TOP",0,1);
					General_List.Angle_Play=GetAngle_V(0)
					General_List.Angle_End=GetAngle_V(General_List.Angle_Play+180,true)
					SetClampedTextureRotation(General.arrow,General_List.Angle_Play,true);
					General_List:SetPoint("BOTTOM", General, "TOP", 0, 4);
					General_List.Close:SetPoint("BOTTOM",General_List,"TOP",0,0)
				end
			elseif PIGA["QuickBut"]["Pailie"]==2 then
				local WowWidth=GetScreenWidth()
				local offset1 = General:GetLeft() or 500
				if offset1>(WowWidth*0.5) then
					General.arrow:SetPoint("LEFT",-1,0);
					General_List.Angle_Play=GetAngle_V(270)
					General_List.Angle_End=GetAngle_V(General_List.Angle_Play+180,true)
					SetClampedTextureRotation(General.arrow,General_List.Angle_Play);
					General_List:SetPoint("RIGHT",General,"LEFT",-2,0);
					General_List.Close:SetPoint("RIGHT",General_List,"LEFT",-2,0)
				else
					General.arrow:SetPoint("RIGHT",1,0);
					General_List.Angle_Play=GetAngle_V(90)
					General_List.Angle_End=GetAngle_V(General_List.Angle_Play+180,true)
					SetClampedTextureRotation(General.arrow,General_List.Angle_Play);
					General_List:SetPoint("LEFT",General,"RIGHT",2,0);
					General_List.Close:SetPoint("LEFT",General_List,"RIGHT",2,0)
				end
			end
        end)
		General_List:HookScript("OnHide",function(self)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
			SetClampedTextureRotation(General.arrow,self.Angle_Play);
		end)
		General_List:HookScript("OnShow",function(self)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
			SetClampedTextureRotation(General.arrow,self.Angle_End);
			General_List:Update_Lists()
		end)
		--玩具
		local ToyList = {
			64488,--旅店老板的女儿
			260221,--纳鲁的拥抱
		}
		local ToyList_Retail = {
			168907,--数字化全息炉石
			162973,--冬天爷爷的炉石
			166746,--吞火者的炉石
			165802,--复活节的炉石
			165802,--复活节的炉石
			165670,--小匹德菲特的可爱炉石
			208704,--幽邃住民的土灵炉石
			190196,--开悟者的炉石
			228940,--恶名丝线炉石
			163045,--无头骑士的炉石
			193588,--时光旅行者的炉石
			165669,
			184353,
			200630,
			172179,
			180290,
			209035,
			166747,
			188952,
			110560,--要塞炉石
			140192,--达拉然炉石
			182773,
			212337,--炉之石
			93672,--黑暗之门	
		}
		local BagList = {
			6948,--炉石
			46874,--银色北伐军战袍
		}
		if PIG_MaxTocversion() then
			table.insert(ToyList,184871)--黑暗之门
			table.insert(BagList,28585)--红宝石靴子
		else
			for k,v in pairs(ToyList_Retail) do
				table.insert(ToyList,v)
			end
		end
		local function BAGIsitemID(duibiID)
			for bag=1,#bagData["bagID"] do
				for slot=1,PIGGetContainerNumSlots(bagData["bagID"][bag]) do
					local ItemID = PIGGetContainerItemID(bagData["bagID"][bag], slot)
					if ItemID and ItemID==duibiID then
						return true
					end
				end
			end
			local ItemID = GetInventoryItemID("player", 8);
			if ItemID and ItemID==duibiID then
				return true
			end
			return false
		end
		local function Get_Lists()
			local datax={}
			for i=1,#ToyList do
				local itemicon=C_Item.GetItemIconByID(ToyList[i])
				if itemicon and itemicon~=134400 then
					table.insert(datax,{ToyList[i],itemicon,PlayerHasToy(ToyList[i])})
				end
			end
			for i=1,#BagList do
				local itemicon=C_Item.GetItemIconByID(BagList[i])
				if itemicon and itemicon~=134400 then
					table.insert(datax,{BagList[i],itemicon,BAGIsitemID(BagList[i])})
				end
			end
			return datax
		end
		General_List.ButList={}
		function General_List:Update_Lists()
			local listall=Get_Lists()
			for i=1,#listall do
				if not General_List.ButList[i] then
					local butitem = CreateFrame("Button", nil, General_List)
					General_List.ButList[i]=butitem
					butitem:SetHighlightTexture(130839)
					butitem:SetSize(butW, butW)
					if i==1 then
						butitem:SetPoint("BOTTOMLEFT",General_List,"BOTTOMLEFT",6,6);
					else
						local num1,num2=math.modf(i/(kuanNum))
						if num2==0 then
							butitem.huanhang=true
						end
						if General_List.ButList[i-1].huanhang then
							butitem:SetPoint("BOTTOMLEFT",General_List.ButList[i-kuanNum],"TOPLEFT",0,6);
						else
							butitem:SetPoint("LEFT",General_List.ButList[i-1],"RIGHT",6,0);
						end	
					end
					butitem.Select = butitem:CreateTexture(nil, "OVERLAY");
					butitem.Select:SetTexture(130724);
					butitem.Select:SetBlendMode("ADD");
					butitem.Select:SetAllPoints(butitem)
					butitem.Select:Hide();
					butitem:HookScript("OnClick", function(self)
						if self.notusr then
							if InCombatLockdown() then
								PIGErrorMsg(ERR_NOT_IN_COMBAT)
							else
								PIGA_Per["QuickBut"]["LushiID"]=listall[i][1]
								UpdateIconAttribute(listall[i][1]) General_List:Hide();
							end
						end
					end);
					butitem:SetScript("OnEnter", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
						GameTooltip:SetItemByID(listall[i][1])
						GameTooltip:Show();
					end)
					butitem:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				end
				local butitem=General_List.ButList[i]
				butitem:SetNormalTexture(listall[i][2]);
				butitem:GetNormalTexture():SetDesaturated(not listall[i][3])
				butitem.notusr=listall[i][3]
				if listall[i][1]==PIGA_Per["QuickBut"]["LushiID"] then
					butitem.Select:Show();
				else
					butitem.Select:Hide();
				end
			end
		end
	end,
})
--职业技能----
local Item_Spell_List ={{},{}}
local function GetSpellData_1(datax,classId,mapIDname)
	local NewData,lienum={},0
	for i=1,#datax do
		if classId==8 then
			lienum=2
			local _,num2=math.modf((i+1)/2)
			if num2~=0 then
				table.insert(NewData,{"spell",datax[i]});	
			else
				local namex
				if mapIDname and mapIDname[(i+1)/2] then
					local inxond = GetMapInfo(mapIDname[(i+1)/2]) 
					namex=inxond and inxond.name or UNKNOWN
				end
				table.insert(NewData,{"spell",datax[i],namex});	
			end
		else
			lienum=1
			table.insert(NewData,{"spell",datax[i]});	
		end
	end
	return NewData,lienum
end
local function GetSpellData()
	local datax={}
	--1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
	local classId = PlayerInfo.ClassData.classId
	if classId==3 then --3猎人
		datax ={6197,982,2641,1462,1515,883};
		if PIG_MaxTocversion(40000) then
			table.insert(datax,1002);
			table.insert(datax,5149);
			if PIG_MaxTocversion(30000,true) then
				table.insert(datax,62757);
			end
		end
		if PIG_MaxTocversion(60000) then
			table.insert(datax,1,6991);
			if PIG_MaxTocversion(50000,true) then
				table.insert(datax,83242);
				table.insert(datax,83243);
				table.insert(datax,83244);
				table.insert(datax,83245);
			end
		end
	elseif classId==4 then--盗贼
		if PIG_MaxTocversion(50000) then
			datax ={2842};
		end
	elseif classId==6 then--死亡骑士
		datax ={53428,50977};
	elseif classId==8 then --法师
		local mapIDname={}
		local englishFaction, _ = UnitFactionGroup("player") 
		if englishFaction=="Alliance" then
			datax ={3561,10059,3562,11416,3565,11419};
			-- 125/126--达拉然
			if PIG_MaxTocversion(50000) then
				--1453暴风城/1455铁炉堡/1457达纳苏斯/1947埃索达/1955沙塔斯
				mapIDname ={1453,1455,1457,1947,1445,1955,125,nil,nil,390};
			else
				--84暴风城/87铁炉堡/89达纳苏斯/103埃索达/111沙塔斯
				mapIDname ={84,87,89,103,70,111,125,nil,244,390};
			end
		elseif englishFaction=="Horde" then
			datax ={3567,11417,3566,11420,3563,11418};
			if PIG_MaxTocversion(50000) then
				--1454奥格/1456雷霆崖/1458幽暗城/1954银月城/1955沙塔斯
				mapIDname ={1454,1456,1458,1954,1435,1955,125,nil,nil,390};
			else
				--85奥格/88雷霆崖/998幽暗城/110银月城/111沙塔斯
				mapIDname ={85,88,998,110,70,111,125,nil,244,390};
			end
		end
		if PIG_MaxTocversion(20000,true) then
			if englishFaction=="Alliance" then
				local tbcchuansong = {32271,32266,49359,49360,33690,33691};	
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			elseif englishFaction=="Horde" then
				local tbcchuansong = {32272,32267,49358,49361,35715,35717};
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			end
		end
		if PIG_MaxTocversion(30000,true) then
			local tbcchuansong ={53140,53142};
			for ik=1,#tbcchuansong do
				table.insert(datax,tbcchuansong[ik]);			
			end			
		end
		if PIG_MaxTocversion(40000,true) then
			table.insert(datax,120145)
			table.insert(datax,120146)
			if englishFaction=="Alliance" then
				local tbcchuansong = {88342,88345};	
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			elseif englishFaction=="Horde" then
				local tbcchuansong = {88344,88346};
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			end		
		end
		if PIG_MaxTocversion(50000,true) then
			if englishFaction=="Alliance" then
				local tbcchuansong = {132621,132620};	
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			elseif englishFaction=="Horde" then
				local tbcchuansong = {132627,132626};
				for ik=1,#tbcchuansong do
					table.insert(datax,tbcchuansong[ik]);			
				end
			end		
		end
		return GetSpellData_1(datax,classId,mapIDname)
	end
	return GetSpellData_1(datax,classId)
end
local ItemDataX ={18984,18986,7148,18587,18232,18660};--空间撕裂器-永望镇/安全传送器-加基森/起搏器/起搏器XL		
local function GetItemData(ix,funxx,Count)
	if PIG_MaxTocversion() then
		if ItemDataX[ix] then
			Count=Count or 0
			local _,itemLink = GetItemInfo(ItemDataX[ix])
			if not itemLink and Count<100 then
				Count=Count+1
				C_Timer.After(0.02,function()
		            GetItemData(ix, funxx, Count)
		        end)
				return
			end
			if itemLink then
				funxx({"item",itemLink,ItemDataX[ix]})
				return
			end
		end
	end
end
local ActionID,qkuiname=400, "PIG_QuickButSpell"
Create.PIGaddQuickBut(8,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["Spell"]
	end,
	Icon=131146,
	UIname=qkuiname,
	Tooltip = KEY_BUTTON1.."-|cff00FFFF随机使用坐骑|r\nShift+"..KEY_BUTTON1.."-|cff00FFFF打开Recount/Details插件记录面板|r\n"..KEY_BUTTON2.."-|cff00FFFF展开职业辅助技能栏|r",
	Template="SecureHandlerClickTemplate",
	fun=function(Zhushou,QuickButUI)
		local PigMacroEventCount_QK =0;
		local PigMacroDeleted_QK = false;
		local PigMacroCount_QK=0
		local butW = QuickButUI.butWWW+4
		local gaoNum,CommonNum,extNum = 10,2,0
		local FixedSpellData,extNum=GetSpellData()
		local kuanNum=CommonNum+extNum
		local IconTEX=Zhushou:GetNormalTexture()
		local IconCoord = CLASS_ICON_TCOORDS[PlayerInfo.ClassData.classFile];
		if Fun.IsElvUI() or Fun.IsNDui() then
			local left, right, top, bottom = unpack(IconCoord);
			local left   = left+0.02;
			local right  = right  - 0.02;
			local top    = top+0.02;
			local bottom = bottom - 0.02;
			IconTEX:SetTexCoord(left, right, top, bottom);
		else
			IconTEX:SetTexCoord(unpack(IconCoord));
		end
		Zhushou.arrow = Zhushou:CreateTexture(nil,"ARTWORK");
		Zhushou.arrow:SetDrawLayer("ARTWORK", 7)
		if PIG_MaxTocversion() then
			Zhushou.arrow:SetAtlas("bag-arrow")
			Zhushou.arrow:SetSize(11,16);
		else
			Zhushou.arrow:SetAtlas("UI-HUD-ActionBar-Flyout-Mouseover");
			Zhushou.arrow:SetSize(16,8)
		end
		Zhushou.start = Zhushou:CreateTexture(nil, "OVERLAY");
		Zhushou.start:SetTexture(130724);
		Zhushou.start:SetBlendMode("ADD");
		Zhushou.start:SetAllPoints(Zhushou)
		Zhushou.start:Hide();
		_G["BINDING_NAME_CLICK "..qkuiname..":LeftButton"]= "PIG功能条随机坐骑"
		---内容页----
		local Zhushou_List = CreateFrame("Frame", nil, Zhushou,"BackdropTemplate,SecureHandlerShowHideTemplate");
		Zhushou_List:SetBackdrop(Create.BackdropData)
		Zhushou_List:SetBackdropColor(unpack(Create.BackdropColor));
		Zhushou_List:SetBackdropBorderColor(unpack(Create.BackdropBorderColor));
		Zhushou_List:SetSize((butW+6)*kuanNum+6,(butW+6)*gaoNum+6);
		Zhushou_List:SetScale(PIGA["QuickBut"]["bili"]);
		Zhushou_List:Hide();
		Zhushou_List:SetFrameLevel(33)
		Zhushou_List:SetScale(0.8)
		--
		hooksecurefunc(QuickButUI, "UpdateShowHide", function(self)
			Zhushou_List:ClearAllPoints();
			Zhushou.arrow:ClearAllPoints();
			Zhushou_List.Close:ClearAllPoints();
			Zhushou_List.ClickClose:ClearAllPoints();
			Zhushou_List.Reset:ClearAllPoints();
			if PIGA["QuickBut"]["Pailie"]==1 then
				Zhushou_List.ClickClose:SetPoint("RIGHT",Zhushou_List.Close,"LEFT",-10,0)
				Zhushou_List.Reset:SetPoint("RIGHT",Zhushou_List.ClickClose,"LEFT",-4,0)
				local WowHeight=GetScreenHeight();
				local offset = Zhushou:GetBottom() or 200
				Zhushou_List:ClearAllPoints()
				if offset>(WowHeight*0.5) then
					Zhushou.arrow:SetPoint("BOTTOM",0,-1);
					Zhushou_List.Angle_Play=GetAngle_V(180)
					Zhushou_List.Angle_End=GetAngle_V(Zhushou_List.Angle_Play+180,true)
					SetClampedTextureRotation(Zhushou.arrow,Zhushou_List.Angle_Play);
					Zhushou_List:SetPoint("TOP", Zhushou, "BOTTOM", 0, -4);
					Zhushou_List.Close:SetPoint("TOPRIGHT",Zhushou_List,"BOTTOMRIGHT",0,0)
				else
					Zhushou.arrow:SetPoint("TOP",0,1);
					Zhushou_List.Angle_Play=GetAngle_V(0)
					Zhushou_List.Angle_End=GetAngle_V(Zhushou_List.Angle_Play+180,true)
					SetClampedTextureRotation(Zhushou.arrow,Zhushou_List.Angle_Play);
					Zhushou_List:SetPoint("BOTTOM", Zhushou, "TOP", 0, 4);
					Zhushou_List.Close:SetPoint("BOTTOMRIGHT",Zhushou_List,"TOPRIGHT",0,0)
				end
			elseif PIGA["QuickBut"]["Pailie"]==2 then
				Zhushou_List.ClickClose:SetPoint("TOP",Zhushou_List.Close,"BOTTOM",0,-10)
				Zhushou_List.Reset:SetPoint("TOP",Zhushou_List.ClickClose,"BOTTOM",0,-6)
				local WowWidth=GetScreenWidth()
				local offset1 = Zhushou:GetLeft() or 500
				if offset1>(WowWidth*0.5) then
					Zhushou.arrow:SetPoint("LEFT",-1,0);
					Zhushou_List.Angle_Play=GetAngle_V(270)
					Zhushou_List.Angle_End=GetAngle_V(Zhushou_List.Angle_Play+180,true)
					SetClampedTextureRotation(Zhushou.arrow,Zhushou_List.Angle_Play);
					Zhushou_List:SetPoint("RIGHT",Zhushou,"LEFT",-2,0);
					Zhushou_List.Close:SetPoint("RIGHT",Zhushou_List,"LEFT",-2,0)
				else
					Zhushou.arrow:SetPoint("RIGHT",1,0);
					Zhushou_List.Angle_Play=GetAngle_V(90)
					Zhushou_List.Angle_End=GetAngle_V(Zhushou_List.Angle_Play+180,true)
					SetClampedTextureRotation(Zhushou.arrow,Zhushou_List.Angle_Play);
					Zhushou_List:SetPoint("LEFT",Zhushou,"RIGHT",2,0);
					Zhushou_List.Close:SetPoint("LEFT",Zhushou_List,"RIGHT",2,0)
				end
			end
        end)
		--
		Zhushou_List:HookScript("OnShow",function(self)
			SetClampedTextureRotation(Zhushou.arrow,self.Angle_End);
		end)
		Zhushou_List:HookScript("OnHide",function(self)
			SetClampedTextureRotation(Zhushou.arrow,self.Angle_Play);
		end)
		Zhushou:SetAttribute("_onclick",[=[
			if button == "RightButton" then
				local ref=self:GetFrameRef("frame1")
				if ref:IsShown() then
					ref:Hide();
				else
					ref:Show();
				end
			end
		]=])
		Zhushou:SetFrameRef("frame1", Zhushou_List);
		Zhushou:HookScript("OnClick",function(self,button)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
			if button == "LeftButton" then
				if IsShiftKeyDown() then
					if Recount then
						if Recount.MainWindow:IsShown() then
							Recount.MainWindow:Hide()
						else
							Recount.MainWindow:Show()
							Recount:RefreshMainWindow()
						end
					elseif DetailsBaseFrame1 then
						for i=1,10 do
							if not _G["DetailsBaseFrame"..i] then break end
							if _G["DetailsBaseFrame"..i]:IsShown() then
								_G["DetailsBaseFrame"..i]:Hide()
							else
								_G["DetailsBaseFrame"..i]:Show()
							end
						end
					else
						PIGErrorMsg("未安装Recount/Details");
					end
				else
					C_MountJournal.SummonByID(0)
				end
			end
		end)
		Zhushou:RegisterEvent("PLAYER_ENTERING_WORLD");
		Zhushou:RegisterEvent("ZONE_CHANGED_INDOORS");
		Zhushou:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		Zhushou:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED");
		Zhushou:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
		Zhushou:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
		Zhushou:HookScript("OnEvent", function(self,event,arg1,_,arg3)
			if event=="UNIT_SPELLCAST_START" or event=="UNIT_SPELLCAST_STOP" then
				local mountID = C_MountJournal.GetMountFromSpell(arg3)
				if mountID then 
					-- local name, spellID= C_MountJournal.GetMountInfoByID(mountID)
					-- if arg3==spellID then
					if event=="UNIT_SPELLCAST_START" then
				 		self.start:Show();
				 	end
				 	if event=="UNIT_SPELLCAST_STOP" then
				 		self.start:Hide();
					end
				end
			elseif event=="PLAYER_ENTERING_WORLD" or event=="ACTIONBAR_UPDATE_USABLE" or event=="MOUNT_JOURNAL_USABILITY_CHANGED" then
				if IsIndoors() then
					self:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5)
				else
					self:GetNormalTexture():SetVertexColor(1, 1, 1);
				end
			end
		end)
		---
		Zhushou_List.Close=PIGDiyBut(Zhushou_List,{"BOTTOMRIGHT",Zhushou_List,"TOPRIGHT",0,0},{26},nil,"SecureHandlerClickTemplate")
		Zhushou_List.Close:SetAttribute("_onclick",[=[
			if button == "LeftButton" then
				local ref=self:GetFrameRef("frame1")
				if ref:IsShown() then
					ref:Hide();
				else
					ref:Show();
				end
			end
		]=])
		Zhushou_List.Close:SetFrameRef("frame1", Zhushou_List);
		Zhushou_List.ClickClose = PIGCheckbutton(Zhushou_List,nil,{"","点击按钮后关闭界面"});
		Zhushou_List.ClickClose:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["QuickBut"]["SpellClose"]=true;
			else
				PIGA["QuickBut"]["SpellClose"]=false;
			end
		end)
		Zhushou_List.ClickClose:SetScript("OnShow", function (self)
			self:SetChecked(PIGA["QuickBut"]["SpellClose"])
		end)
		Zhushou_List.Reset = PIGDiyBut(Zhushou_List,nil,{21,nil,21,nil,"common-icon-undo"})
		PIGEnter(Zhushou_List.Reset,"重置|r"..CLASS..BINDING_HEADER_ACTIONBAR.."为默认")
		Zhushou_List.Reset:SetScript("OnClick", function (self)
			StaticPopup_Show ("PIG_ZHUSHOU_LISTRESET");
		end)
		StaticPopupDialogs["PIG_ZHUSHOU_LISTRESET"] = {
			text = "|cffff0000重置|r"..CLASS..BINDING_HEADER_ACTIONBAR.."为默认(需要重载界面)\n确定重置?",
			button1 = YES,
			button2 = NO,
			OnAccept = function()
				PIGA_Per["QuickBut"]["ActionData"]={}
				ReloadUI();
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		local function addBarButton(i,butlist,leftV,liecocc)
			local zhushoubut = CreateFrame("CheckButton", nil, Zhushou_List, "SecureActionButtonTemplate,SecureHandlerDragTemplate,SecureHandlerMouseUpDownTemplate")
			butlist[i]=zhushoubut
			zhushoubut:SetSize(butW, butW)
			zhushoubut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
			zhushoubut:SetNormalAtlas("UI-HUD-ActionBar-IconFrame")
			zhushoubut:SetCheckedTexture("Interface/Buttons/CheckButtonHilight")
			zhushoubut:GetCheckedTexture():SetBlendMode("ADD")
			zhushoubut.icon = zhushoubut:CreateTexture()
			zhushoubut.icon:SetAllPoints(zhushoubut)
			zhushoubut.cooldown = CreateFrame("Cooldown", nil, zhushoubut, "CooldownFrameTemplate")
			zhushoubut.cooldown:SetAllPoints()
			zhushoubut.Name = PIGFontString(zhushoubut,{"BOTTOM",zhushoubut,"BOTTOM",0,0},nil,"THICKOUTLINE",16)
			zhushoubut.Name:SetTextColor(1, 1, 1, 1)
			zhushoubut.NameRight = PIGFontString(zhushoubut,{"TOP",zhushoubut,"TOP",butW*0.5+6,1},nil,"THICKOUTLINE",16)
			zhushoubut.NameRight:SetTextColor(1, 1, 1, 1)
			zhushoubut.Count = PIGFontString(zhushoubut,{"BOTTOMRIGHT",zhushoubut,"BOTTOMRIGHT",-1,0},nil,"THICKOUTLINE",16)
			if i==1 then
				zhushoubut:SetPoint("BOTTOMLEFT",Zhushou_List,"BOTTOMLEFT",6+leftV,6);
			else
				if liecocc>1 then
					local num1,num2=math.modf(i/liecocc)
					if num2~=0 then
						zhushoubut:SetPoint("BOTTOMLEFT",butlist[i-liecocc],"TOPLEFT",0,6);
					else
						zhushoubut:SetPoint("LEFT",butlist[i-1],"RIGHT",6,0);
					end
				else
					zhushoubut:SetPoint("BOTTOM",butlist[i-1],"TOP",0,6);
				end
			end
			PIGUseKeyDown(zhushoubut)
			zhushoubut:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip_SetDefaultAnchor(GameTooltip, self)
				Update_OnEnter(self,"QuickBut")
			end)
			zhushoubut:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			zhushoubut:HookScript("PostClick", function(self)
				Update_PostClick(self)
				if PIGA["QuickBut"]["SpellClose"] and not InCombatLockdown() then Zhushou_List:Hide() end
			end);
			zhushoubut:HookScript("OnShow", function (self)
				self:GetCheckedTexture():Hide()
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
				Update_bukeyong(self)
			end)
			zhushoubut:HookScript("OnMouseUp", function (self)
				Cursor_Fun(self,"OnMouseUp","QuickBut")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end);
			----
			zhushoubut:RegisterEvent("TRADE_SKILL_CLOSE")
			if PIG_MaxTocversion() then
				zhushoubut:RegisterEvent("CRAFT_CLOSE")
			end
			zhushoubut:RegisterEvent("UPDATE_MACROS");
			--zhushoubut:RegisterEvent("EXECUTE_CHAT_LINE");
			zhushoubut:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
			zhushoubut:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			zhushoubut:RegisterUnitEvent("UNIT_AURA","player");
			zhushoubut:RegisterEvent("BAG_UPDATE");
			zhushoubut:RegisterEvent("PLAYER_UPDATE_RESTING");
			zhushoubut:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
				if not Zhushou_List:IsShown() then return end
				if event=="PLAYER_REGEN_ENABLED" then
					PigMacroDeleted_QK,PigMacroCount_QK=Update_Macro(self,PigMacroDeleted_QK,PigMacroCount_QK,"QuickBut")
					self:UnregisterEvent("PLAYER_REGEN_ENABLED");
				elseif event=="BAG_UPDATE" then
					Update_Count(self)
				elseif event=="ACTIONBAR_UPDATE_COOLDOWN" then
					Update_Cooldown(self)
					Update_bukeyong(self)
				elseif event=="ACTIONBAR_UPDATE_STATE" or event=="TRADE_SKILL_CLOSE" or event=="CRAFT_CLOSE" or event=="UNIT_AURA" or event=="EXECUTE_CHAT_LINE" then
					Update_State(self)
					Update_Icon(self)
				elseif event=="UPDATE_MACROS" or event=="PLAYER_REGEN_ENABLED" then
					PigMacroEventCount_QK=PigMacroEventCount_QK+1;
					if self.Type=="macro" then
						if PigMacroEventCount_QK>5 then
							local AccMacros, CharMacros = GetNumMacros();
							if PigMacroCount_QK==0 then
								PigMacroCount_QK = AccMacros + CharMacros;
							elseif (PigMacroCount_QK > AccMacros + CharMacros) then
								PigMacroDeleted_QK = true;
							end
							PigMacroDeleted_QK,PigMacroCount_QK=Update_Macro(self,PigMacroDeleted_QK,PigMacroCount_QK,"QuickBut")
						end
					end
					Update_Icon(self)
					Update_Count(self)
				elseif event=="PLAYER_UPDATE_RESTING" then
					Update_bukeyong(self)
				end
			end)
			return zhushoubut
		end
		Zhushou_List.ButList={}
		for i=1,gaoNum*CommonNum do
			local zhushoubut=addBarButton(i,Zhushou_List.ButList,0,CommonNum)
			zhushoubut:SetAttribute("_ondragstart",[=[
				self:SetAttribute("type", nil)
			]=])
			zhushoubut:HookScript("OnDragStart", function (self)
				Cursor_Fun(self,"OnDragStart","QuickBut")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end)
			zhushoubut:SetAttribute("_onreceivedrag",[=[
				local leibie, spellID = ...
				if kind=="spell" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, spellID)
				elseif kind=="item" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, leibie)
				elseif kind=="macro" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, value)
				end
			]=])
			zhushoubut:HookScript("OnReceiveDrag", function (self)
				Cursor_Fun(self,"OnReceiveDrag","QuickBut")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end);
			zhushoubut:SetAttribute("action", ActionID+i)
			local actionID=zhushoubut:GetAttribute("action")
			if PIGA_Per["QuickBut"]["ActionData"][actionID] then
				loadingButInfo(zhushoubut,PIGA_Per["QuickBut"]["ActionData"][actionID],"NoShowActionBars")
			else
				GetItemData(i,function(ndata)
					if ndata then
						loadingButInfo(zhushoubut,ndata,"NoShowActionBars")
					end
				end)
			end
		end
		Zhushou_List.extButList={}
		for i=1,gaoNum*extNum do
			local zhushoubut=addBarButton(i,Zhushou_List.extButList,(butW+6)*CommonNum,extNum)
			loadingButInfo(zhushoubut,FixedSpellData[i],"lock")
		end
	end,
})