local addonName, PD = ...;
local gsub = _G.string.gsub
local match = _G.string.match
local lower=string.lower
local sub = _G.string.sub
local find = _G.string.find
local char=string.char
local L =PD.locale
local Fun = {}
PD.Fun=Fun
---lua
function FormatLocalStr(text)
	text = text:gsub("[%%][sd]", "")
	text = text:gsub("x","")
	text = text:gsub("%.","")
	text = text:gsub("。","")
	text = text:gsub(": ","")
	text = text:gsub("：","")
	return text
end
--格式化时间
function Fun.disp_time(time)
	if time then
		local days = floor(time/86400)
		local hours = floor(mod(time, 86400)/3600)
		local minutes = math.ceil(mod(time,3600)/60)
		if time>86400 then
			return format("|c00FF0000"..GARRISON_DURATION_DAYS_HOURS.."|r",days,hours)
		elseif time<86400 and time>3600 then
			return format("|c00FFA500"..GARRISON_DURATION_HOURS_MINUTES.."|r",hours,minutes)
		elseif time<3600 and time>60 then
			return format("|c00FFFF40"..GARRISON_DURATION_MINUTES.."|r",minutes)
		else
			return format("|c00FFFF40"..GARRISON_DURATION_SECONDS.."|r",time)
		end
	else
		return TIME_UNKNOWN
	end
	-- GARRISON_DURATION_DAYS = "%d天";
	-- GARRISON_DURATION_HOURS = "%d小时";
end
-------
function Fun.PruningServerName(str)
    local lastIndex = str:reverse():find("-")
    if lastIndex then
        local actualIndex = #str - lastIndex + 1
        return str:sub(1, actualIndex - 1)
    end
    return str
end
function Fun.IsAddOnLoaded(AddOnName,funx)
	if PIGIsAddOnLoaded(AddOnName) then
		funx()
	else
		EventUtil.ContinueOnAddOnLoaded(AddOnName, function()
			funx()
		end)
	end
end
function Fun.EventCOMBAT_LOG(frame,bot)
	if PIG_MaxTocversion(120000) then
		if bot then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		else
			frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
	end
end
Fun.IsElvUI=function(vf1,vf2,vf3)
	if PIGIsAddOnLoaded("ElvUI") then
		if not vf1 then return true end
		local E= unpack(ElvUI)
		if not E.private then return true end
		if vf1 and vf2 and vf3 then
			if E.private[vf1] and E.private[vf1][vf2] then
				return E.private[vf1][vf2][vf3]
			end
		elseif vf1 and vf2 then
			if E.private[vf1] then
				return E.private[vf1][vf2]
			end
		elseif vf1 then
			return E.private[vf1]
		end
		return true
	else
		return false
	end
end
Fun.SetElvUI=function(bot,vf1,vf2,vf3)
	if PIGIsAddOnLoaded("ElvUI") then
		local E= unpack(ElvUI)
		if E.private then
			if vf1 and vf2 and vf3 then
				if E.private[vf1] and E.private[vf1][vf2] and E.private[vf1][vf2][vf3] then E.private[vf1][vf2][vf3]=bot end
			elseif vf1 and vf2 then
				if E.private[vf1] and E.private[vf1][vf2] then E.private[vf1][vf2]=bot end
			elseif vf1 then
				if E.private[vf1] then E.private[vf1]=bot end
			end
		end
	end
end
Fun.IsNDui=function(vf1,vf2,vf3)
	if PIGIsAddOnLoaded("NDui") then
		if not vf1 then return true end
		if not NDui then return true end
		if not NDui[2] then return true end
		if vf1 and vf2 and vf3 then
			if NDui[2].db[vf1] and NDui[2].db[vf1][vf2] then
				return NDui[2].db[vf1][vf2][vf3] 
			end
		elseif vf1 and vf2 then
			if NDui[2].db[vf1] then
				return NDui[2].db[vf1][vf2] 
			end
		elseif vf1 then
			return NDui[2].db[vf1]
		end
		return true
	else
		return false
	end
