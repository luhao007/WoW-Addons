local addonName, PD = ...;
local L=PD.locale
local Create=PD.Create
---
local Mapfun={}
PD.Mapfun=Mapfun
--
PD.Map = function()
	Mapfun.Minimap_Hide()
	Mapfun.Minimap_XY()
	Mapfun.Minimap_Move()
	Mapfun.WorldMap_XY()
	if PIG_MaxTocversion() then
		Mapfun.WorldMap_Wind()
		Mapfun.WorldMap_LVSkill()
		Mapfun.WorldMap_Miwu()
	end
end
function PD.addOptions_Map()
	local Fun=PD.Fun
	---
	local PIGFrame=Create.PIGFrame
	local PIGEnter=Create.PIGEnter
	local PIGButton = Create.PIGButton
	local PIGDownMenu=Create.PIGDownMenu
	local PIGSlider = Create.PIGSlider
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGFontString=Create.PIGFontString
	local PIGFontStringBG=Create.PIGFontStringBG
	local PIGTabBut=Create.PIGTabBut
	local PIGDiyTex=Create.PIGDiyTex
	-----
	local fuFrame = Create.PIGOptionsList(L["MAP_TABNAME"],"TOP")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	local GeneralF,Generaltabbut =PIGOptionsList_R(RTabFrame,GENERAL,70)
	GeneralF:Show()
	Generaltabbut:Selected(true)
	GeneralF:HookScript("OnShow", function (self)
		if GeneralF.Minimap_but then return end
		GeneralF.Minimap_but = PIGCheckbutton_R(GeneralF,{L["MAP_NIMIBUT"],L["MAP_NIMIBUTTIPS"]},true)
		GeneralF.Minimap_but.eror = PIGFontString(GeneralF.Minimap_but,{"LEFT",GeneralF.Minimap_but.Text,"RIGHT",0,0})
		GeneralF.Minimap_but.eror:SetTextColor(1, 0, 0, 1);
		GeneralF.Minimap_but:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Map"]["MinimapBut"]=true;
				PD.MiniMapBut_Add()
			else
				PIGA["Map"]["MinimapBut"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			GeneralF:Update_SetUI()
		end)
		--按钮位置
		local mapPointList = {"附着于小地图","附着于聊天框","自由模式(可随意拖动)"};
		GeneralF.Minimap_but_Point=PIGDownMenu(GeneralF,{"LEFT",GeneralF.Minimap_but.Text,"RIGHT",20,0},{250})
		function GeneralF.Minimap_but_Point:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#mapPointList,1 do
			    info.text, info.arg1 = mapPointList[i], i
			    info.checked = i==PIGA["Map"]["MinimapPointMode"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function GeneralF.Minimap_but_Point:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["Map"]["MinimapPointMode"]=arg1
			GeneralF:Update_SetUI()
			Mapfun.UpdateMiniButPoint()
			PIGCloseDropDownMenus()
		end
		GeneralF.CZinfo = PIGButton(GeneralF,{"LEFT",GeneralF.Minimap_but_Point,"RIGHT",10,0},{80,22},RESET_POSITION)
		GeneralF.CZinfo:SetScript("OnClick", function()
			Mapfun.MiniMapBut:CZMinimapInfo()
		end);
		GeneralF.EntertispBox = PIGCheckbutton(GeneralF,{"TOPLEFT",GeneralF,"TOPLEFT",420,-62},{"悬浮提示收纳框"})
		GeneralF.EntertispBox:SetScript("OnClick", function (self)
			PIGA["Map"]["EntertispBox"]=self:GetChecked()
			Mapfun.EntertispBox=PIGA["Map"]["EntertispBox"]
		end)
		-----------
		local function clickFun(id)
			PIGA["Map"]["MiniButShouNa_YN"]=id
			GeneralF:Update_SetUI()
			Mapfun.UpdateMiniButPoint()
			Mapfun.UpdateCollectBut()
		end
		local datax={
			[1]={
				tisp={L["MAP_NIMIBUT_SN"],L["MAP_NIMIBUT_SNTIPS"]},
				click=function(id)
					clickFun(id)
				end,
			},
			[2]={
				tisp={L["MAP_NIMIBUT_BS"],L["MAP_NIMIBUT_BSTIPS"]},
				click=function(id)
					clickFun(id)
				end,
			},
		}
		GeneralF.shoutab={}
		Create.PIGCheckSingle(GeneralF,GeneralF.shoutab,datax,{"TOPLEFT",GeneralF,"TOPLEFT",20,-60})
		--=======================================
		GeneralF.MinimapButF = PIGFrame(GeneralF)
		GeneralF.MinimapButF:PIGSetBackdrop()
		GeneralF.MinimapButF:SetPoint("TOPLEFT", GeneralF, "TOPLEFT", 6, -120)
		GeneralF.MinimapButF:SetPoint("BOTTOMRIGHT", GeneralF, "BOTTOMRIGHT", -6, 6)
		GeneralF.MinimapButF.biaoti=PIGFontString(GeneralF.MinimapButF,{"BOTTOMLEFT",GeneralF.MinimapButF,"TOPLEFT",10,10},L["MAP_NIMIBUT_NOSN"])
		GeneralF.MinimapButF.biaoti:SetTextColor(0.7, 1, 0, 1);
		--收纳小地图按钮每行数目
		GeneralF.MinimapButF.SN_meihangNumT = PIGFontString(GeneralF.MinimapButF,{"LEFT",GeneralF.MinimapButF.biaoti,"RIGHT",20,0},L["MAP_NIMIBUT_HANGNUM"])
		GeneralF.MinimapButF.SN_meihangNum = PIGSlider(GeneralF.MinimapButF,{"LEFT", GeneralF.MinimapButF.SN_meihangNumT,"RIGHT",4,0}, {1,10,1})	
		function GeneralF.MinimapButF.SN_meihangNum:PIGOnValueChange(arg1)
			PIGA["Map"]["MiniButShouNa_hang"]=arg1
			Mapfun.UpdateCollectBut()
		end
		GeneralF.MinimapButF.butlist={}
		local butWWHH,hang_NUM  = 25, 18;
		local function UpdatePaichuButLsit()
			if not GeneralF.MinimapButF:IsShown() then return end
			for _,butx in pairs(GeneralF.MinimapButF.butlist) do
				butx:Hide()
				PIGEnter(butx,"")
			end
			for i=1,#Mapfun.MiniBoxList do
				if not GeneralF.MinimapButF.butlist[i] then
					local but = CreateFrame("Button", nil, GeneralF.MinimapButF);
					GeneralF.MinimapButF.butlist[i]=but
					if i==1 then
						but:SetPoint("TOPLEFT",GeneralF.MinimapButF, "TOPLEFT", 8, -8)
					else
						local tmp1,tmp2 = math.modf((i-1)/hang_NUM)
						if tmp2==0 then
							but:SetPoint("TOPLEFT",GeneralF.MinimapButF.butlist[i-hang_NUM], "BOTTOMLEFT", 0, -8)
						else
							but:SetPoint("LEFT",GeneralF.MinimapButF.butlist[i-1], "RIGHT", 8, 0)
						end
					end
					but:SetSize(butWWHH, butWWHH);
					but:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
					but:SetNormalTexture(132311)
					but:RegisterForClicks("LeftButtonUp","RightButtonUp")
					but.Down = but:CreateTexture(nil, "OVERLAY");
					but.Down:SetTexture(130839);
					but.Down:SetAllPoints(but)
					but.Down:Hide();
					but:SetScript("OnMouseDown", function (self)
						self.Down:Show();
					end);
					but:SetScript("OnMouseUp", function (self)
						self.Down:Hide();
					end);
					but.x=PIGDiyTex(but,{"BOTTOMRIGHT",but, "BOTTOMRIGHT", 0, 0},{16})
					but.x:SetAlpha(0.9)
					but:SetScript("OnClick", function (self)
						local datax = PIGA["Map"]["MinimapBpaichu"]
						for ix=#datax,1,-1 do
							if datax[ix]==self.uiname then
								table.remove(datax,ix)
								UpdatePaichuButLsit()
								Mapfun.UpdateCollectBut(true)
								return
							end
						end
						table.insert(datax,self.uiname)
						UpdatePaichuButLsit()
						Mapfun.UpdateCollectBut(true)
					end);
				end
				local butuiname=unpack(Mapfun.MiniBoxList[i])
				local butx = GeneralF.MinimapButF.butlist[i]
				butx:Show()
				butx.uiname=butuiname
				local iconx = _G[butuiname] and _G[butuiname].icon and _G[butuiname].icon:GetTexture() or _G[butuiname] and _G[butuiname].Icon and _G[butuiname].Icon:GetTexture() or 134400
				butx:SetNormalTexture(iconx)
				PIGEnter(butx,butx.uiname)
				if Mapfun.IsNoDIYExclude(butx.uiname) then
					butx.x:Show()
				else
					butx.x:Hide()
				end
			end
		end
		----
		function GeneralF:Update_SetUI()
			self.Minimap_but:SetChecked(PIGA["Map"]["MinimapBut"])
			self.EntertispBox:SetChecked(PIGA["Map"]["EntertispBox"])
			self.Minimap_but_Point:SetShown(PIGA["Map"]["MinimapBut"])
			self.Minimap_but_Point:PIGDownMenu_SetText(mapPointList[PIGA["Map"]["MinimapPointMode"]])
			self.CZinfo:SetShown(PIGA["Map"]["MinimapBut"] and PIGA["Map"]["MinimapPointMode"]==3)
			for i=1,#GeneralF.shoutab do
				GeneralF.shoutab[i]:SetShown(PIGA["Map"]["MinimapBut"])
				GeneralF.shoutab[i]:SetChecked(PIGA["Map"]["MiniButShouNa_YN"]==i)
			end
			self.MinimapButF:SetShown(PIGA["Map"]["MinimapBut"] and PIGA["Map"]["MiniButShouNa_YN"]==1)
			self.MinimapButF.SN_meihangNum:PIGSetValue(PIGA["Map"]["MiniButShouNa_hang"])
			UpdatePaichuButLsit();
		end
		GeneralF:Update_SetUI()
	end);

	---minimap
	local MiniMapF,MiniMaptabbut =PIGOptionsList_R(RTabFrame,L["MAP_TABNAME1"],70)
	MiniMapF:HookScript("OnShow", function (self)
		if MiniMapF.MinimapXY then return end
		MiniMapF.MinimapXY = PIGCheckbutton_R(MiniMapF,{L["MAP_WORDXY"],L["MAP_WORDXYTIPS"]},true)
		MiniMapF.MinimapXY:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Map"]["MinimapXY"]=true;
			else
				PIGA["Map"]["MinimapXY"]=false;
			end
			Mapfun.Minimap_XY()
		end);
		MiniMapF.MinimapHide = PIGCheckbutton_R(MiniMapF,{HIDE..MINIMAP_LABEL},true)
		MiniMapF.MinimapHide:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Map"]["MinimapHide"]=true;
			else
				PIGA["Map"]["MinimapHide"]=false;
			end
			PIG_OptionsUI.RLUI:Show()
		end);
		MiniMapF.MinimapXY:SetChecked(PIGA["Map"]["MinimapXY"])
		MiniMapF.MinimapHide:SetChecked(PIGA["Map"]["MinimapHide"])

		MiniMapF.MinimapMove = PIGCheckbutton_R(MiniMapF,{NPE_MOVE..MINIMAP_LABEL},true)
		MiniMapF.MinimapMove:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Map"]["MinimapMove"]=true;
				Mapfun.Minimap_Move()
			else
				PIGA["Map"]["MinimapMove"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
			MiniMapF:Update_SetUI()
		end);
		MiniMapF.MinimapMove:SetChecked(PIGA["Map"]["MinimapMove"])

		MiniMapF.SetF = PIGFrame(MiniMapF,{"TOPLEFT", MiniMapF.MinimapMove, "BOTTOMLEFT", 20, -16},{10,10})
		MiniMapF.SetF.AnchorPointT = PIGFontString(MiniMapF.SetF,{"TOPLEFT", MiniMapF.SetF, "TOPLEFT", 0, 0},"定位锚点")
		MiniMapF.SetF.AnchorPoint=PIGDownMenu(MiniMapF.SetF,{"LEFT", MiniMapF.SetF.AnchorPointT, "RIGHT", 4, 0},{120,nil})
		local xyList = {"TOP","BOTTOM","TOPLEFT","TOPRIGHT","BOTTOMLEFT","BOTTOMRIGHT"}
		local xyListName = {["TOP"]="顶部",["BOTTOM"]="底部",["TOPLEFT"]="左上角",["TOPRIGHT"]="右上角",["BOTTOMLEFT"]="左下角",["BOTTOMRIGHT"]="右下角"}
		function MiniMapF.SetF.AnchorPoint:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#xyList do
			 	info.text, info.arg1 = xyListName[xyList[i]], xyList[i]
			 	info.checked = xyList[i] == PIGA["Map"]["MinimapAnchor"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function MiniMapF.SetF.AnchorPoint:PIGDownMenu_SetValue(value,arg1)
			self:PIGDownMenu_SetText(value)
			PIGA["Map"]["MinimapAnchor"]=arg1
			PIGA["Map"]["MinimapPointX"]=0
			PIGA["Map"]["MinimapPointY"]=0
			MiniMapF:Update_SetUI()
			Mapfun.Minimap_MoveUpdate()
			PIGCloseDropDownMenus()
		end
		MiniMapF.SetF.AnchorPointX = PIGSlider(MiniMapF.SetF,{"TOPLEFT", MiniMapF.SetF.AnchorPointT, "BOTTOMLEFT", 0, -22},{-1000, 1000, 1,{["Right"]="X坐标%d"}},400)
		function MiniMapF.SetF.AnchorPointX:PIGOnValueChange(arg1)
			PIGA["Map"]["MinimapPointX"]=arg1;
			Mapfun.Minimap_MoveUpdate()
		end
		MiniMapF.SetF.AnchorPointY = PIGSlider(MiniMapF.SetF,{"TOPLEFT", MiniMapF.SetF.AnchorPointX, "BOTTOMLEFT", 0, -10},{-1000, 1000, 1,{["Right"]="Y坐标%d"}},400)
		function MiniMapF.SetF.AnchorPointY:PIGOnValueChange(arg1)
			PIGA["Map"]["MinimapPointY"]=arg1;
			Mapfun.Minimap_MoveUpdate()
		end
		----
		function MiniMapF:Update_SetUI()
			self.MinimapMove:SetShown(not PIGA["Map"]["MinimapHide"])
			self.SetF:SetShown(PIGA["Map"]["MinimapMove"] and not PIGA["Map"]["MinimapHide"])
			self.SetF.AnchorPoint:PIGDownMenu_SetText(xyListName[PIGA["Map"]["MinimapAnchor"]])
			self.SetF.AnchorPointX:PIGSetValue(PIGA["Map"]["MinimapPointX"])
			self.SetF.AnchorPointY:PIGSetValue(PIGA["Map"]["MinimapPointY"])
		end
		MiniMapF:Update_SetUI()
	end);
	--WorldMap================
	local WorldMapF =PIGOptionsList_R(RTabFrame,L["MAP_TABNAME2"],90)
	WorldMapF:HookScript("OnShow", function (self)
		if WorldMapF.WorldMapXY then return end
		WorldMapF.WorldMapXY = PIGCheckbutton_R(WorldMapF,{L["MAP_WORDXY"],L["MAP_WORDXYTIPS"]},true)
		WorldMapF.WorldMapXY:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Map"]["WorldMapXY"]=true;
				Mapfun.WorldMap_XY()
			else
				PIGA["Map"]["WorldMapXY"]=false;
				PIG_OptionsUI.RLUI:Show()
			end
		end);
		WorldMapF.WorldMapXY:SetChecked(PIGA["Map"]["WorldMapXY"])
		if PIG_MaxTocversion() then
			WorldMapF.WorldMapWind = PIGCheckbutton_R(WorldMapF,{L["MAP_WORDWIND"],L["MAP_WORDWINDTIPS"]},true)
			WorldMapF.WorldMapWind:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Map"]["WorldMapWind"]=true;
					Mapfun.WorldMap_Wind()
				else
					PIGA["Map"]["WorldMapWind"]=false;
					PIG_OptionsUI.RLUI:Show()
				end
			end);

			WorldMapF.WorldMapLV = PIGCheckbutton_R(WorldMapF,{L["MAP_WORDLV"],L["MAP_WORDLVTIPS"]},true)
			WorldMapF.WorldMapLV:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Map"]["WorldMapLV"]=true;
					Mapfun.WorldMap_LVSkill()
				else
					PIGA["Map"]["WorldMapLV"]=false;
					PIG_OptionsUI.RLUI:Show()
				end
			end);
			WorldMapF.WorldMapSkill = PIGCheckbutton_R(WorldMapF,{L["MAP_WORDSKILL"],L["MAP_WORDSKILLTIPS"]},true)
			WorldMapF.WorldMapSkill:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Map"]["WorldMapSkill"]=true;
					Mapfun.WorldMap_LVSkill()
				else
					PIGA["Map"]["WorldMapSkill"]=false;
					PIG_OptionsUI.RLUI:Show()
				end
			end);
			WorldMapF.WorldMapMiwu = PIGCheckbutton_R(WorldMapF,{L["MAP_WORDMIWU"],L["MAP_WORDMIWUTIPS"]},true)
			WorldMapF.WorldMapMiwu:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIGA["Map"]["WorldMapMiwu"]=true;
					Mapfun.WorldMap_Miwu()
				else
					PIGA["Map"]["WorldMapMiwu"]=false;
					PIG_OptionsUI.RLUI:Show()
				end
			end);
			function WorldMapF.WorldMapMiwu.GetDefColor()
				if PIGA["Map"]["WorldMapMiwuColor"] then
					for i=1,4 do
						if PIGA["Map"]["WorldMapMiwuColor"][i]~=Mapfun.MiwuColor[i] then
							return PIGA["Map"]["WorldMapMiwuColor"]
						end
					end
					PIGA["Map"]["WorldMapMiwuColor"]=nil
				end
				return Mapfun.MiwuColor
			end
			WorldMapF.WorldMapMiwu.Color = Create.ColorBut(WorldMapF.WorldMapMiwu,{"LEFT",WorldMapF.WorldMapMiwu.Text,"RIGHT",10,0})
			function WorldMapF.WorldMapMiwu.Color:PIGinitialize()
				self.pezhiV=WorldMapF.WorldMapMiwu.GetDefColor()
			end
			function WorldMapF.WorldMapMiwu.Color:PIGSetValue(newR, newG, newB, newA)
				PIGA["Map"]["WorldMapMiwuColor"]={newR, newG, newB, newA}
				Mapfun.SetmiwuColor({newR, newG, newB, newA})
			end
			WorldMapF.WorldMapMiwu.CZinfo = PIGButton(WorldMapF.WorldMapMiwu,{"LEFT",WorldMapF.WorldMapMiwu.Color,"RIGHT",10,0},{60,22},RESET)
			WorldMapF.WorldMapMiwu.CZinfo:SetScript("OnClick", function()
				PIGA["Map"]["WorldMapMiwuColor"]=nil
				WorldMapF.WorldMapMiwu.Color:ShowButColor(unpack(WorldMapF.WorldMapMiwu.GetDefColor()))
				Mapfun.SetmiwuColor()
			end);
			WorldMapF.WorldMapWind:SetChecked(PIGA["Map"]["WorldMapWind"])
			WorldMapF.WorldMapLV:SetChecked(PIGA["Map"]["WorldMapLV"])
			WorldMapF.WorldMapSkill:SetChecked(PIGA["Map"]["WorldMapSkill"])
			WorldMapF.WorldMapMiwu:SetChecked(PIGA["Map"]["WorldMapMiwu"])
			WorldMapF.WorldMapMiwu.Color:ShowButColor(unpack(WorldMapF.WorldMapMiwu.GetDefColor()))
		end
	end)
end