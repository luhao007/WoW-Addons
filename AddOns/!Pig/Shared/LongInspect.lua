local addonName, PD = ...;
local sub = _G.string.sub
local match = _G.string.match
-------------
local Fun=PD.Fun
local jieya_NumberString=Fun.jieya_NumberString
local GetEquipmTXT=Fun.GetEquipmTXT
local HY_EquipmTXT=Fun.HY_EquipmTXT
local GetRuneTXT=Fun.GetRuneTXT
local HY_RuneTXT=Fun.HY_RuneTXT

local Data=PD.Data
local TalentData=Data.TalentData

local Create = PD.Create
---
local pig_PREFIX="!Pig-YCIN";
local YCinfo_GET_MSG = {"!GETALL","!GETT-","!GETG-","!GETR-","!GETI-"};
C_ChatInfo.RegisterAddonMessagePrefix(pig_PREFIX)
--ala
local ALA=PD.ALA
local ALA_tiquMsg=ALA.ALA_tiquMsg
local ala_PREFIX = ALA.ala_PREFIX
local COMM_PART_PREFIX = ALA.ala_COMM_PART_PREFIX
local COMM_QUERY_PREFIX = ALA.ala_COMM_QUERY_PREFIX
local COMM_TALENT_PREFIX = ALA.ala_COMM_TALENT_PREFIX
local COMM_GLYPH_PREFIX = ALA.ala_COMM_GLYPH_PREFIX
local COMM_EQUIPMENT_PREFIX = ALA.ala_COMM_EQUIPMENT_PREFIX
local COMM_ENGRAVING_PREFIX = ALA.ala_COMM_ENGRAVING_PREFIX
local COMM_ADDON_PREFIX = ALA.ala_COMM_ADDON_PREFIX
local td_PREFIX = "tdInspect"
-----
local UIname="PIG_LongInspectUI"
Data.UILayout[UIname]={"TOPLEFT","TOPLEFT",0, -116}
local LongInspect
local function addCharacterF()
	if Data.LongInspectUI then return Data.LongInspectUI end
	local addui=Create.CharacterFrame(UIParent,UIname,99)
	Data.LongInspectUI=addui
	Create.PIG_SetPoint(UIname)
	return addui
end
---------------
local function Update_ShowItem(itemstxt,laiyuan)
	local zbData = {}
	if not itemstxt then return end
	for k,v in pairs(itemstxt) do
		zbData[k]=v
	end
	for k,v in pairs(zbData) do
		GetItemInfo(v)
	end
	C_Timer.After(0.1,function()
		LongInspect.ZBLsit.ShowItemNum=0
		LongInspect:Update_ShowItem_List(zbData,laiyuan)
	end)
end
Fun.Update_ShowItem=Update_ShowItem
local function Update_ShowPlayer(Player,lyfrome)
	local class,race,level,itemLV,gender = unpack(Player)
	if PIG_HardcoreDeathsUI then PIG_HardcoreDeathsUI.Save_playerdata(LongInspect.fullnameX,class,race,gender) end
	local className, classFile = PIGGetClassInfo(class)
	local raceName = "  "
	if tonumber(race)>0 then
		local raceInfo = C_CreatureInfo.GetRaceInfo(race)
		raceName=raceInfo["raceName"]
	end
	LongInspect.LevelText:SetText(LEVEL..level.." "..raceName.." "..className);
	if not ElvUI and not NDui then
		LongInspect.Portrait:SetTexture("interface/targetingframe/ui-classes-circles.blp")
		local coords = CLASS_ICON_TCOORDS[classFile]
		LongInspect.Portrait:SetTexCoord(unpack(coords));
	end
	LongInspect.ZBLsit.level=level
	LongInspect.ZBLsit.zhiyeID=class
	LongInspect.ZBLsit.zhiye=classFile
	LongInspect.ZBLsit.itemLV=itemLV
	LongInspect.ZBLsit:Update_Player(lyfrome)
