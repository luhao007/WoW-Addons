local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGLine=Create.PIGLine
local PIGSlider = Create.PIGSlider
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local Backdropinfo=Create.Backdropinfo
local Data=addonTable.Data
--=========================

local ActionFun=addonTable.Fun.ActionFun
local ActionBarfun=addonTable.ActionBarfun
local RTabFrame=ActionBarfun.RTabFrame

local Action_plusF,Action_plusTabBut =PIGOptionsList_R(RTabFrame,L["ACTION_TABNAME3"],100)
if PIG_MaxTocversion("tbc") then
	for index=6,8 do
		local Checkbut = PIGCheckbutton_R(Action_plusF,{ACTIONBARS_LABEL..index});
		Checkbut:SetPoint("TOPLEFT",Action_plusF,"TOPLEFT",20,-40*(index-6)-20);
		Checkbut:SetScript("OnClick", function (self)
			Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", self:GetChecked())
		end);
	end
else
	local fuFrame=ActionBarfun.fuFrame
	local fuFrameBut=ActionBarfun.fuFrameBut
	------
	local barName="PIG_ActionBar"
	local Showtiaojian,pailieName,paiNum,PailieFun,ShowHideNumFun,ShowHideEvent=unpack(ActionFun.UIdata)
	------------
	local zongshu, anniugeshu, anniujiange=4,12,6;
	for index=1,zongshu do
		local tishixinx = "PIG"..ACTIONBAR_LABEL.."|cff00FF00"..index.."|r"
		local Checkbut = PIGCheckbutton(Action_plusF, nil,{tishixinx,tishixinx}, nil, "PigBarOptionsCheckbut"..index);
		if index==1 then
			Checkbut:SetPoint("TOPLEFT",Action_plusF,"TOPLEFT",20,-20);
		else
			Checkbut:SetPoint("TOPLEFT",_G["PigBarOptionsCheckbut"..(index-1)],"BOTTOMLEFT",0,-76);
		end
		Checkbut:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA_Per["PigAction"]["Open"][index]=true
				ActionBarfun.Pig_Action()
			else
				PIGA_Per["PigAction"]["Open"][index]=false
				PIG_OptionsUI.RLUI:Show()
			end
			Checkbut:ShowOpenFun()
		end);
		Checkbut.ShowHide=PIGDownMenu(Checkbut,{"LEFT",Checkbut.Text,"RIGHT",20,0},{130,24})
		function Checkbut.ShowHide:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#Showtiaojian,1 do
			    info.text, info.arg1 = Showtiaojian[i], i
			    info.checked = i==PIGA_Per["PigAction"]["ShowTJ"][index]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function Checkbut.ShowHide:PIGDownMenu_SetValue(value,arg1,arg2)
			if InCombatLockdown()  then 
				PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
				return 
			end
			self:PIGDownMenu_SetText(value)
			PIGA_Per["PigAction"]["ShowTJ"][index] = arg1;
			if PIGA_Per["PigAction"]["Open"][index] then
				local max=PIGA_Per["PigAction"]["AnniuNum"][index]
				for id=1,anniugeshu do
					if id<=max then
						ShowHideEvent(_G[barName..index.."_But"..id],arg1)
					end
				end
			end
			PIGCloseDropDownMenus()
		end
		Checkbut.Lockdongzuotiao = PIGCheckbutton(Checkbut, {"LEFT",Checkbut.ShowHide,"RIGHT",30,0},{LOCK_FRAME,LOCK_FOCUS_FRAME..", "..HIDE..MOVE_FRAME..EMBLEM_SYMBOL});
		Checkbut.Lockdongzuotiao:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA_Per["PigAction"]["Lock"][index]=true
			else
				PIGA_Per["PigAction"]["Lock"][index]=false
			end
			if _G[barName..index] then
				if PIGA_Per["PigAction"]["Lock"][index] then
					_G[barName..index].yidong:Hide()
				else
					_G[barName..index].yidong:Show()
				end
			end
		end);
		Checkbut.Bindings = PIGButton(Checkbut,{"LEFT",Checkbut.Lockdongzuotiao.Text,"RIGHT",30,0},{76,20},KEY_BINDING);
		Checkbut.Bindings:SetScript("OnClick", function (self)
			Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID, addonName);
		end)
		Checkbut.CZBUT = PIGButton(Checkbut,{"LEFT",Checkbut.Bindings,"RIGHT",40,0},{76,20},RESET_POSITION);  
		Checkbut.CZBUT:SetScript("OnClick", function (self)
			Create.PIG_ResPoint(barName..index)
		end);
		Checkbut.PailieT = PIGFontString(Checkbut,{"TOPLEFT",Checkbut,"BOTTOMLEFT",20,-16},"排列")
		Checkbut.Pailie=PIGDownMenu(Checkbut,{"LEFT",Checkbut.PailieT,"RIGHT",2,0},{80,24})
		function Checkbut.Pailie:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,paiNum,1 do
			    info.text, info.arg1 = pailieName[i], i
			    info.checked = i==PIGA_Per["PigAction"]["Pailie"][index]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function Checkbut.Pailie:PIGDownMenu_SetValue(value,arg1,arg2)
			if InCombatLockdown()  then 
				PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
				return 
			end
			self:PIGDownMenu_SetText(value)
			PIGA_Per["PigAction"]["Pailie"][index] = arg1;
			for id=2,anniugeshu do
				PailieFun(barName..index,id,anniujiange,arg1)
			end
			PIGCloseDropDownMenus()
		end
		Checkbut.AnniuNumT = PIGFontString(Checkbut,{"LEFT",Checkbut.Pailie,"RIGHT",20,0},"按钮数")
		Checkbut.AnniuNum=PIGDownMenu(Checkbut,{"LEFT",Checkbut.AnniuNumT,"RIGHT",2,0},{60,24})
		function Checkbut.AnniuNum:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,12,1 do
			    info.text, info.arg1 = i, i
			    info.checked = i ==PIGA_Per["PigAction"]["AnniuNum"][index]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function Checkbut.AnniuNum:PIGDownMenu_SetValue(value,arg1,arg2)
			if InCombatLockdown()  then 
				PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
				return 
			end
			self:PIGDownMenu_SetText(value)
			PIGA_Per["PigAction"]["AnniuNum"][index] = arg1;
			for idx=1,anniugeshu do
				_G[barName..index.."_But"..idx]:SetAnniuNumFun(arg1)
			end
			PIGCloseDropDownMenus()
		end
		Checkbut.suofang_t = PIGFontString(Checkbut,{"LEFT",Checkbut.AnniuNum,"RIGHT",30,-2},"缩放:")
		local xiayiinfo = {0.6,1.4,0.01,{["Right"]="%"}}
		Checkbut.suofang = PIGSlider(Checkbut,{"LEFT",Checkbut.suofang_t,"RIGHT",10,0},xiayiinfo)
		function Checkbut.suofang:PIGOnValueChange(arg1)
			if InCombatLockdown()  then 
				PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
				return 
			end
			PIGA_Per["PigAction"]["Scale"][index]=arg1;
			_G[barName..index]:SetScale(arg1);
		end
		PIGLine(Action_plusF,"TOP",-94*index)
		function Checkbut:ShowOpenFun()
			self:SetChecked(PIGA_Per["PigAction"]["Open"][index])
			if PIGA_Per["PigAction"]["Open"][index] then
				self.Lockdongzuotiao:SetChecked(PIGA_Per["PigAction"]["Lock"][index])
				self.ShowHide:PIGDownMenu_SetText(Showtiaojian[PIGA_Per["PigAction"]["ShowTJ"][index]])
				self.Pailie:PIGDownMenu_SetText(pailieName[PIGA_Per["PigAction"]["Pailie"][index]])
				self.AnniuNum:PIGDownMenu_SetText(PIGA_Per["PigAction"]["AnniuNum"][index])
				self.suofang:PIGSetValue(PIGA_Per["PigAction"]["Scale"][index])
			end
			self.Lockdongzuotiao:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.ShowHide:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.PailieT:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.Pailie:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.AnniuNumT:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.AnniuNum:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.suofang_t:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.suofang:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.Bindings:SetShown(PIGA_Per["PigAction"]["Open"][index])
			self.CZBUT:SetShown(PIGA_Per["PigAction"]["Open"][index])
		end
	end
	---底部
	Action_plusF.dongzuotxian = PIGLine(Action_plusF,"TOP",-380)
	Action_plusF.title = PIGFontString(Action_plusF,{"TOPLEFT",Action_plusF.dongzuotxian,"TOPLEFT",20,-10},L["LIB_TIPS"]..": ");
	Action_plusF.title1 = PIGFontString(Action_plusF,{"TOPLEFT",Action_plusF.dongzuotxian,"TOPLEFT",40,-30},"|cff00ff001.此"..L["ACTION_TABNAME3"].."非其他插件调用系统预留给其他姿态(例如鸟德暗牧)的动作条，\n而是完全独立的动作条，不会占用角色其他形态的动作条按钮。|r")
	Action_plusF.title1:SetJustifyH("LEFT");
	---
	Action_plusF.CZ = PIGFontString(Action_plusF,{"TOPLEFT",Action_plusF.dongzuotxian,"TOPLEFT",40,-80},"|cffFFff00动作条异常点此：|r");
	Action_plusF.CZBUT = PIGButton(Action_plusF,{"LEFT",Action_plusF.CZ,"RIGHT",10,0},{76,20},RESET);  
	Action_plusF.CZBUT:SetScript("OnClick", function ()
		StaticPopup_Show ("CHONGZHI_EWAIDONGZUO");
	end);
	StaticPopupDialogs["CHONGZHI_EWAIDONGZUO"] = {
		text = "此操作将|cffff0000重置|r"..L["ACTION_TABNAME3"].."配置。\n确定重置?",
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA_Per["PigAction"] = addonTable.Default_Per["PigAction"];
			PIG_OptionsUI.RLUI:Show()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	Action_plusF:HookScript("OnShow", function(self)
		for index=1,zongshu do
			local Checkbut=_G["PigBarOptionsCheckbut"..index]
			Checkbut:ShowOpenFun()
		end
	end)
	--==================================
	function ActionBarfun.Pig_Action()
		for index=1,zongshu do
			local CFdata={
				index=index,
				["Mode"]="Action",
				["getData"]=function(key,index)
				    return PIGA_Per["PigAction"][key][index]
				end,
			}
			ActionBarfun.ADD_ActionBar(barName..index,CFdata,anniugeshu,anniujiange,fuFrame,fuFrameBut,RTabFrame,Action_plusF,Action_plusTabBut)
		end
		--处理绑定
		for index=1,zongshu do
			for id=1,anniugeshu do
				_G["BINDING_NAME_CLICK "..barName..index.."_But"..id..":LeftButton"]= "PIG"..ACTIONBARS_LABEL..index.." "..SETTINGS_KEYBINDINGS_LABEL..id
			end
		end
	end
end