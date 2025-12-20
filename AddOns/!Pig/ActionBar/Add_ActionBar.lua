local addonName, addonTable = ...;
local L=addonTable.locale
---
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGFontString=Create.PIGFontString
local Data=addonTable.Data
--=======================================
local ActionBarfun=addonTable.ActionBarfun
local RTabFrame=ActionBarfun.RTabFrame
local fuFrame=ActionBarfun.fuFrame
local fuFrameBut=ActionBarfun.fuFrameBut
------
local Showtiaojian = {ALWAYS..SHOW,LEAVING_COMBAT..HIDE,BATTLEFIELD_JOIN..HIDE,SPELL_FAILED_BAD_IMPLICIT_TARGETS..HIDE,};
---排列方式
local pailieName={"横向","竖向","6×2","2×6","4×3","3×4"};
local paiNum = #pailieName
local pailieweizhi={
	{
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
	},
	{
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
		{"TOP","BOTTOM",0,"-",1},
	},
	{
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",6},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
	},
	{
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",2},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",2},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",2},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",2},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",2},
		{"LEFT","RIGHT","+",0,1},
	},
	{
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",4},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",4},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
	},
	{
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",3},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",3},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
		{"TOPLEFT","BOTTOMLEFT",0,"-",3},
		{"LEFT","RIGHT","+",0,1},
		{"LEFT","RIGHT","+",0,1},
	},
};
local function PailieFun(barName,id,Newjiange,cfPailie)
	for x=1,paiNum do
		if cfPailie == x then
			_G[barName.."_But"..id]:ClearAllPoints();
			if pailieweizhi[x][id-1][3]=="+" then
				_G[barName.."_But"..id]:SetPoint(pailieweizhi[x][id-1][1],_G[barName.."_But"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],Newjiange,pailieweizhi[x][id-1][4])
			elseif pailieweizhi[x][id-1][4]=="+" then
				_G[barName.."_But"..id]:SetPoint(pailieweizhi[x][id-1][1],_G[barName.."_But"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],pailieweizhi[x][id-1][3],Newjiange)
			elseif pailieweizhi[x][id-1][3]=="-" then
				_G[barName.."_But"..id]:SetPoint(pailieweizhi[x][id-1][1],_G[barName.."_But"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],-Newjiange,pailieweizhi[x][id-1][4])
			elseif pailieweizhi[x][id-1][4]=="-" then
				_G[barName.."_But"..id]:SetPoint(pailieweizhi[x][id-1][1],_G[barName.."_But"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],pailieweizhi[x][id-1][3],-Newjiange)
			end
		end
	end
end
local function ShowHideNumFun(self,CVarV,tuodong)
	if tuodong then self:SetAnniuNumFun() return end
	local CVarV = CVarV or GetCVar("alwaysShowActionBars")
	if CVarV=="0" then
		if not self.Type then
			self:Hide()
		end
	elseif CVarV=="1" then
		self:SetAnniuNumFun()
	end
end
local function ShowHideEvent(self,canshuV)
	if canshuV==1 then
		RegisterStateDriver(self, "combatYN", "[] show; hide");--一直显示
	elseif canshuV==2 then
		RegisterStateDriver(self, "combatYN", "[combat] show; hide");--脱战后隐藏
	elseif canshuV==3 then
		RegisterStateDriver(self, "combatYN", "[nocombat] show; hide");--进战斗隐藏
	elseif canshuV==4 then
		RegisterStateDriver(self, "combatYN", "[exists] show; hide");--无目标隐藏
	end
end
ActionBarfun.UIdata={Showtiaojian,pailieName,paiNum,PailieFun,ShowHideNumFun,ShowHideEvent}
---add------------------
local PigMacroEventCount =0;
local PigMacroDeleted = false;
local PigMacroCount=0
local ActionFun=addonTable.Fun.ActionFun
local PIGUseKeyDown=ActionFun.PIGUseKeyDown
local Update_Attribute=ActionFun.Update_Attribute
local Update_Icon=ActionFun.Update_Icon
local Update_Cooldown=ActionFun.Update_Cooldown
local Update_Count=ActionFun.Update_Count
local Update_bukeyong=ActionFun.Update_bukeyong
local Update_State=ActionFun.Update_State
local Update_PostClick=ActionFun.Update_PostClick
local loadingButInfo=ActionFun.loadingButInfo
local Update_OnEnter=ActionFun.Update_OnEnter
local Cursor_Fun=ActionFun.Cursor_Fun
local Update_Macro=ActionFun.Update_Macro
local Update_Equipment=ActionFun.Update_Equipment