end
Fun.SetNDui=function(bot,vf1,vf2,vf3)
	if PIGIsAddOnLoaded("NDui") then
		if NDui and NDui[2] then
			if vf1 and vf2 and vf3 then
				if NDui[2].db[vf1] and NDui[2].db[vf1][vf2] and NDui[2].db[vf1][vf2][vf3] then NDui[2].db[vf1][vf2][vf3]=bot end
			elseif vf1 and vf2 then
				if NDui[2].db[vf1] and NDui[2].db[vf1][vf2] then NDui[2].db[vf1][vf2]=bot end
			elseif vf1 then
				if NDui[2].db[vf1] then NDui[2].db[vf1]=bot end
			end
		end
	end
end
----
Fun.PIGGetColorKey=function()
	if PIG_MaxTocversion(60000) then
		return "cff%w%w%w%w%w%w"
	else
		return "cnIQ%d:"
	end
end

function Fun.IsAudioNumMaxV(cfv,AudioData)
	if not AudioData[cfv] or AudioData[cfv] and cfv>#AudioData then
		return 1
	else
		return cfv
	end
end

---
function Fun.PIGSetAtlas(buticon,Atlas,useAtlasSize,hWrapMode,vWrapMode)
	if not PD.Data.AtlasInfo then return false end
	for k,v in pairs(PD.Data.AtlasInfo) do
		if v[Atlas] then
			buticon:SetTexture(k,hWrapMode,vWrapMode)
			buticon:SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
			return true
		end
	end
	return false
end
function Fun.PIGSetButtonNormalAtlas(buticon,Atlas)
	if not PD.Data.AtlasInfo then return false end
	for k,v in pairs(PD.Data.AtlasInfo) do
		if v[Atlas] then
			buticon:SetNormalTexture(k)
			buticon:GetNormalTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
		end
	end
end
function Fun.PIGSetButtonPushedAtlas(buticon,Atlas)
	if not PD.Data.AtlasInfo then return false end
	for k,v in pairs(PD.Data.AtlasInfo) do
		if v[Atlas] then
			buticon:SetPushedTexture(k)
			buticon:GetPushedTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
		end
	end
end
function Fun.PIGSetButtonDisabledAtlas(buticon,Atlas)
	if not PD.Data.AtlasInfo then return false end
	for k,v in pairs(PD.Data.AtlasInfo) do
		if v[Atlas] then
			buticon:SetDisabledTexture(k)
			buticon:GetDisabledTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
		end
	end
end
function Fun.PIGSetButtonHighlightAtlas(buticon,Atlas)
	if not PD.Data.AtlasInfo then return false end
	for k,v in pairs(PD.Data.AtlasInfo) do
		if v[Atlas] then
			buticon:SetHighlightTexture(k)
			buticon:GetHighlightTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
		end
	end
end
function Fun.RGBToHex(t)
	local r,g,b = t.r*255,t.g*255,t.b*255
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return format("%02x%02x%02x", r, g, b)
end
-----
local GetLootMethod=GetLootMethod or C_PartyInfo and C_PartyInfo.GetLootMethod
local SetLootMethod=SetLootMethod or C_PartyInfo and C_PartyInfo.SetLootMethod
local GetSpecialization = GetSpecialization or C_SpecializationInfo and C_SpecializationInfo.GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo or C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo
local lootList = {
	[0]={"freeforall",LOOT_FREE_FOR_ALL,"自由"},
	[2]={"master",LOOT_MASTER_LOOTER,"队长"},
	[1]={"roundrobin",LOOT_ROUND_ROBIN,"轮流"},
	[3]={"group",LOOT_GROUP_LOOT,"队伍"},
	[4]={"needbeforegreed",LOOT_NEED_BEFORE_GREED,"需求"},
	[5]={"personal",LOOT_PERSONAL_LOOT,"个人"},
}
local lootListIDNum=4
if PIG_MaxTocversion(60000,true) then
	lootListIDNum=5
end
local lootforNum=lootListIDNum-1
function Fun.Get_LootTypeData()
	return lootforNum,lootList
end
local function Get_LootMethodID()
	local lootmethod, masterlooterPartyID, masterlooterRaidID=GetLootMethod()
	return lootmethod, masterlooterPartyID, masterlooterRaidID
