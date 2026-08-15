local addonName, PD = ...;
local L=PD.locale
local Data=PD.Data
local Fun = PD.Fun
---
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGCheckbutton=Create.PIGCheckbutton
local PIGFontString=Create.PIGFontString
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGOptionsList_RF=Create.PIGOptionsList_RF
---
local PigConfigFun={}
PD.PigConfigFun=PigConfigFun

function PD.addOptions_Config()
	local fuFrame,fuFrameBut = PIGOptionsList(L["CONFIG_TABNAME"],"TOP")
	PigConfigFun.fuFrame=fuFrame
	PigConfigFun.fuFrameBut=fuFrameBut
	--
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,L["CONFIG_DAOCHU"]..L["CONFIG_DAORU"],90)
	fujiF:Show()
	fujiBut:Selected(true)
	--------
	local cfbutW=fujiF:GetWidth()-20
	local DefaultF=PIGFrame(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-10},{cfbutW,60})
	DefaultF:PIGSetBackdrop(0.4)
	DefaultF.button = PIGButton(DefaultF,{"LEFT",DefaultF,"LEFT",10,0},{120,24},DEFAULTS)
	DefaultF.title = PIGFontString(DefaultF,{"LEFT", DefaultF.button, "RIGHT", 6, 0},L["CONFIG_ERRTIPS"])
	DefaultF.title:SetTextColor(0, 1, 0, 1);
	DefaultF.title:SetJustifyH("LEFT");
	DefaultF.title:SetWidth(cfbutW-120);
	DefaultF.button:SetScript("OnClick", function ()
		StaticPopup_Show("PIG_CONFIG_ZAIRUQUEREN",DEFAULTS,nil,{"Default",DEFAULTS});
	end);
	StaticPopupDialogs["PIG_CONFIG_ZAIRUQUEREN"] = {
		text = L["CONFIG_LOADTIPS"],
		button1 = YES,
		button2 = NO,
		OnAccept = function(self,arg1)
			if PD[arg1[1]] then
				PIGA=PD[arg1[1]];
				PIGA_Per=PD[arg1[1].."_Per"];
				--if DefaultF.ResetExtConfig then DefaultF.ResetExtConfig() end
				ReloadUI()
			else
				PIGErrorMsg(string.format(ERR_ARENA_TEAM_PLAYER_NOT_FOUND_S,arg1[2]),"R")
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}

	--导入/导出-------------------
	--导入------
	local function Load_ImportTxt1(old, new)
		for k,v in pairs(old) do
			if type(v)=="table" then
				if not new[k] then new[k]=CopyTable(v) end
				Load_ImportTxt1(v, new[k])
			else
				new[k]=v
			end
		end
	end
	local function Load_ImportTxt(config, config_Per)
		Load_ImportTxt1(config, PIGA)
		Load_ImportTxt1(config_Per, PIGA_Per)
	end
	DefaultF.daorubut = PIGButton(DefaultF,{"TOPLEFT",DefaultF,"TOPLEFT",10, -200},{90,24},L["CONFIG_DAORU"]..L["CONFIG_TABNAME"])
	DefaultF.daorubut:SetScript("OnClick", function ()
		Fun.Config_RU("Config",function(config, config_Per)
			Load_ImportTxt(config, config_Per)
		end)
	end);

	--导出-------
	local ConfigUIList={"PlayerFrame","TargetFrame","FocusFrame",}--如果选择则导出头像位置
	local function Get_ExtData(newdata)--动作条开启/头像位置
		if DefaultF.I_ActionBar:GetChecked() then
			newdata["Config_ActionBar"] = {GetActionBarToggles()}
		else
			newdata["Config_ActionBar"]=nil
		end
		if DefaultF.I_UnitF and DefaultF.I_UnitF:GetChecked() then--获取头像位置信息
			for _,name in pairs(ConfigUIList) do
		    	local uiname = _G[name]
		    	if uiname then
		    		newdata["Config_Unit"]=newdata["Config_Unit"] or {}
		    		if uiname:IsUserPlaced() then
			        	local point, relativePoint, offsetX, offsetY = PIGGetPoint(uiname)
			        	if point then
			       			newdata["Config_Unit"][name]={point, relativePoint, offsetX, offsetY}
			       		end
			       	else
			       		newdata["Config_Unit"][name]=nil
			       	end
			    end
			end
			if next(newdata["Config_Unit"])==nil then newdata["Config_Unit"]=nil end
		else
			newdata["Config_Unit"]=nil
		end
	end
	-- local function Remove_Data(newdata,Per)--剔除数据类配置
	-- 	if Per then
	-- 		newdata["AutoSellBuy"]["Buy_List"]=nil
	-- 		newdata["AutoSellBuy"]["Save_List"]=nil
	-- 		newdata["AutoSellBuy"]["Take_List"]=nil
	-- 		--
	-- 		newdata["PigAction"]["ActionData"]=nil
	-- 		newdata["QuickBut"]["ActionData"]=nil
	-- 		newdata["QuickBut"]["EquipList"]=nil
	-- 		newdata["QuickBut"]["TrinketList"]=nil
	-- 		--
	-- 		newdata["CombatPlus"]["PetFoodList"]=nil
	-- 		--
	-- 		newdata["Farm"]=nil
	-- 		-- if PIGIsAddOnLoaded("!Pig_Farm") then
	-- 		-- 	newdata["Farm"]["Fuben_G"]=nil
	-- 		-- 	newdata["Farm"]["Auto_KeyList"]=nil
	-- 		-- 	newdata["Farm"]["Namelist"]=nil
	-- 		-- 	newdata["Farm"]["Timelist"]=nil
	-- 		-- end
	-- 	else
	-- 		--非必要信息
	-- 		newdata["VerC"]=nil
	-- 		newdata["Error"]["ErrorDB"]=nil
	-- 		newdata["ActionBarEnabled"]=nil
	-- 		--
	-- 		newdata["Hardcore"]["Deaths"]["Player"]=nil
	-- 		newdata["Hardcore"]["Deaths"]["List"]=nil
	-- 		--信息统计
	-- 		newdata["StatsInfo"]["Players"]=nil
	-- 		newdata["StatsInfo"]["PlayerSH"]=nil
	-- 		newdata["StatsInfo"]["FBCDRecords"]=nil
	-- 		newdata["StatsInfo"]["SkillData"]=nil
	-- 		newdata["StatsInfo"]["Times"]=nil
	-- 		newdata["StatsInfo"]["Token"]=nil
	-- 		newdata["StatsInfo"]["Items"]=nil
	-- 		newdata["StatsInfo"]["TradeData"]=nil
	-- 		newdata["StatsInfo"]["Played"]=nil
	-- 		--邮箱
	-- 		newdata["MailPlus"]["Coll"]=nil
	-- 		--售卖助手
	-- 		newdata["AutoSellBuy"]["Diuqi_List"]=nil
	-- 		newdata["AutoSellBuy"]["Sell_List"]=nil
	-- 		newdata["AutoSellBuy"]["Sell_Lsit_Filtra"]=nil
	-- 		newdata["AutoSellBuy"]["Open_List"]=nil
	-- 		newdata["AutoSellBuy"]["Fen_List"]=nil
	-- 		newdata["AutoSellBuy"]["Xuan_List"]=nil
	-- 		--AH
	-- 		newdata["AHPlus"]["CacheData"]=nil
	-- 		newdata["AHPlus"]["Coll"]=nil
	-- 		--聊天
	-- 		newdata["Chat"]["Channel_List"]=nil
	-- 		newdata["Chat"]["Tiqu"]["KeysList"]=nil
	-- 		newdata["Chat"]["Filter"]["Ignore_P"]=nil
	-- 		newdata["Chat"]["Filter"]["Ignore_N"]=nil
	-- 		--聊天记录
	-- 		newdata["Chatjilu"]["WHISPER"]["record"]=nil
	-- 		newdata["Chatjilu"]["PARTY"]["record"]=nil
	-- 		newdata["Chatjilu"]["RAID"]["record"]=nil
	-- 		newdata["Chatjilu"]["GUILD"]["record"]=nil
	-- 		newdata["Chatjilu"]["INSTANCE_CHAT"]["record"]=nil
	-- 		--界面扩展
	-- 		newdata["FramePlus"]["AddonStatus"]=nil
	-- 		--扩展
	-- 		newdata["Tardis"]=nil
	-- 		newdata["GDKP"]=nil
	-- 		newdata["Farm"]=nil
	-- 		newdata["ConfigString"]=nil
	-- 		-- if PIGIsAddOnLoaded("!Pig_Tardis") then
	-- 		-- 	newdata["Tardis"]["Plane"]["InfoList"]=nil
	-- 		-- end
	-- 		-- if PIGIsAddOnLoaded("!Pig_GDKP") then
	-- 		-- 	newdata["GDKP"]["PaichuList"]=nil
	-- 		-- 	newdata["GDKP"]["ItemList"]=nil
	-- 		-- 	newdata["GDKP"]["History"]=nil
	-- 		-- 	newdata["GDKP"]["instanceName"]=nil
	-- 		-- end
	-- 	end
	-- end
	local specialPaths = {
        {false,"Chat", "QuickChat_ButHide"},
        {false,"PigLayout", "topMenu", "HideBut"},
        {false,"PigLayout", "topInfoL", "HideBut"},
        {false,"PigLayout", "topInfoR", "HideBut"},
        {false,"PigLayout", "MicroMenu", "HideBut"},
        {false,"Pig_UI"},
        {false,"Blizzard_UI"},
        --
        {true,"Pig_UI"},
    }
	local function GetNotnil(NewDataX,NewDataX_Per)--初始为nil的配置
		for _, path in ipairs(specialPaths) do
			local xieruD=path[1] and NewDataX_Per or NewDataX
			local laiyuanD=path[1] and PIGA_Per or PIGA
			if path[2] and path[3] and path[4] then
				if next(laiyuanD[path[2]][path[3]][path[4]]) ~= nil then
					xieruD[path[2]]=xieruD[path[2]] or {}
					xieruD[path[2]][path[3]]=xieruD[path[2]][path[3]] or {}
					xieruD[path[2]][path[3]][path[4]]=CopyTable(laiyuanD[path[2]][path[3]][path[4]])
				end
			elseif path[2] and path[3] then
				if next(laiyuanD[path[2]][path[3]]) ~= nil then
					xieruD[path[2]]=xieruD[path[2]] or {}
					xieruD[path[2]][path[3]]=CopyTable(laiyuanD[path[2]][path[3]])
				end
			elseif path[2] then
				if next(laiyuanD[path[2]]) ~= nil then
					xieruD[path[2]]=CopyTable(laiyuanD[path[2]])
				end
			end
		end
	end
	local function ExtractConfig_1(newData, Default, Local)
	    if type(Local) ~= "table" then return end
	    for k, v in pairs(Default) do
	        if type(v) == "table" then
	            if type(Local[k]) == "table" then
	                newData[k] = {}
	                ExtractConfig_1(newData[k], v, Local[k])
	                if next(newData[k]) == nil then newData[k] = nil end
	            end
	        else
	            if v ~= Local[k] then
	                newData[k] = Local[k]
	            end
	        end
	    end
	end
	local function ExtractConfig()
		local NewDataX = {}
		ExtractConfig_1(NewDataX,PD.Default,PIGA)
		NewDataX["Error"]=nil
		Get_ExtData(NewDataX)
		local NewDataX_Per={}
		ExtractConfig_1(NewDataX_Per,PD.Default_Per,PIGA_Per)
		GetNotnil(NewDataX,NewDataX_Per)
		-- for k,v in pairs(NewDataX) do
		-- 	--print(k,v)
		-- 	for k1,v1 in pairs(v) do
		-- 		print(k,k1,v1)
		-- 	end
		-- end
		-- for k,v in pairs(NewDataX_Per) do
		-- 	--print(k,v)
		-- 	for k1,v1 in pairs(v) do
		-- 		print(k,k1,v1)
		-- 	end
		-- end
		return NewDataX,NewDataX_Per
	end
	DefaultF.daochubut = PIGButton(DefaultF,{"TOPLEFT",DefaultF.daorubut,"BOTTOMLEFT",0, -20},{90,24},L["CONFIG_DAOCHU"]..L["CONFIG_TABNAME"])
	DefaultF.daochubut:SetScript("OnClick", function ()
		Fun.Config_CHU("Config",ExtractConfig())
	end);
	DefaultF.I_ActionBar=PIGCheckbutton(DefaultF,{"LEFT",DefaultF.daochubut,"RIGHT",20, 0},{"包含动作条启用状态","导出信息将包含系统各个动作条启用状态"})
	DefaultF.I_ActionBar:SetChecked(true)
	-- if PIG_MaxTocversion("old") then
	-- 	DefaultF.I_UnitF=PIGCheckbutton(DefaultF,{"TOPLEFT",DefaultF.I_ActionBar,"BOTTOMLEFT",0, -10},{"导出包含头像位置（自身/目标/焦点）","导出信息将包含头像位置数据"})
	-- 	DefaultF.I_UnitF:SetChecked(true)
	-- 	DefaultF.I_Chat=PIGCheckbutton(DefaultF,{"TOPLEFT",DefaultF.I_UnitF,"BOTTOMLEFT",0, -10},{"导出包含聊天栏设置","导出信息将包含聊天栏设置"})
	-- 	DefaultF.I_Chat:Disable();
	-- else
		DefaultF.I_EditMode=PIGCheckbutton(DefaultF,{"TOPLEFT",DefaultF.I_ActionBar,"BOTTOMLEFT",0, -10},{"导出编辑模式布局","导出当前编辑模式布局"})
		DefaultF.I_EditMode:Disable();
	--end
	DefaultF.I_Data=PIGCheckbutton(DefaultF,{"TOPLEFT",DefaultF.I_ActionBar,"BOTTOMLEFT",0, -110},{"导出包含数据(离线银行，聊天记录，售卖信息等)","注意这将导致字符串长度大大增加"})
	DefaultF.I_Data:Disable();
end