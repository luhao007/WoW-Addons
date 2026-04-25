local addonName, PD = ...;
local L=PD.locale
---
local Create=PD.Create
local PIGLine=Create.PIGLine
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
--
local CommonInfo=PD.CommonInfo
------交互
local fujiF =PIGOptionsList_R(CommonInfo.NR,UNIT_FRAME_DROPDOWN_SUBSECTION_TITLE_INTERACT,70)
--自动对话
fujiF.AutoDialogue = PIGCheckbutton_R(fujiF,{L["INTERACT_DIALOGUE"],L["INTERACT_DIALOGUETISP"]})
fujiF.AutoDialogue:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoDialogue"]=true;			
	else
		PIGA["Interaction"]["AutoDialogue"]=false;
	end
	CommonInfo.Interaction_AutoDialogue()
end);
local setdhname = {[0]=NONE}
fujiF.AutoDialogue.max1=PIGDownMenu(fujiF.AutoDialogue,{"LEFT",fujiF.AutoDialogue,"RIGHT",160,0},{80,24})
fujiF.AutoDialogue.max1.T = PIGFontString(fujiF.AutoDialogue.max1,{"RIGHT",fujiF.AutoDialogue.max1,"LEFT",-4,0},L["INTERACT_DIALOGUEMULTI"])
function fujiF.AutoDialogue.max1:PIGDownMenu_Update_But()
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=0,9,1 do
	    info.text, info.arg1 = setdhname[i] or i, i
	    info.checked = i==PIGA["Interaction"]["AutoDialogueIndex"]
		self:PIGDownMenu_AddButton(info)
	end 
end
function fujiF.AutoDialogue.max1:PIGDownMenu_SetValue(value,arg1,arg2)
	self:PIGDownMenu_SetText(value)
	PIGA["Interaction"]["AutoDialogueIndex"]=arg1
	PIGCloseDropDownMenus()
end
--自动接任务
fujiF.AutoJierenwu = PIGCheckbutton_R(fujiF,{L["INTERACT_QUEST"],L["INTERACT_QUESTTISP"]})
fujiF.AutoJierenwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoJierenwu"]=true;
	else
		PIGA["Interaction"]["AutoJierenwu"]=false;
	end
	CommonInfo.Interaction_AutoDialogue()
end);
--自动交任务
fujiF.AutoJiaorenwu = PIGCheckbutton_R(fujiF,{L["INTERACT_QUESTEND"],L["INTERACT_QUESTENDTISP"]})
fujiF.AutoJiaorenwu:SetScript("OnClick", function ()
	if fujiF.AutoJiaorenwu:GetChecked() then
		PIGA["Interaction"]["AutoJiaorenwu"]=true;
	else
		PIGA["Interaction"]["AutoJiaorenwu"]=false;
	end
	CommonInfo.Interaction_AutoDialogue()
end);
--自动站立下马
fujiF.AutoDown = PIGCheckbutton_R(fujiF,{L["INTERACT_STAND"],L["INTERACT_STANDTISP"]})
fujiF.AutoDown:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoDown"]=true;			
	else
		PIGA["Interaction"]["AutoDown"]=false;
	end
	CommonInfo.Interaction_AutoDown()
end);

fujiF.zidongjieshouyaoqing = PIGCheckbutton_R(fujiF,{L["INTERACT_INVITE"]})
fujiF.zidongjieshouyaoqing:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoJyaoqing"]=true;
	else
		PIGA["Interaction"]["AutoJyaoqing"]=false;
	end
	CommonInfo.Interaction_YaoqingFuhuo()
end);
----
fujiF.zidongFuhuo = PIGCheckbutton_R(fujiF,{L["INTERACT_REQUEST"]})
fujiF.zidongFuhuo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoFuhuo"]=true;
	else
		PIGA["Interaction"]["AutoFuhuo"]=false;
	end
	CommonInfo.Interaction_YaoqingFuhuo()
end);
------
local AutoRepairline = PIGLine(fujiF,"TOP",-300)
fujiF.AutoRepair = PIGCheckbutton(fujiF,{"TOPLEFT",AutoRepairline,"TOPLEFT",20,-16},{L["INTERACT_AUTOREPAIR"],L["INTERACT_AUTOREPAIRTISP"]})
fujiF.AutoRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoRepair"]=true;
	else
		PIGA["Interaction"]["AutoRepair"]=false;
	end
end);
if PIG_MaxTocversion(20000,true) then
	fujiF.GonghuiRepair = PIGCheckbutton(fujiF,{"LEFT",fujiF.AutoRepair,"RIGHT",200,0},{L["INTERACT_AUTOREPAIRGUILD"]})
	fujiF.GonghuiRepair:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoRepair_GUILD"]=true;
		else
			PIGA["Interaction"]["AutoRepair_GUILD"]=false;
		end
	end);
end
---------------
local RightPlusline = PIGLine(fujiF,"TOP",-400)
fujiF.RightPlus = PIGCheckbutton(fujiF,{"TOPLEFT",RightPlusline,"TOPLEFT",20,-18},{L["INTERACT_RIGHTMENU"],L["INTERACT_RIGHTMENUERR"]})
fujiF.RightPlus:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Interaction"]["RightPlus"]=true;
        CommonInfo.Interaction_RightPlus()
        fujiF.xiayiSlider:SetValue(PIGA["Interaction"]["xiayijuli"]);
    else
        PIGA["Interaction"]["RightPlus"]=false;
        PIG_OptionsUI.RLUI:Show()
    end
end);
if not Menu or not Menu.ModifyMenu then
	fujiF.xiayiTxt = PIGFontString(fujiF,{"LEFT",fujiF.RightPlus.Text,"RIGHT",20,0},L["INTERACT_RIGHTMENUDOWN"])
	fujiF.xiayiSlider = PIGSlider(fujiF,{"LEFT",fujiF.xiayiTxt,"RIGHT",10,0},{0, 100, 1})
	function fujiF.xiayiSlider:PIGOnValueChange(arg1)
		PIGA["Interaction"]["xiayijuli"]=arg1
		if Pig_RightFUI then
			Pig_RightFUI:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",0,-arg1)
		end
	end
end
--
fujiF:HookScript("OnShow", function(self)
	self.AutoDialogue:SetChecked(PIGA["Interaction"]["AutoDialogue"]);
	local xmaxindex = setdhname[PIGA["Interaction"]["AutoDialogueIndex"]] or PIGA["Interaction"]["AutoDialogueIndex"]
	self.AutoDialogue.max1:PIGDownMenu_SetText(xmaxindex)
	self.AutoDown:SetChecked(PIGA['Interaction']['AutoDown']);
	self.AutoJierenwu:SetChecked(PIGA["Interaction"]["AutoJierenwu"]);
	self.AutoJiaorenwu:SetChecked(PIGA["Interaction"]["AutoJiaorenwu"]);
	self.zidongjieshouyaoqing:SetChecked(PIGA["Interaction"]["AutoJyaoqing"]);
	self.zidongFuhuo:SetChecked(PIGA["Interaction"]["AutoFuhuo"]);
	self.AutoRepair:SetChecked(PIGA["Interaction"]["AutoRepair"]);
	if self.GonghuiRepair then
		self.GonghuiRepair:SetChecked(PIGA["Interaction"]["AutoRepair_GUILD"]);
	end
	self.RightPlus:SetChecked(PIGA["Interaction"]["RightPlus"])
	if self.xiayiSlider then self.xiayiSlider:PIGSetValue(PIGA["Interaction"]["xiayijuli"]) end
end)