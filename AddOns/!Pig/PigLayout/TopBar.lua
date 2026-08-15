local _, addonTable = ...;
---
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGFontString=Create.PIGFontString
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
---
local PigLayoutFun=addonTable.PigLayoutFun
----
local function Update_TopBarXYUI()
	local topinfobar=PigLayoutFun.topinfobar
	local topOffset = GetUIParentOffset();
	UIParent:ClearAllPoints();
	topinfobar:ClearAllPoints();
	if PIGA["PigLayout"]["TopBar"]["AnchorPoint"]=="TOP" then
		UIParent:SetPoint("TOPLEFT", 0, -topOffset-PIGA["PigLayout"]["TopBar"]["Height"]-1);
		UIParent:SetPoint("BOTTOMRIGHT", 0, 0);
		topinfobar:SetPoint("BOTTOMLEFT",UIParent,"TOPLEFT", -1, 0);
		topinfobar:SetPoint("BOTTOMRIGHT", UIParent, "TOPRIGHT", 1, 0);
	else
		UIParent:SetPoint("TOPLEFT", 0, -topOffset);
		UIParent:SetPoint("BOTTOMRIGHT", 0, PIGA["PigLayout"]["TopBar"]["Height"]+1);
		topinfobar:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT", -1, 0);
		topinfobar:SetPoint("TOPRIGHT", UIParent, "BOTTOMRIGHT", 1, 0);
	end
	topinfobar:PIGSetBackdrop(PIGA["PigLayout"]["TopBar"]["Alpha"],PIGA["PigLayout"]["TopBar"]["Alpha"])
	topinfobar:SetHeight(PIGA["PigLayout"]["TopBar"]["Height"])
end
function PigLayoutFun.TopBarFun(set)
	if not PIGA["PigLayout"]["TopBar"]["Open"] then return end
	if PigLayoutFun.topinfobar then return end
	local topinfobar = PIGFrame(UIParent)
	topinfobar:SetFrameLevel(0)
	PigLayoutFun.topinfobar=topinfobar
	if set then Update_TopBarXYUI() end
	hooksecurefunc("UpdateUIParentPosition", function()
		Update_TopBarXYUI()
	end)
