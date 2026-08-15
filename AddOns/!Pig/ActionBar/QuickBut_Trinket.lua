local addonName, PD = ...;
local L=PD.locale
local Data=PD.Data
local Create = PD.Create
local PIGFrame=Create.PIGFrame
local PIGButton=Create.PIGButton
---
local GNopen
local bagID=Data.bagData["bagID"]
--获取身上饰品
local function GetPlaterTrinketSlotId(datax,invSlotId)
	local itemID= GetInventoryItemID("player", invSlotId)
	if itemID then
		local ItemLink= GetInventoryItemLink("player", invSlotId)
		local icon= GetInventoryItemTexture("player", invSlotId)
		datax[itemID]={icon,ItemLink,invSlotId,"InvC"}
	end
end
local function GetPlaterTrinket(datax)
	GetPlaterTrinketSlotId(datax,13)
	GetPlaterTrinketSlotId(datax,14)
end
--获取背包饰品
local function GetBagTrinket(datax)
	for bag=1,#bagID do
		for slot = 1, PIGGetContainerNumSlots(bagID[bag]) do
			local ItemLink = PIGGetContainerItemLink(bagID[bag], slot);
			if ItemLink then
				local itemID, itemType, itemSubType, itemEquipLoc, icon= PIGGetItemInfoInstant(ItemLink)
				if itemEquipLoc=="INVTYPE_TRINKET" then
					datax[itemID]={icon, ItemLink, bagID[bag], slot}
				end
			end
		end
	end
end

