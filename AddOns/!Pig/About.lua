local addonName, addonTable = ...;
local gsub = _G.string.gsub
local L=addonTable.locale
local Create = addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton=Create.PIGButton
local PIGOptionsList=Create.PIGOptionsList
local PIGFontString=Create.PIGFontString
local PIGSetFont=Create.PIGSetFont
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGOptionsList_RF=Create.PIGOptionsList_RF
local Fun=addonTable.Fun
local GetPIGID=Fun.GetPIGID
----------------------------------------
--右侧顶部版本
local Pig_Options=PIG_OptionsUI
Pig_Options.R.top = PIGFrame(Pig_Options.R)
Pig_Options.R.top:SetHeight(24)
Pig_Options.R.top:SetPoint("TOPLEFT", Pig_Options.R, "TOPLEFT", 0, -2)
Pig_Options.R.top:SetPoint("TOPRIGHT", Pig_Options.R, "TOPRIGHT", -2, 0)
Pig_Options.R.top:PIGSetBackdrop()
Pig_Options.R.top:PIGSetMovableNoSave(Pig_Options)
Pig_Options.R.top:PIGClose(25,25,Pig_Options)
Pig_Options.R.top.Ver = CreateFrame("Frame", nil, Pig_Options.R.top)
Pig_Options.R.top.Ver:SetPoint("TOPLEFT", Pig_Options.R.top, "TOPLEFT", 0, 0)
Pig_Options.R.top.Ver:SetPoint("BOTTOMRIGHT", Pig_Options.R.top, "BOTTOMRIGHT", -30, 0)
Pig_Options.VersionID=0
function Pig_Options:GetVer_NUM(EXTaddname,ly)
	if ly=="audio" then
		return Pig_Options.R.top.audioVer and Pig_Options.R.top.audioVer[EXTaddname].VersionID or 0
	else
		return Pig_Options.R.top.Ver and Pig_Options.R.top.Ver[EXTaddname].VersionID or 0
	end
end
function Pig_Options:GetVer_TXT(EXTaddname,ly)
	if ly=="audio" then
		return Pig_Options.R.top.audioVer and Pig_Options.R.top.audioVer[EXTaddname].VersionTXT or 0
	else
		return Pig_Options.R.top.Ver and Pig_Options.R.top.Ver[EXTaddname].VersionTXT or 0
	end
