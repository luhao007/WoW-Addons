----<本插件初始为猪猪加油定制插件,现已公开分享>---562314----
local addonName, PD = ...;
local L=PD.locale
local Data=PD.Data
local PlayerInfo=Data.PlayerInfo
local Fun=PD.Fun
local GetPIGID=Fun.GetPIGID
_G.PIG = {PD.Create,PD.Data,PD.Fun,L,PD.Default,PD.Default_Per,PD.Audio,PD.ExtDB}
--=====================
local Ver_biaotou="!Pig_VER";
PD.VerData={biaotou=Ver_biaotou,Ver={},audioVer={},TopVerF={},Genxing={}}
C_ChatInfo.RegisterAddonMessagePrefix(Ver_biaotou)
local function GetAddonsVerV(EXTaddname,ly)
	if ly=="audio" then
		if not PD.VerData.audioVer[EXTaddname] then
			local VersionID=PIGGetAddOnMetadata(EXTaddname, "Version")
			if VersionID then
				PD.VerData.audioVer[EXTaddname] = VersionID
			else
				PD.VerData.audioVer[EXTaddname] = "-1"
			end
		end
		return PD.VerData.audioVer[EXTaddname] or "-1"
	else
		if not PD.VerData.Ver[EXTaddname] then
			local VersionID=PIGGetAddOnMetadata(EXTaddname, "Version")
			if VersionID then
				PD.VerData.Ver[EXTaddname] = VersionID
			else
				PD.VerData.Ver[EXTaddname] = "-1"
			end
		end
		return PD.VerData.Ver[EXTaddname] or "-1"
	end
end
PD.VerData.GetAddonsVerV=GetAddonsVerV
local function IsUpdateOK(adname,VersionID)
	if PIGA["VerC"][adname] and PIGA["VerC"][adname].verno>tonumber(VersionID) and #PIGA["VerC"][adname].p>4 then
		return true
	end
	return false
end
PD.VerData.IsUpdateOK=IsUpdateOK
local function ISchongfuP(name,data)
	for i=1,#data do
		if name==data[i] then
			return true
		end
	end
	return false
end
local function GetExtVerInfo(arg2, arg3, arg4, arg5)
	local getName, getype, getVer = strsplit("#", arg2);
	if getype=="X" then
		Fun.Save_is_slist(getVer)
	else
		-- print("--------"..getName)
		-- print("类型    :"..getype)
		-- print("版本      :"..getVer)
		-- print("消息      :"..arg2)
		-- print("频道      :"..arg3)
		-- print("名字+服务器:"..arg4)
		-- print("名字      :"..arg5)
		local getVer=tonumber(getVer)
		local LocalVer=tonumber(GetAddonsVerV(getName))
		if arg3=="WHISPER" then
			if getype=="V" then--手动请求的返回
				PIG_VersionUI.infoList[arg5][getName]=getVer
			elseif getype=="G" then--发出手动请求
				PIGSendAddonMessage(Ver_biaotou,getName.."#V#"..GetAddonsVerV(getName),"WHISPER",arg4)
			elseif getype=="D" then--收到其他玩家版本号
				if getVer>LocalVer then
					if PIGA["VerC"][getName] then
						if getVer>PIGA["VerC"][getName].verno then
							PIGA["VerC"][getName]= {["verno"]=getVer,["p"]={arg5}}
						elseif getVer==PIGA["VerC"][getName].verno then
							if not ISchongfuP(arg5,PIGA["VerC"][getName].p) then
								table.insert(PIGA["VerC"][getName].p,arg5)
							end
						end
					else
						PIGA["VerC"][getName]= {["verno"]=getVer,["p"]={arg5}}
					end
					if adname==addonName and not PD.VerData.Genxing[adname] then
						PD.VerData.Genxing[adname]=true
						if IsUpdateOK(adname,getVer) then
							PIGprint(L["ABOUT_UPDATETIPS"],"R")
						end
					end
				end
			end
		else
			if getype=="U" then--收到广播更新请求
				if getVer<LocalVer then
					if arg4==PlayerInfo.AllName then return end
					if arg5==PlayerInfo.Name then return end
					PIGSendAddonMessage(Ver_biaotou,getName.."#D#"..LocalVer,"WHISPER",arg4)
				end
			end
		end
	end
end
local function SendExtVerInfo(adname,jimoV)
	if PIGIsAddOnLoaded(adname) then
		local fsMsg=adname
		if jimoV then
			fsMsg=fsMsg.."#X#"..jimoV
		else
			if IsUpdateOK(adname,GetAddonsVerV(adname)) then return end
			fsMsg=fsMsg.."#U#"..GetAddonsVerV(adname)
		end
		if PIG_MaxTocversion(100000) then
			PIGSendAddonMessage(Ver_biaotou,fsMsg,"YELL")
		else
			local PIGID=GetPIGID("PIG")
			if PIGID>0 then
				PIGSendAddonMessage(Ver_biaotou,fsMsg,"CHANNEL",PIGID)
			end
		end
		if IsInGuild() then PIGSendAddonMessage(Ver_biaotou,fsMsg,"GUILD") end
		if IsInRaid() then
			if IsInRaid(LE_PARTY_CATEGORY_HOME) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"RAID") end
			if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"INSTANCE_CHAT") end
		elseif IsInGroup() then
			if IsInGroup(LE_PARTY_CATEGORY_HOME) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"PARTY") end
			if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"INSTANCE_CHAT") end
		end
	end
end
--===========================
local PIGUI = CreateFrame("Frame")
PIGUI:RegisterEvent("PLAYER_LOGIN")
PIGUI:RegisterEvent("CHAT_MSG_ADDON")
PIGUI:SetScript("OnEvent",function(self, event, arg1, arg2, arg3, arg4, arg5)
	if event=="CHAT_MSG_ADDON" then
		if arg1 ~= Ver_biaotou then return end
		GetExtVerInfo(arg2, arg3, arg4, arg5)
	else
		PD.ExtConfig()
		PD.GetPlayerInfo()
		PD.MiniMapBut_Add()
		--
		PD.General()
		PD.Business()
		PD.Chat()
		PD.ActionBar()
		PD.CombatPlus()
		PD.TooltipPlus()
		PD.FramePlus()
		PD.UnitFrame()
		PD.BagBank()
		PD.Map()
		PD.CVars()
		PD.PigLayout()
		PD.ExtAddonsFun()
		--
		PD.QuickBut()
		PD.MiniMapBut_Collect()
		------------------------------
		if not PIGA["Other"]["PigLoad"] then
			PIGprint(L["ADDON_LOAD"])
		end
		for i=1,#L.addnames do
			SendExtVerInfo(L.addnames[i])
		end
		Fun.fasong_is_slist(SendExtVerInfo)
	end
end)