local function addSeTUI(TrinketSelectF)
	local setuiname="PIG_TrinketSetUI"
	if _G[setuiname] then return _G[setuiname] end
	-- 	
	local PIGDiyBut=Create.PIGDiyBut
	
	local PIGQuickBut=Create.PIGQuickBut
	local PIGSlider = Create.PIGSlider
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGDownMenu=Create.PIGDownMenu
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGFontString=Create.PIGFontString
	----
	local TrinkeWW,TrinkeHH = 300,400
	local TrinketSetUI=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,100},{TrinkeWW,TrinkeHH},setuiname,true)
	TrinketSetUI:PIGSetBackdrop()
	TrinketSetUI:PIGSetMovableNoSave()
	TrinketSetUI:PIGClose()
	TrinketSetUI:Hide()

	local RTabFrame =PIGOptionsList_RF(TrinketSetUI)
	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,SWITCH..MODE,90)
	fujiF:Show()
	fujiBut:Selected(true)
	fujiF.mode1 = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-5},{TRACKER_SORT_MANUAL..MODE},{16,16})
	fujiF.mode1:SetScript("OnClick", function (self)
		PIGA_Per["QuickBut"]["TrinketMode"]=1
		fujiF:Update_Set()
		TrinketSelectF.UpdateTrinketMode()
	end)
	fujiF.mode1.F=PIGFrame(fujiF.mode1,{"TOPLEFT",fujiF,"TOPLEFT",0,-24})
	fujiF.mode1.F:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", 0, 0);
	fujiF.mode1.F:PIGSetBackdrop()
	fujiF.mode2 = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",160,-5},{SELF_CAST_AUTO..MODE},{16,16})
	fujiF.mode2:SetScript("OnClick", function (self)
		PIGA_Per["QuickBut"]["TrinketMode"]=2
		fujiF:Update_Set()
		TrinketSelectF.UpdateTrinketMode()
	end)
	fujiF.mode2.F=PIGFrame(fujiF.mode2,{"TOPLEFT",fujiF,"TOPLEFT",0,-24})
	fujiF.mode2.F:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", 0, 0);
	fujiF.mode2.F:PIGSetBackdrop()

	local tishiNR = "1、此模式下"..INVTYPE_TRINKET..SWITCH..TRACKER_SORT_MANUAL..NPE_CONTROLS..
					"\n\n2、"..LEAVING_COMBAT..":\n"..string.rep(" ", 6)..KEY_BUTTON1..SWITCH.."上"..INVTYPE_TRINKET.."\n"..string.rep(" ", 6)..KEY_BUTTON2..SWITCH.."下"..INVTYPE_TRINKET..
					"\n\n3、"..AT_WAR.."点击加入队列,\n"..string.rep(" ", 6)..LEAVING_COMBAT..SWITCH..INVTYPE_TRINKET..
					"\n\n4、"..KEY_BUTTON2.."取消队列中饰品"
	fujiF.mode1.F.tip = PIGFontString(fujiF.mode1.F,{"TOPLEFT",fujiF.mode1.F,"TOPLEFT",10,-13},tishiNR)
	fujiF.mode1.F.tip:SetJustifyH("LEFT")
	fujiF.mode2.F.tip = PIGFontString(fujiF.mode2.F,{"TOPLEFT",fujiF.mode2.F,"TOPLEFT",10,-4},"选中"..CHAT_JOIN..SELF_CAST_AUTO..SWITCH..SOCIAL_QUEUE_TOOLTIP_HEADER.."(CD后脱战切换)")
	fujiF.mode2.F.locksp1 = PIGCheckbutton(fujiF.mode2.F,{"TOPLEFT",fujiF.mode2.F,"TOPLEFT",10,-26},{LOCK.."上"..INVTYPE_TRINKET},{14,14})
	fujiF.mode2.F.locksp1:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA_Per["QuickBut"]["LockTrinket"]=1
		else
			PIGA_Per["QuickBut"]["LockTrinket"]=0
		end
		fujiF:Update_Set()
		fujiF.mode2.F.List.Update_hang()
	end)
	fujiF.mode2.F.locksp2 = PIGCheckbutton(fujiF.mode2.F,{"LEFT",fujiF.mode2.F.locksp1.Text,"RIGHT",20,0},{LOCK.."下"..INVTYPE_TRINKET},{14,14})
	fujiF.mode2.F.locksp2:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA_Per["QuickBut"]["LockTrinket"]=2
		else
			PIGA_Per["QuickBut"]["LockTrinket"]=0
		end
		fujiF:Update_Set()
		fujiF.mode2.F.List.Update_hang()
	end)

	local hang_Height,hang_NUM  = 26, 11;
	fujiF.mode2.F.List=PIGFrame(fujiF.mode2.F,{"TOPLEFT",fujiF.mode2.F,"TOPLEFT",0,-44})
	fujiF.mode2.F.List:SetPoint("BOTTOMRIGHT",fujiF.mode2.F,"BOTTOMRIGHT",-16,0);
	fujiF.mode2.F.List:PIGSetBackdrop()
	fujiF.mode2.F.List.Scroll = CreateFrame("ScrollFrame",nil,fujiF.mode2.F.List, "FauxScrollFrameTemplate");  
	fujiF.mode2.F.List.Scroll:SetPoint("TOPLEFT",fujiF.mode2.F.List,"TOPLEFT",0,0);
	fujiF.mode2.F.List.Scroll:SetPoint("BOTTOMRIGHT",fujiF.mode2.F.List,"BOTTOMRIGHT",-3,0);
	fujiF.mode2.F.List.Scroll.ScrollBar:SetScale(0.8);
	fujiF.mode2.F.List.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, fujiF.mode2.F.List.Update_hang)
	end)
	fujiF.mode2.F.List.ButList={}
	fujiF.mode2.F.List:SetScript("OnShow", function (self)
		self.Update_hang()
	end)
	function fujiF.mode2.F.List.UpdateUpDwan(itemID,caozuo)
		local jiluweizhi = {0,{}}
		for i=1,#PIGA_Per["QuickBut"]["TrinketList"] do
			if itemID==PIGA_Per["QuickBut"]["TrinketList"][i] then
				jiluweizhi[1]=i
				jiluweizhi[2]=PIGA_Per["QuickBut"]["TrinketList"][i]
				table.remove(PIGA_Per["QuickBut"]["TrinketList"],i)
			end
		end
		if caozuo=="-" then
			table.insert(PIGA_Per["QuickBut"]["TrinketList"],jiluweizhi[1]-1,jiluweizhi[2])
		elseif caozuo=="+" then
			table.insert(PIGA_Per["QuickBut"]["TrinketList"],jiluweizhi[1]+1,jiluweizhi[2])
		end
		fujiF.mode2.F.List.Update_hang()
	end
	function fujiF.mode2.F.List.Update_hang()
		local Scroll = fujiF.mode2.F.List.Scroll
	    for _,but in pairs(fujiF.mode2.F.List.ButList) do
			but:Hide()
		end
		TrinketSelectF.SortTrinketList()
		local ItemsNum = #TrinketSelectF.SortTrinketLsit
	    FauxScrollFrame_Update(Scroll, ItemsNum, hang_NUM, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(Scroll);
	    for id = 1, hang_NUM do
			local dangqianH = id+offset;
			local itemIDx = TrinketSelectF.SortTrinketLsit[dangqianH]
			if itemIDx then
				if not fujiF.mode2.F.List.ButList[id] then
					local hang = CreateFrame("Button", nil, fujiF.mode2.F.List,nil,id);
					fujiF.mode2.F.List.ButList[id]=hang
					hang:SetSize(fujiF.mode2.F.List:GetWidth(), hang_Height);
					if id==1 then
						hang:SetPoint("TOPLEFT",fujiF.mode2.F.List.Scroll,"TOPLEFT",0,-1);
					else
						hang:SetPoint("TOP",fujiF.mode2.F.List.ButList[id-1],"BOTTOM",0,-1);
					end
					hang.highlight = hang:CreateTexture();
					hang.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
					hang.highlight:SetBlendMode("ADD")
					hang.highlight:SetAllPoints(hang)
					hang.highlight:SetAlpha(0.2);
					hang.check = hang:CreateTexture()
					hang.check:SetTexture("interface/buttons/ui-checkbox-check.bl");
					hang.check:SetSize(hang_Height-6,hang_Height-2);
					hang.check:SetPoint("LEFT", hang, "LEFT", 0,0);
					hang.icon = hang:CreateTexture(nil, "BORDER");
					hang.icon:SetSize(hang_Height-2,hang_Height-2);
					hang.icon:SetPoint("LEFT", hang.check, "RIGHT", 0,0);
					hang.link = PIGFontString(hang,{"LEFT", hang.icon, "RIGHT", 4,0})
					hang:SetScript("OnEnter", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(fujiF, "ANCHOR_NONE");
						GameTooltip:SetPoint("TOPRIGHT",fujiF,"TOPLEFT",-2,2);
						GameTooltip:SetHyperlink(TrinketSelectF.AllTrinketLsit[self.itemID][2])
						GameTooltip:Show();
						local tooltip, anchorFrame, shoppingTooltip1, shoppingTooltip2 = GameTooltip_InitializeComparisonTooltips(GameTooltip);
						shoppingTooltip1:Hide()
						shoppingTooltip2:Hide()
					end);
					hang:SetScript("OnLeave", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
					hang:SetScript("OnMouseUp", function (self,button)
						for ib=#PIGA_Per["QuickBut"]["TrinketList"],1,-1 do
							if self.itemID==PIGA_Per["QuickBut"]["TrinketList"][ib] then
								table.remove(PIGA_Per["QuickBut"]["TrinketList"],ib)
								fujiF.mode2.F.List.Update_hang()
								return
							end
						end
						table.insert(PIGA_Per["QuickBut"]["TrinketList"],self.itemID)
						fujiF.mode2.F.List.Update_hang()
					end);
					hang.DOWN = PIGDiyBut(hang,{"RIGHT", hang, "RIGHT", 0,0},{hang_Height-2,nil,nil,nil,"NPE_ArrowDown"})
					hang.DOWN:SetScript("OnClick", function (self)
						local fujik = self:GetParent()
						fujiF.mode2.F.List.UpdateUpDwan(fujik.itemID,"+")
					end);
					hang.UP = PIGDiyBut(hang,{"RIGHT", hang.DOWN, "LEFT", -1,0},{hang_Height-2,nil,nil,nil,"NPE_ArrowUp"})
					hang.UP:SetScript("OnClick", function (self)
						local fujik = self:GetParent()
						fujiF.mode2.F.List.UpdateUpDwan(fujik.itemID,"-")
					end);
				end
	    		local hang = fujiF.mode2.F.List.ButList[id]
	    		hang:Show();
		    	hang.icon:SetTexture(TrinketSelectF.AllTrinketLsit[itemIDx][1]);
				hang.link:SetText(TrinketSelectF.AllTrinketLsit[itemIDx][2]);
				hang.itemID=itemIDx
				if TrinketSelectF.AllTrinketLsit[itemIDx][5] then
					hang.icon:SetDesaturated(false)
					hang.check:Show()
					hang.UP:Show()
					hang.DOWN:Show()
					if dangqianH==1 then
		    			hang.UP:Disable()
		    		else
		    			hang.UP:Enable()
		    		end
		    		if dangqianH==TrinketSelectF.SelectedNum then
		    			hang.DOWN:Disable()
		    		else
		    			hang.DOWN:Enable()
		    		end
				else
					hang.icon:SetDesaturated(true)
					hang.check:Hide()
					hang.UP:Hide()
					hang.DOWN:Hide()
				end
			end
		end
	end
	fujiF:SetScript("OnShow", function (self)
		self:Update_Set()
	end)
	function fujiF:Update_Set()
		TrinketSelectF.TrinketMode=PIGA_Per["QuickBut"]["TrinketMode"]
		TrinketSelectF.LockTrinket=PIGA_Per["QuickBut"]["LockTrinket"]
		self.mode1:SetChecked(TrinketSelectF.TrinketMode==1)
		self.mode1.F:SetShown(TrinketSelectF.TrinketMode==1)
		self.mode2:SetChecked(TrinketSelectF.TrinketMode==2)
		self.mode2.F:SetShown(TrinketSelectF.TrinketMode==2)
		self.LockTrinket=PIGA_Per["QuickBut"]["LockTrinket"]
		self.mode2.F.locksp1:SetChecked(PIGA_Per["QuickBut"]["LockTrinket"]==1)
		self.mode2.F.locksp2:SetChecked(PIGA_Per["QuickBut"]["LockTrinket"]==2)
	end

	--设置
	local SetfujiF =PIGOptionsList_R(RTabFrame,SETTINGS,70)
	SetfujiF.Bindings = PIGButton(SetfujiF,{"TOPLEFT",SetfujiF,"TOPLEFT",20,-20},{76,20},KEY_BINDING);
	SetfujiF.Bindings:SetScript("OnClick", function (self)
		Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID, addonName);
	end)
	SetfujiF.Fenli = PIGCheckbutton(SetfujiF,{"TOPLEFT",SetfujiF,"TOPLEFT",20,-60},{UNDOCK_WINDOW.."(需"..RELOADUI..")","分离"..INVTYPE_TRINKET..VIDEO_OPTIONS_WINDOWED})
	SetfujiF.Fenli:SetChecked(PIGA["QuickBut"]["TrinketFenli"])
	SetfujiF.Fenli:SetScript("OnClick", function (self)
		StaticPopup_Show("PIGQKTRINKETFENLIMODE",nil,nil,self:GetChecked());
	end)
	StaticPopupDialogs["PIGQKTRINKETFENLIMODE"] = {
		text = "此操作将"..RELOADUI.."?",
		button1 = YES,
		button2 = NO,
		OnAccept = function(self,data)
			PIGA["QuickBut"]["TrinketFenli"]=data
			C_UI.Reload()
		end,
		OnCancel = function()
			SetfujiF.Fenli:SetChecked(PIGA["QuickBut"]["TrinketFenli"])
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	if PIGA["QuickBut"]["TrinketFenli"] then
		SetfujiF.PailieT = PIGFontString(SetfujiF,{"TOPLEFT",SetfujiF.Fenli,"BOTTOMLEFT",10,-20},"排序方向")
		local pailieList = {"横","竖"}
		SetfujiF.Pailie=PIGDownMenu(SetfujiF,{"LEFT",SetfujiF.PailieT,"RIGHT",2,0},{46,nil})
		function SetfujiF.Pailie:PIGDownMenu_Update_But()
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#pailieList,1 do
			    info.text, info.arg1 = pailieList[i], i
			    info.checked = i==PIGA["QuickBut"]["TrinketFenliPailie"]
				self:PIGDownMenu_AddButton(info)
			end 
		end
		function SetfujiF.Pailie:PIGDownMenu_SetValue(value,arg1,arg2)
			self:PIGDownMenu_SetText(value)
			PIGA["QuickBut"]["TrinketFenliPailie"]=arg1
			TrinketSelectF:UpdataFenliPailie()
			PIGCloseDropDownMenus()
		end
		SetfujiF.Scale = PIGSlider(SetfujiF,{"TOPLEFT",SetfujiF.PailieT,"BOTTOMLEFT",0,-20},{0.8,1.8,0.01,{["Right"]="缩放%d%%"}})
		function SetfujiF.Scale:PIGOnValueChange(arg1)
			PIGA["QuickBut"]["TrinketScale"]=arg1;
			TrinketSelectF.UpdataFenliScale()
		end
		SetfujiF.lock = PIGCheckbutton(SetfujiF,{"TOPLEFT",SetfujiF.Scale,"BOTTOMLEFT",0,-20},{LOCK_FRAME,LOCK_FOCUS_FRAME})
		SetfujiF.lock:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["QuickBut"]["TrinketFenlilock"]=true
			else
				PIGA["QuickBut"]["TrinketFenlilock"]=false
			end
			TrinketSelectF.UpdataFenliScale()
		end)
		SetfujiF.CZBUT = PIGButton(SetfujiF,{"TOPLEFT",SetfujiF.lock,"BOTTOMLEFT",0,-20},{80,24},RESET_POSITION)
		SetfujiF.CZBUT:SetScript("OnClick", function ()
			PIGA["QuickBut"]["TrinketScale"]=1
			SetfujiF.Scale:PIGSetValue(1)
			TrinketSelectF.UpdataFenliCZ()
		end)
		SetfujiF.Pailie:PIGDownMenu_SetText(pailieList[PIGA["QuickBut"]["TrinketFenliPailie"]])
		SetfujiF.lock:SetChecked(PIGA["QuickBut"]["TrinketFenlilock"])
		SetfujiF.Scale:PIGSetValue(PIGA["QuickBut"]["TrinketScale"])
	end
	return TrinketSetUI
end
local function addSelectUI(butW,QuickButUI)
	if GNopen then return GNopen end
	--饰品选择界面
	local TrinketSelectF = PIGFrame(UIParent,nil,{butW,butW})
	GNopen=TrinketSelectF
	TrinketSelectF:PIGSetBackdrop(1)
	TrinketSelectF:Hide()
	TrinketSelectF.AllTrinketLsit={}
	TrinketSelectF.SortTrinketLsit={}
	TrinketSelectF.NextTrinketLsit={}
	TrinketSelectF.SelectedNum=0
	TrinketSelectF.ButList={}
	TrinketSelectF.DQList={}
	TrinketSelectF.TrinketMode=PIGA_Per["QuickBut"]["TrinketMode"]
	TrinketSelectF.LockTrinket=PIGA_Per["QuickBut"]["LockTrinket"]
	TrinketSelectF:HookScript("OnEnter", function(self)
		self:EnterShow()
	end)
	TrinketSelectF:HookScript("OnLeave", function(self)
		self:Hide()
	end)
	function TrinketSelectF.GetPlaterBagTrinket()
	    wipe(TrinketSelectF.AllTrinketLsit)
		GetPlaterTrinket(TrinketSelectF.AllTrinketLsit)
		GetBagTrinket(TrinketSelectF.AllTrinketLsit)
	end
	function TrinketSelectF.SortTrinketList()
		TrinketSelectF.GetPlaterBagTrinket()
		wipe(TrinketSelectF.SortTrinketLsit)
		wipe(TrinketSelectF.NextTrinketLsit)
		for i=1,#PIGA_Per["QuickBut"]["TrinketList"] do
			for k,v in pairs(TrinketSelectF.AllTrinketLsit) do
				if k==PIGA_Per["QuickBut"]["TrinketList"][i] then
					v[5]=true
					table.insert(TrinketSelectF.SortTrinketLsit,k)
					if v[4]~="InvC" then
						table.insert(TrinketSelectF.NextTrinketLsit,{k,v[3],v[4]})
					end
				end
			end
		end
		TrinketSelectF.SelectedNum=#TrinketSelectF.SortTrinketLsit
		for k,v in pairs(TrinketSelectF.AllTrinketLsit) do
			if not TrinketSelectF.AllTrinketLsit[k][5] then
				table.insert(TrinketSelectF.SortTrinketLsit,k)
			end
		end
	end
	local WowHeight=GetScreenHeight();
	local WowWidth=GetScreenWidth()
	local function Update_hangbut(P1,P2,P3,P4,P5)
		for i=1,#TrinketSelectF.ButList do
			local hangBut=TrinketSelectF.ButList[i]
			hangBut:ClearAllPoints();
			if not TrinketSelectF.DQList[i] then return end
			local tmp1,tmp2 = math.modf(i/2)
			if i==1 then
				hangBut:SetPoint(P1,TrinketSelectF,P1,1,0);
			elseif tmp2==0 then
				hangBut:SetPoint(P2,TrinketSelectF.ButList[i-1],P3,0,0);
			else
				hangBut:SetPoint(P4,TrinketSelectF.ButList[i-2],P5,0,0);
			end
		end
	end
	function TrinketSelectF:EnterShow()
		self.GetPlaterBagTrinket()
		wipe(self.DQList)
		for k,v in pairs(self.AllTrinketLsit) do
			if v[4]~="InvC" then
				table.insert(self.DQList,{k,v[1],v[2],v[3],v[4]})
			end
		end
		for i=1,#self.DQList do
			if not self.ButList[i] then
				local hangBut = CreateFrame("Button", nil, self)
				self.ButList[i]=hangBut
				hangBut:Hide()
				hangBut:SetSize(butW, butW)
				hangBut:SetHighlightTexture(130718);
				hangBut.Cooldown = CreateFrame("Frame", nil, hangBut);
				hangBut.Cooldown:SetAllPoints()
				hangBut.Cooldown.N = CreateFrame("Cooldown", nil, hangBut.Cooldown, "CooldownFrameTemplate")
				hangBut.Cooldown.N:SetAllPoints()
				hangBut:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				hangBut:HookScript("OnEnter", function(self)
					TrinketSelectF:EnterShow()
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_NONE");
					GameTooltip:SetPoint("BOTTOMLEFT",self,"BOTTOMRIGHT",2,2);
					GameTooltip:SetBagItem(self.bagID, self.slot)
					GameTooltip:Show();
					if GameTooltip_HideShoppingTooltips then
						GameTooltip_HideShoppingTooltips(GameTooltip);
					else
						local tooltip, anchorFrame, shoppingTooltip1, shoppingTooltip2 = GameTooltip_InitializeComparisonTooltips(GameTooltip);
						shoppingTooltip1:Hide()
						shoppingTooltip2:Hide()
					end
				end)
				hangBut:HookScript("OnLeave", function()
					GameTooltip:ClearLines();
					GameTooltip:Hide()
					TrinketSelectF:Hide()
				end)
				hangBut:HookScript("OnClick", function(self,button)
					local TrinkeLR=button=="LeftButton" and TrinketSelectF.AutoTrinketButList[1] or TrinketSelectF.AutoTrinketButList[2]
					if InCombatLockdown() then
						if TrinketSelectF.TrinketMode==2 then
							PIGErrorMsg("当前处于自动模式", "R")
							return
						end
						for butid=1,#TrinketSelectF.AutoTrinketButList do
							local Trinketbut=TrinketSelectF.AutoTrinketButList[butid]
							if Trinketbut.NextList and Trinketbut.NextList[1]==self.bagID and Trinketbut.NextList[2]==self.slot then
								Trinketbut.NextList=nil
								Trinketbut:NextListFun()
							end
						end
						TrinkeLR.NextList={self.bagID,self.slot,self.itemicon}
						TrinkeLR:NextListFun()
					else
						PIGPickupContainerItem(self.bagID,self.slot)
						PickupInventoryItem(TrinkeLR.Inventoryslot)
					end
					self:Hide()
				end);
			end
			local hangBut = self.ButList[i]
			hangBut:Show()
			hangBut.bagID=self.DQList[i][4]
			hangBut.slot=self.DQList[i][5]
			hangBut.itemicon=self.DQList[i][2]
			hangBut:SetNormalTexture(self.DQList[i][2]);
			local startTime, duration, enable = PIGGetContainerItemCooldown(self.DQList[i][4], self.DQList[i][5])
			hangBut.Cooldown.N:SetCooldown(startTime, duration);
		end
		local lieshuNUM = math.ceil(#self.DQList*0.5)
		self.pianyiv=0
		self:ClearAllPoints();
		if self.Pailie==1 then
			self:SetSize(butW*2+2, butW*lieshuNUM+1)
			local offset1 = self.Pmubiao:GetBottom() or 200
			if offset1>(WowHeight*0.5) then
				self:SetPoint("TOPLEFT",self.Pmubiao,"BOTTOMLEFT",-1,1);
				Update_hangbut("TOPLEFT","LEFT","RIGHT","TOPLEFT","BOTTOMLEFT")
			else
				self:SetPoint("BOTTOMLEFT",self.Pmubiao,"TOPLEFT",-1,-1);
				Update_hangbut("BOTTOMLEFT","LEFT","RIGHT","BOTTOMLEFT","TOPLEFT")
			end
		elseif self.Pailie==2 then
			self:SetSize(butW*lieshuNUM+1,butW*2)
			local offset1 = self.Pmubiao:GetLeft() or 500
			if offset1>(WowWidth*0.48) then
				self.pianyiv=butW
				self:SetPoint("TOPRIGHT",self.Pmubiao,"TOPLEFT",1,0);
				Update_hangbut("TOPRIGHT","TOP","BOTTOM","TOPRIGHT","TOPLEFT")
			else
				self:SetPoint("TOPLEFT",self.Pmubiao,"TOPRIGHT",-1,0);
				Update_hangbut("TOPLEFT","TOP","BOTTOM","TOPLEFT","TOPRIGHT")
			end
		end
		self:Show()
	end

 	local function _fun_PickupContainer(index, NewTrinketData, invSlotId)
 		local bagID, slot=NewTrinketData[index][2],NewTrinketData[index][3]
 		if bagID and slot and invSlotId then
 			local ItemID = PIGGetContainerItemID(bagID, slot)
 			if ItemID then
 				local _, _, _, itemEquipLoc= PIGGetItemInfoInstant(ItemID)
				if itemEquipLoc=="INVTYPE_TRINKET" then
					PIGPickupContainerItem(bagID, slot)
					PickupInventoryItem(invSlotId)
					table.remove(NewTrinketData,index)
				end
			end
		end
	end
	local function AutoSwitchingTrinket_1(invSlotId,NewTrinketData)
		local Invstart, Invduration, Invenable = GetInventoryItemCooldown("player", invSlotId)
		--start - 冷却时间的开始时间，如果没有冷却时间（或槽中没有物品），则为 0
		--duration - 冷却时间的持续时间（不是剩余时间）。如果物品没有使用/冷却时间或插槽为空，则为 0。
		--enable- 返回 1 或 0。如果库存物品能够有冷却时间，则为 1，如果不能，则为 0。
 		if Invenable==0 or Invenable==1 and (Invstart+Invduration-GetTime())>30 then
 			local ItemLink= GetInventoryItemLink("player", invSlotId)
			for i=1,#NewTrinketData do
				local _, spellID = PIGGetItemSpell(NewTrinketData[i][1])
				if spellID then
					local start, duration, enable = C_Container.GetItemCooldown(NewTrinketData[i][1])
					if enable==1 and (start+duration-GetTime())<32 then
						_fun_PickupContainer(i,NewTrinketData,invSlotId)
						return
					elseif enable==0 then
						_fun_PickupContainer(i,NewTrinketData,invSlotId)
						return
					end
				else
					_fun_PickupContainer(i,NewTrinketData,invSlotId)
					return
				end
			end
		end
	end
	function TrinketSelectF:AutoSwitchingTrinket()
		TrinketSelectF.SortTrinketList()
		if self.LockTrinket==1 then
			AutoSwitchingTrinket_1(14,TrinketSelectF.NextTrinketLsit)
		elseif self.LockTrinket==2 then
			AutoSwitchingTrinket_1(13,TrinketSelectF.NextTrinketLsit)
		else
			AutoSwitchingTrinket_1(13,TrinketSelectF.NextTrinketLsit)
			AutoSwitchingTrinket_1(14,TrinketSelectF.NextTrinketLsit)
		end
	end
	function TrinketSelectF.QuickButClick(Button)
		if Button=="LeftButton" then
			local TrinketSetUI=addSeTUI(TrinketSelectF)
			if TrinketSetUI:IsShown() then
				TrinketSetUI:Hide()
			else
				TrinketSetUI:Show()
			end
		end
	end
	-------------
	TrinketSelectF:RegisterEvent("PLAYER_ENTERING_WORLD");
	TrinketSelectF:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");--更换装备
	TrinketSelectF:RegisterEvent("PLAYER_REGEN_ENABLED");
	TrinketSelectF:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
	TrinketSelectF:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
	TrinketSelectF:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	TrinketSelectF:HookScript("OnEvent", function(self,event,arg1,_,arg3)
		if event=="PLAYER_ENTERING_WORLD" then
			C_Timer.After(1, function()
				for butid=1,#self.AutoTrinketButList do
					self.AutoTrinketButList[butid]:SetanniuIcon()
					self.AutoTrinketButList[butid]:Update_Cooldown()
				end
			end)
		elseif event=="PLAYER_EQUIPMENT_CHANGED" then
			for butid=1,#self.AutoTrinketButList do
				self.AutoTrinketButList[butid]:SetanniuIcon()
				self.AutoTrinketButList[butid]:Update_Cooldown()
			end
		elseif event=="PLAYER_REGEN_ENABLED" then
			if self.TrinketMode==1 then
				for butid=1,#self.AutoTrinketButList do
					local butxxx=self.AutoTrinketButList[butid]
					if butxxx.NextList then
						PIGPickupContainerItem(butxxx.NextList[1],butxxx.NextList[2])
						PickupInventoryItem(butxxx.Inventoryslot)
						butxxx.NextList=nil
						butxxx:NextListFun()
					end
				end
			elseif self.TrinketMode==2 then
				self:AutoSwitchingTrinket()
			end
		elseif event=="SPELL_UPDATE_COOLDOWN" then
			C_Timer.After(0.01, function()
				for butid=1,#self.AutoTrinketButList do
					self.AutoTrinketButList[butid]:Update_Cooldown()
				end
			end)
		end
	end);

	--分离模式
	local UIname= "PIG_QuickTrinketUI"
	if PIGA["QuickBut"]["TrinketFenli"] then
		Data.UILayout[UIname]={"BOTTOM","BOTTOM",-200,200}
		local FenliUI=PIGFrame(UIParent,nil,nil,UIname)
		TrinketSelectF.FenliUI=FenliUI
		FenliUI:PIGSetBackdrop()
		Create.PIG_SetPoint(UIname)
		FenliUI.yidong=PIGButton(FenliUI)
		Create.PIGSetMovable(FenliUI.yidong,FenliUI,nil,nil,true)
		FenliUI.yidong.tisplist={KEY_BUTTON1.."拖拽-|cff00FFff"..TUTORIAL_TITLE2.."|r",KEY_BUTTON1.."-|cff00FFff"..SETTINGS..INVTYPE_TRINKET..MODE.."|r"}
		FenliUI.yidong:HookScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			GameTooltip:AddLine(L["LIB_TIPS"])
			for i=1,#FenliUI.yidong.tisplist do
				GameTooltip:AddLine(FenliUI.yidong.tisplist[i])
			end
			GameTooltip:Show();
		end);
		FenliUI.yidong:HookScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end)
		FenliUI.yidong.move = FenliUI.yidong:CreateTexture()
		FenliUI.yidong.move:SetAtlas("OptionsIcon-Brown")
		FenliUI.yidong.move:SetSize(13,13);
		FenliUI.yidong.move:SetPoint("TOP",FenliUI.yidong, "CENTER",0, 0);
		FenliUI.yidong.move:SetDesaturated(true)
		QuickButUI.yidong.onoff:SetParent(FenliUI.yidong)
		FenliUI.nr=PIGFrame(FenliUI)
		FenliUI.nr:PIGSetBackdrop(0)
		function TrinketSelectF:UpdataFenliPailie()
			self.Pailie=PIGA["QuickBut"]["TrinketFenliPailie"]
			FenliUI.yidong:ClearAllPoints();
			FenliUI.nr:ClearAllPoints();
			self.AutoTrinketButList[1]:ClearAllPoints();
			self.AutoTrinketButList[2]:ClearAllPoints();
			QuickButUI.yidong.move:ClearAllPoints();
			QuickButUI.yidong.move:SetPoint("CENTER",QuickButUI.yidong, "CENTER",0, 0);
			FenliUI.yidong.move:ClearAllPoints();QuickButUI.yidong.onoff:ClearAllPoints();
			if self.Pailie==1 then
				FenliUI:SetSize(butW*2+14,butW);
				FenliUI.yidong:SetWidth(13);
				FenliUI.yidong:SetPoint("TOPLEFT",FenliUI,"TOPLEFT",0,0)
				FenliUI.yidong:SetPoint("BOTTOMLEFT", FenliUI, "BOTTOMLEFT", 0, 0);
				FenliUI.yidong.move:SetPoint("TOP",FenliUI.yidong, "CENTER",0, 0);
				QuickButUI.yidong.onoff:SetPoint("BOTTOM",FenliUI.yidong, "CENTER",0, 0);
				FenliUI.nr:SetPoint("TOPLEFT",FenliUI.yidong,"TOPRIGHT",0.5,0)
				FenliUI.nr:SetPoint("BOTTOMRIGHT", FenliUI, "BOTTOMRIGHT", 0, 0);
				self.AutoTrinketButList[1]:SetPoint("LEFT",FenliUI.nr,"LEFT",2,0);
				self.AutoTrinketButList[2]:SetPoint("LEFT",self.AutoTrinketButList[1],"RIGHT",1,0);
			elseif self.Pailie==2 then
				FenliUI:SetSize(butW,butW*2+14);
				FenliUI.yidong:SetHeight(13);
				FenliUI.yidong:SetPoint("TOPLEFT",FenliUI,"TOPLEFT",0,-0.5)
				FenliUI.yidong:SetPoint("TOPRIGHT", FenliUI, "TOPRIGHT", 0, 0);
				FenliUI.yidong.move:SetPoint("LEFT",FenliUI.yidong, "CENTER",0, 0);
				QuickButUI.yidong.onoff:SetPoint("RIGHT",FenliUI.yidong, "CENTER",0, 0);
				FenliUI.nr:SetPoint("TOPLEFT",FenliUI.yidong,"BOTTOMLEFT",0,0)
				FenliUI.nr:SetPoint("BOTTOMRIGHT", FenliUI, "BOTTOMRIGHT", 0, 0);
				self.AutoTrinketButList[1]:SetPoint("TOP",FenliUI.nr,"TOP",0,-2);
				self.AutoTrinketButList[2]:SetPoint("TOP",self.AutoTrinketButList[1],"BOTTOM",0,-1);
			end
		end
		function TrinketSelectF.UpdataFenliScale()
			if PIGA["QuickBut"]["TrinketFenlilock"] then
				FenliUI.yidong:RegisterForDrag("")
			else
				FenliUI.yidong:RegisterForDrag("LeftButton")
			end
			FenliUI:SetScale(PIGA["QuickBut"]["TrinketScale"]);
		end
		function TrinketSelectF.UpdataFenliCZ()
			Create.PIG_ResPoint(UIname)
			FenliUI:SetScale(PIGA["QuickBut"]["TrinketScale"]);
		end
	end
	return TrinketSelectF
