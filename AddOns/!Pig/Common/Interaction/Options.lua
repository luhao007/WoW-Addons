local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create=addonTable.Create
local PIGLine=Create.PIGLine
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
--
local CommonInfo=addonTable.CommonInfo
CommonInfo.Interactionfun={}
------交互
local fujiF =PIGOptionsList_R(CommonInfo.NR,L["COMMON_TABNAME2"],70)
--自动对话
fujiF.AutoDialogue = PIGCheckbutton_R(fujiF,{"自动对话","当NPC只有一个对话选项时自动激活选项，按住Shift停止自动对话\n对话大于1个请在后面下拉菜单设置"})
fujiF.AutoDialogue:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoDialogue"]=true;			
	else
		PIGA["Interaction"]["AutoDialogue"]=false;
	end
	CommonInfo.Interactionfun.zidongduihua()
end);
local setdhname = {[0]=NONE}
fujiF.AutoDialogue.max1=PIGDownMenu(fujiF.AutoDialogue,{"LEFT",fujiF.AutoDialogue,"RIGHT",160,0},{60,24})
fujiF.AutoDialogue.max1.T = PIGFontString(fujiF.AutoDialogue.max1,{"RIGHT",fujiF.AutoDialogue.max1,"LEFT",-4,0},"多对话选择")
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
--自动站立下马
fujiF.AutoDown = PIGCheckbutton_R(fujiF,{"自动下马/站立","与NPC或物体交互时自动下马/站立"})
fujiF.AutoDown:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoDown"]=true;			
	else
		PIGA["Interaction"]["AutoDown"]=false;
	end
	CommonInfo.Interactionfun.AutoDown()
end);
--自动接任务
fujiF.AutoJierenwu = PIGCheckbutton_R(fujiF,{"自动接任务","和NPC对话时自动接任务，按住Shift停止自动接任务"})
fujiF.AutoJierenwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoJierenwu"]=true;
	else
		PIGA["Interaction"]["AutoJierenwu"]=false;
	end
	CommonInfo.Interactionfun.zidongduihua()
end);
--自动交任务
fujiF.AutoJiaorenwu = PIGCheckbutton_R(fujiF,{"自动交任务","和NPC对话时自动交任务，按住Shift停止自动交任务"})
fujiF.AutoJiaorenwu:SetScript("OnClick", function ()
	if fujiF.AutoJiaorenwu:GetChecked() then
		PIGA["Interaction"]["AutoJiaorenwu"]=true;
	else
		PIGA["Interaction"]["AutoJiaorenwu"]=false;
	end
	CommonInfo.Interactionfun.zidongduihua()
end);
fujiF.zidongjieshouyaoqing = PIGCheckbutton_R(fujiF,{"自动接受组队邀请","自动接受组队邀请"})
fujiF.zidongjieshouyaoqing:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoJyaoqing"]=true;
	else
		PIGA["Interaction"]["AutoJyaoqing"]=false;
	end
	CommonInfo.Interactionfun.YaoqingFuhuo()
end);
----
fujiF.zidongFuhuo = PIGCheckbutton_R(fujiF,{"自动接受复活","自动接受复活"})
fujiF.zidongFuhuo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoFuhuo"]=true;
	else
		PIGA["Interaction"]["AutoFuhuo"]=false;
	end
	CommonInfo.Interactionfun.YaoqingFuhuo()
end);
------
local AutoRepairline = PIGLine(fujiF,"TOP",-300)
fujiF.AutoRepair = PIGCheckbutton(fujiF,{"TOPLEFT",AutoRepairline,"TOPLEFT",20,-16},{"自动修理", "与修理商人对话时自动修理身上和背包物品"})
fujiF.AutoRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["Interaction"]["AutoRepair"]=true;
	else
		PIGA["Interaction"]["AutoRepair"]=false;
	end
end);
if PIG_MaxTocversion(20000,true) then
	fujiF.GonghuiRepair = PIGCheckbutton(fujiF,{"LEFT",fujiF.AutoRepair,"RIGHT",200,0},{"优先使用公会资金", "修理时优先使用公会资金"})
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
fujiF.RightPlus = PIGCheckbutton(fujiF,{"TOPLEFT",RightPlusline,"TOPLEFT",20,-18},{KEY_BUTTON2.."增强","增强交互时"..KEY_BUTTON2.."功能，例如点击聊天栏玩家名/查询页玩家名\n注意不要用此功能复制的姓名作为/tar目标"})
fujiF.RightPlus:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIGA["Interaction"]["RightPlus"]=true;
        CommonInfo.Interactionfun.RightPlus()
        fujiF.xiayiSlider:SetValue(PIGA["Interaction"]["xiayijuli"]);
    else
        PIGA["Interaction"]["RightPlus"]=false;
        PIG_OptionsUI.RLUI:Show()
    end
end);
if not Menu or not Menu.ModifyMenu then
	fujiF.xiayiTxt = PIGFontString(fujiF,{"LEFT",fujiF.RightPlus.Text,"RIGHT",20,0},"下移增强菜单")
	fujiF.xiayiSlider = PIGSlider(fujiF,{"LEFT",fujiF.xiayiTxt,"RIGHT",10,0},{0, 100, 1})
	fujiF.xiayiSlider.Slider:HookScript("OnValueChanged", function(self, arg1)
		PIGA["Interaction"]["xiayijuli"]=arg1
		if Pig_RightFUI then
			Pig_RightFUI:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",0,-arg1)
		end
	end)
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