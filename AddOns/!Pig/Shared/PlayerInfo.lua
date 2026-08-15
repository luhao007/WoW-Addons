local _, PD = ...;
local Data=PD.Data
Data.PlayerInfo={}
---
function PD.GetPlayerInfo()
	local englishFaction= UnitFactionGroup("player")--阵营
	local wanjia= UnitName("player")
	local realm = GetRealmName()
	if not englishFaction or not wanjia or not realm then
		C_Timer.After(0.01,Get_PlayerInfo)
		return
	end
	local gender = UnitSex("player") or 2
	local className, classFile, classId = UnitClass("player")
	local raceName, raceFile, raceId = UnitRace("player")
	Data.PlayerInfo.englishFaction=englishFaction
	Data.PlayerInfo.Name=wanjia
	Data.PlayerInfo.Realm=realm
	Data.PlayerInfo.AllName = wanjia.."-"..realm
	Data.PlayerInfo.gender=gender
	Data.PlayerInfo.ClassData = {["className"]=className,["classFile"]=classFile,["classId"]=classId}
	Data.PlayerInfo.RaceData = {["raceName"]=raceName,["raceFile"]=raceFile,["raceId"]=raceId}
end