end
Fun.Get_LootMethodID=Get_LootMethodID
local function Update_LootTxt(but)
	if PIG_MaxTocversion() then
		if IsInGroup() then
			but:Enable()
			return "\124cff00ff00"..lootList[Get_LootMethodID()][3].."\124r"
		else
			but:Disable();
			return "\124cff555555N/A\124r"
		end
	else
		local specID = GetLootSpecialization()--当前拾取专精
		if specID>0 then
			local _, name = GetSpecializationInfoByID(specID)
			return "\124cff00ff00"..name.."\124r"
		else
			local specIndex = GetSpecialization()--当前专精
			if specIndex==5 then
				return "\124cff00ff00"..NONE.."*\124r"
			else
				local _, name = GetSpecializationInfo(specIndex)
				return "\124cff00ff00"..name.."*"
			end
		end
	end
end
function Fun.Update_LootType(uix,funx,set)
	uix:RegisterEvent("PLAYER_ENTERING_WORLD")
	if PIG_MaxTocversion() then
		uix:RegisterEvent("GROUP_ROSTER_UPDATE");
		uix:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");--战利品方法改变时触发
	else
		uix:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED");
	end
	if set then funx(Update_LootTxt(uix)) end
	uix:HookScript("OnEvent", function (self)
		funx(Update_LootTxt(self))
	end)
	uix:HookScript("OnClick", function (self)
		if PIG_MaxTocversion() then
			local lootmethodID= Get_LootMethodID()
			if lootmethodID==lootforNum then
				SetLootMethod(0)
			else
				local newlootID=lootmethodID+1;
				if newlootID==2 then
					SetLootMethod(newlootID,"player")
				else
					SetLootMethod(newlootID)
				end
			end
		else
			local numSpecializations = GetNumSpecializations()--总专精数
			local specID = GetLootSpecialization()
			if specID==0 then
				self.specIndex = 1
				local specID, name = GetSpecializationInfo(self.specIndex)
				SetLootSpecialization(specID)
			else
				self.specIndex = self.specIndex or specID
				self.specIndex = self.specIndex+1
				if self.specIndex>numSpecializations then
					SetLootSpecialization(0)
					self.specIndex = 0
				else
					local specID, name = GetSpecializationInfo(self.specIndex)
					SetLootSpecialization(specID)
				end	
			end
		end
	end)
end
function Fun.Delmaohaobiaodain(oldt)
	local oldt=oldt:gsub(" ","");
	local oldt=oldt:gsub("：","");
	local oldt=oldt:gsub(":","");
	return oldt
end
function Fun.tihuankuohao(fullName)
	local fullName = fullName:gsub("%s", "")
	local fullName = fullName:gsub("（", "(")
	local fullName = fullName:gsub("）", ")")
	return fullName
end
--
local genders = {[2]="male", [3]="female",[0]="male",[1]="female",}
--local genders = {[0]="male", [1]="female",[2]="none", [3]="both", [3]="neutral"}
local fixedRaceAtlasNames = {
    ["highmountaintauren"] = "highmountain",
    ["lightforgeddraenei"] = "lightforged",
    ["scourge"] = "undead",
    ["zandalaritroll"] = "zandalari",
    ["zandalaritroll"] = "zandalari",
    ["earthendwarf"]="earthen",
};
--种族
local PIGraceList = {}
for i=100,1,-1 do
	local raceInfo = C_CreatureInfo.GetRaceInfo(i)
	if raceInfo then
		if raceInfo.raceName then
			-- if raceInfo.clientFileString=="Scourge" then raceInfo.clientFileString="undead" end
			-- if raceInfo.clientFileString=="EarthenDwarf" then raceInfo.clientFileString="earthen" end
			PIGraceList[raceInfo.raceName]=raceInfo.clientFileString
		end
	end
end
function Fun.PIGGetRaceAtlas(raceName, gender)
	local gender=tonumber(gender)
	if gender>0 and gender<4 then
		if PIGraceList[raceName] then
			raceName = PIGraceList[raceName]
		end
		local raceName = lower(raceName)
		if (fixedRaceAtlasNames[raceName]) then
			raceName = fixedRaceAtlasNames[raceName];
		end
		local race_icon = "raceicon-"..raceName.."-"..genders[gender]
		if race_icon then
			return race_icon
		end
	end
	return "Forge-ColorSwatchBackground"
