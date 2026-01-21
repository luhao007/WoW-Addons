local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create = addonTable.Create
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGCheckbutton=Create.PIGCheckbutton
local PIGFontString=Create.PIGFontString
local PIGSlider = Create.PIGSlider
local PIGButton=Create.PIGButton
local PIGFrame=Create.PIGFrame
local PIGDownMenu=Create.PIGDownMenu
--=======================================
local ActionBarfun=addonTable.ActionBarfun
local RTabFrame=ActionBarfun.RTabFrame
local fuFrame=ActionBarfun.fuFrame
local fuFrameBut=ActionBarfun.fuFrameBut
---
local bagIDMax= addonTable.Data.bagData["bagIDMax"]
local ActionFun=addonTable.Fun.ActionFun
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local IsUsableItem=IsUsableItem or C_Item and C_Item.IsUsableItem
------------
local barName,LocaleName="PIG_ActionBar",BAG_FILTER_CONSUMABLES..ACTIONBARS_LABEL
local Showtiaojian,pailieName,paiNum,PailieFun,ShowHideNumFun,ShowHideEvent=unpack(ActionFun.UIdata)
local index,anniugeshu, anniujiange=9,12,6;
------------
local CABarF,CABarTabBut =PIGOptionsList_R(RTabFrame,BAG_FILTER_CONSUMABLES..ACTIONBARS_LABEL,110)

CABarF.Open=PIGCheckbutton(CABarF,{"TOPLEFT",CABarF,"TOPLEFT",10,-12},{BAG_FILTER_CONSUMABLES..ACTIONBARS_LABEL,"在屏幕上创建一条"..LocaleName.."，以便快捷使用"})
CABarF.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["CABar"]["Open"]=true;
		ActionBarfun.ConsumableActionBar()
		ActionBarfun.Update_ActionButton()
	else
		PIGA["CABar"]["Open"]=false;
		PIG_OptionsUI.RLUI:Show()
	end
	CABarF.SetF:SetShown(PIGA["CABar"]["Open"])
	CABarF.ModF:SetShown(PIGA["CABar"]["Open"])
end)
CABarF:HookScript("OnShow", function(self)
	self.SetF:SetShown(PIGA["CABar"]["Open"])
	self.ModF:SetShown(PIGA["CABar"]["Open"])
	self.Open:SetChecked(PIGA["CABar"]["Open"])
end)
--
CABarF.CZBUT = PIGButton(CABarF,{"TOPRIGHT",CABarF,"TOPRIGHT",-20,-12},{60,22},RESET);  
CABarF.CZBUT:SetScript("OnClick", function ()
	StaticPopup_Show ("CHONGZHI_QUICKBUT");
end);
StaticPopupDialogs["CHONGZHI_QUICKBUT"] = {
	text = "此操作将|cffff0000重置|r"..LocaleName.."配置。\n确定重置?",
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		PIGA["CABar"] = addonTable.Default["CABar"];
		PIG_OptionsUI.RLUI:Show()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
--
CABarF.SetF = PIGFrame(CABarF)
CABarF.SetF:PIGSetBackdrop(0)
CABarF.SetF:SetHeight(60)
CABarF.SetF:SetPoint("TOPLEFT",CABarF,"TOPLEFT",0,-40);
CABarF.SetF:SetPoint("TOPRIGHT",CABarF,"TOPRIGHT",0,0);
CABarF.SetF:Hide()
local function CABarFLock()
	if _G[barName..index].yidong then
		if PIGA["CABar"]["Lock"] then
			_G[barName..index].yidong:Hide()
		else
			_G[barName..index].yidong:Show()
		end
	end
end
CABarF.SetF.Lock=PIGCheckbutton(CABarF.SetF,{"TOPLEFT",CABarF.SetF,"TOPLEFT",20,-20},{LOCK_FRAME,LOCK_FOCUS_FRAME})
CABarF.SetF.Lock:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["CABar"]["Lock"]=true
	else
		PIGA["CABar"]["Lock"]=false;
	end
	CABarFLock()
end)
--
local xiayiinfo = {0.6,1.4,0.01,{["Right"]="缩放%d%%"}}
CABarF.SetF.suofang = PIGSlider(CABarF.SetF,{"LEFT",CABarF.SetF.Lock,"RIGHT",90,0},xiayiinfo)
function CABarF.SetF.suofang:PIGOnValueChange(arg1)
	PIGA["CABar"]["Scale"]=arg1;
	_G[barName..index]:SetScale(arg1);
end
CABarF.SetF.PailieT = PIGFontString(CABarF.SetF,{"LEFT",CABarF.SetF.suofang,"RIGHT",90,0},"排列")
CABarF.SetF.Pailie=PIGDownMenu(CABarF.SetF,{"LEFT",CABarF.SetF.PailieT,"RIGHT",2,0},{80,24})
function CABarF.SetF.Pailie:PIGDownMenu_Update_But()
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,paiNum,1 do
	    info.text, info.arg1 = pailieName[i], i
	    info.checked = i==PIGA["CABar"]["Pailie"]
		self:PIGDownMenu_AddButton(info)
	end 