end
function Pig_Options:SetVer_EXT(EXTaddname,ly)
	local VersionTXT=PIGGetAddOnMetadata(EXTaddname, "Version")
	local VersionID=tonumber(VersionTXT)
	if ly=="audio" then
		Pig_Options.R.top.audioVer=Pig_Options.R.top.audioVer or{}
		Pig_Options.R.top.audioVer[EXTaddname]=Pig_Options.R.top.audioVer[EXTaddname] or {}
		Pig_Options.R.top.audioVer[EXTaddname].VersionID=VersionID
		Pig_Options.R.top.audioVer[EXTaddname].VersionTXT=VersionTXT
	else
		local ziframe = {Pig_Options.R.top.Ver:GetChildren()}
		local verF = PIGFrame(Pig_Options.R.top.Ver,nil,{0.0001,20})
		Pig_Options.R.top.Ver[EXTaddname]=verF
		verF.VersionTXT=VersionTXT
		verF.VersionID=VersionID
		if #ziframe==0 then
			verF:SetPoint("LEFT", Pig_Options.R.top.Ver, "LEFT", 4, -2)
		else
			verF:SetPoint("LEFT", ziframe[#ziframe].txt, "RIGHT", 0, 0)
		end
		verF.txt = PIGFontString(verF,{"LEFT", verF, "LEFT", 0, 0})
		verF.New = verF:CreateTexture();
		verF.New:SetAtlas("loottoast-arrow-purple");
		verF.New:SetSize(14,15);
		verF.New:SetPoint("BOTTOMLEFT", verF.txt, "TOPRIGHT", -6, -11);
		verF.New:Hide()
	end
end
local VerTXT = "|cffFFD700%s:|r|cff00FF00%s|r"
Pig_Options:HookScript("OnShow", function (self)
	for i=1,#L.addnames do
		local EXTverF=self.R.top.Ver[L.addnames[i]]
		if EXTverF then
			if L.addnames[i]==addonName then
				EXTverF.txt:SetText(string.format(VerTXT,GAME_VERSION_LABEL,EXTverF.VersionTXT))
			else
				EXTverF.txt:SetText("|cff00FFFF + |r"..string.format(VerTXT,L.addnames[i],EXTverF.VersionTXT))
			end
			if PIGA["Ver"][L.addnames[i]] and PIGA["VerC"][L.addnames[i]] then
				if EXTverF.VersionID<PIGA["Ver"][L.addnames[i]] and #PIGA["VerC"][L.addnames[i]].p>4 then
					EXTverF.New:Show()
					if L.addnames[i]==addonName then
						self.UpdateVer:Show()
					end
				end
			end
		end
	end
end);

------
local fuFrame = PIGOptionsList(L["ABOUT_TABNAME"],"BOT")
local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
local aboutF,aboutBut =PIGOptionsList_R(RTabFrame,L["ABOUT_TABNAME"],90)
aboutF:Show()
aboutBut:Selected(true)
local Aboutdata={
	["Mail"] = "xdfxjf1004@hotmail.com",
	["Tutorial"] = "哔哩哔哩/抖音搜geligasi",
	["Disc"]="QQ群27397148,  2群117883385,  YY频道113213",
}
if GetLocale() ~= "zhCN" and GetLocale() ~= "zhTW" then
	Aboutdata.Tutorial = "YouTube@geligasi"
	Aboutdata.Disc="---"
end
aboutF:HookScript("OnShow", function (self)
	if not self.addok then
		local YY=-10
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},"xdfxjf1004@hotmail.com",L["ABOUT_MAIL"],nil,480)
		YY=YY-30
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},Aboutdata.Tutorial,L["ABOUT_TUTORIAL"],nil,480)
		YY=YY-30
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},Aboutdata.Disc,L["ABOUT_DISC"],nil,480)
		YY=YY-31
		PIGLine(self,"TOP",YY)
		self.addok=true
	end
end);

--扩展
local extF,extBut =PIGOptionsList_R(RTabFrame,L["ABOUT_TABNAME2"],90)
extF:HookScript("OnShow", function (self)
	if not self.addok then
		local YY=-10
		for ExtID=1,#L.addnames do
			local addname=L.addnames[ExtID]
			local adddata=L.ExtList[addname]
			YY=ExtID>1 and YY-100 or YY
			Create.add_extLsitFrame("error",self,addname,adddata,YY)
		end
		self.addok=true
	end
end);
--语音
local audioF,audioBut =PIGOptionsList_R(RTabFrame,VOICE,90)
audioF:HookScript("OnShow", function (self)
	if not self.addok then
		local YY=-10
		for ExtID=1,#L.audioName do
			local addname=L.audioName[ExtID]
			local adddata=L.AudioList[addname]
			YY=ExtID>1 and YY-100 or YY
			Create.add_extLsitFrame("error",self,addname,adddata,YY)
		end
		self.addok=true
	end
end);
----版本更新
local Ver_biaotou="!Pig_VER";
PIG_OptionsUI.Ver_biaotou=Ver_biaotou
C_ChatInfo.RegisterAddonMessagePrefix(Ver_biaotou)
local function ISchongfuP(name,data)
	for i=1,#data do
		if name==data[i] then
			return true
		end
	end
	return false