local ActionW = ActionButton1:GetWidth()
local PIGActionBarActionEventsFrame=CreateFrame("Frame")
PIGActionBarActionEventsFrame:HookScript("OnEvent", function(self,event,...)
	for k, frame in pairs(self.frames) do
		if self.events[event] then self.events[event](frame, ...); end
	end
end)
function PIGActionBarActionEventsFrame:ActionBarActionEventsFrame_OnLoad()
	self.events = { };
	self.frames = { };
	-- self:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
 	-- self:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	self:RegisterEvent("ACTIONBAR_SHOWGRID");
	self:RegisterEvent("ACTIONBAR_HIDEGRID");
	self:RegisterEvent("TRADE_SKILL_CLOSE")
	if PIG_MaxTocversion() then
		self:RegisterEvent("CRAFT_CLOSE")
	end
	self:RegisterEvent("CVAR_UPDATE");
	self:RegisterEvent("UPDATE_MACROS");
	--self:RegisterEvent("EXECUTE_CHAT_LINE");--要执行的宏文本体
	self:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED");
	self:RegisterUnitEvent("UNIT_AURA","player");
	--self:RegisterUnitEvent("UNIT_PET","player");
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED");
	self:RegisterEvent("PLAYER_UPDATE_RESTING");
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	self:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end
PIGActionBarActionEventsFrame:ActionBarActionEventsFrame_OnLoad()
PIGActionBarActionEventsFrame.events={
    ACTIONBAR_SHOWGRID = function(button, arg1, arg2, arg3)
    	if button.ModeSet=="cons" then return end
	    if InCombatLockdown() then return end
	    ShowHideNumFun(button, nil, true)
    end,
    ACTIONBAR_HIDEGRID = function(button, arg1, arg2, arg3)
    	if button.ModeSet=="cons" then return end
        if InCombatLockdown() then
            button.always_show = true
        else
            ShowHideNumFun(button)
        end
    end,
    CVAR_UPDATE = function(button, cvarName, value, ...)
    	if button.ModeSet=="cons" then return end
        if cvarName == "ActionButtonUseKeyDown" then
            PIGUseKeyDown(button)
        elseif cvarName == "alwaysShowActionBars" then
            if InCombatLockdown() then
                button.always_show = true
            else
                ShowHideNumFun(button, value)
            end
        end
    end,
    UNIT_PET = function(button, ...)
    end,
    MOUNT_JOURNAL_USABILITY_CHANGED = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_bukeyong(button)
    end,
    TRADE_SKILL_CLOSE = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_State(button)
        Update_Icon(button)
    end,
    CRAFT_CLOSE = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_State(button)
        Update_Icon(button)
    end,
    EXECUTE_CHAT_LINE = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_State(button)
        Update_Icon(button)
    end,
    PLAYER_UPDATE_RESTING = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_bukeyong(button)
    end,
    EQUIPMENT_SETS_CHANGED = function(button, ...)
    	if button.ModeSet=="cons" then return end
        Update_Equipment(button)
    end,
    UPDATE_MACROS = function(button, ...)
        if button.ModeSet=="cons" then return end
        PigMacroEventCount = PigMacroEventCount + 1
        if button.Type == "macro" then
            if PigMacroEventCount > 5 then
                local AccMacros, CharMacros = GetNumMacros()
                if PigMacroCount == 0 then
                    PigMacroCount = AccMacros + CharMacros
                elseif PigMacroCount > AccMacros + CharMacros then
                    PigMacroDeleted = true
                end
                PigMacroDeleted, PigMacroCount = Update_Macro(button, PigMacroDeleted, PigMacroCount, "PigAction")
            end
        end
        Update_Icon(button)
        Update_Count(button)
        Update_State(button)
    end,

    PLAYER_ENTERING_WORLD = function(button, ...)
    	if button.ModeSet~="cons" then 
            if button.Type == "macro" then
                Update_Macro(button, PigMacroDeleted, PigMacroCount, "PigAction")
            end
        end
        Update_Icon(button)
        Update_Count(button)
        Update_State(button)
    end,
    PLAYER_REGEN_ENABLED = function(button, ...)
        Update_bukeyong(button)
        if button.ModeSet~="cons" then 
	        Update_Equipment(button)
	        ShowHideNumFun(button)
	    end
        button.always_show = nil
    end,
    PLAYER_REGEN_DISABLED = function(button, ...)
        Update_bukeyong(button)
    end,
    ACTIONBAR_UPDATE_USABLE = function(button, ...)
        Update_bukeyong(button)
    end,
    ACTIONBAR_UPDATE_STATE = function(button, ...)
        Update_State(button)
        Update_Icon(button)
    end,
    ACTIONBAR_UPDATE_COOLDOWN = function(button, ...)
        Update_Cooldown(button)
        Update_bukeyong(button)
        Update_Icon(button)
    end,
    BAG_UPDATE = function(button, ...)
        Update_Count(button)
        Update_bukeyong(button)
    end,
    UNIT_AURA = function(button, unit, ...)
        Update_State(button)
        Update_Icon(button)
    end,
}
-------
local function ADD_ActionBar(barName,CFdata,anniugeshu, anniujiange,tabF,tabBut,RTabFrame,plusF,plusTabBut)
	local NewIndex,cfOpen,cfScale,cfLock,cfAnniuNum,cfShowTJ,cfPailie,ModeFun=unpack(CFdata)
	if not cfOpen then return end
	if _G[barName] then return end
	Data.UILayout[barName]={"CENTER","CENTER",-200,-200+NewIndex*50}
	local Pig_bar=PIGFrame(UIParent,nil,{0.01,ActionW-4},barName)
	-- Pig_bar:SetAttribute("type", "actionbar");
	-- Pig_bar:SetAttribute("actionbar", NewIndex+100);
	Create.PIG_SetPoint(barName)
	Pig_bar:SetScale(cfScale);
	Pig_bar.yidong = PIGFrame(Pig_bar)
	Pig_bar.yidong:PIGSetBackdrop()
	Pig_bar.yidong:SetSize(12, ActionW-4)
	Pig_bar.yidong:SetPoint("LEFT",Pig_bar,"LEFT",0,0);
	Pig_bar.yidong.title = PIGFontString(Pig_bar.yidong,nil,NewIndex,"OUTLINE",12)
	Pig_bar.yidong.title:SetAllPoints(Pig_bar.yidong)
	Pig_bar.yidong.title:SetTextColor(1, 1, 0.1, 1)
	if ModeFun then
		Pig_bar.yidong:PIGSetMovable(Pig_bar,nil,nil,true)
	else
		Pig_bar.yidong:PIGSetMovable(Pig_bar,nil,true,true)
	end
	Pig_bar.yidong:SetScript("OnEnter", function (self)
		self:SetBackdropBorderColor(0,0.8,1, 0.9);
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine(KEY_BUTTON1.."-|cff00FFff"..TUTORIAL_TITLE2.."|r\n"..KEY_BUTTON2.."-|cff00FFff"..SETTINGS.."|r")	
		GameTooltip:Show();
	end);
	Pig_bar.yidong:SetScript("OnLeave", function (self)
		self:SetBackdropBorderColor(0, 0, 0, 1);
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end)
	if cfLock then Pig_bar.yidong:Hide() end
	Pig_bar.yidong:SetScript("OnMouseUp", function (self,Button)
		if Button=="RightButton" then
			if PIG_OptionsUI:IsShown() then
				PIG_OptionsUI:Hide()
			else
				PIG_OptionsUI:Show()
				Create.Show_TabBut(tabF,tabBut)
				Create.Show_TabBut_R(RTabFrame,plusF,plusTabBut)
			end
		end
	end)
	if ModeFun then
		Pig_bar.butlist={}
	end
	-----
	for id=1,anniugeshu do
		--local piganniu = CreateFrame("CheckButton", "$parent_But"..id, Pig_bar, "ActionButtonTemplate",0)
		local piganniu = CreateFrame("CheckButton", "$parent_But"..id, Pig_bar, "SecureActionButtonTemplate,ActionButtonTemplate,SecureHandlerDragTemplate,SecureHandlerMouseUpDownTemplate,SecureHandlerStateTemplate,SecureHandlerBaseTemplate")
		piganniu:SetSize(ActionW, ActionW)
		piganniu.NormalTexture:SetAlpha(0.4);
		piganniu.cooldown:SetSwipeColor(0, 0, 0, 0.8);
		if id==1 then
			piganniu:SetPoint("LEFT",Pig_bar.yidong,"RIGHT",2,0)
		else
			PailieFun(barName,id,anniujiange,cfPailie)
		end
		piganniu.BGtex = piganniu:CreateTexture(nil, "BACKGROUND", nil, -1);
		piganniu.BGtex:SetTexture("Interface/Buttons/UI-Quickslot");
		piganniu.BGtex:SetAlpha(0.4);
		piganniu.BGtex:SetPoint("TOPLEFT", -15, 15);
		piganniu.BGtex:SetPoint("BOTTOMRIGHT", 15, -15);
	 	if NewIndex==1 then 
	 		local ActionID = 500+id
	 		piganniu.action=ActionID
			piganniu:SetAttribute("action", ActionID)
		else
			local ActionID = 500+(NewIndex-1)*12+id
			piganniu.action=ActionID
			piganniu:SetAttribute("action", ActionID)
		end
		piganniu.ID=id
	 	-- piganniu:SetAttribute("checkfocuscast", true);--使用系统焦点施法按键
	 	-- piganniu:SetAttribute("checkselfcast", true);--可以使用自我施法按键
	 	-- piganniu.flashing = 0;
	 	-- piganniu.flashtime = 0;
	 	PIGActionBarActionEventsFrame.frames[piganniu] = piganniu;
		piganniu:SetScript("OnEvent", PIGActionButton_OnEvent);
		---
		PIGUseKeyDown(piganniu)
		piganniu:HookScript("PostClick", function(self)
			Update_PostClick(self)
		end)
		----
		piganniu:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip_SetDefaultAnchor(GameTooltip, self)
			Update_OnEnter(self)
		end)
		piganniu:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		--------------------
		if ModeFun then 
			Pig_bar.butlist[id]=piganniu
			piganniu.ModeSet=ModeFun
		else
			function piganniu:SetAnniuNumFun(max,all)
				local max=max or cfAnniuNum
				local id=self.ID
				if id>max then
					self:Hide()
					return
				end
				self:Show()
			end
			piganniu:SetAnniuNumFun()
			loadingButInfo(piganniu,"PigAction")
			---
			piganniu:HookScript("OnMouseUp", function (self)
				Cursor_Fun(self,"OnMouseUp","PigAction")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
				Update_bukeyong(self)
			end);
			----
			piganniu:HookScript("OnDragStart", function (self)
				if InCombatLockdown() then return end
				local lockvalue = GetCVar("lockActionBars")
				if lockvalue=="0" then
					self:SetAttribute("type", nil)
					Cursor_Fun(self,"OnDragStart","PigAction")
					Update_Icon(self)
					Update_Cooldown(self)
					Update_Count(self)
					Update_State(self)
				elseif lockvalue=="1" then
					if IsShiftKeyDown() then
						self:SetAttribute("type", nil)
						Cursor_Fun(self,"OnDragStart","PigAction")
						Update_Icon(self)
						Update_Cooldown(self)
						Update_Count(self)
						Update_State(self)
					end
				end
			end)
			----
			piganniu:SetAttribute("_onreceivedrag",[=[
				local leibie, spellID = ...
				if kind=="spell" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, spellID)
				elseif kind=="item" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, leibie)
				elseif kind=="macro" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, value)
				end
			]=])
			piganniu:HookScript("OnReceiveDrag", function (self)
				Cursor_Fun(self,"OnReceiveDrag","PigAction")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
				Update_bukeyong(self)
			end);
			ShowHideEvent(piganniu,cfShowTJ)
			piganniu:SetAttribute("_onstate-combatYN","if newstate == 'show' then self:Show(); else self:Hide(); end")
		end
	end
	return Pig_bar
end
ActionBarfun.ADD_ActionBar=ADD_ActionBar