local addonName, addonTable = ...;
local L=addonTable.locale
local Create=addonTable.Create
local PIGGetRaceAtlas=addonTable.Fun.PIGGetRaceAtlas
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGModbutton=Create.PIGModbutton
local PIGFontString=Create.PIGFontString
local PIGOptionsList_RF=Create.PIGOptionsList_RF
--
local BusinessInfo=addonTable.BusinessInfo
--=================================
local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.StatsInfoData)
local Width,Height,biaotiH  = 860, 530, 21;
--===========================
function BusinessInfo.StatsInfo_ADDUI()
	if not PIGA["StatsInfo"]["Open"] then return end
	if _G[GnUI] then return end
	local ModBut = PIGModbutton(GnName,GnIcon,GnUI,FrameLevel)
	local StatsInfo=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,60},{Width,Height},GnUI,true)
	StatsInfo:PIGSetBackdrop()
	StatsInfo:PIGClose()
	StatsInfo:PIGSetMovableNoSave()
	StatsInfo.butW=46
	StatsInfo.hang_Height=19
	StatsInfo.title = PIGFontString(StatsInfo,{"TOP", StatsInfo, "TOP", 0, -3},GnName)
	StatsInfo.F=PIGOptionsList_RF(StatsInfo,biaotiH,"Left")
	--
	StatsInfo:RegisterEvent("PLAYER_LEVEL_UP");
	StatsInfo:HookScript("OnEvent",function (self, event)
		if event=="PLAYER_LEVEL_UP" then
			PIGA["StatsInfo"]["Players"][self.allname][5]=UnitLevel("player") or 1
		end
	end)
	--
	local peizhiList={
		["Players"] = "must",
		["PlayerSH"] = "none",
		["Times"] = "none",
		["FBCDRecords"] = "name",
		["SkillData"] = "name",
		["Token"] = "name",
		["Items"] = "name",
		["TradeData"] = "name",
		["Played"] = "name",
	}
	local function Get_renwuInfo()
		StatsInfo.allname = PIG_OptionsUI.AllName
		local race_icon = PIGGetRaceAtlas(PIG_OptionsUI.RaceData.raceFile,PIG_OptionsUI.gender)
		local level = UnitLevel("player")
		PIGA["StatsInfo"]["Players"][StatsInfo.allname]={PIG_OptionsUI.englishFaction,PIG_OptionsUI.RaceData.raceId,race_icon,PIG_OptionsUI.ClassData.classId,level}
		for k,v in pairs(peizhiList) do
			if v=="name" then
				PIGA["StatsInfo"][k][StatsInfo.allname]=PIGA["StatsInfo"][k][StatsInfo.allname] or {}
			end
		end
	end
	Get_renwuInfo()
	BusinessInfo.FBCD(StatsInfo,peizhiList)
	BusinessInfo.SkillCD(StatsInfo,peizhiList)
	BusinessInfo.Token(StatsInfo,peizhiList)
	BusinessInfo.Item(StatsInfo,peizhiList)
	BusinessInfo.Trade(StatsInfo,peizhiList)
	BusinessInfo.AH(StatsInfo,peizhiList)
	BusinessInfo.Time(StatsInfo,peizhiList)
	BusinessInfo.Player(StatsInfo,peizhiList)
	BusinessInfo.Admin(StatsInfo,peizhiList)
end
