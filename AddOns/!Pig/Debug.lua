local _, addonTable = ...;
local L=addonTable.locale
local floor =floor
local Fun=addonTable.Fun
----------
local Create=addonTable.Create
local PIGEnter=Create.PIGEnter
local PIGFrame=Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGCheckbutton=Create.PIGCheckbutton
local PIGOptionsList=Create.PIGOptionsList
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
--
local fuFrame = PIGOptionsList(L["DEBUG_TABNAME"],"BOT")
--------------------------------
fuFrame.errorUI = PIGButton(fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT",20,-20},{120,24},L["DEBUG_ERRORLOG"])
fuFrame.errorUI:SetScript("OnClick", function (self)
	Pig_OptionsUI:Hide()
	Bugcollect_UI:Show()
end);
--
fuFrame.tishi =PIGFontString(fuFrame,{"LEFT", fuFrame.errorUI, "RIGHT", 10, 0},L["DEBUG_OPENERRORLOGCMD"].."/per")
fuFrame.tishi:SetTextColor(1, 1, 0, 1);
---------
fuFrame.ErrCB=PIGCheckbutton(fuFrame,{"LEFT",fuFrame.errorUI,"RIGHT", 200, 0},{SHOW_LUA_ERRORS,L["DEBUG_SCRIPTTOOLTIP"]})
fuFrame.ErrCB:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("scriptErrors", "1")
	else
		SetCVar("scriptErrors", "0")
	end
end);
---
local taintlist = {"0","1","2","11"}
local taintlistmenu = {["0"]=L["DEBUG_TAINT0"],["1"]=L["DEBUG_TAINT1"],
	["2"]=L["DEBUG_TAINT2"],["11"]=L["DEBUG_TAINT11"],
}
fuFrame.taintLog=PIGDownMenu(fuFrame,{"TOPLEFT",fuFrame.errorUI,"BOTTOMLEFT",60,-40},{400,24})
fuFrame.taintLog.tishi=PIGFontString(fuFrame.taintLog,{"RIGHT", fuFrame.taintLog, "LEFT", 0, 0},L["DEBUG_TAINTLOG"])
fuFrame.taintLog.tishi:SetTextColor(1, 1, 0, 1);
function fuFrame.taintLog:PIGDownMenu_Update_But()
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#taintlist,1 do
	    info.text, info.arg1 = taintlistmenu[taintlist[i]], taintlist[i]
	    info.checked = taintlist[i]==GetCVar("taintLog")
		self:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.taintLog:PIGDownMenu_SetValue(value,arg1,arg2)
	self:PIGDownMenu_SetText(value)
	SetCVar("taintLog", arg1)
	PIGCloseDropDownMenus()
end
--內存CPU监控
fuFrame.OPENJK = PIGButton(fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT",20,-200},{150,24},L["DEBUG_BUTNAME"])
fuFrame.OPENJK:SetScript("OnClick", function (self)
	Pig_OptionsUI:Hide()
	PIGAddOnMemoryCPU_UI:Show()
end);

local PIGAddOnMemoryCPU=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{360,494},"PIGAddOnMemoryCPU_UI")
PIGAddOnMemoryCPU:PIGSetBackdrop()
PIGAddOnMemoryCPU:PIGSetMovable()
PIGAddOnMemoryCPU:PIGClose()
PIGAddOnMemoryCPU:Hide()
PIGAddOnMemoryCPU.biaoti=PIGFontString(PIGAddOnMemoryCPU,{"TOP", PIGAddOnMemoryCPU, "TOP", 0, -2},L["DEBUG_BUTNAME"])
PIGAddOnMemoryCPU.NR=PIGFrame(PIGAddOnMemoryCPU)
PIGAddOnMemoryCPU.NR:SetPoint("TOPLEFT", PIGAddOnMemoryCPU, "TOPLEFT", 0, -20)
PIGAddOnMemoryCPU.NR:SetPoint("BOTTOMRIGHT", PIGAddOnMemoryCPU, "BOTTOMRIGHT", 0, 0)
PIGAddOnMemoryCPU.NR:PIGSetBackdrop(0)
PIGAddOnMemoryCPU.NR.autoRefresh=PIGCheckbutton(PIGAddOnMemoryCPU.NR,{"TOPLEFT",PIGAddOnMemoryCPU.NR,"TOPLEFT",6,-4},{SELF_CAST_AUTO..REFRESH,SELF_CAST_AUTO..REFRESH})
PIGAddOnMemoryCPU.NR.autoRefresh:SetScale(0.88)
PIGAddOnMemoryCPU.jishiqi=0
PIGAddOnMemoryCPU.NR.autoRefresh:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGAddOnMemoryCPU:SetScript("OnUpdate", function (self,sss)
			if self.jishiqi>1 then
				self.jishiqi=0
				self.Update_List(self.NR.List.Scroll)
			else
				self.jishiqi = self.jishiqi + sss;
			end
		end);
	else
		PIGAddOnMemoryCPU:SetScript("OnUpdate", nil);
	end