end
Fun.Update_ShowPlayer=Update_ShowPlayer
--处理获取信息
local function PIG_FormatData(msgx,nameX)
	local jiequkaishi = 1
	local datalist= {}  	  
	for i = 1, #msgx do  
	    local kshi, jieshu, msgx1 = msgx:find("(#[^#]+)", jiequkaishi) 
	    if kshi then
	    	jiequkaishi=jieshu+1
	   		table.insert(datalist, msgx1)  
	    end  
	end
	local yxwjinfo = {}
	for i=1,#datalist do
		local xinximsg = datalist[i]
		local qianzhui = xinximsg:sub(1, 2)
		if qianzhui == "#P" then
			yxwjinfo[1] = {strsplit("-", xinximsg:sub(3, -1))};
		elseif qianzhui == "#T" then
			local Tianfu,Tianfu2 =TalentData.HY_TianfuTXT(xinximsg:sub(3, -1))
			PD.talentData[nameX]["T"]={GetServerTime(),Tianfu,Tianfu2}
		elseif qianzhui == "#G" then
			local fwData,fwData2=TalentData.HY_GlyphTXT(xinximsg:sub(3, -1))
			PD.talentData[nameX]["G"]={GetServerTime(),fwData,fwData2}
		elseif qianzhui == "#R" then
			local fwData=HY_RuneTXT(xinximsg:sub(3, -1))
			PD.talentData[nameX]["R"]={GetServerTime(),fwData}
		elseif qianzhui == "#E" then
			yxwjinfo[2]=HY_EquipmTXT(xinximsg:sub(3, -1))
		end
	end
	if yxwjinfo[1] then Update_ShowPlayer(yxwjinfo[1],"yc") end
	if yxwjinfo[2] then Update_ShowItem(yxwjinfo[2],"yc") end
end
local function PIG_tiquMsg(msgx,nameX)
	if LongInspect and LongInspect:IsShown() and LongInspect.fullnameX==nameX then
		local qianzhui = msgx:sub(1, 2)
		if qianzhui == "!P" then
			if not msgx:match("@") then
				LongInspect.fanhuiYN=true
				local allnum = msgx:sub(3, 3)
				local danqian = msgx:sub(4, 4)
				if danqian=="1" then
					LongInspect.allmsg=msgx:sub(5, -1)
				else
					LongInspect.allmsg=LongInspect.allmsg..msgx:sub(5, -1)
				end
				if allnum==danqian then
					PIG_FormatData(LongInspect.allmsg,nameX)
				end
			end
		end
	end
	if InspectFrame and InspectFrame:IsShown() and InspectNameText:GetText()==nameX or Data.TardisUI and Data.TardisUI:IsShown() or Pig_playerStatsUI and Pig_playerStatsUI:IsShown() then--观察/时空
		local qianzhui = msgx:sub(1, 3)
		if qianzhui == "!T-" or qianzhui == "!G-" or qianzhui == "!R-" or qianzhui == "!I-" then
			local leixing = msgx:sub(2, 2)	
			if leixing == "T" then
				LongInspect.fanhuiYN_TF=true
				local Tianfu,Tianfu2 =TalentData.HY_TianfuTXT(msgx:sub(4, -1))
				PD.talentData[nameX][leixing]={GetServerTime(),Tianfu,Tianfu2}
			end
			if leixing == "G" then
				LongInspect.fanhuiYN_GG=true
				local dwData,dwData2=TalentData.HY_GlyphTXT(msgx:sub(4, -1))
				PD.talentData[nameX][leixing]={GetServerTime(),dwData,dwData2}
			end
			if leixing == "R" then
				LongInspect.fanhuiYN_RR=true
				local fwData=HY_RuneTXT(msgx:sub(4, -1))
				PD.talentData[nameX][leixing]={GetServerTime(),fwData}
			end
			if leixing == "I" then
				LongInspect.fanhuiYN_II=true
				local classId,raceId,level,ItemLevel,gender = strsplit("-", msgx:sub(4, -1))
				PD.talentData[nameX][leixing]={GetServerTime(),classId,raceId,level,ItemLevel,gender}
			end
		end
	end
