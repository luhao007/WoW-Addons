local addonName, PD = ...;
local Fun=PD.Fun
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
--------------
local function Set_ConfigValue(cfdata,bool,count)
	for k,v in pairs(cfdata) do
		if type(v)=="boolean" then
			if k~="MinimapBut" then
				cfdata[k] = bool
			end
		elseif type(v)=="table" then
			if count<4 then
				Set_ConfigValue(v,bool,count+1)
			end
		end
	end
end
local function Load_DefaultData(DqCF, moren, count, Per)
	if type(moren) ~= "table" then return end
	for k,v in pairs(moren) do
		if DqCF[k]==nil then
			DqCF[k] = moren[k]
		elseif DqCF[k]=="OFF" then
			DqCF[k]=false
		elseif type(v)=="table" then
			if type(DqCF[k])=="table" then
				if count<4 then
					Load_DefaultData(DqCF[k],v,count+1,Per)
				end
			else
				DqCF[k]=v
			end			
		end
	end
end
Fun.Set_ConfigValue=Set_ConfigValue
Fun.Load_DefaultData=Load_DefaultData
--删除废弃配置
local function Clear_FailureData()
	PIGA["xxxxxx"]=nil
	PIGA["Ver"]=nil
	PIGA["Error"]["ErrorInfo"]=nil
	PIGA["PigUI"]=nil
	PIGA["PigUIPoint"]=nil
	PIGA["WowUI"]=nil
	PIGA["BlizzardUI"]=nil
	PIGA["Other"]["Fast_Loot"]=nil
	PIGA["Map"]["MinimapPoint"] = nil

	PIGA["Interaction"]["Autoloot"]=nil
	PIGA["Common"]["AutoCVars"]=nil
	PIGA["Common"]["AutoLoot"]=nil
	PIGA["Common"]["FastLoot"]=nil
	PIGA["Common"]["SHAMAN_Color"]=nil

	PIGA["Chat"]["Frame"]=nil
	PIGA["Chat"]["Plus_chat"]=nil
	PIGA["Chat"]["QuickChat_ButList"]=nil
	PIGA["Chat"]["Tiqu"]["KeywordFShow"]=nil
	PIGA["Chat"]["Tiqu"]["Keys"]=nil
	PIGA["Chat"]["TiquKey"]=nil
	PIGA["Chat"]["Filter"]["Blacks_P"]=nil
	PIGA["Chat"]["Filter"]["Blacks"]=nil
	PIGA["Chatjilu"]["jiluinfo"]=nil
	PIGA["Chatjilu"]["tianshu"]=nil

	PIGA["ActionBar"]["HideShijiu"]=nil
	PIGA["ActionBar"]["BarRight"]=nil
	PIGA["ActionBar"]["ActionBar_bili_value"]=nil
	PIGA["ActionBar"]["ActionBar_bili"]=nil
	PIGA["BagBank"]["lixian"]=nil
	PIGA["BagBank"]["hulueBAG"]=nil
	PIGA["BagBank"]["hulueBANK"]=nil
	PIGA["BagBank"]["jiaoyiOpen"]=nil
	PIGA["BagBank"]["AHOpen"]=nil

	PIGA["StatsInfo"]["Skill_ExistCD"]=nil
	PIGA["StatsInfo"]["SkillCD"]=nil
	PIGA["StatsInfo"]["FubenCD"]=nil
	PIGA["StatsInfo"]["InstancesCD"]=nil
	PIGA["StatsInfo"]["AHOffline"]=nil
	PIGA["StatsInfo"]["AHData"]=nil
	PIGA["MailPlus"]["BagOpen"]=nil
			
	PIGA["AHPlus"]["Data"]=nil
	PIGA["AHPlus"]["RepeatQuery"]=nil
	PIGA["AHPlus"]["Time"]=nil
	PIGA["AHPlus"]["ScanCD"]=nil
	PIGA["AHPlus"]["ScanCD_M"]=nil
	PIGA["AHPlus"]["ScanTime"]=nil
	PIGA["AHPlus"]["Tokens"]=nil
	PIGA["AHPlus"]["DataList"]=nil
	PIGA["AHPlus"]["OfflineData"]=nil
	PIGA["AHPlus"]["BagOpen"]=nil
	PIGA["CombatPlus"]["topMenu"]=nil
	PIGA["CombatPlus"]["CombatTime"]=nil
	PIGA["CombatPlus"]["Biaoji"]=nil
	PIGA["UnitFrame"]["PlayerFrame"]["Plus"]=nil
	PIGA["UnitFrame"]["PlayerFrame"]["Loot"]=nil
	PIGA["QuickFollow"]=nil

	PIGA["FramePlus"]["Zhuizong"]=nil
	PIGA["FramePlus"]["Character_xiuliG"]=nil
	PIGA["FramePlus"]["yidongUI"]=nil
	PIGA["FramePlus"]["Character_Mingzhong"]=nil
	PIGA["FramePlus"]["Character_naijiu"]=nil
	PIGA["FramePlus"]["Character_ItemLevel"]=nil
	PIGA["FramePlus"]["Character_ItemColor"]=nil
	PIGA["FramePlus"]["AddonList"]=nil
	PIGA["FramePlus"]["AddonQuickBut"]=nil

	PIGA["Tooltip"]["SpellID"]=nil
	PIGA["QuickBut"]["Point"]=nil
	PIGA["QuickBut"]["AutoEquip"]=nil
	PIGA["QuickBut"]["TrinketMode"]=nil

	PIGA["PigLayout"]["TopBar"]["JG"]=nil
	--
	PIGA_Per["PigUI"]=nil
	PIGA_Per["AutoSellBuy"]["Diuqi_List"]=nil
	PIGA_Per["QuickFollow"]=nil
	PIGA_Per["Config_Unit"]=nil
	PIGA_Per["Config_ActionBar"]=nil
