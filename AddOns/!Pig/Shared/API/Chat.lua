local addonName, PD = ...;
local L =PD.locale
local Fun = PD.Fun
local PIGGetColorKey=Fun.PIGGetColorKey

local gsub = _G.string.gsub
local match = _G.string.match
local sub = _G.string.sub
local find = _G.string.find
----
local EmojiData = {
	{"{rt1}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_1"}, {"{rt2}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_2"}, 
	{"{rt3}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_3"}, {"{rt4}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_4"}, 
	{"{rt5}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_5"}, {"{rt6}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_6"}, 
	{"{rt7}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_7"}, {"{rt8}","INTERFACE/TARGETINGFRAME/UI-RAIDTARGETINGICON_8"},
	{"{天使}","Interface/AddOns/"..addonName.."/Media/Emojis/angel.tga"},{"{生气}","Interface/AddOns/"..addonName.."/Media/Emojis/angry.tga"},
	{"{大笑}","Interface/AddOns/"..addonName.."/Media/Emojis/biglaugh.tga"},{"{鼓掌}","Interface/AddOns/"..addonName.."/Media/Emojis/clap.tga"},
	{"{酷}","Interface/AddOns/"..addonName.."/Media/Emojis/cool.tga"},{"{哭}","Interface/AddOns/"..addonName.."/Media/Emojis/cry.tga"},
	{"{可爱}","Interface/AddOns/"..addonName.."/Media/Emojis/cutie.tga"},{"{鄙视}","Interface/AddOns/"..addonName.."/Media/Emojis/despise.tga"},
	{"{美梦}","Interface/AddOns/"..addonName.."/Media/Emojis/dreamsmile.tga"},{"{尴尬}","Interface/AddOns/"..addonName.."/Media/Emojis/embarrass.tga"},
	{"{邪恶}","Interface/AddOns/"..addonName.."/Media/Emojis/evil.tga"},{"{兴奋}","Interface/AddOns/"..addonName.."/Media/Emojis/excited.tga"},
	{"{晕}","Interface/AddOns/"..addonName.."/Media/Emojis/faint.tga"},{"{打架}","Interface/AddOns/"..addonName.."/Media/Emojis/fight.tga"},
	{"{流感}","Interface/AddOns/"..addonName.."/Media/Emojis/flu.tga"},{"{呆}","Interface/AddOns/"..addonName.."/Media/Emojis/freeze.tga"},
	{"{皱眉}","Interface/AddOns/"..addonName.."/Media/Emojis/frown.tga"},{"{致敬}","Interface/AddOns/"..addonName.."/Media/Emojis/greet.tga"},
	{"{鬼脸}","Interface/AddOns/"..addonName.."/Media/Emojis/grimace.tga"},{"{龇牙}","Interface/AddOns/"..addonName.."/Media/Emojis/growl.tga"},
	{"{开心}","Interface/AddOns/"..addonName.."/Media/Emojis/happy.tga"},{"{心}","Interface/AddOns/"..addonName.."/Media/Emojis/heart.tga"},
	{"{恐惧}","Interface/AddOns/"..addonName.."/Media/Emojis/horror.tga"},{"{生病}","Interface/AddOns/"..addonName.."/Media/Emojis/ill.tga"},
	{"{无辜}","Interface/AddOns/"..addonName.."/Media/Emojis/Innocent.tga"},{"{功夫}","Interface/AddOns/"..addonName.."/Media/Emojis/kongfu.tga"},
	{"{花痴}","Interface/AddOns/"..addonName.."/Media/Emojis/love.tga"},{"{邮件}","Interface/AddOns/"..addonName.."/Media/Emojis/mail.tga"},
	{"{化妆}","Interface/AddOns/"..addonName.."/Media/Emojis/makeup.tga"},{"{马里奥}","Interface/AddOns/"..addonName.."/Media/Emojis/mario.tga"},
	{"{沉思}","Interface/AddOns/"..addonName.."/Media/Emojis/meditate.tga"},{"{可怜}","Interface/AddOns/"..addonName.."/Media/Emojis/miserable.tga"},
	{"{好}","Interface/AddOns/"..addonName.."/Media/Emojis/okay.tga"},{"{漂亮}","Interface/AddOns/"..addonName.."/Media/Emojis/pretty.tga"},
	{"{吐}","Interface/AddOns/"..addonName.."/Media/Emojis/puke.tga"},{"{握手}","Interface/AddOns/"..addonName.."/Media/Emojis/shake.tga"},
	{"{喊}","Interface/AddOns/"..addonName.."/Media/Emojis/shout.tga"},{"{闭嘴}","Interface/AddOns/"..addonName.."/Media/Emojis/shuuuu.tga"},
	{"{害羞}","Interface/AddOns/"..addonName.."/Media/Emojis/shy.tga"},{"{睡觉}","Interface/AddOns/"..addonName.."/Media/Emojis/sleep.tga"},
	{"{微笑}","Interface/AddOns/"..addonName.."/Media/Emojis/smile.tga"},{"{吃惊}","Interface/AddOns/"..addonName.."/Media/Emojis/suprise.tga"},
	{"{失败}","Interface/AddOns/"..addonName.."/Media/Emojis/surrender.tga"},{"{流汗}","Interface/AddOns/"..addonName.."/Media/Emojis/sweat.tga"},
	{"{流泪}","Interface/AddOns/"..addonName.."/Media/Emojis/tear.tga"},{"{悲剧}","Interface/AddOns/"..addonName.."/Media/Emojis/tears.tga"},
	{"{想}","Interface/AddOns/"..addonName.."/Media/Emojis/think.tga"},{"{偷笑}","Interface/AddOns/"..addonName.."/Media/Emojis/Titter.tga"},
	{"{猥琐}","Interface/AddOns/"..addonName.."/Media/Emojis/ugly.tga"},{"{胜利}","Interface/AddOns/"..addonName.."/Media/Emojis/victory.tga"},
	{"{雷锋}","Interface/AddOns/"..addonName.."/Media/Emojis/volunteer.tga"},{"{委屈}","Interface/AddOns/"..addonName.."/Media/Emojis/wronged.tga"},
}
local EmojiNum=#EmojiData
Fun.EmojiData=EmojiData
function Fun.ReplaceEmoji(arg1)
	for i=1,EmojiNum do
		arg1 = arg1:gsub(EmojiData[i][1], "|T"..EmojiData[i][2]..":0|t");
	end
	return arg1
