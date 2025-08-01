local _, addonTable = ...;
---
local L=addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGFontString=Create.PIGFontString
local PIGSlider = Create.PIGSlider
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList_R=Create.PIGOptionsList_R
---
local PigLayoutFun=addonTable.PigLayoutFun
local RTabFrame =PigLayoutFun.RTabFrame
----
local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,"扩展"..INFO.."栏",90)
fujiF.Open = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-20},{ENABLE.."扩展"..INFO.."栏","在屏幕顶部或底部添加一个信息栏，且不影响现有元素布局"})
fujiF.Open:SetScript("OnClick", function (self)
	if InCombatLockdown() then self:SetChecked(false) PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
	if self:GetChecked() then
		PIGA["PigLayout"]["TopBar"]["Open"]=true;
		fujiF.setF:Show()
	else
		PIGA["PigLayout"]["TopBar"]["Open"]=false;
		PIG_OptionsUI.RLUI:Show()
	end
	PigLayoutFun.Options_TopBar()
end);
fujiF:HookScript("OnShow", function (self)
	self.Open:SetChecked(PIGA["PigLayout"]["TopBar"]["Open"])
	if PIGA["PigLayout"]["TopBar"]["Open"] then
		self.setF:Show()
	else
		self.setF:Hide()
	end
end);
fujiF.setF = PIGFrame(fujiF,{"TOPLEFT", fujiF, "TOPLEFT", 10, -50})
fujiF.setF:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", -10, 10);
fujiF.setF:PIGSetBackdrop(0)
fujiF.setF.AnchorPointT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -20},"定位锚点")
fujiF.setF.AnchorPoint=PIGDownMenu(fujiF.setF,{"LEFT", fujiF.setF.AnchorPointT, "LEFT", 106, 0},{120,nil})
local xyList = {"TOP","BOTTOM"}
local xyListName = {["TOP"]="顶部",["BOTTOM"]="底部"}
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
	fujiF.Update_XYUI()
	PIGCloseDropDownMenus()
end
fujiF.setF.HeightT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -60},"信息栏高度")
fujiF.setF.Height = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.HeightT, "LEFT", 100, 0},{20, 60, 1})
fujiF.setF.Height.Slider:HookScript("OnValueChanged", function(self, arg1)
	PIGA["PigLayout"]["TopBar"]["Height"]=arg1;
	fujiF.Update_XYUI()
end)
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
	fujiF.Update_XYUI()
	PIGCloseDropDownMenus()