end
EventUtil.ContinueOnAddOnLoaded(addonName, function()
	PIGA = PIGA or PD.Default;
	PIGA_Per = PIGA_Per or PD.Default_Per;
	Load_DefaultData(PIGA,PD.Default, 0)
	Load_DefaultData(PIGA_Per,PD.Default_Per, 0, true)
	Clear_FailureData()
end)
--执行动作条开启配置
local ActionBarUI = CreateFrame("Frame")        
ActionBarUI:SetScript("OnEvent",function(self, event, arg1)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if PIGA["Config_ActionBar"] then
		local function SetActionBarToggle(index, value)
			SetActionBarToggles(unpack(PIGA["Config_ActionBar"]));
			MultiActionBar_Update();
		end
		for kw,vw in pairs(PIGA["Config_ActionBar"]) do
			SetActionBarToggle(kw,vw)
		end
		PIGA["Config_ActionBar"]=nil
	end
end)
--加载导入配置/外部插件的PIG配置
PD.ExtDB={}
PD.ExtConfig = function()
	if PIGA["Config_ActionBar"] then
		ActionBarUI:RegisterEvent("PLAYER_ENTERING_WORLD");
	end
	if PIGA["Config_Unit"] then
		local TopBarY = 0
		for name,data in pairs(PIGA["Config_Unit"]) do
			local point, relativePoint, offsetX, offsetY=unpack(data)
			if point and relativePoint and offsetX and offsetY then
				local uixx=_G[name]
				uixx:SetUserPlaced(false)
				uixx:ClearAllPoints();
				-- if PIGA["PigLayout"]["TopBar"]["Open"] then
				-- 	if relativePoint=="TOP" or relativePoint=="TOPLEFT" or relativePoint=="TOPRIGHT" then
				-- 		TopBarY=PIGA["PigLayout"]["TopBar"]["Height"]
				-- 	end
				-- end
				uixx:SetPoint(point, UIParent, relativePoint, offsetX, offsetY+TopBarY);
				uixx:SetUserPlaced(true)
			end
		end
		PIGA["Config_Unit"]=nil
	end
	-- for adname,adDB in pairs(PD.ExtDB) do
	-- 	PigConfigFun.fuFrameBut.Text:SetText(PigConfigFun.fuFrameBut.Text:GetText().."+|cff00FFFF("..adDB.TitleName..")|r")
	-- 	local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,adDB.TitleName,100)
	-- 	_G[Data.ExportImportUIname].ClickButFunX=LoadSameValue
	-- 	fujiF.tispext1 = PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-10})
	-- 	fujiF.tispext1:SetJustifyH("LEFT");
	-- 	local Title=PIGGetAddOnMetadata(adname, "Title")
	-- 	local VersionTXT=PIGGetAddOnMetadata(adname, "Version")
	-- 	fujiF.tispext1:SetText("检测到外部配置(来自|cff00FFFF<"..Title.."|r|cff00FF0Fv"..VersionTXT.."|r), 你的部分"..addonName.."配置将被接管")
	-- 	fujiF.tispext1:SetTextColor(1, 0.2, 0, 1);
	-- 	fujiF.tispext2 = PIGFontString(fujiF,{"TOPLEFT",fujiF.tispext1,"BOTTOMLEFT",0,-8},"外部配置载入状态:")
	-- 	fujiF.tispext2:SetJustifyH("LEFT");
	-- 	fujiF.tispext2:SetTextColor(1, 0.2, 0, 1);
	-- 	fujiF.tispext3 = PIGFontString(fujiF,{"LEFT",fujiF.tispext2,"RIGHT",0,0},"成功")
	-- 	fujiF.tispext3:SetTextColor(0, 1, 0, 1);
	-- 	fujiF.butRL = PIGButton(fujiF,{"LEFT",fujiF.tispext3,"RIGHT",4,0},{80,20},"重置设置")
	-- 	PIGEnter(fujiF.butRL,"如遇异常情况，请点此重置此作者配置\n注意只会重置被接管的那部分"..addonName.."设置")
	-- 	fujiF.butRL:SetScript("OnClick", function ()
	-- 		adDB.ResetConfig()
	-- 		ReloadUI()
	-- 	end);
	-- 	DefaultF.ResetExtConfig=adDB.ResetConfig
	-- 	fujiF.tabbot=PIGFrame(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",0,-72})
	-- 	fujiF.tabbot:SetPoint("BOTTOMRIGHT", fujiF, "BOTTOMRIGHT", 0, 0);
	-- 	fujiF.tabbot:PIGSetBackdrop(0,1)
	-- 	fujiF.tabbot.tisp=PIGFontString(fujiF.tabbot,{"BOTTOMLEFT",fujiF.tabbot,"TOPLEFT",10,2},"以下设置为外部插件提供，非"..addonName.."功能，相关问题请咨询对应作者")
	-- 	fujiF.tabbot.tisp:SetTextColor(1, 0.2, 0, 1);
	-- 	adDB.CreateSetting(fujiF.tabbot)
	-- 	--外部作者设置的加载配置的条件
	-- 	local ConfigDB = adDB.LoadingCondition(VersionTXT)
	-- 	if ConfigDB then
	-- 		local errtxt = _G[Data.ExportImportUIname].Is_PIGString(ConfigDB)
	-- 		if errtxt then
	-- 			fujiF.tispext3:SetTextColor(1, 0, 0, 1);
	-- 			fujiF.tispext3:SetText("失败,原因:"..errtxt)
	-- 		else
	-- 			--执行头像位置配置
	-- 			if PIGA["Config_Unit"] then
	-- 				local TopBarY = 0
	-- 				for k,v in pairs(PIGA["Config_Unit"]) do
	-- 					local point, relativePoint, offsetX, offsetY=unpack(v)
	-- 					if point and relativePoint and offsetX and offsetY then
	-- 						local uixx=_G[k]
	-- 						uixx:ClearAllPoints();
	-- 						if PIGA["PigLayout"]["TopBar"]["Open"] then
	-- 							if relativePoint=="TOP" or relativePoint=="TOPLEFT" or relativePoint=="TOPRIGHT" then
	-- 								TopBarY=PIGA["PigLayout"]["TopBar"]["Height"]
	-- 							end
	-- 						end
	-- 						uixx:SetPoint(point, UIParent, relativePoint, offsetX, offsetY+TopBarY);
	-- 						uixx:SetUserPlaced(true)
	-- 					end
	-- 				end
	-- 				PIGA["Config_Unit"]=nil
	-- 			end
	-- 		end
	-- 	end
	-- 	if PIGA["Config_ActionBar"] then
	-- 		PIGA["ActionBarEnabled"]=PIGA["ActionBarEnabled"] or {}
	-- 		ActionBarUI:RegisterEvent("PLAYER_ENTERING_WORLD");
	-- 	end
	-- 	return
	-- end
end