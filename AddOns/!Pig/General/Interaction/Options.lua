local addonName, PD = ...;
local GeneralFun=PD.GeneralFun
--交互
function GeneralFun.addOptions_Interaction()
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
	---
	local fujiF =PIGOptionsList_R(GeneralFun.NR,UNIT_FRAME_DROPDOWN_SUBSECTION_TITLE_INTERACT,70)
	--自动对话
	fujiF.AutoDialogue = PIGCheckbutton_R(fujiF,{L["INTERACT_DIALOGUE"],L["INTERACT_DIALOGUETISP"]})
	fujiF.AutoDialogue:SetChecked(PIGA["Interaction"]["AutoDialogue"]);
	fujiF.AutoDialogue:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoDialogue"]=true;			
		else
			PIGA["Interaction"]["AutoDialogue"]=false;
		end
		GeneralFun.Interaction_AutoDialogue()
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
	local xmaxindex = setdhname[PIGA["Interaction"]["AutoDialogueIndex"]] or PIGA["Interaction"]["AutoDialogueIndex"]
	fujiF.AutoDialogue.max1:PIGDownMenu_SetText(xmaxindex)
	--自动接任务
	fujiF.AutoJierenwu = PIGCheckbutton_R(fujiF,{L["INTERACT_QUEST"],L["INTERACT_QUESTTISP"]})
	fujiF.AutoJierenwu:SetChecked(PIGA["Interaction"]["AutoJierenwu"]);
	fujiF.AutoJierenwu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoJierenwu"]=true;
		else
			PIGA["Interaction"]["AutoJierenwu"]=false;
		end
		GeneralFun.Interaction_AutoDialogue()
	end);
	--自动交任务
	fujiF.AutoJiaorenwu = PIGCheckbutton_R(fujiF,{L["INTERACT_QUESTEND"],L["INTERACT_QUESTENDTISP"]})
	fujiF.AutoJiaorenwu:SetChecked(PIGA["Interaction"]["AutoJiaorenwu"]);
	fujiF.AutoJiaorenwu:SetScript("OnClick", function ()
		if fujiF.AutoJiaorenwu:GetChecked() then
			PIGA["Interaction"]["AutoJiaorenwu"]=true;
		else
			PIGA["Interaction"]["AutoJiaorenwu"]=false;
		end
		GeneralFun.Interaction_AutoDialogue()
	end);

	--自动站立下马
	fujiF.AutoDown = PIGCheckbutton_R(fujiF,{L["INTERACT_STAND"],L["INTERACT_STANDTISP"]})
	fujiF.AutoDown:SetChecked(PIGA['Interaction']['AutoDown']);
	fujiF.AutoDown:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoDown"]=true;			
		else
			PIGA["Interaction"]["AutoDown"]=false;
		end
		GeneralFun.Interaction_AutoDown()
	end);

	fujiF.zidongjieshouyaoqing = PIGCheckbutton_R(fujiF,{L["INTERACT_INVITE"]})
	fujiF.zidongjieshouyaoqing:SetChecked(PIGA["Interaction"]["AutoJyaoqing"]);
	fujiF.zidongjieshouyaoqing:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoJyaoqing"]=true;
		else
			PIGA["Interaction"]["AutoJyaoqing"]=false;
		end
		GeneralFun.Interaction_YaoqingFuhuo()
	end);
	----
	fujiF.zidongFuhuo = PIGCheckbutton_R(fujiF,{L["INTERACT_REQUEST"]})
	fujiF.zidongFuhuo:SetChecked(PIGA["Interaction"]["AutoFuhuo"]);
	fujiF.zidongFuhuo:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoFuhuo"]=true;
		else
			PIGA["Interaction"]["AutoFuhuo"]=false;
		end
		GeneralFun.Interaction_YaoqingFuhuo()
	end);
	------
	local AutoRepairline = PIGLine(fujiF,"TOP",-300)
	fujiF.AutoRepair = PIGCheckbutton(fujiF,{"TOPLEFT",AutoRepairline,"TOPLEFT",20,-16},{L["INTERACT_AUTOREPAIR"],L["INTERACT_AUTOREPAIRTISP"]})
	fujiF.AutoRepair:SetChecked(PIGA["Interaction"]["AutoRepair"]);
	fujiF.AutoRepair:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Interaction"]["AutoRepair"]=true;
		else
			PIGA["Interaction"]["AutoRepair"]=false;
		end
	end);
	if PIG_MaxTocversion(20000,true) then
		fujiF.GonghuiRepair = PIGCheckbutton(fujiF,{"LEFT",fujiF.AutoRepair,"RIGHT",200,0},{L["INTERACT_AUTOREPAIRGUILD"]})
		fujiF.GonghuiRepair:SetChecked(PIGA["Interaction"]["AutoRepair_GUILD"]);
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
	fujiF.RightPlus:SetChecked(PIGA["Interaction"]["RightPlus"])
	fujiF.RightPlus:SetScript("OnClick", function (self)
	    if self:GetChecked() then
	        PIGA["Interaction"]["RightPlus"]=true;
	        GeneralFun.Interaction_RightPlus()
	    else
	        PIGA["Interaction"]["RightPlus"]=false;
	        PIG_OptionsUI.RLUI:Show()
	    end
	end);
	if not Menu or not Menu.ModifyMenu then
		fujiF.xiayiTxt = PIGFontString(fujiF,{"LEFT",fujiF.RightPlus.Text,"RIGHT",20,0},L["INTERACT_RIGHTMENUDOWN"])
		fujiF.xiayiSlider = PIGSlider(fujiF,{"LEFT",fujiF.xiayiTxt,"RIGHT",10,0},{0, 100, 1})
		fujiF.xiayiSlider:PIGSetValue(PIGA["Interaction"]["xiayijuli"])
		function fujiF.xiayiSlider:PIGOnValueChange(arg1)
			PIGA["Interaction"]["xiayijuli"]=arg1
			if GeneralFun.PigRightF then
				GeneralFun.PigRightF:SetPoint("TOPLEFT",DropDownList1,"TOPRIGHT",0,-arg1)
			end
		end
	end
end