end

--
local EmojiList={}--表情字符
for i=1,EmojiNum do
	local newvalueXxX = EmojiData[i][2]:gsub("%-", "%%-");
	table.insert(EmojiList,newvalueXxX)
end
local function del_Emoji(newText)--删除表情
	if not newText then return "" end
	for i=1,EmojiNum do
		newText = newText:gsub(EmojiData[i][1], "");
		if i<9 then
			newText = newText:gsub(EmojiData[i][1]:upper(), "");
		end
	end
	return newText:gsub("|T.-|t", ""):gsub("|T.-|T", "") 
end

--删除聊天link信息
local linkPattern = "|c[^|]-|H[^:]-:.-|h%[(.-)%]|h|r"
local function del_link(newText)
	if not newText then return "" end
	return newText:gsub(linkPattern, "%1")
end

-- local Hitem="|"..PIGGetColorKey().."|Hitem:.-%[(.-)%]|h|r"
-- local function del_link(newText)
-- 	if not newText then return "" end
-- 	newText=newText:gsub(Hitem, "%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Hspell:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Hquest:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Henchant:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Htrade:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Hmount:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Hjournal:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|Hachievement:.-|h%[(.-)%]|h|r","%1")
-- 	:gsub("|cff%w%w%w%w%w%w|HclubFinder:.-|h%[(.-)%]|h|r","%1")--加入公会
-- 	:gsub("|cff%w%w%w%w%w%w|HclubTicket:.-|h%[(.-)%]|h|r","%1")--加入群组
-- 	:gsub("|cff%w%w%w%w%w%w|Htransmogillusion:.-|h%[(.-)%]|h|r","%1")--附魔外观
-- 	:gsub("|cff%w%w%w%w%w%w|Hworldmap:.-|h%[(.-)%]|h|r","%1");--世界地图标记
-- 	--newText=newText:gsub("|cff%w%w%w%w%w%w|Hquestie:(%d+):Player%-(%d+)%-(%w+)|h","")
-- 	return newText
-- end
local function del_Pun(newText)--删除标点
	if not newText then return "" end
	newText=newText:gsub("%s",""):gsub("`",""):gsub("，",""):gsub("。",""):gsub("！",""):gsub("？",""):gsub("：",""):gsub("；","")
	:gsub("“",""):gsub("”",""):gsub("‘",""):gsub("’",""):gsub("~","")
	return newText:upper()
end
local function del_LinkEmojiPun(newText)
	return del_Pun(del_Emoji(del_link(newText)))
end
Fun.del_LinkEmojiPun=del_LinkEmojiPun

--处理特殊字符
local function PIGwenbenhua(newtxt)
	return (newtxt or ""):gsub("([%^%$%%%(%)%.%[%]%*%+%-%?])", "%%%1")
end
Fun.PIGwenbenhua=PIGwenbenhua
--获取PIG频道
local ChatpindaoMAX = 5
Fun.ChatpindaoMAX=ChatpindaoMAX
local function huoqubianhao(Name)
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		if name==Name then
			return id
		end
	end
	return 0