end);
PIGAddOnMemoryCPU.NR.CPU_OPEN=PIGCheckbutton(PIGAddOnMemoryCPU.NR,{"LEFT",PIGAddOnMemoryCPU.NR.autoRefresh.Text,"RIGHT",10,0},{"|cffFF0000"..L["DEBUG_CPUUSAGE"].."|r",L["DEBUG_CPUUSAGETIPS"]})
PIGAddOnMemoryCPU.NR.CPU_OPEN:SetScale(0.88)
PIGAddOnMemoryCPU.NR.CPU_OPEN:SetScript("OnClick", function (self)
	if self:GetChecked() then
		SetCVar("scriptProfile", "1")
	else
		SetCVar("scriptProfile", "0")
	end
	ReloadUI();
end);

PIGAddOnMemoryCPU.NR.CZ = PIGButton(PIGAddOnMemoryCPU.NR,{"LEFT",PIGAddOnMemoryCPU.NR.CPU_OPEN.Text,"RIGHT",20,0},{50,18},RESET)
PIGAddOnMemoryCPU.NR.CZ:SetScript("OnClick", function (self)
	ResetCPUUsage()
	-- debugprofilestart()
	-- debugprofilestop()
	PIGAddOnMemoryCPU.Update_List(PIGAddOnMemoryCPU.NR.List.Scroll)
end);
PIGAddOnMemoryCPU.NR.COLLECT = PIGButton(PIGAddOnMemoryCPU.NR,{"LEFT",PIGAddOnMemoryCPU.NR.CZ,"RIGHT",20,0},{50,18},L["DEBUG_COLLECT"])
--PIGAddOnMemoryCPU.NR.COLLECT:Disable()
PIGAddOnMemoryCPU.NR.COLLECT:SetMotionScriptsWhileDisabled(true)
PIGEnter(PIGAddOnMemoryCPU.NR.COLLECT,L["LIB_TIPS"]..": ",L["DEBUG_COLLECTTIPS"]);
PIGAddOnMemoryCPU.NR.COLLECT:SetScript("OnClick", function (self)
	collectgarbage()--回收内存
	PIGAddOnMemoryCPU.Update_List(PIGAddOnMemoryCPU.NR.List.Scroll)
end);
PIGAddOnMemoryCPU.NR.List=PIGFrame(PIGAddOnMemoryCPU.NR)
PIGAddOnMemoryCPU.NR.List:SetPoint("TOPLEFT", PIGAddOnMemoryCPU.NR, "TOPLEFT", 0, -22)
PIGAddOnMemoryCPU.NR.List:SetPoint("BOTTOMRIGHT", PIGAddOnMemoryCPU.NR, "BOTTOMRIGHT", 0, 0)
PIGAddOnMemoryCPU.NR.List:PIGSetBackdrop(0)
-- 
local nrww = PIGAddOnMemoryCPU.NR.List:GetWidth()
PIGAddOnMemoryCPU.sort=21--排序
local hang_Height,hang_NUM  = 22, 18;
PIGAddOnMemoryCPU.NR.List.tet1=PIGFontStringBG(PIGAddOnMemoryCPU.NR.List,{"TOPLEFT", PIGAddOnMemoryCPU.NR.List, "TOPLEFT", 0,-1},L["DEBUG_ADD"],{nrww*0.5,22})
PIGAddOnMemoryCPU.NR.List.tet2 = PIGButton(PIGAddOnMemoryCPU.NR.List,{"LEFT", PIGAddOnMemoryCPU.NR.List.tet1, "RIGHT", 0,0},{nrww*0.25,22},L["DEBUG_MEMORY"].."(k)")
PIGAddOnMemoryCPU.NR.List.tet2:PIGSetBackdrop(0.4, 0.2)
PIGAddOnMemoryCPU.NR.List.tet2:SetScript("OnClick", function ()
	PIGAddOnMemoryCPU.sort=21
	PIGAddOnMemoryCPU.Update_List(PIGAddOnMemoryCPU.NR.List.Scroll)
end);
PIGAddOnMemoryCPU.NR.List.tet3 = PIGButton(PIGAddOnMemoryCPU.NR.List,{"LEFT", PIGAddOnMemoryCPU.NR.List.tet2, "RIGHT", 0,0},{nrww*0.25,22},"CPU(ms)")
PIGAddOnMemoryCPU.NR.List.tet3:PIGSetBackdrop(0.4, 0.2)
PIGAddOnMemoryCPU.NR.List.tet3:SetScript("OnClick", function ()
	if GetCVar("scriptProfile")=="1" then
		PIGAddOnMemoryCPU.sort=31
		PIGAddOnMemoryCPU.Update_List(PIGAddOnMemoryCPU.NR.List.Scroll)
	end
end);
PIGAddOnMemoryCPU.NR.List.buttet1=PIGFontStringBG(PIGAddOnMemoryCPU.NR.List,{"BOTTOMLEFT", PIGAddOnMemoryCPU.NR.List, "BOTTOMLEFT", 0,1},"",{nrww*0.5,22})
PIGAddOnMemoryCPU.NR.List.buttet2=PIGFontStringBG(PIGAddOnMemoryCPU.NR.List,{"LEFT", PIGAddOnMemoryCPU.NR.List.buttet1, "RIGHT", 0,0},"",{nrww*0.25,22})
PIGAddOnMemoryCPU.NR.List.buttet3=PIGFontStringBG(PIGAddOnMemoryCPU.NR.List,{"LEFT", PIGAddOnMemoryCPU.NR.List.buttet2, "RIGHT", 0,0},"",{nrww*0.25,22})