end
fujiF.setF.AlphaT = PIGFontString(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -140},"背景透明度")
fujiF.setF.Alpha = PIGSlider(fujiF.setF,{"LEFT", fujiF.setF.AlphaT, "LEFT", 100, 0},{0, 1, 0.1})
fujiF.setF.Alpha.Slider:HookScript("OnValueChanged", function(self, arg1)
	PIGA["PigLayout"]["TopBar"]["Alpha"]=arg1;
	fujiF.Update_XYUI()
end)
--
fujiF.setF:HookScript("OnShow", function(self)
	self.AnchorPoint:PIGDownMenu_SetText(xyListName[PIGA["PigLayout"]["TopBar"]["AnchorPoint"]])
	self.Height:PIGSetValue(PIGA["PigLayout"]["TopBar"]["Height"])
	self.Backdrop:PIGDownMenu_SetText("背景"..PIGA["PigLayout"]["TopBar"]["Backdrop"])
	self.Alpha:PIGSetValue(PIGA["PigLayout"]["TopBar"]["Alpha"])
end)
-----
PigLayoutFun.JGUIlist={}
function PigLayoutFun.Options_TopBar()
	if not PIGA["PigLayout"]["TopBar"]["Open"] then return end
	if fujiF.TopBarOpen then return end
	fujiF.TopBarOpen=true
	
	local topinfobar = PIGFrame(UIParent)
	topinfobar:SetFrameLevel(0)
	function fujiF.Update_XYUI()
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
	fujiF.Update_XYUI()
	hooksecurefunc("UpdateUIParentPosition", function()
		fujiF.Update_XYUI()
	end)
	--接管
	local function Update_UIPoint(name)
		local pigui=_G[name]
		if pigui then
			PIGA["Pig_UI"][name]=nil
			local uidata=PIGA["PigLayout"]["TopBar"]["JG"][name]
			if pigui.yidong then pigui.yidong:ClearAllPoints() end
			pigui:SetParent(topinfobar)
			pigui:SetClampedToScreen(false)
			pigui:ClearAllPoints()
			pigui.zengjialiang=0
			if pigui.banW then
				if uidata[1]=="BOTTOM" then
					pigui.zengjialiang=pigui.banW
				elseif uidata[1]=="BOTTOMRIGHT" then
					pigui.zengjialiang=pigui.banW*2
				end
			end
			pigui:SetPoint(uidata[1],topinfobar,uidata[1],uidata[2]+pigui.zengjialiang,0.8)
		end
	end
	local function add_Checkbut()
		for i=1,#PigLayoutFun.JGUIlist do
			PIGA["PigLayout"]["TopBar"]["JG"]=PIGA["PigLayout"]["TopBar"]["JG"] or {}
			local gndata = PigLayoutFun.JGUIlist[i]
			local gnname = gndata[1]
			local CfV =PIGA["PigLayout"]["TopBar"]["JG"]
			local WowWidth2=GetScreenWidth()
			local ModeList={{"BOTTOMLEFT","左"},{"BOTTOM","中"},{"BOTTOMRIGHT","右"}}
			local ModeListData={
				["BOTTOMLEFT"]={"左",{0, WowWidth2}},
				["BOTTOM"]={"中",{-WowWidth2*0.5, WowWidth2*0.5}},
				["BOTTOMRIGHT"]={"右",{-WowWidth2, 0}},
			}
			local ckbutMenu = PIGCheckbutton(fujiF.setF,{"TOPLEFT", fujiF.setF, "TOPLEFT", 20, -180-40*i},{"接管:"..gndata[2]})
			ckbutMenu:HookScript("OnClick", function (self)
				if InCombatLockdown() then self:SetChecked(false) PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT,"R") return end
				if self:GetChecked() then
					CfV[gnname]={"BOTTOMLEFT",0}
					Update_UIPoint(gndata[1])
				else
					CfV[gnname]=nil
					PIG_OptionsUI.RLUI:Show()
				end
				self:Update_Checkbut(gndata[1])
			end);
			ckbutMenu.PointModeT = PIGFontString(ckbutMenu,{"LEFT", ckbutMenu, "RIGHT", 180, 0},"锚点")
			ckbutMenu.PointMode=PIGDownMenu(ckbutMenu,{"LEFT", ckbutMenu.PointModeT, "RIGHT", 2, 0},{60,nil})
			function ckbutMenu.PointMode:PIGDownMenu_Update_But()
				local info = {}
				info.func = self.PIGDownMenu_SetValue
				for ix=1,#ModeList do
				 	info.text, info.arg1 = ModeList[ix][2], ModeList[ix][1]
				 	local saveV=CfV[gnname] and CfV[gnname][1]
				 	info.checked = ModeList[ix][1] == saveV
					self:PIGDownMenu_AddButton(info)
				end 
			end
			function ckbutMenu.PointMode:PIGDownMenu_SetValue(value,arg1)
				self:PIGDownMenu_SetText(value)
				CfV[gnname][1]=arg1
				CfV[gnname][2]=0
				ckbutMenu.OffsetV.Slider:SetMinMaxValues(ModeListData[CfV[gnname][1]][2][1],ModeListData[CfV[gnname][1]][2][2]);
				ckbutMenu.OffsetV:PIGSetValue(0)
				Update_UIPoint(gndata[1])
				PIGCloseDropDownMenus()
			end
			ckbutMenu.OffsetVT = PIGFontString(ckbutMenu,{"LEFT", ckbutMenu.PointMode, "RIGHT", 10, 0},"偏移")
			local minvvv = CfV[gnname] and ModeListData[CfV[gnname][1]][2][1] or -200
			local maxvvv = CfV[gnname] and ModeListData[CfV[gnname][1]][2][2] or 200
			ckbutMenu.OffsetV = PIGSlider(ckbutMenu,{"LEFT", ckbutMenu.OffsetVT, "RIGHT", 0, 0},{minvvv,maxvvv,1},200)
			ckbutMenu.OffsetV.Slider:HookScript("OnValueChanged", function(self, arg1)
				CfV[gnname][2]=arg1;
				Update_UIPoint(gndata[1])
			end)
			function ckbutMenu:Update_Checkbut()
				if CfV[gnname] then
					self.PointModeT:Show()
					self.PointMode:Show()
					self.OffsetVT:Show()
					self.OffsetV:Show()
					self.PointMode:PIGDownMenu_SetText(ModeListData[CfV[gnname][1]][1])
					self.OffsetV:PIGSetValue(CfV[gnname][2])
				else
					self.PointModeT:Hide()
					self.PointMode:Hide()
					self.OffsetVT:Hide()
					self.OffsetV:Hide()
				end
			end
			ckbutMenu:HookScript("OnShow", function (self)
				if CfV[gnname] then
					self:SetChecked(true)
				else
					self:SetChecked(false)
				end
				self:Update_Checkbut(gnname)
			end);
		end
	end
	add_Checkbut()
	for k,v in pairs(PigLayoutFun.JGUIlist) do
		if PIGA["PigLayout"]["TopBar"]["JG"] and PIGA["PigLayout"]["TopBar"]["JG"][v[1]] then
			Update_UIPoint(v[1])
		end
	end
end