end
--无PIG返回/ALA获取/无返回
local function ALA_GetDATA_YN()
	if LongInspect.alaGet_1 then LongInspect.alaGet_1:Cancel() end
	LongInspect.alaGet_1=C_Timer.NewTimer(1,function()
		if not LongInspect.fanhuiYN then
			PIGSendAddonMessage(ala_PREFIX, COMM_QUERY_PREFIX.."TEG", "WHISPER", LongInspect.fullnameX);
		end
	end)
	--if LongInspect.alaGet_2 then LongInspect.alaGet_2:Cancel() end
	-- LongInspect.alaGet_2=C_Timer.NewTimer(2,function()
	-- 	if not LongInspect.fanhuiYN then
	-- 		PIGSendAddonMessage(ala_PREFIX, "_q_tal", "WHISPER", LongInspect.fullnameX);
	-- 		PIGSendAddonMessage(ala_PREFIX, "_q_equ", "WHISPER", LongInspect.fullnameX);		
	-- 	end
	-- end)
	if LongInspect.ycNull then LongInspect.ycNull:Cancel() end
	LongInspect.ycNull=C_Timer.NewTimer(3,function()
		if not LongInspect.fanhuiYN then
			LongInspect.LevelText:SetText("|cffFF0000获取失败\n目标未安装"..addonName.."插件或版本过期|r");
		end
	end)
end
--------
local function FasongYCqingqiu(fullnameX,iidd)
	if name==UNKNOWNOBJECT then return end
	PD.talentData[fullnameX]=PD.talentData[fullnameX] or {}
	local iidd=iidd or 1
	LongInspect=addCharacterF()
	if iidd==1 then
		if InspectFrame and InspectFrame:IsShown() then InspectFrame:Hide() end
		LongInspect.fanhuiYN=false
		PIGSendAddonMessage(pig_PREFIX,YCinfo_GET_MSG[iidd], "WHISPER", fullnameX)
		LongInspect.TitleText:SetText(fullnameX);
		LongInspect.fullnameX=fullnameX
		ALA_GetDATA_YN()
		LongInspect:CZ_yuancheng_Data(INVTYPE_RANGED)
	elseif iidd==2 then--只请求天赋信息
		if not PD.talentData[fullnameX]["T"] or GetServerTime()-PD.talentData[fullnameX]["T"][1]>10 then
			LongInspect.fanhuiYN_TF=false
			PIGSendAddonMessage(pig_PREFIX,YCinfo_GET_MSG[iidd], "WHISPER", fullnameX)
			if LongInspect.alaGet_TF then LongInspect.alaGet_TF:Cancel() end
			LongInspect.alaGet_TF=C_Timer.NewTimer(1,function()
				if not LongInspect.fanhuiYN_TF then
					PIGSendAddonMessage(ala_PREFIX, COMM_QUERY_PREFIX.."T", "WHISPER", fullnameX);
				end
			end)
		end
	elseif iidd==3 then--只请求雕文信息
		if not PD.talentData[fullnameX]["G"] or GetServerTime()-PD.talentData[fullnameX]["G"][1]>10 then
			LongInspect.fanhuiYN_GG=false
			PIGSendAddonMessage(pig_PREFIX,YCinfo_GET_MSG[iidd], "WHISPER", fullnameX)
			if LongInspect.alaGet_GG then LongInspect.alaGet_GG:Cancel() end
			LongInspect.alaGet_GG=C_Timer.NewTimer(1,function()
				if not LongInspect.fanhuiYN_GG then
					PIGSendAddonMessage(ala_PREFIX, COMM_QUERY_PREFIX.."G", "WHISPER", fullnameX);
				end
			end)
		end
	elseif iidd==4 then--只请求符文信息
		if not PD.talentData[fullnameX]["R"] or GetServerTime()-PD.talentData[fullnameX]["R"][1]>10 then
			LongInspect.fanhuiYN_RR=false
			PIGSendAddonMessage(pig_PREFIX,YCinfo_GET_MSG[iidd], "WHISPER", fullnameX)
			if LongInspect.alaGet_RR then LongInspect.alaGet_RR:Cancel() end
			LongInspect.alaGet_RR=C_Timer.NewTimer(1,function()
				if not LongInspect.fanhuiYN_RR then
					PIGSendAddonMessage(ala_PREFIX, COMM_QUERY_PREFIX.."R", "WHISPER", fullnameX);
				end
			end)
		end
	elseif iidd==5 then--只请求角色信息
		if not PD.talentData[fullnameX]["I"] or GetServerTime()-PD.talentData[fullnameX]["I"][1]>10 then
			LongInspect.fanhuiYN_II=false
			PIGSendAddonMessage(pig_PREFIX,YCinfo_GET_MSG[iidd], "WHISPER", fullnameX)
		end
	end