PIGAddOnMemoryCPU.NR.List.Scroll = CreateFrame("ScrollFrame",nil,PIGAddOnMemoryCPU.NR.List, "FauxScrollFrameTemplate");  
PIGAddOnMemoryCPU.NR.List.Scroll:SetPoint("TOPLEFT",PIGAddOnMemoryCPU.NR.List,"TOPLEFT",0,-24);
PIGAddOnMemoryCPU.NR.List.Scroll:SetPoint("BOTTOMRIGHT",PIGAddOnMemoryCPU.NR.List,"BOTTOMRIGHT",-20,23);
PIGAddOnMemoryCPU.NR.List.Scroll.ScrollBar:SetScale(0.8)
PIGAddOnMemoryCPU.NR.List.Scroll:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, PIGAddOnMemoryCPU.Update_List)
end)
PIGAddOnMemoryCPU.butlist={}
for id = 1, hang_NUM do
	local hang = CreateFrame("Frame", nil, PIGAddOnMemoryCPU.NR.List);
	PIGAddOnMemoryCPU.butlist[id]=hang
	hang:SetSize(nrww-20, hang_Height);
	if id==1 then
		hang:SetPoint("TOP",PIGAddOnMemoryCPU.NR.List.Scroll,"TOP",0,0);
	else
		hang:SetPoint("TOP",PIGAddOnMemoryCPU.butlist[id-1],"BOTTOM",0,0);
	end
	hang.tet1 = PIGFontString(hang,{"LEFT", hang, "LEFT", 2,0},"","OUTLINE")
	hang.tet1:SetSize(nrww*0.5-2,hang_Height)
	hang.tet1:SetJustifyH("LEFT")
	hang.tet1:SetTextColor(1, 1, 1, 0.9); 
	hang.tet2 = PIGFontString(hang,{"LEFT", hang.tet1, "RIGHT", 2,0},"","OUTLINE")
	hang.tet2:SetSize(nrww*0.25-6,hang_Height)
	hang.tet2:SetJustifyH("RIGHT")
	hang.tet2:SetTextColor(1, 1, 1, 0.9); 
	hang.tet3 = PIGFontString(hang,{"LEFT", hang.tet2, "RIGHT", 2,0},"","OUTLINE")
	hang.tet3:SetSize(nrww*0.25-20,hang_Height)
	hang.tet3:SetJustifyH("RIGHT")
	hang.tet3:SetTextColor(1, 1, 1, 0.9); 
