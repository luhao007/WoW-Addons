local addonName, PD = ...;
local PigLayoutFun=PD.PigLayoutFun
function PigLayoutFun.addOptions_General()
	local L=PD.locale
	local Data=PD.Data
	local Create=PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGDownMenu=Create.PIGDownMenu
	local PIGFontString=Create.PIGFontString
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local RTabFrame =PigLayoutFun.RTabFrame
	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,GENERAL,70)
	fujiF:Show()
	fujiBut:Selected(true)
	fujiF:HookScript("OnShow", function (self)
		if fujiF.FontMiaobianT then return end
		fujiF.FontMiaobianT = PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-80},"PIG桌面元素字体");
		local MiaobianList={"NORMAL","OUTLINE","THICKOUTLINE","MONOCHROME","MONOCHROMEOUTLINE"}
		fujiF.FontMiaobian=PIGDownMenu(fujiF,{"TOPLEFT",fujiF.FontMiaobianT,"BOTTOMLEFT",0,-10},{210})
		function fujiF.FontMiaobian:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#MiaobianList,1 do
			    info.text, info.arg1 = MiaobianList[i], MiaobianList[i]
			    info.checked = MiaobianList[i]==PIGA["PigLayout"]["FontMiaobian"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function fujiF.FontMiaobian:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["PigLayout"]["FontMiaobian"]=value
			PIGCloseDropDownMenus()
			PIG_OptionsUI.RLUI:Show()
		end
		fujiF.FontMiaobian:PIGDownMenu_SetText(PIGA["PigLayout"]["FontMiaobian"])

		fujiF.UILayoutT = PIGFontString(fujiF,{"TOPLEFT",fujiF.FontMiaobianT,"BOTTOMLEFT",0,-80},"PIG桌面元素位置和缩放");
		fujiF.UILayout=PIGDownMenu(fujiF,{"TOPLEFT",fujiF.UILayoutT,"BOTTOMLEFT",0,-10},{210})
		function fujiF.UILayout:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for name,data in pairs(Data.UILayout) do
				info.text, info.arg1 = name, data
				self:PIGDownMenu_AddButton(info)
			end
		end
		function fujiF.UILayout:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			fujiF.SetUIname=value
			fujiF.Update_XYCZ()
			PIGCloseDropDownMenus()
		end
		fujiF.UILayout:PIGDownMenu_SetText("选择要调整的UI")

		fujiF.CZ = PIGButton(fujiF,{"LEFT",fujiF.UILayout,"RIGHT",10,0},{100,24},"重置所有")
		fujiF.CZ:SetScript("OnClick", function ()
			PIGA["Pig_UI"]={}
			PIGA_Per["Pig_UI"]={}
			Create.PIG_ResPoint()
			PIGprint("已重置所有PIG桌面元素位置和缩放")
		end);
		function fujiF.Update_XYCZ()
			if not fujiF.F then
				fujiF.F = PIGFrame(fujiF,{"TOPLEFT",fujiF.UILayout,"BOTTOMLEFT",0,-6},{240,120})
				fujiF.F:Hide()
				fujiF.F:PIGSetBackdrop()
				fujiF.F.PointCCT = PIGButton(fujiF.F,{"CENTER",fujiF.F,"CENTER",0,0},{40,30},"重置")
				fujiF.F.PointCCT:SetScript("OnClick", function ()
					Create.PIG_ResPoint(fujiF.SetUIname)
				end)
				fujiF.F.PointXL = PIGButton(fujiF.F,{"RIGHT",fujiF.F.PointCCT,"LEFT",-20,0},{70,30},"←微调")
				fujiF.F.PointXL:SetScript("OnClick", function ()
					if not PIGA["Pig_UI"][fujiF.SetUIname] then
						PIGA["Pig_UI"][fujiF.SetUIname]=CopyTable(Data.UILayout[fujiF.SetUIname])
					end
					PIGA["Pig_UI"][fujiF.SetUIname][3]=PIGA["Pig_UI"][fujiF.SetUIname][3]-1
					Create.PIG_SetPoint(fujiF.SetUIname)
				end)
				fujiF.F.PointXR = PIGButton(fujiF.F,{"LEFT",fujiF.F.PointCCT,"RIGHT",20,0},{70,30},"→微调")
				fujiF.F.PointXR:SetScript("OnClick", function ()
					if not PIGA["Pig_UI"][fujiF.SetUIname] then
						PIGA["Pig_UI"][fujiF.SetUIname]=CopyTable(Data.UILayout[fujiF.SetUIname])
					end
					PIGA["Pig_UI"][fujiF.SetUIname][3]=PIGA["Pig_UI"][fujiF.SetUIname][3]+1
					Create.PIG_SetPoint(fujiF.SetUIname)
				end)
				fujiF.F.PointXT = PIGButton(fujiF.F,{"BOTTOM",fujiF.F.PointCCT,"TOP",0,10},{70,30},"↑微调")
				fujiF.F.PointXT:SetScript("OnClick", function ()
					if not PIGA["Pig_UI"][fujiF.SetUIname] then
						PIGA["Pig_UI"][fujiF.SetUIname]=CopyTable(Data.UILayout[fujiF.SetUIname])
					end
					PIGA["Pig_UI"][fujiF.SetUIname][4]=PIGA["Pig_UI"][fujiF.SetUIname][4]+1
					Create.PIG_SetPoint(fujiF.SetUIname)
				end)
				fujiF.F.PointXB = PIGButton(fujiF.F,{"TOP",fujiF.F.PointCCT,"BOTTOM",0,-10},{70,30},"↓微调")
				fujiF.F.PointXB:SetScript("OnClick", function ()
					if not PIGA["Pig_UI"][fujiF.SetUIname] then
						PIGA["Pig_UI"][fujiF.SetUIname]=CopyTable(Data.UILayout[fujiF.SetUIname])
					end
					PIGA["Pig_UI"][fujiF.SetUIname][4]=PIGA["Pig_UI"][fujiF.SetUIname][4]-1
					Create.PIG_SetPoint(fujiF.SetUIname)
				end)
			end
			fujiF.F:SetShown(fujiF.SetUIname)
		end
	end);
end