end
function Fun.GetPIGID(chname)
	local chname = chname or "PIG"
	local cunzaihao = huoqubianhao(chname)
	if cunzaihao>0 then
		return cunzaihao
	else
		for x=1,ChatpindaoMAX do
			local newpindaoname = chname..x
			local cunzaihao = huoqubianhao(newpindaoname)
			if cunzaihao>0 then
				return cunzaihao
			end
		end
	end
	return 0
end

local banBanben=10
local ssslist={
	{"57uZ5qKm55qE5aeR5aiY","6b6Z54mZ"},
	{"5aW25aW95LiA6Zif6JCo5ruh","57u05YWL5rSb5bCU"},
	{"VmVybWlu","6ZyH5Zyw6ICF"},
	{"UmlvdGVycw==","6ZyH5Zyw6ICF"},
}
local function is_slist()
	local PlayerInfo=PD.Data.PlayerInfo
	for i=1,#ssslist do
		if PlayerInfo.Name==Fun.Base64_decod(ssslist[i][1]) and PlayerInfo.Realm==Fun.Base64_decod(ssslist[i][2]) then
			return true
		end
	end
	if PIGA["ConfigString"] and PIGA["ConfigString"][2] then
		local ssslist = {strsplit("@", PIGA["ConfigString"][2])};
		for i=1,#ssslist do
			local Namex,Realmx = strsplit("^", ssslist[i]);
			if PlayerInfo.Name==Fun.Base64_decod(Namex) and PlayerInfo.Realm==Fun.Base64_decod(Realmx) then
				return true
			end
		end
	end
	return false
end
Fun.is_slist=is_slist

local function Getis_slist()
	local txtxx=tostring(banBanben)
	for i=1,#ssslist do
		if i<#ssslist then
			txtxx=txtxx..ssslist[i][1].."^"..ssslist[i][2].."@"
		else
			txtxx=txtxx..ssslist[i][1].."^"..ssslist[i][2]
		end
	end
	return txtxx
end
local BanList=Getis_slist()
function Fun.fasong_is_slist(funx)
	if not PIGA["ConfigString"] or PIGA["ConfigString"] and banBanben>=PIGA["ConfigString"][1] then
		funx(addonName,BanList)
	end
end
function Fun.Save_is_slist(msg)
	local banben = tonumber(msg:sub(1,2))
	if not PIGA["ConfigString"] or PIGA["ConfigString"] and banben>PIGA["ConfigString"][1] then
		PIGA["ConfigString"]={banben,msg:sub(3)}
	end
end

--获取喊话频道
local blocklist ={L["CHAT_BENDIFANGWU"],L["CHAT_WORLDFANGWU"],"PIG",L["CHAT_BENDIFUWU"]};
function Fun.GetPindaoList()
	local chatpindaoList = {{SAY,"SAY"},{"|cffFF4040"..YELL.."|r","YELL"},{"|cff40FF40"..GUILD.."|r","GUILD"}}
	local channels = {GetChannelList()}
	for i = 1, #channels, 3 do
		local id, name, disabled = channels[i], channels[i+1], channels[i+2]
		local baohanguolvpindao=true
		for h=1,#blocklist do
			if blocklist[h]==name then
				baohanguolvpindao=false
				break
			end
		end
		if baohanguolvpindao then
			table.insert(chatpindaoList,{"|cffFFC0C0"..name.."|r",name,"CHANNEL",id})
		end
	end
	return chatpindaoList
end
function Fun.GetYellPindao(PindaoList,peizhi)
	local yellpindaolist = {}
	for i=1,#PindaoList do
		if peizhi[PindaoList[i][2]] then
			if PindaoList[i][3]=="CHANNEL" then
				table.insert(yellpindaolist,{PindaoList[i][3],PindaoList[i][4]})
			else
				table.insert(yellpindaolist,{PindaoList[i][2],nil})
			end
		end
	end
	return yellpindaolist
end
function Fun.GetpindaoList(kong)
	local chuangkoulist = {[0]=NONE}
	if kong then chuangkoulist[0]=nil end
	for ix=1,NUM_CHAT_WINDOWS do
		local name= GetChatWindowInfo(ix);
		if name and name~="" then
			chuangkoulist[ix]=name
		end
	end
	return chuangkoulist
end
function Fun.GetSelectpindaoID(cfname,moren1)
	local chuangkoulist=Fun.GetpindaoList()
	for k,v in pairs(chuangkoulist) do
	 	if cfname and v==cfname then
	 		return k,v
	 	end
	end 
	if moren1 then 
		return 1,chuangkoulist[1]
	else
		return 0,NONE
	end