end
local function GetRaceClassFormat(file,iconH,texW,left,right,top,bottom,color)
	if color then
		return "|T"..file..":"..iconH..":"..iconH..":0:0:"..texW..":"..texW..":"..left..":"..right..":"..top..":"..bottom..color.."|t"
	else
		return "|T"..file..":"..iconH..":"..iconH..":0:0:"..texW..":"..texW..":"..left..":"..right..":"..top..":"..bottom.."|t"
	end
end
function Fun.GetRaceClassTXT(iconH,texW,race,sex,class,color)
	local RaceX,ClassX = "",""
	if race and sex then
		local race_icon = Fun.PIGGetRaceAtlas(race,sex)
		local Texinfo = C_Texture.GetAtlasInfo(race_icon)
		if Texinfo then
			if PIG_MaxTocversion() then
				local left=Texinfo.leftTexCoord*texW+5
				local right=Texinfo.rightTexCoord*texW-5
				local top=Texinfo.topTexCoord*texW+5
				local bottom=Texinfo.bottomTexCoord*texW-5
				RaceX=GetRaceClassFormat(Texinfo.file,iconH,texW,left,right,top,bottom,color)
			else
				local left=Texinfo.leftTexCoord*texW+2
				local right=Texinfo.rightTexCoord*texW-1
				local top=Texinfo.topTexCoord*texW+3
				local bottom=Texinfo.bottomTexCoord*texW-3
				RaceX=GetRaceClassFormat(Texinfo.file,iconH,texW,left,right,top,bottom,color)
			end
		end
	end
	if class then
		local leftCoord,rightCoord,topCoord,bottomCoord = unpack(CLASS_ICON_TCOORDS[class])
		local left=leftCoord*texW+9
		local right=rightCoord*texW-9
		local top=topCoord*texW+9
		local bottom=bottomCoord*texW-9
		ClassX=GetRaceClassFormat(131146,iconH,texW,left,right,top,bottom,color)
	end
	return RaceX,ClassX
end

--压缩数字======
local p=PD.Create.pig64
local pig_yasuo = {}
local pig_jieya = {}
do
    local xuhao = 1
    for asciiCode = string.byte('A'), string.byte('Z') do
        local char = char(asciiCode)
        pig_yasuo[xuhao] = char
        xuhao = xuhao + 1
    end
    for asciiCode = string.byte('a'), string.byte('z') do
        local char = char(asciiCode)
        pig_yasuo[xuhao] = char
        xuhao = xuhao + 1
    end
    for asciiCode = string.byte('A'), string.byte('Z') do
        local char = char(asciiCode)
        pig_yasuo[xuhao] = char .. char
        xuhao = xuhao + 1
    end
    for asciiCode = string.byte('a'), string.byte('z') do
        local char = char(asciiCode)
        pig_yasuo[xuhao] = char .. char
        xuhao = xuhao + 1
    end
    for asciiCode = string.byte('A'), string.byte('Z') do
        local char = char(asciiCode)
        local charmin = char:lower()
        pig_yasuo[xuhao] = char .. charmin
        xuhao = xuhao + 1
    end
    for asciiCode = string.byte('A'), string.byte('Z') do
        local char = char(asciiCode)
        local charmin = char:lower()
        pig_yasuo[xuhao] = charmin .. char
        xuhao = xuhao + 1
    end
    for k, v in pairs(pig_yasuo) do
        pig_jieya[v] = k
    end