end
function CABarF.SetF.Pailie:PIGDownMenu_SetValue(value,arg1,arg2)
	if InCombatLockdown()  then 
		PIG_OptionsUI:ErrorMsg(ERR_NOT_IN_COMBAT)
		return 
	end
	self:PIGDownMenu_SetText(value)
	PIGA["CABar"]["Pailie"] = arg1;
	for id=2,anniugeshu do
		PailieFun(barName..index,id,anniujiange,arg1)
	end
	PIGCloseDropDownMenus()
end
--
CABarF.SetF.CZBUT = PIGButton(CABarF.SetF,{"TOPRIGHT",CABarF.SetF,"TOPRIGHT",-20,-20},{80,22},RESET_POSITION)
CABarF.SetF.CZBUT:SetScript("OnClick", function ()
	Create.PIG_ResPoint(barName..index)
end)
CABarF.SetF:HookScript("OnShow", function(self)
	self.Lock:SetChecked(PIGA["CABar"]["Lock"])
	self.suofang:PIGSetValue(PIGA["CABar"]["Scale"])
	self.Pailie:PIGDownMenu_SetText(pailieName[PIGA["CABar"]["Pailie"]])
end)
--
CABarF.ModF = PIGFrame(CABarF)
CABarF.ModF:PIGSetBackdrop(0)
CABarF.ModF:SetPoint("TOPLEFT",CABarF.SetF,"BOTTOMLEFT",0,1);
CABarF.ModF:SetPoint("BOTTOMRIGHT",CABarF,"BOTTOMRIGHT",0,30);
CABarF.ModF:Hide()
CABarF.ModF.Cons=PIGCheckbutton_R(CABarF.ModF,{"显示消耗品"},true)
CABarF.ModF.Cons:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["CABar"]["Cons"]=true
	else
		PIGA["CABar"]["Cons"]=false;
	end
	ActionBarfun.Update_ActionButton(true)
end)
CABarF.ModF.Quest=PIGCheckbutton_R(CABarF.ModF,{"显示任务物品"},true)
CABarF.ModF.Quest:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["CABar"]["Quest"]=true
	else
		PIGA["CABar"]["Quest"]=false;
	end
	ActionBarfun.Update_ActionButton(true)
end)
CABarF.ModF:HookScript("OnShow", function(self)
	self.Cons:SetChecked(PIGA["CABar"]["Cons"])
	self.Quest:SetChecked(PIGA["CABar"]["Quest"])
end)
--==================
function ActionBarfun.ConsumableActionBar()
	if not PIGA["CABar"]["Open"] then return end
	local CFdata={
		index=index,
		["Mode"]="cons",
		["getData"]=function(key,index)
		    return PIGA["CABar"][key]
		end,
	}
	local Actionbar=ActionBarfun.ADD_ActionBar(barName..index,CFdata,anniugeshu,anniujiange,fuFrame,fuFrameBut,RTabFrame,CABarF,CABarTabBut)
	Actionbar.Items={}
	Actionbar.butindex=0
	Actionbar:RegisterEvent("PLAYER_ENTERING_WORLD");
	Actionbar:HookScript("OnEvent", function(self,event,...)
		if event=="PLAYER_ENTERING_WORLD" then
			self:RegisterEvent("BAG_UPDATE");
			ActionBarfun.Update_ActionButton()
		elseif event=="PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
			ActionBarfun.Update_ActionButton()
		else
			if InCombatLockdown() then
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
			else
				ActionBarfun.Update_ActionButton()
			end
		end
	end)
	local function GetItemsData()
		wipe(Actionbar.Items)
	    for bag=0,bagIDMax do
			local NumSlots=GetContainerNumSlots(bag)
			for slot=1,NumSlots do
				local itemID, itemLink, icon, _,quality,_,lootable = PIGGetContainerItemInfo(bag, slot)
				if itemID and itemID~=6948 then
					local usable, noMana = IsUsableItem(itemID)
					if usable or lootable then
						local _, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID=C_Item.GetItemInfoInstant(itemID)
						if classID==0 and PIGA["CABar"]["Cons"] or classID==12 and PIGA["CABar"]["Quest"] then
							Actionbar.Items[itemID]={"item",itemLink,itemID}
							--table.insert(Actionbar.Items,{"item",itemLink,itemID})
						end
					end
				end
			end
		end
	end
	function ActionBarfun.Update_ActionButton(set)
		if set and InCombatLockdown() then
			Actionbar:RegisterEvent("PLAYER_REGEN_ENABLED")
			return
		end
		GetItemsData()
		for butid, button in pairs(Actionbar.butlist) do
			button:Hide()
		end
		Actionbar.butindex=0
		for itemID,itemd in pairs(Actionbar.Items) do
			Actionbar.butindex=Actionbar.butindex+1
			if Actionbar.butlist[Actionbar.butindex] then
				ActionFun.loadingButInfo_Mode(Actionbar.butlist[Actionbar.butindex],itemd)
			end
		end
	end
end