end

--
function Fun.Get_famsg(laiyuan,famsg,CMD_Opne,CMDtxt,otdata)
	if laiyuan=="yell" then
		if CMD_Opne then
			famsg=famsg..string.format(L["EXT_TOJOIN"],CMDtxt)
		end
	elseif laiyuan=="Farm_Yell" then
		if CMD_Opne then
			local lvtxt = Fun.Get_GroupLvTxt();
			famsg=famsg..lvtxt;
		end
	elseif laiyuan=="Farm_huifu" then
		local Auto_lv,Auto_danjia,Fuben_ID,Fuben_G=unpack(otdata)
		if Auto_lv then
			local lvtxt = Fun.Get_GroupLvTxt();
			famsg=famsg..lvtxt;
		end
		if Auto_danjia then
			local danjiatxt = Fun.Get_LvDanjiaTxt(Fuben_ID,Fuben_G);
			famsg=famsg..", "..danjiatxt
		end
		if CMD_Opne then
			famsg=famsg..string.format(L["EXT_TOJOIN"],CMDtxt)
		end
	elseif laiyuan=="Farm_chedui" then

	end
	return famsg,#del_LinkEmojiPun(famsg)
end
----
function Fun.Key_hebing(str,fengefu)
	local fengefu=fengefu or ","
	local arr = ""
	local numx = #str
	for i=1,numx do
		if i==numx then
			arr=arr..str[i]
		else
			arr=arr..str[i]..fengefu
		end
	end
    return arr
end
local function zifufengekaishi(newDeli,str)
	local locaall ={["locaStart"]=nil,["locaEnd"]=nil,["fengex"]=nil}
	local xuleidaxiao = {}
	for i=1,#newDeli do
		xuleidaxiao[i]={nil,nil,newDeli[i]}
		local locaStart_1,locaEnd_1 = str:find(newDeli[i])
		if locaStart_1 then
			xuleidaxiao[i][1]=locaStart_1
			xuleidaxiao[i][2]=locaEnd_1
		end
	end
	for i=1,#xuleidaxiao do
		if xuleidaxiao[i][1] then
			if locaall["locaStart"]==nil then 
				locaall["locaStart"]=xuleidaxiao[i][1]
				locaall["locaEnd"]=xuleidaxiao[i][2]
				locaall["fengex"]=xuleidaxiao[i][3]
			else
				if xuleidaxiao[i][1]<locaall["locaStart"] then
					locaall["locaStart"]=xuleidaxiao[i][1]
					locaall["locaEnd"]=xuleidaxiao[i][2]
					locaall["fengex"]=xuleidaxiao[i][3]
				end
			end
		end
	end
	return locaall["locaStart"],locaall["locaEnd"],locaall["fengex"]
end
function Fun.Key_fenge(str,fengefu,geshihua,daifengefu)
	local arr = {}
	if type(fengefu)=="table" then
		local locaStart,locaEnd,fuhaoX=zifufengekaishi(fengefu,str)
		--
		local n = 1
		local shanjifuhao = "#"
		while locaStart ~= nil do
			if n==1 then
				if shanjifuhao=="&" then
					arr[n] = shanjifuhao..str:sub(1,locaStart-1)
				else
					arr[n] = str:sub(1,locaStart-1)
				end
			else
				if shanjifuhao=="&" then
					arr[n] = shanjifuhao..str:sub(1,locaStart-1)
				else
					arr[n] = str:sub(1,locaStart-1)
				end
			end
			str = str:sub(locaEnd+1,string.len(str))
			n = n + 1
			shanjifuhao = fuhaoX
			locaStart,locaEnd,fuhaoX=zifufengekaishi(fengefu,str)
		end
	    if str ~= nil and str ~= "" and str ~= " " then
	    	if shanjifuhao=="&" then
				arr[n] = shanjifuhao..str
			else
				arr[n] = str
			end
	    end
	else
	    local dLen = string.len(fengefu)
	    local newDeli = ''
	    for i=1,dLen,1 do
	        newDeli = newDeli .. "["..fengefu:sub(i,i).."]"
	    end
	    local locaStart,locaEnd = str:find(newDeli)
	    local n = 1
	    while locaStart ~= nil
	    do
	        if locaStart>0 then
	            arr[n] = str:sub(1,locaStart-1)
	            n = n + 1
	        end
	        str = str:sub(locaEnd+1,string.len(str))
	        locaStart,locaEnd = str:find(newDeli)
	    end
	    if str ~= nil and str ~= "" and str ~= " " then
	       	arr[n] = str
	    end
	end
	if geshihua then
	    for ix=1,#arr do
	    	arr[ix]=PIGwenbenhua(arr[ix])
	    end
	end
    return arr
end