end
local function GetExtVerInfo(uifff,EXTName,EXTlocalV, arg1, arg2, arg3, arg4, arg5)
	if arg1 ~= Ver_biaotou then return end
	local getName, getype, getVer = strsplit("#", arg2);
	if getype=="X" then
		Fun.Save_is_slist(getVer)
	else
		local getVer=tonumber(getVer)
		if arg3=="WHISPER" then
			if getype=="V" then--存储手动请求的版本信息
				PIG_Version.infoList[arg5]=PIG_Version.infoList[arg5] or {}
				PIG_Version.infoList[arg5][getName]=getVer
			else
				if getName~=EXTName then return end
				if getype=="G" then--请求版本号
					PIGSendAddonMessage(Ver_biaotou,EXTName.."#V#"..EXTlocalV,"WHISPER",arg4)
				elseif getype=="D" then--收到其他玩家版本号
					if uifff.yiGenxing then return end
					if getVer>EXTlocalV then
						uifff.yiGenxing=true;
						PIGA["Ver"][EXTName]=getVer
						PIGA["VerC"][EXTName]= {["verno"]=0,["p"]={}}
						PIGA["VerC"][EXTName]=PIGA["VerC"][EXTName] or {["verno"]=0,["p"]={}}
						if getVer>PIGA["VerC"][EXTName].verno then
							PIGA["VerC"][EXTName].p={}
							PIGA["VerC"][EXTName].verno=getVer
							if not ISchongfuP(arg5,PIGA["VerC"][EXTName].p) then
								table.insert(PIGA["VerC"][EXTName].p,arg5)
							end
						elseif getVer==PIGA["VerC"][EXTName].verno then
							if not ISchongfuP(arg5,PIGA["VerC"][EXTName].p) then
								table.insert(PIGA["VerC"][EXTName].p,arg5)
							end
						end
						-- print("--------")
						-- print("插件名    :"..EXTName)
						-- print("版本      :"..EXTlocalV)
						-- print("消息      :"..arg2)
						-- print("频道      :"..arg3)
						-- print("名字+服务器:"..arg4)
						-- print("名字      :"..arg5)
						if EXTName==addonName then
							PIGprint(L["ABOUT_UPDATETIPS"],"R")
						end
					end
				end
			end
		else
			if getName~=EXTName then return end
			if getype=="U" then--回复更新请求
				if getVer<EXTlocalV then--小于自己版本
					--不是自己
					if arg4==PIG_OptionsUI.AllName then return end
					if arg5==PIG_OptionsUI.Name then return end
					PIGSendAddonMessage(Ver_biaotou,EXTName.."#D#"..EXTlocalV+0.01,"WHISPER",arg4)
				end
			end
		end
	end
end
local function SendExtVerInfo(fsMsg,adname,exuix)
	if PIGA["Ver"][adname] and PIGA["VerC"][adname] then
		if PIGA["Ver"][adname]>PIG_OptionsUI:GetVer_NUM(adname) and #PIGA["VerC"][adname].p>4 then
			exuix.yiGenxing=true;
			return
		end
	end
	if PIG_MaxTocversion(100000) then
		PIGSendAddonMessage(Ver_biaotou,fsMsg,"YELL")
	else
		local PIGID=GetPIGID("PIG")
		if PIGID>0 then
			PIGSendAddonMessage(Ver_biaotou,fsMsg,"CHANNEL",PIGID)
		end
	end
	--if IsInGuild() then PIGSendAddonMessage(Ver_biaotou,fsMsg,"GUILD") end
	if IsInRaid() then
		if IsInRaid(LE_PARTY_CATEGORY_HOME) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"RAID") end
		if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"INSTANCE_CHAT") end
	elseif IsInGroup() then
		if IsInGroup(LE_PARTY_CATEGORY_HOME) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"PARTY") end
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then PIGSendAddonMessage(Ver_biaotou,fsMsg,"INSTANCE_CHAT") end
	end
end
PIG_OptionsUI.GetExtVerInfo=GetExtVerInfo
PIG_OptionsUI.SendExtVerInfo=SendExtVerInfo
---
fuFrame:RegisterEvent("CHAT_MSG_ADDON"); 
fuFrame:RegisterEvent("PLAYER_LOGIN");            
fuFrame:SetScript("OnEvent",function(self, event, arg1, arg2, arg3, arg4, arg5)
	if event=="CHAT_MSG_ADDON" then
		GetExtVerInfo(self,addonName,PIG_OptionsUI:GetVer_NUM(addonName), arg1, arg2, arg3, arg4, arg5)
	elseif event=="PLAYER_LOGIN" then
		Fun.fasong_is_slist(SendExtVerInfo)
		if PIGA["Ver"][addonName] and PIGA["VerC"][addonName] then
			if PIGA["Ver"][addonName]>PIG_OptionsUI:GetVer_NUM(addonName) and PIGA["VerC"][addonName] and #PIGA["VerC"][addonName].p>4 then
				self.yiGenxing=true;
				PIGprint(L["ABOUT_UPDATETIPS"],"R")
				return
			end
		end
		SendExtVerInfo(addonName.."#U#"..PIG_OptionsUI:GetVer_NUM(addonName))
	end
end)