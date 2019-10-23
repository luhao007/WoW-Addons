--[[
Name: Lib-Scenarios
Revision: $Rev: 17 $
Maintainers: Arith
Website: https://wow.curseforge.com/addons/lib-scenarios/
Dependencies: None
License: MIT

This library provide the ability to get scenario name, step name, and step description by ID. 
By default it will return user's language, but one can toggle to show the specified language.

Sample of function calls:
local lib = LibStub:GetLibrary("Lib-Scenarios")
local sName, stpName, stpDesc

sName = lib:GetScenarioNameByID(53)
stpName = lib:GetScenarioStepNameByID(53, 1)
stpDesc = lib:GetScenarioStepDescByID(53, 1)

]]
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs
-- Libraries
local string = _G.string
local tostring = _G.tostring
local tonumber = _G.tonumber
local match = string.match
-- WoW
local GetLocale = _G.GetLocale
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local LibStub = _G.LibStub
local FOLDER_NAME, private = ...

local MAJOR_VERSION = "Lib-Scenarios"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 17 $"):match("%d+"))

local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local LANGSINDEX = {
	["enUS"] =  1;  
	["deDE"] =  2;  
	["esES"] =  3;  
	["esMX"] =  4;  
	["frFR"] =  5;  
	["itIT"] =  6;  
	["koKR"] =  7;  
	["ptBR"] =  8;  
	["ruRU"] =  9;  
	["zhCN"] = 10; 
	["zhTW"] = 11;
}

local function CheckLang(lang)
	local found = false
	
	for k, v in pairs(LANGSINDEX) do
		if (lang == k) then
			found = true
			break
		end
	end
	return found
end

--[[
To get the scenario name by given the scenario ID
]]
function lib:GetScenarioNameByID(scID, lang)
	if not scID then return; end

	local key = tostring(scID)
	
	if (lang) then
		if ( CheckLang(lang) == false ) then
			return nil
		end
	else
		lang = GetLocale()
	end

	if (private.Scenarios.Names.DB[key]) then
		return private.Scenarios.Names.DB[key][LANGSINDEX[lang]]
	else
		return nil
	end
end

--[[
To get the scenario step-name by given the scenario ID and step ID
]]
function lib:GetScenarioStepNameByID(scID, stID, lang)
	if (not (scID and stID)) then return; end

	local key = tostring(scID)
	
	if (not private.Scenarios.Steps.DB[key]) then
		return nil
	end
	if (not private.Scenarios.Steps.DB[key][stID]) then
		return nil
	end
	if (lang) then
		if ( CheckLang(lang) == false ) then
			return nil
		end
	else
		lang = GetLocale()
	end

	return private.Scenarios.Steps.DB[key][stID][LANGSINDEX[lang]]
end

--[[
To get the scenario step-description by given the scenario ID and step ID
]]
function lib:GetScenarioStepDescByID(scID, stID, lang)
	if (not (scID and stID)) then return; end

	local key = tostring(scID)
	
	if (not private.Scenarios.Descriptions.DB[key]) then
		return nil
	end
	if (not private.Scenarios.Descriptions.DB[key][stID]) then
		return nil
	end
	if (lang) then
		if ( CheckLang(lang) == false ) then
			return nil
		end
	else
		lang = GetLocale()
	end

	return private.Scenarios.Descriptions.DB[key][stID][LANGSINDEX[lang]]
end

--[[
To get the number of steps from specified scenario
]]
function lib:GetNumberScenarioSteps(scID)
	if not scID then return; end
	local key = tostring(scID)

	if (not private.Scenarios.Steps.DB[key]) then
		return nil
	else
		return getn(private.Scenarios.Steps.DB[key])
	end
end

--[[
To get the scenario step ID of specified scenario-step
]]
function lib:GetScenarioStepID(scID, stID)
	if (not (scID and stID)) then return; end
	local key = tostring(scID)

	if (not private.Scenarios.StepID.DB[key]) then
		return nil
	else
		return private.Scenarios.StepID.DB[key][stID][1]
	end
end

--[[
To get the scenario step's criteria-tree ID of specified scenario-step
]]
function lib:GetScenarioStepCriteriaTreeID(scID, stID)
	if (not (scID and stID)) then return; end
	local key = tostring(scID)

	if (not private.Scenarios.StepID.DB[key]) then
		return nil
	else
		return private.Scenarios.StepID.DB[key][stID][2]
	end
end


-- /////////////// Dev Only /////////////////////////////
-- local LibScenariosStepsTempDB = {}
-- local LibScenariosDescriptionsTempDB = {}
-- local StepIDTempDB = {}

-- below was only used for new database conversion
--[[
function lib:Convert_StepsTempDB()
	for k, v in ipairs(LibScenariosStepsTempDB) do
		local scID, stID, st, enUS, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhTW = v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12], v[13], v[14], v[15]
		local num = tonumber(st)
		num = num +1
		--st = tostring(num)
		
		if (ScenariosDB == nil) then ScenariosDB = { } end
		if (ScenariosDB.Steps == nil) then ScenariosDB.Steps = { } end
		if (ScenariosDB.Steps[scID] == nil) then ScenariosDB.Steps[scID] = { } end
		if (ScenariosDB.Steps[scID][num] == nil) then ScenariosDB.Steps[scID][num] = { } end
		ScenariosDB.Steps[scID][num] = { enUS, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhTW }
	end
end

function lib:Convert_DescTempDB()
	for k, v in ipairs(LibScenariosDescriptionsTempDB) do
		local scID, stID, st, enUS, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhTW = v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9], v[10], v[11], v[12], v[13], v[14], v[15]
		local num = tonumber(st)
		num = num +1
		--st = tostring(num)
		
		if (ScenariosDB == nil) then ScenariosDB = { } end
		if (ScenariosDB.Desc == nil) then ScenariosDB.Desc = { } end
		if (ScenariosDB.Desc[scID] == nil) then ScenariosDB.Desc[scID] = { } end
		if (ScenariosDB.Desc[scID][num] == nil) then ScenariosDB.Desc[scID][num] = { } end
		ScenariosDB.Desc[scID][num] = { enUS, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN, zhTW }
	end
end

function Convert_StepIDTempDB()
	for k, v in ipairs(StepIDTempDB) do
		local scID, st, stID, criID = v[1], v[2], v[3], v[4]
		local num = tonumber(st)
		num = num +1
		--st = tostring(num)
		
		if (ScenariosDB == nil) then ScenariosDB = { } end
		if (ScenariosDB.StepsID == nil) then ScenariosDB.StepsID = { } end
		if (ScenariosDB.StepsID[scID] == nil) then ScenariosDB.StepsID[scID] = { } end
		if (ScenariosDB.StepsID[scID][num] == nil) then ScenariosDB.StepsID[scID][num] = { } end
		ScenariosDB.StepsID[scID][num] = { tonumber(stID), tonumber(criID) }
	end
end

]]