end
local function GetSelectUI(QkBut,slotID,butW,QuickButUI)
	local TrinketSelectF = addSelectUI(butW,QuickButUI)
	if slotID==13 then
		TrinketSelectF.AutoTrinketButList= {}
		TrinketSelectF.AutoTrinketButList[1]=QkBut
		TrinketSelectF.Pmubiao=TrinketSelectF.AutoTrinketButList[1]
	elseif slotID==14 then
		TrinketSelectF.AutoTrinketButList[2]=QkBut
		local yidongUI
		if PIGA["QuickBut"]["TrinketFenli"] then
			QkBut.Fenli=true
			QkBut:SetParent(TrinketSelectF.FenliUI)
			QkBut:SetFrameLevel(TrinketSelectF.FenliUI:GetFrameLevel()+10)
			TrinketSelectF.AutoTrinketButList[1].Fenli=true
			TrinketSelectF.AutoTrinketButList[1]:SetParent(TrinketSelectF.FenliUI)
			TrinketSelectF.AutoTrinketButList[1]:SetFrameLevel(TrinketSelectF.FenliUI:GetFrameLevel()+10)
			TrinketSelectF:SetParent(TrinketSelectF.FenliUI)
			TrinketSelectF:SetFrameLevel(TrinketSelectF.FenliUI:GetFrameLevel()+10)
			TrinketSelectF.UpdataFenliScale()
			TrinketSelectF:UpdataFenliPailie()
			TrinketSelectF.FenliUI.yidong:SetScript("OnClick", function (self,Button)
				TrinketSelectF.QuickButClick(Button)
			end);
			yidongUI=TrinketSelectF.FenliUI.yidong
			hooksecurefunc(QuickButUI, "UpdateShowHide", function(self)
				TrinketSelectF:UpdataFenliPailie()
			end)
		else
			table.insert(QuickButUI.yidong.tisplist,1,KEY_BUTTON1.."-|cff00FFff"..SETTINGS..INVTYPE_TRINKET..MODE.."|r")
			TrinketSelectF:SetParent(QuickButUI)
			TrinketSelectF:SetFrameLevel(QuickButUI:GetFrameLevel()+6)
			QuickButUI.yidong:HookScript("OnClick", function (self,Button)
				TrinketSelectF.QuickButClick(Button)
			end);
			yidongUI=QuickButUI.yidong
			hooksecurefunc(QuickButUI, "UpdateShowHide", function(self)
				TrinketSelectF.Pailie=self.Pailie
			end)
		end
		local function GertishiTXT()
			local txtxt=INVTYPE_TRINKET..MODE..": "
			local txtxt1=TrinketSelectF.TrinketMode==2 and "|cffFF0000"..string.format(L["LIB_AUTO"],MODE).."|r" or "|cffEEEEEE手动|r"
			return txtxt..txtxt1
		end
		table.insert(yidongUI.tisplist,1,GertishiTXT())
		function TrinketSelectF.UpdateTrinketMode()
			QuickButUI.yidong.onoff:SetDesaturated(TrinketSelectF.TrinketMode~=2)
			yidongUI.tisplist[1]=GertishiTXT()
		end
		TrinketSelectF.UpdateTrinketMode()
	end
	return TrinketSelectF