end
Fun.FasongYCqingqiu=FasongYCqingqiu
-----
local function lixian_chakan(fullnameX,renwu,itemdata)
	if InspectFrame and InspectFrame:IsShown() then InspectFrame:Hide() end
	LongInspect=addCharacterF()
	LongInspect.TitleText:SetText(fullnameX);
	LongInspect.fullnameX=fullnameX
	LongInspect:CZ_yuancheng_Data(FRIENDS_LIST_OFFLINE)
	Update_ShowPlayer({renwu[4],renwu[2],renwu[5]},"lx")
	local zbtxtlist=HY_EquipmTXT(PIGA["StatsInfo"]["Items"][fullnameX]["C"])
	Update_ShowItem(zbtxtlist,"lx")
end
Fun.lixian_chakan=lixian_chakan
------------------------------------
PD.talentData={}
PD.talentData={}
local fengeLEN = 240
local uifff = CreateFrame("Frame")
uifff:RegisterEvent("PLAYER_LOGIN")
uifff:SetScript("OnEvent",function(self, event, arg1, arg2, _, arg4, arg5)
	if event=="CHAT_MSG_ADDON" then
		if arg1 == pig_PREFIX then
			if arg2==YCinfo_GET_MSG[1] then
				local Player =TalentData.SAVE_Player()
				local Tianfu =TalentData.GetTianfuTXT()
				local Glyph =TalentData.GetGlyphTXT()
				local Rune =GetRuneTXT()
				local Items =GetEquipmTXT()
				local infoall = "#P"..Player.."#T"..Tianfu.."#G"..Glyph.."#R"..Rune.."#E"..Items
				local msglen = #infoall
				if msglen>fengeLEN then
					local fasongcishu = math.ceil(msglen/fengeLEN)
					for ic=1,fasongcishu do
						local jiequK = (ic-1)*fengeLEN+1
						local jiequJ = ic*fengeLEN
						if ic==fasongcishu then
							jiequJ = -1
						end
						local NewMsg1 = infoall:sub(jiequK,jiequJ)
						PIGSendAddonMessage(pig_PREFIX, "!P"..fasongcishu..ic..NewMsg1, "WHISPER", arg5)
					end		
				else
					PIGSendAddonMessage(pig_PREFIX, "!P11"..infoall, "WHISPER", arg5)
				end
			elseif arg2==YCinfo_GET_MSG[2] then
				local info =TalentData.GetTianfuTXT()
				PIGSendAddonMessage(pig_PREFIX, "!T-"..info, "WHISPER", arg5)
			elseif arg2==YCinfo_GET_MSG[3] then
				local info =TalentData.GetGlyphTXT()
				PIGSendAddonMessage(pig_PREFIX, "!G-"..info, "WHISPER", arg5)
			elseif arg2==YCinfo_GET_MSG[4] then
				local info =GetRuneTXT()
				PIGSendAddonMessage(pig_PREFIX, "!R-"..info, "WHISPER", arg5)
			elseif arg2==YCinfo_GET_MSG[5] then
				local Player =TalentData.SAVE_Player()
				PIGSendAddonMessage(pig_PREFIX, "!I-"..Player, "WHISPER", arg5)
			else
				PIG_tiquMsg(arg2,arg5)
			end
		elseif arg1==ala_PREFIX then
			ALA_tiquMsg(arg2,arg5)
		elseif arg1==td_PREFIX then
			--TD_tiquMsg(arg2,arg5)
		end
	elseif event=="PLAYER_LOGIN" then
		C_Timer.After(3,function()
			if not C_ChatInfo.IsAddonMessagePrefixRegistered(ala_PREFIX) then
				C_ChatInfo.RegisterAddonMessagePrefix(ala_PREFIX)
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered(td_PREFIX) then
				C_ChatInfo.RegisterAddonMessagePrefix(td_PREFIX)
			end
		end)
		self:RegisterEvent("CHAT_MSG_ADDON")
	end
end)