end
function Fun.yasuo_NumberString(sss)
    if not sss or sss == "" then return "" end
    local txtmsg = ""
    local count = 1
    local lastChar = nil
    for i = 1, #sss do
        local char = sss:sub(i, i)
        if lastChar and (not lastChar:match("%d")) then
            txtmsg = txtmsg .. lastChar
            lastChar = nil
            count = 0
        end
        if char:match("%d") then
            if char == lastChar then
                count = count + 1
            else
                if lastChar and lastChar:match("%d") then
                    if count > 1 then
                        local comp = pig_yasuo[count]
                        txtmsg = txtmsg .. lastChar .. (comp or tostring(count))
                    else
                        txtmsg = txtmsg .. lastChar
                    end
                elseif lastChar then
                    txtmsg = txtmsg .. lastChar
                end
                count = 1
                lastChar = char
            end
        else
            if lastChar and lastChar:match("%d") then
                if count > 1 then
                    local comp = pig_yasuo[count]
                    txtmsg = txtmsg .. lastChar .. (comp or tostring(count))
                else
                    txtmsg = txtmsg .. lastChar
                end
                lastChar = nil
                count = 0
            end
            txtmsg = txtmsg .. char
        end
    end
    if lastChar then
        if lastChar:match("%d") then
            if count > 1 then
                local comp = pig_yasuo[count]
                txtmsg = txtmsg .. lastChar .. (comp or tostring(count))
            else
                txtmsg = txtmsg .. lastChar
            end
        else
            txtmsg = txtmsg .. lastChar
        end
    end
    return txtmsg
end
function Fun.jieya_NumberString(sss)
    if not sss or sss == "" then return "" end
    local txtdec = ""
    local i = 1
    while i <= #sss do
        local char = sss:sub(i, i)
        if char:match("%d") then
            local digit = char
            i = i + 1
            local nextChar1 = sss:sub(i, i)
            if nextChar1 and pig_jieya[nextChar1] then
                local repeatCount = pig_jieya[nextChar1]
                for _ = 1, repeatCount do
                    txtdec = txtdec .. digit
                end
                i = i + 1
            else
                local nextChar2 = sss:sub(i, i + 1)
                if nextChar2 and #nextChar2 == 2 and pig_jieya[nextChar2] then
                    local repeatCount = pig_jieya[nextChar2]
                    for _ = 1, repeatCount do
                        txtdec = txtdec .. digit
                    end
                    i = i + 2
                else
                    txtdec = txtdec .. digit
                end
            end
        else
            txtdec = txtdec .. char
            i = i + 1
        end
    end

    return txtdec
end
--压缩配置
local pig_teshuzifu = {"&","@","#"}
function Fun.quchu_teshufuhao(str)
   	for i=1,#pig_teshuzifu do
        str = str:gsub(pig_teshuzifu[i], "")
    end
    return str
end
local pig_yasuoCF = {
	['"%]=true,']="&",
	['"%]=false,']="@",
	['"%]={%["']="#",
}
local pig_yasuoCF_1 = {
	['"%]=true']="&_",
	['"%]=false']="@_",
	['"%]={']="#_",
}
local pig_yasuoCF_2 = {
	[']="BOTTOMRIGHT"']="&~",
	[']="RIGHT"']="@~",
	[']="CENTER"']="#~",
}
local pig_yasuoCF_3 = {
	['%]=true']="&~",
	['%]=false']="@~",
	['%]={}']="#~",
	['%]="N/A"']="#1",
	['%]=0']="&1",
	['%]=""']="@1",
}
local pig_jieyaCF = {}
local pig_jieyaCF_1 = {}
local pig_jieyaCF_2 = {}
do
	for k,v in pairs(pig_yasuoCF) do
		pig_jieyaCF[v]=k
	end
	for k,v in pairs(pig_yasuoCF_1) do
		pig_jieyaCF_1[v]=k
	end
	for k,v in pairs(pig_yasuoCF_2) do
		pig_jieyaCF_2[v]=k
	end
end
function Fun.yasuo_string(str)
	str = Fun.quchu_teshufuhao(str)
    for key, value in pairs(pig_yasuoCF) do
        str = str:gsub(key, tostring(value))
    end
    for key, value in pairs(pig_yasuoCF_1) do
        str = str:gsub(key, tostring(value))
    end
    for key, value in pairs(pig_yasuoCF_2) do
       str = str:gsub(key, tostring(value))
    end
    return str
end
function Fun.jieya_string(str)
	for key, value in pairs(pig_jieyaCF_2) do
       str = str:gsub(key, tostring(value))
    end
    for key, value in pairs(pig_jieyaCF_1) do
        str = str:gsub(key, tostring(value))
    end
    for key, value in pairs(pig_jieyaCF) do
        str = str:gsub(key, tostring(value))
    end
    return str
end
--转码
function Fun.Base64_encod(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return p:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
function Fun.Base64_decod(data)
    data = data:gsub('[^'..p..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(p:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return char(c)
    end))
end