end
-----
function PigLayoutFun.addOptions_TopBar()
	local RTabFrame =PigLayoutFun.RTabFrame
	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,"扩展"..INFO.."栏",90)
	fujiF.Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-20},{ENABLE.."扩展"..INFO.."栏","在屏幕顶部或底部添加一个信息栏，且不影响现有元素布局"})
	fujiF.Open:SetScript("OnClick", function (self)
		if InCombatLockdown() then self:SetChecked(false) PIGErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
		if self:GetChecked() then
			PIGA["PigLayout"]["TopBar"]["Open"]=true;
			PigLayoutFun.TopBarFun(true)
		else
			PIGA["PigLayout"]["TopBar"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		fujiF.setF:SetShown(PIGA["PigLayout"]["TopBar"]["Open"])
	end);
	fujiF:SetScript("OnShow", function (self)
		fujiF.Open:SetChecked(PIGA["PigLayout"]["TopBar"]["Open"])
		if not fujiF.setF then
			fujiF.setF = PIGFrame(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 10, -50})
			fujiF.setF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", -10, 10);
			fujiF.setF:PIGSetBackdrop(0)
			local xyList = {"TOP","BOTTOM"}
			local xyListName = {["TOP"]="顶部",["BOTTOM"]="底部"}
			fujiF.setF.CZBUT = PIGButton(fujiF.setF,{"TOPRIGHT", fujiF.setF,"TOPRIGHT",-20,-20},{50,22},RESET)
			fujiF.setF.CZBUT:SetScript("OnClick", function ()
				PIGA["PigLayout"]["TopBar"]["AnchorPoint"]=addonTable.Default["PigLayout"]["TopBar"]["AnchorPoint"]
				PIGA["PigLayout"]["TopBar"]["Height"]=addonTable.Default["PigLayout"]["TopBar"]["Height"]
				PIGA["PigLayout"]["TopBar"]["Backdrop"]=addonTable.Default["PigLayout"]["TopBar"]["Backdrop"]
				PIGA["PigLayout"]["TopBar"]["Alpha"]=addonTable.Default["PigLayout"]["TopBar"]["Alpha"]
				Update_TopBarXYUI()
				fujiF.setF.Update_SetUI()
			end)
			fujiF.setF.AnchorPointT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -20},"定位锚点")
			fujiF.setF.AnchorPoint=PIGDownMenu(fujiF.setF,{"LEFT", fujiF.setF.AnchorPointT, "LEFT", 106, 0},{120,nil})
			function fujiF.setF.AnchorPoint:PIGDownMenu_Update_But()
				local info = {}
				info.func = self.PIGDownMenu_SetValue
				for i=1,#xyList do
				 	info.text, info.arg1 = xyListName[xyList[i]], xyList[i]
				 	info.checked = xyList[i] == PIGA["PigLayout"]["TopBar"]["AnchorPoint"]
					self:PIGDownMenu_AddButton(info)
				end 
			end
			function fujiF.setF.AnchorPoint:PIGDownMenu_SetValue(value,arg1)
				self:PIGDownMenu_SetText(value)
				PIGA["PigLayout"]["TopBar"]["AnchorPoint"]=arg1
				Update_TopBarXYUI()
				PIGCloseDropDownMenus()
			end
			fujiF.setF.HeightT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -60},"信息栏高度")
			fujiF.setF.Height = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.HeightT, "LEFT", 100, 0},{20, 60, 1})
			function fujiF.setF.Height:PIGOnValueChange(arg1)
				PIGA["PigLayout"]["TopBar"]["Height"]=arg1;
				Update_TopBarXYUI()
			end
			fujiF.setF.BackdropT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -100},"背景材质")
			fujiF.setF.Backdrop=PIGDownMenu(fujiF.setF,{"LEFT", fujiF.setF.BackdropT, "LEFT", 106, 0},{120,nil})
			function fujiF.setF.Backdrop:PIGDownMenu_Update_But()
				local info = {}
				info.func = self.PIGDownMenu_SetValue
				for i=1,4 do
				 	info.text, info.arg1 = "背景"..i, i
				 	info.checked = i == PIGA["PigLayout"]["TopBar"]["Backdrop"]
					self:PIGDownMenu_AddButton(info)
				end 
			end
			function fujiF.setF.Backdrop:PIGDownMenu_SetValue(value,arg1)
				self:PIGDownMenu_SetText(value)
				PIGA["PigLayout"]["TopBar"]["Backdrop"]=arg1
				Update_TopBarXYUI()
				PIGCloseDropDownMenus()
			end
			fujiF.setF.AlphaT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -140},"背景透明度")
			fujiF.setF.Alpha = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.AlphaT, "LEFT", 100, 0},{0, 1, 0.1})
			function fujiF.setF.Alpha:PIGOnValueChange(arg1)
				PIGA["PigLayout"]["TopBar"]["Alpha"]=arg1;
				Update_TopBarXYUI()
			end
			function fujiF.setF.Update_SetUI()
				fujiF.setF.AnchorPoint:PIGDownMenu_SetText(xyListName[PIGA["PigLayout"]["TopBar"]["AnchorPoint"]])
				fujiF.setF.Height:PIGSetValue(PIGA["PigLayout"]["TopBar"]["Height"])
				fujiF.setF.Backdrop:PIGDownMenu_SetText("背景"..PIGA["PigLayout"]["TopBar"]["Backdrop"])
				fujiF.setF.Alpha:PIGSetValue(PIGA["PigLayout"]["TopBar"]["Alpha"])
			end
			fujiF.setF.Update_SetUI()
		end
		fujiF.setF:SetShown(PIGA["PigLayout"]["TopBar"]["Open"])
	end)
end