end
local GetNumAddOns=GetNumAddOns or C_AddOns.GetNumAddOns and C_AddOns.GetNumAddOns
function PIGAddOnMemoryCPU.Update_List(self)
	local MemoryCPUData = {
		["NumAddOns"]=GetNumAddOns(),
		["NumMemory"]=0,
		["NumCPU"]=0,
		["DATA"]={},
	}
	UpdateAddOnMemoryUsage()
	UpdateAddOnCPUUsage()
	for id=1,MemoryCPUData.NumAddOns do	
		local name, title, notes, loadable=PIGGetAddOnInfo(id)
		if loadable then
			local Memory=GetAddOnMemoryUsage(id)
			local CPUUsage=GetAddOnCPUUsage(id)
			MemoryCPUData.NumMemory=MemoryCPUData.NumMemory+Memory
			MemoryCPUData.NumCPU=MemoryCPUData.NumCPU+CPUUsage
			table.insert(MemoryCPUData.DATA,{name,Memory,CPUUsage})
		end
	end
	for id=1,hang_NUM do
		PIGAddOnMemoryCPU.butlist[id]:Hide()
	end
	if PIGAddOnMemoryCPU.sort==21 then
		table.sort(MemoryCPUData.DATA,function(a,b)
			return a[2]>b[2]
		end)
	elseif PIGAddOnMemoryCPU.sort==31 then
		table.sort(MemoryCPUData.DATA,function(a,b)
			return a[3]>b[3]
		end)
	end
	local hejilist = #MemoryCPUData.DATA
	FauxScrollFrame_Update(self, hejilist, hang_NUM, hang_Height);
	local offset = FauxScrollFrame_GetOffset(self);
	for id = 1, hang_NUM do
		local newID = id+offset
		if MemoryCPUData.DATA[newID] then
			local tetf = PIGAddOnMemoryCPU.butlist[id]
			tetf:Show()
			tetf.tet1:SetText(MemoryCPUData.DATA[newID][1]);
			tetf.tet2:SetText(floor(MemoryCPUData.DATA[newID][2]));
			tetf.tet3:SetText(floor(MemoryCPUData.DATA[newID][3]*100)*0.01);
		end
	end
	PIGAddOnMemoryCPU.NR.List.buttet1:SetText(hejilist.."/"..MemoryCPUData.NumAddOns);
	PIGAddOnMemoryCPU.NR.List.buttet2:SetText(floor(MemoryCPUData.NumMemory).."k");
	PIGAddOnMemoryCPU.NR.List.buttet3:SetText(floor(MemoryCPUData.NumCPU).."ms");
end
PIGAddOnMemoryCPU:HookScript("OnShow", function (self)
	if GetCVar("scriptProfile")=="1" then
		PIGAddOnMemoryCPU.NR.CPU_OPEN:SetChecked(true)
	else
		PIGAddOnMemoryCPU.NR.CPU_OPEN:SetChecked(false)
	end
	self.Update_List(self.NR.List.Scroll)
end);
if GetCVar("scriptProfile")=="1" then
	PIGAddOnMemoryCPU:Show()
	local masg = "你开启了CPU性能分析，请在测试后关闭此选项"
	UIErrorsFrame:AddMessage(masg, 1, 1, 0, 1.0);
	PIG_print(masg)