end
local function add_Button(QkBut,QuickButUI,slotID)
	local butW=QuickButUI.butWWW
	QkBut.Inventoryslot=slotID
	local TrinketSelectF=GetSelectUI(QkBut,slotID,butW,QuickButUI)
	QkBut:SetAttribute("type1", "macro");
	QkBut.Cooldown = CreateFrame("Frame", nil, QkBut);
	QkBut.Cooldown:SetAllPoints()
	QkBut.Cooldown.N = CreateFrame("Cooldown", nil, QkBut.Cooldown, "CooldownFrameTemplate")
	QkBut.Cooldown.N:SetAllPoints()

	QkBut.START = QkBut:CreateTexture(nil, "OVERLAY");
	QkBut.START:SetTexture(130724);
	QkBut.START:SetBlendMode("ADD");
	QkBut.START:SetAllPoints(QkBut)
	QkBut.START:Hide();
	QkBut.NextBut = QkBut:CreateTexture(nil, "OVERLAY");
	QkBut.NextBut:Hide();
	QkBut.NextBut:SetPoint("TOPLEFT", 0, 0);
	QkBut.NextBut:SetSize(butW*0.5, butW*0.5)
	QkBut:HookScript("OnClick", function(self,button)
		if button=="RightButton" then
			self.NextList=nil
			self:NextListFun()
		end
	end)
	QkBut:HookScript("OnEnter", function(self)
		TrinketSelectF:EnterShow()
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(TrinketSelectF, "ANCHOR_NONE");
		GameTooltip:SetPoint("BOTTOMLEFT",TrinketSelectF,"BOTTOMRIGHT",2+TrinketSelectF.pianyiv,2);
		GameTooltip:SetInventoryItem("player",slotID)
		GameTooltip:Show();
	end)
	QkBut:HookScript("OnLeave", function()
		TrinketSelectF:Hide()
		GameTooltip:ClearLines();
		GameTooltip:Hide()
	end)
	function QkBut:NextListFun()
		self.NextBut:Hide()
		if self.NextList then
			self.NextBut:Show()
			self.NextBut:SetTexture(self.NextList[3]);
		end
	end
	function QkBut:SetanniuIcon()
		local Icon = GetInventoryItemTexture('player', self.Inventoryslot) or 136528
		self:SetNormalTexture(Icon)
	end
	function QkBut:Update_Cooldown()
		local start, duration, enable = GetInventoryItemCooldown("player", slotID)
		CooldownFrame_Set(QkBut.Cooldown.N, start, duration, enable)
	end
	QkBut:SetanniuIcon()
	QkBut:Update_Cooldown()
