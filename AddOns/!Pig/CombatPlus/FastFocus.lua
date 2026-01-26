local _, addonTable = ...;
------------
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
local CombatPlusfun=addonTable.CombatPlusfun

---
local UnitFrame = {
	["Blizzard"]={
		"PlayerFrame","PetFrame","TargetFrame", "TargetFrameToT",
		"PartyMemberFrame1","PartyMemberFrame2","PartyMemberFrame3","PartyMemberFrame4",
		"PartyMemberFrame1PetFrame","PartyMemberFrame2PetFrame","PartyMemberFrame3PetFrame","PartyMemberFrame4PetFrame",
	},
	["ElvUI"]={
		"ElvUF_Player","ElvUF_Target","ElvUF_TargetTarget","ElvUF_Pet",
		"ElvUF_PartyGroup1UnitButton1","ElvUF_PartyGroup1UnitButton2","ElvUF_PartyGroup1UnitButton3","ElvUF_PartyGroup1UnitButton4","ElvUF_PartyGroup1UnitButton5",
	},
}
SetKeyList = {
	{"SHIFT+"..KEY_BUTTON1,"shift"},
	{"CTRL+"..KEY_BUTTON1,"ctrl"},
	{"ALT+"..KEY_BUTTON1,"alt"},
}
SetKeyListName = {
	["shift"]="SHIFT+"..KEY_BUTTON1,
	["ctrl"]="CTRL+"..KEY_BUTTON1,
	["alt"]="ALT+"..KEY_BUTTON1,
}
if PIG_MaxTocversion(20000,true) then
	local Create=addonTable.Create
	local PIGDownMenu=Create.PIGDownMenu
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local FastFocusF =PIGOptionsList_R(CombatPlusfun.RTabFrame,BINDING_NAME_FOCUSTARGET,90)
	FastFocusF.SetFocus = PIGCheckbutton_R(FastFocusF,{BINDING_NAME_FOCUSTARGET,"按后方设置的快捷键后点击头像快速"..SETTINGS_KEYBINDINGS_LABEL..FOCUSTARGET},true)
	FastFocusF.SetFocus:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Common"]["SetFocus"]=true;
			CombatPlusfun.SetFocus()
		else
			PIGA["Common"]["SetFocus"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
	end);
	FastFocusF.SetFocus.xiala=PIGDownMenu(FastFocusF.SetFocus,{"LEFT",FastFocusF.SetFocus.Text, "RIGHT", 4,0},{150,24})
	function FastFocusF.SetFocus.xiala:PIGDownMenu_Update_But()
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		local SetKeyList = SetKeyList
		for i=1,#SetKeyList,1 do
		    info.text, info.arg1, info.arg2 = SetKeyList[i][1], SetKeyList[i][2]
		    info.checked = SetKeyList[i][2]==PIGA["Common"]["SetFocusKEY"]
			self:PIGDownMenu_AddButton(info)
		end 
	end
	function FastFocusF.SetFocus.xiala:PIGDownMenu_SetValue(value,arg1)
		if InCombatLockdown() then PIG_print("战斗中无法更改按键") return end
		self:PIGDownMenu_SetText(value)
		PIGA["Common"]["SetFocusKEY"]=arg1
		CombatPlusfun.SetFocus()
		CombatPlusfun.ClearFocus()
		PIGCloseDropDownMenus()
	end
	FastFocusF.SetFocus.Mouse =PIGCheckbutton(FastFocusF.SetFocus,{"LEFT",FastFocusF.SetFocus.xiala,"RIGHT",10,0},{"包含角色模型","在角色模型上点击设置的快捷键也可设为焦点"})
	FastFocusF.SetFocus.Mouse:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Common"]["SetFocusMouse"]=true;
		else
			PIGA["Common"]["SetFocusMouse"]=false;
		end
		CombatPlusfun.SetFocus()
	end);
	FastFocusF.ClearFocus =PIGCheckbutton_R(FastFocusF,{"快速清除焦点","在焦点头像点击已设置焦点快捷键可快速清除焦点"},true)
	FastFocusF.ClearFocus:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Common"]["ClearFocus"]=true;
		else
			PIGA["Common"]["ClearFocus"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		CombatPlusfun.ClearFocus()
	end);
	FastFocusF:HookScript("OnShow", function (self)
		self.SetFocus:SetChecked(PIGA["Common"]["SetFocus"]);
		self.SetFocus.xiala:PIGDownMenu_SetText(SetKeyListName[PIGA["Common"]["SetFocusKEY"]])
		self.SetFocus.Mouse:SetChecked(PIGA["Common"]["SetFocusMouse"]);
		self.ClearFocus:SetChecked(PIGA["Common"]["ClearFocus"]);
	end)
