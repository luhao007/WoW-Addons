local _, PD = ...;
local Fun=PD.Fun
local CombatPlusfun=PD.CombatPlusfun
---
local extload = {
	["ElvUI"]=Fun.IsElvUI,
	["NDui"]=Fun.IsNDui,
}
local FocusFrame = {
	["Blizzard"]="FocusFrame",
	["ElvUI"]="ElvUF_Focus",
	["NDui"]="oUF_Focus",
}
local UnitFrame = {
	["Blizzard"]={
		"PlayerFrame","PetFrame","TargetFrame", "TargetFrameToT",
		"PartyMemberFrame1","PartyMemberFrame2","PartyMemberFrame3","PartyMemberFrame4",
		"PartyMemberFrame1PetFrame","PartyMemberFrame2PetFrame","PartyMemberFrame3PetFrame","PartyMemberFrame4PetFrame",
	},
	["ElvUI"]={
		"ElvUF_Player","ElvUF_Target","ElvUF_TargetTarget","ElvUF_Pet",
		"ElvUF_PartyGroup1UnitButton1","ElvUF_PartyGroup1UnitButton2","ElvUF_PartyGroup1UnitButton3","ElvUF_PartyGroup1UnitButton4","ElvUF_PartyGroup1UnitButton5",
		"ElvUF_Boss1","ElvUF_Boss2","ElvUF_Boss3","ElvUF_Boss4","ElvUF_Boss5",
		"ElvUF_Arena1","ElvUF_Arena2","ElvUF_Arena3","ElvUF_Arena4","ElvUF_Arena5",
	},
	["NDui"]={
		"oUF_Player","oUF_Target","oUF_ToT","oUF_Pet",
		"oUF_PartyUnitButton1","oUF_PartyUnitButton2","oUF_PartyUnitButton3","oUF_PartyUnitButton4","oUF_PartyUnitButton5",
		"oUF_Boss1","oUF_Boss2","oUF_Boss3","oUF_Boss4","oUF_Boss5",
		"oUF_Arena1","oUF_Arena2","oUF_Arena3","oUF_Arena4","oUF_Arena5",
	},
}
local RiadFrame = {
	["Blizzard"]={
		{"CompactRaidFrame",40},{"CompactRaidGroup%dMember%d",8,5},
	},
	["ElvUI"]={
		{"ElvUF_Raid%dGroup%dUnitButton%d",3,8,40},
	},
	["NDui"]={
		{"oUF_Raid%dUnitButton%d",8,40}
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
local FrameyanchiNUM = {}
local function CZFocus(Frame)
	for i=1,#SetKeyList,1 do
		local gonegnengKEY = SetKeyList[i][2].."-type1"
		Frame:SetAttribute(gonegnengKEY,nil)
	end
end
local function Register_FocusFun(Frame)
	--print(Frame,_G[Frame])
	local uix
	if type(Frame)=="string" then 
		uix=_G[Frame]
	else
		uix=Frame
	end
	if uix then
		if not InCombatLockdown() then
			--CZFocus(uix)--导致清除了其他插件功能
			local gonegnengKEY = PIGA["Common"]["SetFocusKEY"].."-type1"
			uix:SetAttribute(gonegnengKEY,"macro")
			uix:SetAttribute("macrotext","/focus mouseover")
		end
	else
		FrameyanchiNUM[Frame]=FrameyanchiNUM[Frame] or 1
		if FrameyanchiNUM[Frame]<10 then
			C_Timer.After(0.1,function()
				FrameyanchiNUM[Frame]=FrameyanchiNUM[Frame]+1
				Register_FocusFun(Frame)
			end)
		end
	end
end
local function Register_UnitFrame()
	for name,list in pairs(UnitFrame) do
		if not extload[name] or extload[name] and extload[name]() then
			for _,UnitF in pairs(list) do
				Register_FocusFun(UnitF)
			end
		end
	end
	for name,list in pairs(RiadFrame) do
		if not extload[name] or extload[name] and extload[name]() then
			for _,UnitF in pairs(list) do
				local name,index1,index2,index3=UnitF[1],UnitF[2],UnitF[3],UnitF[4]
				if index1 and index2 and index3 then
					for ix=1,index1 do
						for ixx=1,index2 do
							for ixxx=1,index2 do
								Register_FocusFun(string.format(name,ix,ixx,ixxx))
							end
						end
					end
				elseif index1 and index2 then
					for ix=1,index1 do
						for ixx=1,index2 do
							Register_FocusFun(string.format(name,ix,ixx))
						end
					end
				end
			end
		end
	end
end
local function Register_PartyFrame()
	for memberFrame in PartyFrame.PartyMemberFramePool:EnumerateActive() do
		Register_FocusFun(memberFrame)
	end
end
local function Register_MouseoverMode()
	if PIGA["Common"]["SetFocusMouse"] then 
		if not PIG_MouseoverFocuser then
			local MouseoverFocuser=CreateFrame("CheckButton", "PIG_MouseoverFocuser", UIParent, "SecureActionButtonTemplate")
			Fun.ActionFun.PIGUseKeyDown(MouseoverFocuser)
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
function CombatPlusfun.SetFocus()
	if not PIGA["Common"]["SetFocus"] then return end
	Register_MouseoverMode()
	Register_UnitFrame()
	hooksecurefunc("CompactRaidGroup_GenerateForGroup", function(groupIndex)
		Register_UnitFrame()
	end)
	if PartyFrame then
		Register_PartyFrame()
		hooksecurefunc(PartyFrame,"UpdatePartyFrames", function()
			Register_PartyFrame()
		end)
	end
end
--清除
local ClearFrameyanchiNUM={}
local function Register_ClearFocus(Frame)
	if _G[Frame] then
		if not InCombatLockdown() then
			local gonegnengKEY = PIGA["Common"]["SetFocusKEY"].."-type1"
			_G[Frame]:SetAttribute(gonegnengKEY,"macro")
			_G[Frame]:SetAttribute("macrotext","/clearfocus")
		end
	else
		ClearFrameyanchiNUM[Frame]=ClearFrameyanchiNUM[Frame] or 1
		if ClearFrameyanchiNUM[Frame]<10 then
			C_Timer.After(0.1,function()
				ClearFrameyanchiNUM[Frame]=ClearFrameyanchiNUM[Frame]+1
				Register_ClearFocus(Frame)
			end)
		end
	end
end
function CombatPlusfun.ClearFocus()
	if not PIGA["Common"]["ClearFocus"] then return end
	for name,list in pairs(FocusFrame) do
		if not extload[name] or extload[name] and extload[name]() then
			Register_ClearFocus(list)
		end
	end
end
----
function CombatPlusfun.FastFocus()
	if PIG_MaxTocversion(20000,true) then
		CombatPlusfun.SetFocus()
		CombatPlusfun.ClearFocus()
	end
end
function CombatPlusfun.addOptions_FastFocus()
	if PIG_MaxTocversion(20000,true) then
		CombatPlusfun.RTabFrame:HookScript("OnShow", function (self)
			if self.FastFocusF then return end
			local Create=PD.Create
			local PIGDownMenu=Create.PIGDownMenu
			local PIGCheckbutton=Create.PIGCheckbutton
			local PIGCheckbutton_R=Create.PIGCheckbutton_R
			local PIGOptionsList_R=Create.PIGOptionsList_R
			local FastFocusF =PIGOptionsList_R(CombatPlusfun.RTabFrame,BINDING_NAME_FOCUSTARGET,90)
			self.FastFocusF=FastFocusF
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
				self:PIGDownMenu_SetText(value)
				PIGA["Common"]["SetFocusKEY"]=arg1
				PIGCloseDropDownMenus()
				PIG_OptionsUI.RLUI:Show()
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
			FastFocusF.SetFocus:SetChecked(PIGA["Common"]["SetFocus"]);
			FastFocusF.SetFocus.xiala:PIGDownMenu_SetText(SetKeyListName[PIGA["Common"]["SetFocusKEY"]])
			FastFocusF.SetFocus.Mouse:SetChecked(PIGA["Common"]["SetFocusMouse"]);
			FastFocusF.ClearFocus:SetChecked(PIGA["Common"]["ClearFocus"]);
		end)
	end
end