end

--获取NPC物品
fuFrame.NPCID = PIGButton(fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT",20,-350},{125,24},L["DEBUG_GETGUIDBUT"])
fuFrame.NPCID:SetScript("OnClick", function (self)
	print(UnitGUID("target"))
end);
fuFrame.GetItem = PIGButton(fuFrame,{"LEFT",fuFrame.NPCID,"RIGHT",300,0},{110,24},"获取物品信息")
fuFrame.GetItem:SetScript("OnClick", function (self,button)
	if button=="LeftButton" then
		--local itemName,itemLink = GetItemInfo(self.E:GetNumber())
		print(GetItemInfo(self.E:GetText()))
		-- print(string.gsub(itemLink,"|","||"))
		-- local itemLink=Fun.GetItemLinkJJ(itemLink)
		-- print(itemLink)
		-- local itemLink=Fun.HY_ItemLinkJJ(itemLink)
		-- print(itemLink)
	else
		print(PIGGetSpellInfo(self.E:GetText()))
	end
end);
fuFrame.GetItem.E = CreateFrame("EditBox", nil, fuFrame.GetItem, "InputBoxInstructionsTemplate");
fuFrame.GetItem.E:SetSize(200,24);
fuFrame.GetItem.E:SetPoint("RIGHT",fuFrame.GetItem,"LEFT",-4,0);
fuFrame.GetItem.E:SetFontObject(ChatFontNormal);
fuFrame.GetItem.E:SetAutoFocus(false);--自动获得焦点
-----------------
fuFrame:SetScript("OnShow", function()
	if GetCVar("scriptErrors")=="1" then
		fuFrame.ErrCB:SetChecked(true)
	end
	fuFrame.taintLog:PIGDownMenu_SetText(taintlistmenu[GetCVar("taintLog")])
end);
---创建常用3宏
local hongNameList = {["RL"]={"/Reload",132096},["FST"]={"/fstack",132089},["EVE"]={"/eventtrace",132092}}
fuFrame.New_hong = PIGButton(fuFrame,{"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",20,20},{100,24},"ADD_FWR")
fuFrame.New_hong:SetScript("OnClick", function ()
	for k,v in pairs(hongNameList) do
		local macroSlot = GetMacroIndexByName(k)
		if macroSlot>0 then
			EditMacro(macroSlot, nil, v[2], v[1])
		else
			local global, perChar = GetNumMacros()
			if global<120 then
				CreateMacro(k, v[2], v[1], nil)
			else
				PIGTopMsg:add(L["LIB_MACROERR"]);
			end
		end
	end
end)
---调试配置
fuFrame.tiaoshipeizhi = PIGButton(fuFrame,{"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",220,20},{100,24},L["DEBUG_CONFIG"])
fuFrame.tiaoshipeizhi:SetScript("OnClick", function ()
	StaticPopup_Show("TIAOSHIPEIZHIQIYONG",L["DEBUG_CONFIG"]);
end)
local function zairutiaoshiFUN()
	PIGA=addonTable.Default;
	Fun.Set_ConfigValue(PIGA,false,0)
	PIGA_Per=addonTable.Default_Per;
	Fun.Set_ConfigValue(PIGA_Per,false,0)
	Pig_Options_RLtishi_UI:Show()
end
StaticPopupDialogs["TIAOSHIPEIZHIQIYONG"] = {
	text = L["CONFIG_LOADTIPS"].."\n"..L["DEBUG_CONFIGTIPS"],
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		zairutiaoshiFUN()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
fuFrame.zhuanma = PIGButton(fuFrame,{"BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0},{16,16},"64")
fuFrame.zhuanma:SetScript("OnClick", function (self)
	ExportImport_UI:Show_HideFun()
end)