end
Create.PIGaddQuickBut(2,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["Trinket"]
	end,
	Icon=136528,
	UIname="PIG_QkBut_AutoTrinket",
	Template="SecureActionButtonTemplate",
	fun=function(QkBut,QuickButUI)
		QkBut:SetAttribute("macrotext", [=[/use 13]=]);
		_G["BINDING_NAME_CLICK PIG_QkBut_AutoTrinket:LeftButton"]= "PIG"..L["ACTION_TABNAME2"]..TRINKET0SLOT_UNIQUE
		add_Button(QkBut,QuickButUI,13)
	end,
})
Create.PIGaddQuickBut(3,{
	Open=function()
		return PIGA["QuickBut"]["Open"] and PIGA["QuickBut"]["Trinket"]
	end,
	Icon=136528,
	UIname="PIG_QkBut_AutoTrinket1",
	Template="SecureActionButtonTemplate",
	fun=function(QkBut,QuickButUI)
		QkBut:SetAttribute("macrotext", [=[/use 14]=]);
		_G["BINDING_NAME_CLICK PIG_QkBut_AutoTrinket1:LeftButton"]= "PIG"..L["ACTION_TABNAME2"]..TRINKET1SLOT_UNIQUE
		add_Button(QkBut,QuickButUI,14)
	end,
})