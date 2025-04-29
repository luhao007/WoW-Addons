local addonName, addonTable = ...;
local L=addonTable.locale
local _, _, _, tocversion = GetBuildInfo()
---
local Fun=addonTable.Fun
local Create=addonTable.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
--
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
---
local PigConfigFun={}
addonTable.PigConfigFun=PigConfigFun
local fuFrame,fuFrameBut = PIGOptionsList(L["CONFIG_TABNAME"],"TOP")
PigConfigFun.fuFrame=fuFrame
PigConfigFun.fuFrameBut=fuFrameBut
--
local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
PigConfigFun.RTabFrame=RTabFrame
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
Fun.Set_ConfigValue=Set_ConfigValue
---
local function Load_DefaultData(DqCF, moren,count,Per)
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
Fun.Load_DefaultData=Load_DefaultData
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
local function Clear_FailureData()
	PIGA["PigUI"]=nil
	PIGA["PigUIPoint"]=nil
	PIGA["WowUI"]=nil
	PIGA["BlizzardUI"]=nil
	PIGA["StatsInfo"]["SkillCD"]=nil
	PIGA["StatsInfo"]["FubenCD"]=nil
	PIGA["AHPlus"]["Tokens"]=nil
	PIGA["AHPlus"]["DataList"]=nil
	PIGA["CombatPlus"]["topMenu"]=nil
	PIGA["UnitFrame"]["PlayerFrame"]["Plus"]=nil
	PIGA["UnitFrame"]["PlayerFrame"]["Loot"]=nil
	PIGA["QuickFollow"]=nil
	--
	PIGA_Per["PigUI"]=nil
	PIGA_Per["QuickFollow"]=nil
	--
	if PIGA["Config_Unit"] then
		for k,v in pairs(PIGA["Config_Unit"]) do
			local point, relativePoint, offsetX, offsetY=unpack(v)
			if point and relativePoint and offsetX and offsetY then
				local uixx=_G[k]
				uixx:ClearAllPoints();
				uixx:SetPoint(point, UIParent, relativePoint, offsetX, offsetY);
				uixx:SetUserPlaced(true)
			end
		end
		PIGA["Config_Unit"]=nil
	end
	if PIGA["Config_ActionBar"] then
		ActionBarUI:RegisterEvent("PLAYER_ENTERING_WORLD");
	end
end
function addonTable.Load_Config()
	PIGA = PIGA or addonTable.Default;
	PIGA_Per = PIGA_Per or addonTable.Default_Per;
	Load_DefaultData(PIGA,addonTable.Default, 0)
	Load_DefaultData(PIGA_Per,addonTable.Default_Per, 0, true)
	Clear_FailureData()
end
function addonTable.Get_PlayerRealmData()
	local englishFaction= UnitFactionGroup("player")--阵营"Alliance"/"Horde"
	local wanjia, realm = UnitFullName("player")
	local realm = realm or GetRealmName()
	local className, classFile, classId = UnitClass("player")
	local raceName, raceFile, raceId = UnitRace("player")
	local gender = UnitSex("player")
	Pig_OptionsUI.englishFaction=englishFaction or ""
	Pig_OptionsUI.Name=wanjia or ""
	Pig_OptionsUI.Realm=realm or ""
	Pig_OptionsUI.AllName = wanjia.."-"..realm
	Pig_OptionsUI.gender=gender or 2
	Pig_OptionsUI.ClassData = {["className"]=className,["classFile"]=classFile,["classId"]=classId}
	Pig_OptionsUI.RaceData = {["raceName"]=raceName,["raceFile"]=raceFile,["raceId"]=raceId}
	Pig_OptionsUI.AllNameElvUI = format('%s - %s', wanjia, realm)
	Pig_OptionsUI.IsOpen_ElvUI=function(vf1,vf2,vf3)
		if IsAddOnLoaded("ElvUI") then
			local peizName=ElvPrivateDB["profileKeys"][Pig_OptionsUI.AllNameElvUI]
			if peizName then
				local peizData=ElvPrivateDB["profiles"][peizName]
				if peizData then
					if vf1 and vf2 and vf3 then
						if peizData[vf1] and peizData[vf1][vf2] then
							if peizData[vf1][vf2][vf3]==false then
								return false
							end
						end
					elseif vf1 and vf2 then		
						if peizData[vf1] then
							if peizData[vf1][vf2]==false then
								return false
							end
						end
					elseif vf1 then
						if peizData[vf1]==false then
							return false
						end
					end
				end
				return true
			else
				return true
			end
		else
			return false
		end
	end
	Pig_OptionsUI.IsOpen_NDui=function(vf1,vf2,vf3)
		if IsAddOnLoaded("NDui") then
			if vf1 or vf2 or vf3 then
				if vf1 and vf2 and vf3 then
					if NDuiDB[vf1] and NDuiDB[vf1][vf2] and NDuiDB[vf1][vf2][vf3] then return true end
				elseif vf1 and vf2 then
					if NDuiDB[vf1] and NDuiDB[vf1][vf2] then return true end
				elseif vf1 then
					if NDuiDB[vf1] then return true end
				end
				return false
			else
				return true
			end
		else
			return false
		end
	end
end