end
local FrameyanchiNUM = {}
local function CZFocus(Frame)
	for i=1,#SetKeyList,1 do
		local gonegnengKEY = SetKeyList[i][2].."-type1"
		Frame:SetAttribute(gonegnengKEY,nil)
	end
end
local function zhixingshezhiFocus(Frame)
	--print(Frame,type(Frame))
	if _G[Frame] then
		if not InCombatLockdown() then
			CZFocus(_G[Frame])
			local gonegnengKEY = PIGA["Common"]["SetFocusKEY"].."-type1"
			_G[Frame]:SetAttribute(gonegnengKEY,"macro")
			_G[Frame]:SetAttribute("macrotext","/focus mouseover")
		end
	else
		FrameyanchiNUM[Frame]=FrameyanchiNUM[Frame] or 1
		if FrameyanchiNUM[Frame]<10 then
			C_Timer.After(0.1,function()
				FrameyanchiNUM[Frame]=FrameyanchiNUM[Frame]+1
				zhixingshezhiFocus(Frame)
			end)
		end
	end
end
local function SET_MouseoverFocus()
	if PIGA["Common"]["SetFocusMouse"] then 
		if not PIG_MouseoverFocuser then
			local MouseoverFocuser=CreateFrame("CheckButton", "PIG_MouseoverFocuser", UIParent, "SecureActionButtonTemplate")
			addonTable.Fun.ActionFun.PIGUseKeyDown(MouseoverFocuser)
		end
		PIG_MouseoverFocuser:SetAttribute("type1","macro")
		PIG_MouseoverFocuser:SetAttribute("macrotext","/focus mouseover")
		ClearOverrideBindings(PIG_MouseoverFocuser)
		SetOverrideBindingClick(PIG_MouseoverFocuser,true,PIGA["Common"]["SetFocusKEY"].."-BUTTON1","PIG_MouseoverFocuser")
	else
		if PIG_MouseoverFocuser then
			PIG_MouseoverFocuser:SetAttribute("type1",nil)
		end
	end
end
local function SET_BlizzardUnit()	
	for k,v in pairs(UnitFrame.Blizzard) do
		zhixingshezhiFocus(v)
	end
	if IsAddOnLoaded("Blizzard_RaidUI") then
		for i=1, 40 do
			zhixingshezhiFocus("CompactRaidFrame"..i)
		end
		for groupIndex=1, 8 do
			for i=1,5 do
				zhixingshezhiFocus("CompactRaidGroup"..groupIndex.."Member"..i)
			end
		end
	end
end
local function SET_ElvUIUnit_1(id)
	for groupIndex=1, 8 do
		for i=1,40 do
			zhixingshezhiFocus("ElvUF_Raid"..id.."Group"..groupIndex.."UnitButton"..i)
		end
	end
end
local function SET_ElvUIUnit()
	if not IsAddOnLoaded("ElvUI") then return end
	for k,v in pairs(UnitFrame.ElvUI) do
		zhixingshezhiFocus(v)
	end
	SET_ElvUIUnit_1(1)
	SET_ElvUIUnit_1(2)
	SET_ElvUIUnit_1(3)
end
function CombatPlusfun.SetFocus()
	if not PIGA["Common"]["SetFocus"] then return end
	SET_MouseoverFocus()
	SET_BlizzardUnit()
	SET_ElvUIUnit()
	hooksecurefunc("CompactRaidGroup_GenerateForGroup", function(groupIndex)
		SET_BlizzardUnit()
		SET_ElvUIUnit()
	end)
end
--清除
local function zhixingClearFocus(Frame)
	if _G[Frame] then
		if not InCombatLockdown() then
			local gonegnengKEY = PIGA["Common"]["SetFocusKEY"].."-type1"
			_G[Frame]:SetAttribute(gonegnengKEY,"macro")
			_G[Frame]:SetAttribute("macrotext","/clearfocus")
		end
	else
		C_Timer.After(0.1,function()
			zhixingClearFocus(Frame)
		end)
	end
end
function CombatPlusfun.ClearFocus()
	if not PIGA["Common"]["ClearFocus"] then return end
	zhixingClearFocus("FocusFrame")
	if ElvUI then zhixingClearFocus("ElvUF_Focus") end
	if NDui then zhixingClearFocus("oUF_Focus") end
end
----
function CombatPlusfun.FastFocus()
	if PIG_MaxTocversion(20000,true) then
		CombatPlusfun.SetFocus()
		CombatPlusfun.ClearFocus()
	end
end