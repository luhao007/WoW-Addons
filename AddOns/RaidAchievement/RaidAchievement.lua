﻿function PhoenixStyleEA_OnLoad()

psealocalem()
if GetLocale()=="deDE" or GetLocale()=="ruRU" or GetLocale()=="zhTW" or GetLocale()=="zhCN" or GetLocale()=="frFR" or GetLocale()=="koKR" or GetLocale()=="esES" or GetLocale()=="esMX" or GetLocale()=="ptBR" then
  psealocale()
end


	raversion=11.110
	local raverstiptext="alpha"
	if string.len(raversion)==6 then
		raverstiptext="beta"
	elseif string.len(raversion)<6 then
		raverstiptext="release"
	end
	raversshow="ver-"..raversion.." ("..raverstiptext..")"
	if thisaddonworkea==nil then thisaddonworkea=true end
	if pseashowfailreas==nil then pseashowfailreas=true end
	if pseashownewvervar==nil then pseashownewvervar=true end
	if wherereportraidach==nil then wherereportraidach="raid" end
	if wherereportpartyach==nil then wherereportpartyach="party" end
	if raminibutshowt==nil then raminibutshowt=true end
	if raannouncerun4==nil then raannouncerun4=0 end
	if RA_Settings==nil then RA_Settings = {RAMinimapPos = -176} end
	rabigmenuchatlisten={"raid", "raid_warning", "officer", "party", "guild", "say", "yell", "sebe"}
	ralowmenuchatlisten={"party", "officer", "guild", "say", "yell", "sebe"}
	if rasoundtoplay==nil then rasoundtoplay={1,1,1,2,5,0} end
	rasoundtrack={"alarmclockbeeps1.ogg","alarmclockbeeps2.ogg","alarmclockbeeps3.ogg","fireworks.ogg","applause.ogg","gong.ogg","cat.ogg","bam.ogg","Xylo.ogg","Alert.ogg","igQuestFailed","QUESTCOMPLETED","QUESTADDED","PVPENTERQUEUE","PVPTHROUGHQUEUE","igPlayerInvite","igPlayerInviteDecline","igBackPackClose","AuctionWindowOpen","AuctionWindowClose","RaidWarning","ReadyCheck","mario.ogg"}

	ramsgupdate=0
	ramsgtimestart=0
	ramsgwaiting=0
	ramsgmychat=""
	racanannouncetable={}
	raannouncewait={}
	if raenablebg==nil then raenablebg=1 end

	raachdone1=true
	raachdone2=true
	raachdone3=true
	raachdone4=true
	raachdone5=true
	ratime1=0
	ratime2=0
	rabattlev=0
	if raquantrepeatach==nil then raquantrepeatach=5 end
	if raquantrepeatachtm==nil then raquantrepeatachtm=2 end
	raquantrepdone=1
	if raoldvern2==nil then raoldvern2=0 end


	SLASH_PHOENIXSTYLEEASYACH1 = "/RaidAchievement"
	SLASH_PHOENIXSTYLEEASYACH2 = "/raidach"
	SLASH_PHOENIXSTYLEEASYACH3 = "/rach"
	SLASH_PHOENIXSTYLEEASYACH4 = "/fena"
	SLASH_PHOENIXSTYLEEASYACH5 = "/фена"
	SLASH_PHOENIXSTYLEEASYACH6 = "/фениксач"
	SLASH_PHOENIXSTYLEEASYACH7 = "/рейдач"
	SLASH_PHOENIXSTYLEEASYACH8 = "/рач"
	SLASH_PHOENIXSTYLEEASYACH9 = "/ра"
	SLASH_PHOENIXSTYLEEASYACH10 = "/raida"
	SlashCmdList["PHOENIXSTYLEEASYACH"] = PHOENIXSTYLEEASYACH_Command
	
	
	RaidAchievementframe:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievementframe:RegisterEvent("CHAT_MSG_ADDON")
	RaidAchievementframe:RegisterEvent("CHAT_MSG_INSTANCE_CHAT")
	RaidAchievementframe:RegisterEvent("PLAYER_ALIVE")
	RaidAchievementframe:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievementframe:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievementframe:RegisterEvent("ADDON_LOADED")
	RaidAchievementframe:RegisterEvent("PLAYER_ENTERING_WORLD")


end



function ramain_OnUpdate()

local racurrenttime = GetTime()

if radelaysec20 and racurrenttime>radelaysec20 then
  radelaysec20=nil
  raaddonloadedcheckspam()
end

if racheckbossincombat and racurrenttime>racheckbossincombat+1 then
racheckbossincombat=racurrenttime
if UnitName("boss1") and UnitName("boss1")~="" then
else
racheckbossincombat=nil
end
end


if racheckdatay and GetTime()>racheckdatay then
racheckdatay=nil
if raaddoninstalledsins==nil then
local _, month, day, year = tonumber(date("%H")),tonumber(date("%m")),tonumber(date("%d")),tonumber(date("%y"))
if year==2010 and month==10 and day<30 then
raaddoninstalledsins="..."
elseif year and year>2009 then
raaddoninstalledsins=day.."/"..month.."/"..year
end
end
end


if radelaybeforezonech and racurrenttime>radelaybeforezonech+4 then
radelaybeforezonech=nil
chechtekzoneea()
end


--многократный анонс обнуление
if ramanyachon and (raachdone1==false or raachdone2==false or raachdone3==false or raachdone4==false or raachdone5==false or whraachdone1==false or chraachdone1==false or phraachdone1==false or pzraachdone1==false) and raquantrepeatach>=raquantrepdone and radelaybeforerezetach==nil and raquantrepeatachtm>0 then
radelaybeforerezetach=GetTime()+raquantrepeatachtm
end

if radelaybeforerezetach and racurrenttime>radelaybeforerezetach then
radelaybeforerezetach=nil
raquantrepdone=raquantrepdone+1
if raachdone1==false then raachdone1=true end
if raachdone2==false then raachdone2=true end
if raachdone3==false then raachdone3=true end
if raachdone4==false then raachdone4=true end
if raachdone5==false then raachdone5=true end
if whraachdone1==false then whraachdone1=true end
if chraachdone1==false then chraachdone1=true end
if phraachdone1==false then phraachdone1=true end
if pzraachdone1==false then pzraachdone1=true end
end



									if ramsgupdate==1 then

if ramsgtimestart>0 and racurrenttime>ramsgtimestart+0.4 then
ramsgtimestart=0
--тут отправда в аддон канал инфы
  if select(3,GetInstanceInfo())==17 or select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  C_ChatInfo.SendAddonMessage("RaidAc", "myname:"..ranamemsgsend.."++mychat:"..ramsgmychat.."++", "Instance_CHAT")
  else
  C_ChatInfo.SendAddonMessage("RaidAc", "myname:"..ranamemsgsend.."++mychat:"..ramsgmychat.."++", "RAID")
  end
end

if ramsgwaiting>0 and racurrenttime>ramsgwaiting+1.5 then
  ramsgwaiting=0
  table.sort(racanannouncetable)
  --тут аннонс and обнуление всех таблиц

  local bililine=0
  for i,cc in ipairs(rabigmenuchatlisten) do 
    if string.lower(cc) == string.lower(ramsgmychat) then bililine=1
    end
  end
  if ramsgmychat=="Instance_CHAT" then
    bililine=1
  end

  if racanannouncetable[1]==ranamemsgsend then
    if bililine==1 then
      for i=1,#raannouncewait do
        SendChatMessage(raannouncewait[i], ramsgmychat)
      end
    else

      local nrchatmy=GetChannelName(ramsgmychat)
      if nrchatmy>0 then
        for i=1,#raannouncewait do
          SendChatMessage(raannouncewait[i], "CHANNEL",nil,nrchatmy)
        end
      end
    end
  end

  table.wipe(raannouncewait)
  table.wipe(racanannouncetable)
  ramsgupdate=0


end
									end


end




function PhoenixStyleEA_OnEvent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...


if event == "PLAYER_ALIVE" then
rabilresnut=GetTime()
end

if event =="PLAYER_ENTERING_WORLD" then
if type(C_ChatInfo.RegisterAddonMessagePrefix) == "function" then
C_ChatInfo.RegisterAddonMessagePrefix ("RaidAc")

--changed into: RAother
C_ChatInfo.RegisterAddonMessagePrefix ("RAother")

--1 RAverwhips "1info"
--2 RAverwhips2 - строчка с инфо версии в приват
--3 RaidAc_info "3info"
--4 RaidAc_info2 - строчка с инфой версии
--5 RA-myvers - номер версии

end
end

if event == "CHAT_MSG_ADDON" then

--изменяем ник свой в чате
if arg4 and string.find(arg4,"%-") then
	if string.sub(arg4,1,string.find(arg4,"%-")-1) == UnitName("player") then
		arg4=UnitName("player")
	end
end

if arg1=="RaidAc" and ramsgwaiting>0 then

local _,rastriniz1=string.find(arg2, "mychat:")
if rastriniz1==nil then else
local rastrfine1=string.find(arg2, "++", rastriniz1)
if string.lower(string.sub(arg2, rastriniz1+1, rastrfine1-1))==string.lower(ramsgmychat) then

--вырезаем ник
local _,rastriniz2=string.find(arg2, "myname:")
if rastriniz2==nil then else
local rastrfine2=string.find(arg2, "++", rastriniz2)

local rabililinet=0
for i,getcrash in ipairs(racanannouncetable) do 
if getcrash == string.sub(arg2, rastriniz2+1, rastrfine2-1) then rabililinet=1
end end
if(rabililinet==0)then
table.insert(racanannouncetable,string.sub(arg2, rastriniz2+1, rastrfine2-1))
end


end
end
end
end


--отправка моей инфы
if arg1=="RAother" and arg2=="3info" then
local ratmp1=0
local ratmp2=""
local psa6=""
if GetLocale() then
psa6=GetLocale()
end
if ralloptions then
ratmp2="ach: "..ralloptions[1]..ralloptions[7]..":"
for x=2,6 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-1)
		x=7
	end
end
for x=8,12 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-7)
		x=13
	end
end

ratmp2=ratmp2.."-"
if rallbosschaton then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
if rallbosstooltip then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
end
if pseashowfailreas then ratmp1="1-"..rasoundtoplay[1]..rasoundtoplay[2]..rasoundtoplay[3]..rasoundtoplay[4]..rasoundtoplay[5]..rasoundtoplay[6] end
C_ChatInfo.SendAddonMessage("RAother", "4RA "..UnitName("player").." v."..raversion.." "..ratmp1.." "..ratmp2.." "..wherereportraidach..wherereportpartyach.." "..psa6.." installed: "..raaddoninstalledsins, arg3)
end

if arg1=="RAother" and arg3=="WHISPER" and arg2=="1info" then
local ratmp1=0
local ratmp2=""
local psa6=""
if GetLocale() then
psa6=GetLocale()
end
if ralloptions then
ratmp2="ach: "..ralloptions[1]..ralloptions[7]..":"
for x=2,6 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-1)
		x=7
	end
end
for x=8,12 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-7)
		x=13
	end
end

ratmp2=ratmp2.."-"
if rallbosschaton then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
if rallbosstooltip then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
end
if pseashowfailreas then ratmp1="1-"..rasoundtoplay[1]..rasoundtoplay[2]..rasoundtoplay[3]..rasoundtoplay[4]..rasoundtoplay[5]..rasoundtoplay[6] end
C_ChatInfo.SendAddonMessage("RAother", "2RA "..UnitName("player").." v."..raversion.." "..ratmp1.." "..ratmp2.." "..wherereportraidach..wherereportpartyach.." "..psa6.." installed: "..raaddoninstalledsins, "WHISPER",arg4)
end

if arg1=="RAother" and arg3=="WHISPER" and arg2 and string.sub(arg2,1,1)=="2" then
print(string.sub(arg2,2))
end



--получение моей инфы
if arg1=="RAother" and rashushinfo and arg2 and string.sub(arg2,1,1)=="4" then
if GetTime()>rashushinfo then rashushinfo=nil else
if arg4==UnitName("player") then else
print(string.sub(arg2,2))
end
end
end

if arg1=="RAother" and arg2 and string.sub(arg2,1,1)=="5" then
if tonumber(string.sub(arg2,2))>raversion then

		if tonumber(string.sub(arg2,2))-raversion>0.0007 then

raoldvern2=tonumber(string.sub(arg2,2))
if raoldvern2>raversion then
PSFeamain3_Textoldv:Show()
end

	if raverschech2==nil and rabattlev==0 and pseashownewvervar then
	raverschech2=1
print ("|cff99ffffRaidAchievement|r - "..ranewversfound)
	end
		end


elseif tonumber(string.sub(arg2,2))<raversion then
if ralastsendbinf==nil or (ralastsendbinf and GetTime()>ralastsendbinf+60) then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, arg3)
ralastsendbinf=GetTime()
end
end
end
end


end


if event == "ZONE_CHANGED_NEW_AREA" then


radelaybeforezonech=GetTime()
	raachdone1=true
	raachdone2=true
	raachdone3=true
	raachdone4=true
	raachdone5=true
	ratime1=0
	ratime2=0
	raquantrepdone=1

	if raverschech1==nil then
raverschech1=1
if (UnitInRaid("player")) then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
if select(3,GetInstanceInfo())==17 or select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, "Instance_CHAT")
else
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, "raid")
end
end
end

if IsInGuild() then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, "guild")
end
	end

end

if event == "ADDON_LOADED" then
if arg1=="RaidAchievement" then

    zzralistach=raralistach
    zzralistach2=raralistach2
    zzralistach3=raralistach3
    zzralistach3_Button1=raralistach3_Button1
    zzralistach3_Button2=raralistach3_Button2
    zzralistach3_ButtonP=raralistach3_ButtonP
    zzralistach3_ButtonN=raralistach3_ButtonN

radelaysec20=GetTime()+25

--font size from PS
rafontsset={11,12}
if psfontsset then
rafontsset[1]=psfontsset[1]
rafontsset[2]=psfontsset[2]
end

local rarcstxt2 = PSFeamain3:CreateFontString()
rarcstxt2:SetWidth(480)
rarcstxt2:SetHeight(45)
rarcstxt2:SetFont(GameFontNormal:GetFont(), 20, 'MONOCHROME')
rarcstxt2:SetPoint("BOTTOMRIGHT",-110,-10)
rarcstxt2:SetJustifyH("RIGHT")
rarcstxt2:SetJustifyV("TOP")
--rarcstxt2:SetText("www.phoenixstyle.com") --временно убрано





















local t4 = PSFeamain3:CreateFontString()
t4:SetWidth(690)
t4:SetHeight(180)
t4:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t4:SetPoint("TOPLEFT",30,-207)

	local atext="|cffff0000Important!|r\n\n|cff00ff00RaidAchievement|r need your help.\n\n|cff00ff00Highlight link and click  Ctrl+C  to copy|r"
  if GetLocale()=="ruRU" then
    atext="|cffff0000Важно!|r\n\n|cff00ff00RaidAchievement|r нуждается в вашей поддержке.\n\n|cff00ff00Выделите ссылку and нажмите  Ctrl+C  чтобы скопировать|r"
  end
  if GetLocale()=="itIT" then
    atext="|cff00ff00Messaggio importante!|r\n\nIl progetto |cff00ff00RaidAchievement|r forse sarà |cffff0000chiuso|r, per sappere cosa si può fare visita il sito\n\n|cff00ff00Evidenzia il link a clicca  Ctrl+C  per copiare|r"
  end

  
raraerrordfdfdpsdonatefr2 = CreateFrame("ScrollFrame", "raraerrordfdfdpsdonatefr2", PSFeamain3, "UIPanelScrollFrameTemplate")
raraerrordfdfdpsdonatefr2:SetPoint("TOPLEFT", PSFeamain3, "TOPLEFT", 275, -405)
raraerrordfdfdpsdonatefr2:SetHeight(40)
raraerrordfdfdpsdonatefr2:SetWidth(220)
  

raraerrordfsdfsdfjy4 = CreateFrame("EditBox", "raraerrordfsdfsdfjy4", raraerrordfdfdpsdonatefr2)
raraerrordfsdfsdfjy4:SetPoint("TOPRIGHT", raraerrordfdfdpsdonatefr2, "TOPRIGHT", 0, 0)
raraerrordfsdfsdfjy4:SetPoint("TOPLEFT", raraerrordfdfdpsdonatefr2, "TOPLEFT", 0, 0)
raraerrordfsdfsdfjy4:SetPoint("BOTTOMRIGHT", raraerrordfdfdpsdonatefr2, "BOTTOMRIGHT", 0, 0)
raraerrordfsdfsdfjy4:SetPoint("BOTTOMLEFT", raraerrordfdfdpsdonatefr2, "BOTTOMLEFT", 0, 0)
raraerrordfsdfsdfjy4:SetScript("onescapepressed", function(self) raraerrordfsdfsdfjy4:ClearFocus() end)
raraerrordfsdfsdfjy4:SetFont(GameFontNormal:GetFont(), 13, 'MONOCHROME')
raraerrordfsdfsdfjy4:SetMultiLine(true)
raraerrordfsdfsdfjy4:SetAutoFocus(false)
raraerrordfsdfsdfjy4:SetHeight(150)
raraerrordfsdfsdfjy4:SetWidth(225)
raraerrordfsdfsdfjy4:Show()
raraerrordfsdfsdfjy4:SetScript("OnTextChanged", function(self) raraerrordfsdfsdfjy4:SetText("http://www.phoenixstyle.com/help") end ) --raraerrordfsdfsdfjy4:HighlightText(0,string.len(raraerrordfsdfsdfjy4:GetText()))

raraerrordfdfdpsdonatefr2:SetScrollChild(raraerrordfsdfsdfjy4)
raraerrordfdfdpsdonatefr2:Show()

--t4:SetText(atext)
t4:SetJustifyH("CENTER")
t4:SetJustifyV("BOTTOM")











if rasoundtoplay[6]==nil and rasoundtoplay then
rasoundtoplay[6]=0
end

if PSFeamain2_Text then
PSFeamain2_Text:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
end

local srcstxt = PSFeamain2:CreateFontString()
srcstxt:SetWidth(180)
srcstxt:SetHeight(25)
srcstxt:SetFont(GameFontNormal:GetFont(), 15, 'MONOCHROME')
srcstxt:SetPoint("TOP",0,-195)
srcstxt:SetJustifyH("CENTER")
srcstxt:SetJustifyV("TOP")
srcstxt:SetText(ramaintrackingtitle..":")

racheckdatay=GetTime()+10


if raoldvern2>raversion then
PSFeamain3_Textoldv:Show()
end

ramapbuttreflesh()

end
end


if event == "PLAYER_REGEN_DISABLED" then
rabattlev=1

local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or (a2=="raid" or a2=="scenario" or (a2=="party" and a3==2) or a3==14) then
--SetMapToCurrentZone()
end

if (rabilresnut and GetTime()<rabilresnut+3) or racheckbossincombat then
else
--обнулять все данные при начале боя тут:

	raachdone1=true
	raachdone2=true
	raachdone3=true
	raachdone4=true
	raachdone5=true
	ratime1=0
	ratime2=0
	raquantrepdone=1

end

end

if event == "PLAYER_REGEN_ENABLED" then

	rabattlev=0
	racheckbossincombat=GetTime()

end

if(lalaproverkaea==nil)then
radelaybeforezonech=GetTime()+3
lalaproverkaea=1
end



end --конец основной функции аддона





--==========МЕНЮ==


function PHOENIXSTYLEEASYACH_Command(msg)


PSFeamain1:Hide()
PSFeamain2:Hide()
PSFea_closeallpr()

PSFeamain1:Show()
PSFeamain2:Show()
PSFeamain3:Show()


openrasound1()
openrasound2()

end


function PSFea_closeallpr()
if C_AddOns.IsAddOnLoaded("RaidAchievement_Ulduar") then PSFea_closeallprUlduar() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WotlkHeroics") then whra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataHeroics") then chra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_Naxxramas") then nxra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_Icecrown") then icra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataRaids") then crra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaRaids") then prra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics") then phra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaScenarios") then pzra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDHeroics") then wodhra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids") then wodrra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionHeroics") then legionhra_closeallpr() end
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionRaids") then legionrra_closeallpr() end
PSFeamain3:Hide()
PSFeamain10:Hide()
PSFeamain11:Hide()
PSFeamain12:Hide()
PSFeamainWotlk:Hide()
PSFeamainmanyach:Hide()
RAthanks:Hide()
RAthanks2:Hide()
PSFeaerrorgeneral:Hide()
raralistach:Hide()
raralistach2:Hide()
raralistach3:Hide()
if C_AddOns.IsAddOnLoaded("AchievementsReminder") then
icralistach:Hide()
icralistach2:Hide()
icralistach3:Hide()
ARmain1:Hide()
end
end

--НАСТРОЙКА данных при загрузке окна настроек
function PSFea_showoptions()

	if rashowopttime1==nil then
rashowopttime1=1


--убирать кнопки взависимости доступные аддоны или нет
if C_AddOns.IsAddOnLoaded("AchievementsReminder") then
  PSFeamain2_ButtonG12:Hide()
  PSFeamain2_ButtonG13:Hide()
else
  PSFeamain2_Button12:Hide()
  PSFeamain2_Button13:Hide()
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_OldModules") or C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics") then
  PSFeamain2_ButtonwotlkG:Hide()
else
  PSFeamain2_Buttonwotlk:Hide()
end



bigmenuchatlistea = {
pseachatlist1,
pseachatlist2,
pseachatlist3,
pseachatlist4,
pseachatlist5,
pseachatlist6,
pseachatlist7,
pseachatlist8,
}

if psfchatadd then
if #psfchatadd>0 then
for i=1,#psfchatadd do
table.insert(bigmenuchatlistea,psfchatadd[i])
end
end
end


lowmenuchatlistea = {
pseachatlist4,
pseachatlist3,
pseachatlist5,
pseachatlist6,
pseachatlist7,
pseachatlist8,
}

if psfchatadd then
if #psfchatadd>0 then
for i=1,#psfchatadd do
table.insert(lowmenuchatlistea,psfchatadd[i])
end
end
end

	end


if (thisaddonworkea) then PSFeamain3_CheckButton1:SetChecked(true) else PSFeamain3_CheckButton1:SetChecked(false) end
if (raminibutshowt) then PSFeamain3_CheckButton11:SetChecked(true) else PSFeamain3_CheckButton11:SetChecked(false) end
if (pseashowfailreas) then PSFeamain3_CheckButton2:SetChecked(true) else PSFeamain3_CheckButton2:SetChecked(false) end
if (pseashownewvervar) then PSFeamain3_CheckButton3:SetChecked(true) else PSFeamain3_CheckButton3:SetChecked(false) end
if (rasoundtoplay[1]==1) then PSFeamain3_CheckButton4:SetChecked(true) else PSFeamain3_CheckButton4:SetChecked(false) end
if (rasoundtoplay[2]==1) then PSFeamain3_CheckButton5:SetChecked(true) else PSFeamain3_CheckButton5:SetChecked(false) end
if (rasoundtoplay[3]==1) then PSFeamain3_CheckButton6:SetChecked(true) else PSFeamain3_CheckButton6:SetChecked(false) end
if (rasoundtoplay[6]==1) then PSFeamain3_CheckButton7:SetChecked(true) else PSFeamain3_CheckButton7:SetChecked(false) end

if (raenablebg==1) then PSFeamain3_CheckButton22:SetChecked(true) else PSFeamain3_CheckButton22:SetChecked(false) end

openmenureportchra11()
openmenureportchra12()
PSFeamain3_tt1:SetText(pseareports.." ("..pseachatlist4..")")
PSFeamain3_tt2:SetText(pseareports.." ("..pseachatlist1..")")

--Текстуру убрал
--	if C_AddOns.IsAddOnLoaded("PhoenixStyle") and ralogocr==nil then
--ralogocr=1
--local t = PSFeamain3:CreateTexture(nil,"OVERLAY")
--t:SetTexture("Interface\\AddOns\\PhoenixStyle\\phoenix_addon")
--t:SetPoint("CENTER",0,0)
--	end

end



function PSFeavkladdon()
	if (PSFeamain3_CheckButton1:GetChecked()) then
		if(thisaddonworkea)then
			else
			thisaddonworkea=true
			chechtekzoneea()
			out("|cff99ffffRaidAchievement|r - "..pseaaddonmy.." |cff00ff00"..pseaaddonon2.."|r.")
		end
	else
			if(thisaddonworkea)then
			out("|cff99ffffRaidAchievement|r - "..pseaaddonmy.." |cffff0000"..pseaaddonoff.."|r.")
			thisaddonworkea=false
			end
	end
ramapbuttreflesh()
end

function PSFeavklshownames()
	if (PSFeamain3_CheckButton2:GetChecked()) then
		pseashowfailreas=true
	else
		pseashowfailreas=false
	end

end

function PSFeavklshownewver()
	if (PSFeamain3_CheckButton3:GetChecked()) then
		pseashownewvervar=true
	else
		pseashownewvervar=false
	end

end

function PSFsoundipt(i)
if rasoundtoplay[i]==1 then
	rasoundtoplay[i]=0
else
	rasoundtoplay[i]=1
end
end


function PSFea_buttonaddon()
PSFea_closeallpr()
PSFeamain3:Show()


openrasound1()
openrasound2()
openmenureportchra11()
openmenureportchra12()
end

function PSFea_buttonulda()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_Ulduar")==false then
C_AddOns.LoadAddOn("RaidAchievement_Ulduar")
if C_AddOns.IsAddOnLoaded("RaidAchievement_Ulduar") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu5.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_Ulduar") then
PSFea_buttonulda2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function whra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_WotlkHeroics")==false then
C_AddOns.LoadAddOn("RaidAchievement_WotlkHeroics")
if C_AddOns.IsAddOnLoaded("RaidAchievement_WotlkHeroics") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu4.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WotlkHeroics") then
whra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function chra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataHeroics")==false then
C_AddOns.LoadAddOn("RaidAchievement_CataHeroics")
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataHeroics") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenucata.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataHeroics") then
chra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function phra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics")==false then
C_AddOns.LoadAddOn("RaidAchievement_PandaHeroics")
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics") then
phra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function pzra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaScenarios")==false then
C_AddOns.LoadAddOn("RaidAchievement_PandaScenarios")
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaScenarios") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda3.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaScenarios") then
pzra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end


function wodhra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDHeroics")==false then
C_AddOns.LoadAddOn("RaidAchievement_WoDHeroics")
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDHeroics") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenuwod.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDHeroics") then
wodhra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function wodrra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids")==false then
C_AddOns.LoadAddOn("RaidAchievement_WoDRaids")
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenuwod2.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids") then
wodrra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end


function legionhra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionHeroics")==false then
C_AddOns.LoadAddOn("RaidAchievement_LegionHeroics")
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionHeroics") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenulegion.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionHeroics") then
legionhra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end


function legionrra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionRaids")==false then
C_AddOns.LoadAddOn("RaidAchievement_LegionRaids")
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionRaids") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenulegion2.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionRaids") then
legionrra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end



function nxra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_Naxxramas")==false then
C_AddOns.LoadAddOn("RaidAchievement_Naxxramas")
if C_AddOns.IsAddOnLoaded("RaidAchievement_Naxxramas") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu31.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_Naxxramas") then
nxra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function icra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
  if C_AddOns.IsAddOnLoaded("RaidAchievement_Icecrown")==false then
    C_AddOns.LoadAddOn("RaidAchievement_Icecrown")
    if C_AddOns.IsAddOnLoaded("RaidAchievement_Icecrown") then
      print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu6.."!")
    end
  end
  if C_AddOns.IsAddOnLoaded("RaidAchievement_Icecrown") then
    icra_button2()
  else
    PSFeamain12:Show()
  end
else
  PSFeamain10:Show()
end
end

function crra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataRaids")==false then
C_AddOns.LoadAddOn("RaidAchievement_CataRaids")
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataRaids") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenucata2.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_CataRaids") then
crra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function prra_button()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaRaids")==false then
C_AddOns.LoadAddOn("RaidAchievement_PandaRaids")
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaRaids") then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda2.."!")
end
end
if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaRaids") then
prra_button2()
else
PSFeamain12:Show()
end
else
PSFeamain10:Show()
end
end

function PSFea_listach()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("AchievementsReminder") then
  if icll_buttonnew2 then
    icll_buttonnew2()
  else
    icll_button2()
  end
else
--PSFeamain12:Show()
raerrorloading(2)
end
else
PSFeamain10:Show()
end
end

function PSFea_tact()
PSFea_closeallpr()
if(thisaddonworkea)then
if C_AddOns.IsAddOnLoaded("AchievementsReminder") then
icll_button33()
else
--PSFeamain12:Show()
raerrorloading(2)
end
else
PSFeamain10:Show()
end
end

function wotlkold_button()
PSFea_closeallpr()
if(thisaddonworkea)then
  if raoldmodules then
    PSFeamainWotlk:Show()
  else
    raerrorloading(1)
  end
else
  PSFeamain10:Show()
end
end

function PSFea_buttonsaveexit()
PSFea_closeallpr()
PSFeamain1:Hide()
PSFeamain2:Hide()
end


function bigmenuchatea(bigma)
if bigma<9 then
	wherereporttempbigma=rabigmenuchatlisten[bigma]
	else wherereporttempbigma=psfchatadd[bigma-8]
end
end

function bigmenuchatea2(bigma2)
bigma2num=0
if (bigma2=="raid") then bigma2num=1
elseif (bigma2=="raid_warning") then bigma2num=2
elseif (bigma2=="officer") then bigma2num=3
elseif (bigma2=="party") then bigma2num=4
elseif (bigma2=="guild") then bigma2num=5
elseif (bigma2=="say") then bigma2num=6
elseif (bigma2=="yell") then bigma2num=7
elseif (bigma2=="sebe") then bigma2num=8
else
	if psfchatadd==nil or #psfchatadd==0 then
	bigma2num=0
	else
		for i=1,#psfchatadd do
			if string.lower(psfchatadd[i])==string.lower(bigma2) then
			bigma2num=i+8
			end
		end

	end
end
end

function lowmenuchatea(bigma)
if bigma<7 then
	wherereporttempbigma=ralowmenuchatlisten[bigma]
	else wherereporttempbigma=psfchatadd[bigma-6]
end
end

function lowmenuchatea2(bigma2)
bigma2num=0
if (bigma2=="party") then bigma2num=1
elseif (bigma2=="officer") then bigma2num=2
elseif (bigma2=="guild") then bigma2num=3
elseif (bigma2=="say") then bigma2num=4
elseif (bigma2=="yell") then bigma2num=5
elseif (bigma2=="sebe") then bigma2num=6
else
	if psfchatadd==nil or #psfchatadd==0 then
	bigma2num=0
	else
		for i=1,#psfchatadd do
			if string.lower(psfchatadd[i])==string.lower(bigma2) then
			bigma2num=i+6
			end
		end

	end
end
end



function chechtekzoneea()
if C_Map.GetBestMapForUnit("player") and C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player")) and C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player")).name then
local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or (a2=="raid" or a2=="scenario" or (a2=="party" and a3==2) or a3==14) then
--SetMapToCurrentZone()
end

--ульдуар
--if C_Map.GetBestMapForUnit("player")==529 then
local idheroics={147,148,149,150,151,152}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_Ulduar")==false and wasuldatryloadea==nil then
wasuldatryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_Ulduar")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu5.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenu5.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--Накс Сарт
--if C_Map.GetBestMapForUnit("player")==535 or C_Map.GetBestMapForUnit("player")==718 or C_Map.GetBestMapForUnit("player")==531 then
local idheroics={162,163,164,165,166,167,248,155}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_Naxxramas")==false and wasnaxtryloadea==nil then
wasnaxtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_Naxxramas")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu31.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenu31.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--Цитадель
--if C_Map.GetBestMapForUnit("player")==604 then
local idheroics={186,187,188,189,190,191,192,193,698,699,700,701}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_Icecrown")==false and wasictryloadea==nil then
wasictryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_Icecrown")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu6.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenu6.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--рейды каты
--if C_Map.GetBestMapForUnit("player")==754 or C_Map.GetBestMapForUnit("player")==758 or C_Map.GetBestMapForUnit("player")==800 or C_Map.GetBestMapForUnit("player")==824 then
local idheroics={285,286,294,295,296,367,368,369,409,410,411,412,413,414,415}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_CataRaids")==false and wascrtryloadea==nil then
wascrtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_CataRaids")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenucata2.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenucata2.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--рейды панды
--if C_Map.GetBestMapForUnit("player")==897 or C_Map.GetBestMapForUnit("player")==896 or C_Map.GetBestMapForUnit("player")==886 or C_Map.GetBestMapForUnit("player")==930 or C_Map.GetBestMapForUnit("player")==953 then
local idheroics={474,475,471,472,473,728,456,508,509,510,511,512,513,514,515,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaRaids")==false and wasprtryloadea==nil then
wasprtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_PandaRaids")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda2.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenupanda2.."! "..raerrormodulereq.." RaidAchievement_Pandaria")
end
end
end

--тут добавить рейды WoD
--if C_Map.GetBestMapForUnit("player")==988 or C_Map.GetBestMapForUnit("player")==1026 then
local idheroics={596,597,598,599,600,661,662,663,664,665,666,667,668,669,670}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids")==false and waswodrtryloadea==nil then
waswodrtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_WoDRaids")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." RaidAchievement_WoDRaids!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." RaidAchievement_WoDRaids! "..raerrormodulereq.." RaidAchievement_WoD")
end
end
end


--тут добавить рейды Legion
--if C_Map.GetBestMapForUnit("player")==1094 or C_Map.GetBestMapForUnit("player")==1088 or C_Map.GetBestMapForUnit("player")==1147 then
local idheroics={777,778,779,780,781,782,783,784,785,786,787,788,789,764,765,766,767,768,769,770,771,772,850,851,852,853,854,855,856}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if buul==1 then

if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDRaids")==false and waslegionrtryloadea==nil then
waslegionrtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_LegionRaids")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." RaidAchievement_LegionRaids!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." RaidAchievement_LegionRaids! "..raerrormodulereq.." RaidAchievement_Legion")
end
end
end

--героики вотлк
local idheroics={132,160,161,153,154,138,139,140,185,184,823,183,129,370,136,137,168,171,157,158,159}--{522,534,530,525,526,603,602,601,520,524,536,542,533}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if select(3,GetInstanceInfo())==2 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==17 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_WotlkHeroics")==false and waswhtryloadea==nil then
waswhtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_WotlkHeroics")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenu4.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenu4.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--героики каты
local idheroics={291,292,835,836,310,311,312,313,314,315,316,322,323,283,284,324,325,737,293,297,298,299,277,333,233,337,401,402,403,404,405,406,399,400,398}--{756,764,767,753,768,769,757,759,747,781,793,820,819,816}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if select(3,GetInstanceInfo())==2 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==17 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_CataHeroics")==false and waschtryloadea==nil then
waschtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_CataHeroics")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenucata.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenucata.."! "..raerrormodulereq.." RaidAchievement_OldModules")
end
end
end

--героики панды
local idheroics={791,792,439,440,441,442,872,873,874,443,444,445,446,437,438,453,454,455,457,458,459,476,477,478,479,431,432,302,303,304,305,435,436,804,805}--{867, 876, 877, 875, 885, 887, 898, 871, 874}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if select(3,GetInstanceInfo())==2 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==17 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaHeroics")==false and wasphtryloadea==nil then
wasphtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_PandaHeroics")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenupanda.."! "..raerrormodulereq.." RaidAchievement_Pandaria")
end
end
end


--сценарии панды
local idheroics={447,999999,999999,481,482,999999,450,999999,487,451,488,489,999999,999999,524,522}--{878, 899, 884, 900, 880, 906, 882,911,912,883,914,937,939,940,938}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_PandaScenarios")==false and waspztryloadea==nil then
waspztryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_PandaScenarios")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." "..psealeftmenupanda3.."!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." "..psealeftmenupanda3.."! "..raerrormodulereq.." RaidAchievement_Pandaria")
end
end
end



--героики WoD
local idheroics={573,595,593,601,602,616,617,618,606,607,608,609,620,621,574,575,576}--{964,987,984,989,995,993,1008,969}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
if select(3,GetInstanceInfo())==2 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==17 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_WoDHeroics")==false and wasphtryloadea==nil then
wasphtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_WoDHeroics")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." WoDHeroics!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." WoDHeroics! "..raerrormodulereq.." RaidAchievement_WoD")
end
end
end



--героики Legion
local idheroics={793,751,752,753,754,755,756,761,762,763,733,713,790,829,703,704,705,999999,731,749,798,677,678,679,710,711,712,723,732}--{1081,1087,1067,1046,1041,1042,1065,1079,1045,1066}
local buul=0
for i=1,#idheroics do
	if idheroics[i]==C_Map.GetBestMapForUnit("player") then
		buul=1
	end
end
-- ТОЛЬКО ЭПОХАЛЬНЫЕ ПОДЗЕМЕЛЬЯ!!!!! 2 - просто героики, а 23 - эпохальные МИТИК!
if select(3,GetInstanceInfo())==23 and buul==1 then

local chattt="party"
if select(3,GetInstanceInfo())==17 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) or select(3,GetInstanceInfo())==23 then
  chattt="Instance_CHAT"
end

if GetNumGroupMembers()>1 then
C_ChatInfo.SendAddonMessage("RAother", "5"..raversion, chattt)
end
if thisaddonwork then
C_ChatInfo.SendAddonMessage("PSaddon", "17"..psversion, chattt)
end

if C_AddOns.IsAddOnLoaded("RaidAchievement_LegionHeroics")==false and waslhtryloadea==nil then
waslhtryloadea=1
local loaded, reason = C_AddOns.LoadAddOn("RaidAchievement_LegionHeroics")
if loaded then
print("|cff99ffffRaidAchievement|r - "..pseamoduleload.." LegionHeroics!")
else
print("|cff99ffffRaidAchievement|r - "..pseamodulenotload.." LegionHeroics! "..raerrormodulereq.." RaidAchievement_Legion")
end
end
end





end
end

function PSFea_PSaddon()
PSFea_closeallpr()
if C_AddOns.IsAddOnLoaded("PhoenixStyle")==false then
--нету аддона
PSFeamain11:Show()

else
--есть аддон
PSFeamain1:Hide()
PSFeamain2:Hide()

--загрузил
PSFmain1:Hide()
PSFmain2:Hide()
PSF_closeallpr()

PSFmain1:Show()
PSFmain2:Show()
PSFmain3:Show()




PSFmain2_Button3:SetAlpha(0.3)
end
end




function out(text)
DEFAULT_CHAT_FRAME:AddMessage(text)
UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1, 10) 
end

function raver(cchat)
rashushinfo=GetTime()+7
local ratmp1=0
local ratmp2=""
local psa6=""
if GetLocale() then
psa6=GetLocale()
end
if ralloptions then
ratmp2="ach: "..ralloptions[1]..ralloptions[7]..":"
for x=2,6 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-1)
		x=7
	end
end
for x=8,12 do
	if ralloptions[x] and ralloptions[x]==1 then
		ratmp2=ratmp2..(x-7)
		x=13
	end
end

ratmp2=ratmp2.."-"
if rallbosschaton then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
if rallbosstooltip then
ratmp2=ratmp2.."1"
else
ratmp2=ratmp2.."0"
end
end
if pseashowfailreas then ratmp1="1-"..rasoundtoplay[1]..rasoundtoplay[2]..rasoundtoplay[3]..rasoundtoplay[4]..rasoundtoplay[5]..rasoundtoplay[6] end
print ("RA "..UnitName("player").." v."..raversion.." "..ratmp1.." "..ratmp2.." "..wherereportraidach..wherereportpartyach.." "..psa6.." installed: "..raaddoninstalledsins)
if cchat==nil then
if select(3,GetInstanceInfo())==17 or select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
C_ChatInfo.SendAddonMessage("RAother", "3info", "Instance_CHAT")
else
C_ChatInfo.SendAddonMessage("RAother", "3info", "raid")
end
else
C_ChatInfo.SendAddonMessage("RAother", "3info", cchat)
end
end


function pseareportfailnoreason(prichina2, qquant)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end


local add_info=""
if pseashowfailreas==true then
  if prichina2 and qquant then
    add_info=" ("..prichina2.." - "..qquant..")."
  elseif prichina2 then
    add_info=" ("..prichina2..")."
  else
    add_info=""
  end
end

if (wherereportraidach=="sebe") then
out("- "..achlinnk.." |cffff0000"..pseatreb4.."|r"..add_info..ratemp)
else
if UnitIsGroupAssistant("player")==false and wherereportraidach=="raid_warning" then
  if select(3,GetInstanceInfo())==17 or select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO) then
  razapuskanonsa("Instance_CHAT", "RA: {rt8} "..achlinnk.." "..pseatreb4..ratemp)
  else
    if UnitInRaid("player") then
      razapuskanonsa("raid", "RA: {rt8} "..achlinnk.." "..pseatreb4..add_info..ratemp)
    else
      razapuskanonsa("party", "RA: {rt8} "..achlinnk.." "..pseatreb4..add_info..ratemp)
    end
  end
else
  if wherereportraidach=="raid" and UnitInRaid("player")==nil then
    razapuskanonsa("party", "RA: {rt8} "..achlinnk.." "..pseatreb4..add_info..ratemp)
  else
    razapuskanonsa(wherereportraidach, "RA: {rt8} "..achlinnk.." "..pseatreb4..add_info..ratemp)
  end
end
end


end

function pseareportallok()
if (wherereportraidach=="sebe") then
out("- "..achlinnk.." "..pseatreb2)
else
if UnitIsGroupAssistant("player")==false and wherereportraidach=="raid_warning" then
  if UnitInRaid("player") then
    razapuskanonsa("raid", "RA: {rt1} "..achlinnk.." "..pseatreb2)
  else
    razapuskanonsa("party", "RA: {rt1} "..achlinnk.." "..pseatreb2)
  end
else
  if wherereportraidach=="raid" and UnitInRaid("player")==nil then
    razapuskanonsa("party", "RA: {rt1} "..achlinnk.." "..pseatreb2)
  else
    razapuskanonsa(wherereportraidach, "RA: {rt1} "..achlinnk.." "..pseatreb2)
  end
end
end
end


function razapuskanonsa(kudarep, chtorep)
if kudarep and chtorep then

if kudarep=="party" and GetNumGroupMembers()==0 then
  razapuskanonsa("sebe", chtorep)
  return
end

if kudarep=="raid" and UnitInRaid("player")==nil then
  razapuskanonsa("party", chtorep)
  return
end

if (kudarep=="party" or kudarep=="raid" or kudarep=="raid_warning") and (select(3,GetInstanceInfo())==17 or select(3,GetInstanceInfo())==11 or select(3,GetInstanceInfo())==12 or IsLFGModeActive(LE_LFG_CATEGORY_LFD) or IsLFGModeActive(LE_LFG_CATEGORY_SCENARIO)) then
kudarep="Instance_CHAT"
end


if kudarep=="sebe" then
out("- "..chtorep)
else

local bililine=0
for i,cc in ipairs(rabigmenuchatlisten) do 
if cc == kudarep then bililine=1
end end
if kudarep=="Instance_CHAT" then
bililine=1
end

if bililine==0 then
if GetChannelName(kudarep)==0 then
JoinPermanentChannel(kudarep)
ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, kudarep)
end
end

	if (bililine==1 or (bililine==0 and GetChannelName(kudarep)>0)) then


if ramsgwaiting==0 then
ramsgtimestart=GetTime()
ramsgwaiting=GetTime()
ramsgmychat=kudarep --мой чат в который идет аннонс
ramsgupdate=1 --запуск онапдейт таймера
ranamemsgsend=UnitName("player")
if UnitName("player")=="Шуршик" or UnitName("player")=="Шурш" then ranamemsgsend="0"..ranamemsgsend end
if UnitIsGroupAssistant("player") then ranamemsgsend="0"..ranamemsgsend end
table.wipe(racanannouncetable)
table.insert(racanannouncetable, ranamemsgsend)
end

if raannouncewait then
table.insert (raannouncewait, chtorep)
end

	end
end
end
end


function rachatdropm(aa,ww,hh)
aa:ClearAllPoints()
aa:SetPoint("BOTTOMLEFT", ww, hh)
aa:Show()
local items = bigmenuchatlistea
local function OnClick(self)
UIDropDownMenu_SetSelectedID(aa, self:GetID())

bigmenuchatea(self:GetID())
wherereportraidach=wherereporttempbigma
end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

bigmenuchatea2(wherereportraidach)

if bigma2num==0 then
bigma2num=1
wherereportraidach="raid"
end

UIDropDownMenu_Initialize(aa, initialize)
UIDropDownMenu_SetWidth(aa, 90);
UIDropDownMenu_SetButtonWidth(aa, 105)
UIDropDownMenu_SetSelectedID(aa,bigma2num)
UIDropDownMenu_JustifyText(aa, "LEFT")
end

function PSFea_manyach()
PSFea_closeallpr()
if(thisaddonworkea)then
PSFeamainmanyach:Show()


--frames creating
if raframcremanycah==nil then
raframcremanycah=1

ramanyachoninfotxtt = PSFeamainmanyach:CreateFontString()
ramanyachoninfotxtt:SetWidth(700)
ramanyachoninfotxtt:SetHeight(200)
ramanyachoninfotxtt:SetFont(GameFontNormal:GetFont(), 12, 'MONOCHROME')
ramanyachoninfotxtt:SetPoint("TOPLEFT",20,-15)
ramanyachoninfotxtt:SetText(ramanyachtitinfo.."|cff00ff00"..raquantrepeatachtm.."|r "..ramanyachtitinfo2)
ramanyachoninfotxtt:SetJustifyH("LEFT")
ramanyachoninfotxtt:SetJustifyV("TOP")


ramanyachoninfotxt = PSFeamainmanyach:CreateFontString()
ramanyachoninfotxt:SetWidth(550)
ramanyachoninfotxt:SetHeight(20)
ramanyachoninfotxt:SetFont(GameFontNormal:GetFont(), 12, 'MONOCHROME')
ramanyachoninfotxt:SetPoint("TOPLEFT",20,-160)
ramanyachoninfotxt:SetJustifyH("LEFT")
ramanyachoninfotxt:SetJustifyV("TOP")


PSFeamainmanyach_Textbig1:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
PSFeamainmanyach_Textbig2:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')


PSFeamainmanyach_Textmarkoff:SetFont(GameFontNormal:GetFont(), 15, 'MONOCHROME')
PSFeamainmanyach_Textmarkon:SetFont(GameFontNormal:GetFont(), 15, 'MONOCHROME')

getglobal("PSFeamainmanyach_slider1High"):SetText("10")
getglobal("PSFeamainmanyach_slider1Low"):SetText("1")
PSFeamainmanyach_slider1:SetMinMaxValues(1, 10)
PSFeamainmanyach_slider1:SetValueStep(1)
PSFeamainmanyach_slider1:SetValue(raquantrepeatach)
rasliderch1()

getglobal("PSFeamainmanyach_slider2High"):SetText("5 "..rasec)
getglobal("PSFeamainmanyach_slider2Low"):SetText("0 "..rasec)
PSFeamainmanyach_slider2:SetMinMaxValues(0, 50)
PSFeamainmanyach_slider2:SetValueStep(1)
PSFeamainmanyach_slider2:SetValue(raquantrepeatachtm*10)
rasliderch2()

end


ramanyachclosefr()

if ramanyachon then
ramanyachonfr()
else
ramanyachofffr()
end




else
PSFeamain10:Show()
end
end


function ramanychon()
ramanyachon=true
ramanyachclosefr()
ramanyachonfr()
end


function ramanychoff()
ramanyachon=nil
ramanyachclosefr()
ramanyachofffr()
end

function ramanyachclosefr()
PSFeamainmanyach_Textmarkon:Hide()
PSFeamainmanyach_Textmarkoff:Hide()
PSFeamainmanyach_Buttonon:Hide()
PSFeamainmanyach_Buttonoff:Hide()
end

function ramanyachonfr()
PSFeamainmanyach_Textmarkon:Show()
PSFeamainmanyach_Buttonoff:Show()
rasliderch1()
rasliderch2()
raquantrepdone=1
end

function ramanyachofffr()
PSFeamainmanyach_Textmarkoff:Show()
PSFeamainmanyach_Buttonon:Show()
rasliderch1()
rasliderch2()
raquantrepdone=1
end

function rasliderch1()
raquantrepeatach = math.floor(PSFeamainmanyach_slider1:GetValue())
local text=""
if ramanyachon then
text=text.."|cff00ff00"
else
text=text.."|cffff0000"
end
text=text..ramanyachtitinfoq..raquantrepeatach.." "..ramanyachtitinfoq2.."|r"
if ramanyachoninfotxt then
ramanyachoninfotxt:SetText(text)
PSFeamainmanyach_Textbig1:SetText(raquantrepeatach)
end
end

function rasliderch2()
raquantrepeatachtm = math.floor(PSFeamainmanyach_slider2:GetValue())/10
if ramanyachoninfotxtt then
local text=""
if ramanyachon then
text=text.."|cff00ff00"
else
text=text.."|cffff0000"
end
if raquantrepeatachtm==0 then
ramanyachoninfotxtt:SetText(ramanyachtitinfo..text..raquantrepeatachtm.." "..rasec.." ("..ramodulnotblock..")|r "..ramanyachtitinfo2)
else
ramanyachoninfotxtt:SetText(ramanyachtitinfo..text..raquantrepeatachtm.." "..rasec.."|r "..ramanyachtitinfo2)
end
PSFeamainmanyach_Textbig2:SetText(raquantrepeatachtm.." "..rasec)
end
end


function raunitisplayer(id,name)
raunitplayertrue=nil

if UnitInRaid(name) or UnitInParty(name) then
raunitplayertrue=1
else

	if (string.find(id,"Player")) then
		raunitplayertrue=1
	end

end
end

function RAminimaponoff()
if (PSFeamain3_CheckButton11:GetChecked()) then
raminibutshowt=true
else
raminibutshowt=false
RA_MinimapButton:Hide()
end
ramapbuttreflesh()
end

function ramapbuttreflesh()
if ratextffgdgdf==nil then
ratextffgdgdf=1

ratpsicon = RA_MinimapButton:CreateTexture(nil,'ARTWORK')
ratpsicon:SetTexture("Interface\\AddOns\\RaidAchievement\\ra_button_e")
ratpsicon:SetWidth(21)
ratpsicon:SetHeight(21)
ratpsicon:SetPoint("TOPLEFT",6,-6)
RA_MinimapButton.texture = ratpsicon
end

	if raminibutshowt then
RA_MinimapButton:Show()

local isSexyMapLoaded = select(2, C_AddOns.GetAddOnInfo("SexyMap"))
if isSexyMapLoaded then
    -- SexyMap is loaded
else
    RA_MinimapButton_Reposition()
end

if thisaddonworkea then
ratpsicon:SetTexture("Interface\\AddOns\\RaidAchievement\\ra_button_e")
else
ratpsicon:SetTexture("Interface\\AddOns\\RaidAchievement\\ra_button_d")
end
	else
	RA_MinimapButton:Hide()
	end
end




function RA_MinimapButton_Reposition()
	RA_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(RA_Settings.RAMinimapPos)),(80*sin(RA_Settings.RAMinimapPos))-52)
end

function RA_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	RA_Settings.RAMinimapPos = math.deg(math.atan2(ypos,xpos))
	RA_MinimapButton_Reposition()
end

--arg1="LeftButton", "RightButton"
function RA_MinimapButton_OnClick()

GameTooltip:Hide()

	if PSFeamain1:IsShown() then
PSFea_buttonsaveexit()
	else
PSFeamain1:Hide()
PSFeamain2:Hide()
PSFea_closeallpr()
PSFeamain1:Show()
PSFeamain2:Show()
PSFeamain3:Show()



openrasound1()
openrasound2()
	end

end


function RA_MinimapButton_OnEnter(self)
	if (self.dragging) then
		return
	end
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_LEFT")
	RA_MinimapButton_Details(GameTooltip)
end


function RA_MinimapButton_Details(tt, ldb)
	tt:SetText("RaidAchievement")
end


function RA_creditsgo()
PSFea_closeallpr()

RAthanks:Show()

if RAthanksdraw==nil then
RAthanksdraw=1
local t = RAthanks:CreateFontString()
t:SetWidth(700)
t:SetHeight(475)
t:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t:SetPoint("TOPLEFT",20,-15)
t:SetText(racredits3)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")
end

end


function rapromo()
PSFea_closeallpr()

RApromo:Show()

if RAthanksdraw==nil then
RAthanksdraw=1
local t = RApromo:CreateFontString()
t:SetWidth(700)
t:SetHeight(475)
t:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t:SetPoint("TOPLEFT",20,-15)
t:SetText("Dear user, you see this message because you use our addon for more than 5 years.\n\nWe have created this addon in |cff00ff002009 and since that day it is completely free.|r We are very happy to help more than a million players in their adventures in the World of Warcraft!\n\nBut, it is not easy to maintain the addon for free, we don't play WoW anymore. |cff00ff00We were planning to abandon this project.|r Some users suggest us to create an affiliate link to help us with maintaining this project. We use eBay a lot, so we have decided to try.\n\n\n\n\n|cffff0000How is it work?|r |cff00ff00If you are planning to buy somethings – use eBay!|r This is much better than amazon and you are protected with PayPal. Just use our link and buy what you need. |cff00ff00We will get 1% cashback|r (the price doesn't change!) and this small payment will help us to maintain addons for free :)\n\n|cff00ff00Never tried eBay? It’s time to try it ;)\n\n\n\nThank you for using our addons for such a long time|r :)")
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")


local b = RApromo:CreateFontString()
b:SetWidth(660)
b:SetHeight(475)
b:SetFont(GameFontNormal:GetFont(), 12, 'MONOCHROME')
b:SetPoint("TOPLEFT",20,-455)
--b:SetText("* - duration is limited (testing phase). We offer this service only to players who use our add-ons for more than 6 months (if you see this message, you are one of them!)")
b:SetJustifyH("LEFT")
b:SetJustifyV("TOP")


local t2 = RApromo:CreateFontString()
t2:SetWidth(700)
t2:SetHeight(475)
t2:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t2:SetPoint("TOPLEFT",0,-350)
t2:SetText("|CFFFFFF00Support development, use this link and buy on eBay!|r\n\n|cff00ff00Click  Ctrl+C  to copy|r")
t2:SetJustifyH("CENTER")
t2:SetJustifyV("TOP")

local psdonatefr22 = CreateFrame("ScrollFrame", "psdonatefr22", RApromo, "UIPanelScrollFrameTemplate")
psdonatefr22:SetPoint("TOPLEFT", RApromo, "TOPLEFT", 240, -405)
psdonatefr22:SetHeight(50)
psdonatefr22:SetWidth(200)

psdonateeb22 = CreateFrame("EditBox", "psdonateeb22", psdonatefr22)
psdonateeb22:SetPoint("TOPRIGHT", psdonatefr22, "TOPRIGHT", 0, 0)
psdonateeb22:SetPoint("TOPLEFT", psdonatefr22, "TOPLEFT", 0, 0)
psdonateeb22:SetPoint("BOTTOMRIGHT", psdonatefr22, "BOTTOMRIGHT", 0, 0)
psdonateeb22:SetPoint("BOTTOMLEFT", psdonatefr22, "BOTTOMLEFT", 0, 0)
psdonateeb22:SetScript("onescapepressed", function(self) psdonateeb22:ClearFocus() end)
psdonateeb22:SetFont(GameFontNormal:GetFont(), rafontsset[2], 'MONOCHROME')
psdonateeb22:SetMultiLine(true)
psdonateeb22:SetAutoFocus(false)
psdonateeb22:SetHeight(150)
psdonateeb22:SetWidth(185)
psdonateeb22:Show()
psdonateeb22:SetScript("OnTextChanged", function(self) psdonateeb22:SetText("phoenixstyle.com/ePSq56f") psdonateeb22:HighlightText(0,string.len(psdonateeb22:GetText())) end )

psdonatefr22:SetScrollChild(psdonateeb22)
psdonatefr22:Show()










end

end



function openrasound1()
if not DropDownrasound1 then
CreateFrame("Frame", "DropDownrasound1", PSFeamain3, "UIDropDownMenuTemplate")
end

DropDownrasound1:ClearAllPoints()
DropDownrasound1:SetPoint("TOPLEFT", 5, -133)
DropDownrasound1:Show()



local items = rasoundtrack


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownrasound1, self:GetID())

rasoundtoplay[4]=self:GetID()
raplaysound2(rasoundtoplay[4])
end


local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownrasound1, initialize)
UIDropDownMenu_SetWidth(DropDownrasound1, 100)
UIDropDownMenu_SetButtonWidth(DropDownrasound1, 115)
UIDropDownMenu_SetSelectedID(DropDownrasound1, rasoundtoplay[4])
UIDropDownMenu_JustifyText(DropDownrasound1, "LEFT")
end

function openrasound2()
if not DropDownrasound2 then
CreateFrame("Frame", "DropDownrasound2", PSFeamain3, "UIDropDownMenuTemplate")
end

DropDownrasound2:ClearAllPoints()
DropDownrasound2:SetPoint("TOPLEFT", 5, -153)
DropDownrasound2:Show()



local items = rasoundtrack


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownrasound2, self:GetID())

rasoundtoplay[5]=self:GetID()
raplaysound2(rasoundtoplay[5])



end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownrasound2, initialize)
UIDropDownMenu_SetWidth(DropDownrasound2, 100)
UIDropDownMenu_SetButtonWidth(DropDownrasound2, 115)
UIDropDownMenu_SetSelectedID(DropDownrasound2, rasoundtoplay[5])
UIDropDownMenu_JustifyText(DropDownrasound2, "LEFT")
end


function raplaysound(i,achievid,criteria)

--i 1 - фейл, 2 - килл босс!, 3 - просто получить ачивку
achlinnk=GetAchievementLink(achievid)

--звук при фейле
if i==1 then
	if rasoundtoplay[1]==1 then
		if rasoundtoplay[3]==1 then
			local _, _, _, completed = GetAchievementInfo(achievid)
			if completed==false then
				if criteria then
					local a1,_,a3=GetAchievementCriteriaInfo(achievid,criteria)
					if a3==false then
						raplaysound2(rasoundtoplay[4])
					end
				else
					raplaysound2(rasoundtoplay[4])
				end
			end
		else
			raplaysound2(rasoundtoplay[4])
		end
	end
end

--звук при выполнении
if i==2 then
if rasoundtoplay[2]==1 then
	if rasoundtoplay[3]==1 then
		local _, _, _, completed = GetAchievementInfo(achievid)
		if completed==false then
			if criteria then
				local a1,_,a3=GetAchievementCriteriaInfo(achievid,criteria)
				if a3==false then
		--для марио звук не меняется!!
		if achievid==8077 then
		  raplaysound2(23)
		else
		  raplaysound2(rasoundtoplay[5])
		end
				end
			else
		--для марио звук не меняется!!
		if achievid==8077 then
		  raplaysound2(23)
		else          
		  raplaysound2(rasoundtoplay[5])
		end
			end
		end
	else
		--для марио звук не меняется!!
		if achievid==8077 then
		  raplaysound2(23)
		else
		  raplaysound2(rasoundtoplay[5])
		end
	end
end
end
end



function raplaysound2(i)
if i>10 and i~=23 then
	if rasoundtoplay[6]==1 then
		PlaySound(rasoundtrack[i], "Master")
	else
		PlaySound(rasoundtrack[i])
	end
else
	if rasoundtoplay[6]==1 then
		PlaySoundFile("Interface\\AddOns\\RaidAchievement\\Sounds\\"..rasoundtrack[i], "Master")
	else
		PlaySoundFile("Interface\\AddOns\\RaidAchievement\\Sounds\\"..rasoundtrack[i])
	end
end
end


function raopentacticfrommod(i,j)
--i raid1/praty2
--j nrraid/nrparty

if C_AddOns.IsAddOnLoaded("AchievementsReminder") then
	if i==1 then
		rallonlycurrzone=j
		icll_button3()
	end
	if i==2 then
		if j==1 then
			PSFea_listachmanual() rallmanualch1=1 rallmanualch2=1 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
		if j==2 then
			PSFea_listachmanual() rallmanualch1=2 rallmanualch2=1 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
		if j==3 then
			PSFea_listachmanual() rallmanualch1=2 rallmanualch2=2 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
		if j==4 then
			PSFea_listachmanual() rallmanualch1=4 rallmanualch2=1 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
		if j==5 then
			PSFea_listachmanual() rallmanualch1=4 rallmanualch2=2 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
		if j==6 then
			PSFea_listachmanual() rallmanualch1=4 rallmanualch2=3 rallmanualch3=1 openmenullch1() openmenullch2() openmenullch3()
		end
	end
else
--PSFeamain12:Show()
raerrorloading(2)
end

end



function openmenureportchra11()
if not DropDownMenureportchra11 then
CreateFrame("Frame", "DropDownMenureportchra11", PSFeamain3, "UIDropDownMenuTemplate")
end

DropDownMenureportchra11:ClearAllPoints()
DropDownMenureportchra11:SetPoint("TOPLEFT", 5, -235)
DropDownMenureportchra11:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra11, self:GetID())

lowmenuchatea(self:GetID())
wherereportpartyach=wherereporttempbigma
end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

lowmenuchatea2(wherereportpartyach)
if bigma2num==0 then
bigma2num=1
wherereportpartyach="party"
end

UIDropDownMenu_Initialize(DropDownMenureportchra11, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportchra11, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportchra11, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra11,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportchra11, "LEFT")
end


function openmenureportchra12()
if not DropDownMenureportchra12 then
CreateFrame("Frame", "DropDownMenureportchra12", PSFeamain3, "UIDropDownMenuTemplate")
end

DropDownMenureportchra12:ClearAllPoints()
DropDownMenureportchra12:SetPoint("TOPLEFT", 5, -265)
DropDownMenureportchra12:Show()

local items = bigmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra12, self:GetID())

bigmenuchatea(self:GetID())
wherereportraidach=wherereporttempbigma
end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

bigmenuchatea2(wherereportraidach)
if bigma2num==0 then
bigma2num=1
wherereportraidach="raid"
end

UIDropDownMenu_Initialize(DropDownMenureportchra12, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportchra12, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportchra12, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportchra12,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportchra12, "LEFT")
end


function RAdonatef()
PSFea_closeallpr()
RAthanks2:Show()

if RAthanksdrawd2==nil then
RAthanksdrawd2=1
local t = RAthanks2:CreateFontString()
t:SetWidth(700)
t:SetHeight(475)
t:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t:SetPoint("TOPLEFT",20,-20)
t:SetText("Thanks to everyone who's been helping to improve this addon!\n\n\nUnfortunately, I don't raid anymore and i don't spend much time in-game.\nI don't have much time to maintain this addon but i'm trying to find some.\n\n|cff00ff00if you want to thank me for the work i'm doing, please use this link.|r Don't expect someone else to help...")
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")


t2 = RAthanks2:CreateFontString()
t2:SetWidth(700)
t2:SetHeight(475)
t2:SetFont(GameFontNormal:GetFont(), 14, 'MONOCHROME')
t2:SetPoint("TOPLEFT",270,-150)
t2:SetText("|CFFFFFF00Support development!|r\n\n|cff00ff00Click  Ctrl+C  to copy|r")
t2:SetJustifyH("LEFT")
t2:SetJustifyV("TOP")

psdonatefr22 = CreateFrame("ScrollFrame", "psdonatefr22", RAthanks2, "UIPanelScrollFrameTemplate")
psdonatefr22:SetPoint("TOPLEFT", RAthanks2, "TOPLEFT", 240, -205)
psdonatefr22:SetHeight(100)
psdonatefr22:SetWidth(200)

psdonateeb22 = CreateFrame("EditBox", "psdonateeb22", psdonatefr22)
psdonateeb22:SetPoint("TOPRIGHT", psdonatefr22, "TOPRIGHT", 0, 0)
psdonateeb22:SetPoint("TOPLEFT", psdonatefr22, "TOPLEFT", 0, 0)
psdonateeb22:SetPoint("BOTTOMRIGHT", psdonatefr22, "BOTTOMRIGHT", 0, 0)
psdonateeb22:SetPoint("BOTTOMLEFT", psdonatefr22, "BOTTOMLEFT", 0, 0)
psdonateeb22:SetScript("onescapepressed", function(self) psdonateeb22:ClearFocus() end)
psdonateeb22:SetFont(GameFontNormal:GetFont(), rafontsset[2], 'MONOCHROME')
psdonateeb22:SetMultiLine(true)
psdonateeb22:SetAutoFocus(false)
psdonateeb22:SetHeight(150)
psdonateeb22:SetWidth(185)
psdonateeb22:Show()
psdonateeb22:SetScript("OnTextChanged", function(self) psdonateeb22:SetText("http://www.phoenixstyle.com") psdonateeb22:HighlightText(0,string.len(psdonateeb22:GetText())) end )

psdonatefr22:SetScrollChild(psdonateeb22)
psdonatefr22:Show()

end



end

function raaddonloadedcheckspam()

if radonateq1==nil then
	radonateq1=0
end
if radonateq1<50 then
	radonateq1=radonateq1+1
end


--инфо о ДР
local _, month, day, year = tonumber(date("%H")),tonumber(date("%m")),tonumber(date("%d")),tonumber(date("%y"))
--if (year==2017 and month==2 and (day==12 or day==13) and raannouncerun4==0 and (psDoNotShowOtherAnnounces==nil or (psDoNotShowOtherAnnounces and psDoNotShowOtherAnnounces==0)) and math.random(1,100)>70) then
if (year==2017 and (month==8 or month==9) and (day>22 and day<31) and raannouncerun4==0 and (psDoNotShowOtherAnnounces==nil or (psDoNotShowOtherAnnounces and psDoNotShowOtherAnnounces==0)) and math.random(1,100)>70) then
	local text=""
	--text="|cff00ff00RaidAchievement|r > I got WoW for my 20 years birthday, |cff00ff00today I celebrate 30|r. I created PS and RA addons 8 years ago, hope you use and like them :) They got more than |cff00ff0010 mln downloads|r and I raised just 1200 euro in 8 years with the bigger one of 300$. Now, addon is dying as I don't play for last 5 years, if you want to help: http://www.phoenixstyle.com/ also you can find more info about me and Italy where I live :)"
	
	--out (text)
	
	raannouncerun4=1
	psDoNotShowOtherAnnounces=1
end




if radonateq1==50 then
if UnitInRaid("player")==nil and UnitInParty("player")==nil and psDoNotShowOtherAnnounces==nil then
  radonateq1=radonateq1+1
  --сообщение
  --local text="|cff00ff00RaidAchievement|r |cffff0000important update:|r to track achieves from Cataclysm and WotLK you have to |cff00ff00download RaidAchievement_OldModules|r (from curse). |cff00ff00AchievementsReminder|r - is now a separate addon and will have new features soon, if you need it - take it from curse too."
  local text="|cff00ff00RaidAchievement|r > need your help, so addon will be available in |cff00ff00next patch|r too. More info: http://www.phoenixstyle.com/help"
  if GetLocale()=="ruRU" then
    --text="|cff00ff00RaidAchievement|r |cffff0000важное обновление:|r для трекера достижений Катаклизма and ЛК требуется |cff00ff00скачать RaidAchievement_OldModules|r (с curse сайта). |cff00ff00AchievementsReminder|r - теперь отдельный независимый аддон, скоро с новыми функциями, если он вам тоже нужен - скачайте его отдельно."
	text="|cff00ff00RaidAchievement|r > требуется Ваша помощь, чтобы аддон продолжил свое существование в |cff00ff00следующем патче!|r Детальнее: http://www.phoenixstyle.com/help"
  end
  
  out(text)
  
  if psdonaspanvar==nil then
    psdonaspanvar=1
  elseif psdonaspanvar and psdonaspanvar==1 then
    psdonaspanvar=2 --2ка используется для аннонса РА после 20 декабря and после 1 января, только если 1 ВКЛ! иначе же РА сразу прыгает с 1 до 3
  end
else
  psnotproched=1
end

end

end


function raerrorloading(nr)
--nr: 1=Old, 2: Achieve


if raerrorframe1==nil then

raerrorframe1 = PSFeaerrorgeneral:CreateFontString()
raerrorframe1:SetWidth(480)
raerrorframe1:SetHeight(115)
raerrorframe1:SetFont(GameFontNormal:GetFont(), 20, 'MONOCHROME')
raerrorframe1:SetPoint("TOP",0,-100)
raerrorframe1:SetJustifyH("CENTER")
raerrorframe1:SetJustifyV("BOTTOM")


raerrordfdfdpsdonatefr2 = CreateFrame("ScrollFrame", "raerrordfdfdpsdonatefr2", PSFeaerrorgeneral, "UIPanelScrollFrameTemplate")
raerrordfdfdpsdonatefr2:SetPoint("TOPLEFT", PSFeaerrorgeneral, "TOPLEFT", 275, -265)
raerrordfdfdpsdonatefr2:SetHeight(40)
raerrordfdfdpsdonatefr2:SetWidth(320)
  

raerrordfsdfsdfjy4 = CreateFrame("EditBox", "raerrordfsdfsdfjy4", raerrordfdfdpsdonatefr2)
raerrordfsdfsdfjy4:SetPoint("TOPRIGHT", raerrordfdfdpsdonatefr2, "TOPRIGHT", 0, 0)
raerrordfsdfsdfjy4:SetPoint("TOPLEFT", raerrordfdfdpsdonatefr2, "TOPLEFT", 0, 0)
raerrordfsdfsdfjy4:SetPoint("BOTTOMRIGHT", raerrordfdfdpsdonatefr2, "BOTTOMRIGHT", 0, 0)
raerrordfsdfsdfjy4:SetPoint("BOTTOMLEFT", raerrordfdfdpsdonatefr2, "BOTTOMLEFT", 0, 0)
raerrordfsdfsdfjy4:SetFont(GameFontNormal:GetFont(), 13, 'MONOCHROME')
raerrordfsdfsdfjy4:SetMultiLine(true)
raerrordfsdfsdfjy4:SetAutoFocus(false)
raerrordfsdfsdfjy4:SetHeight(150)
raerrordfsdfsdfjy4:SetWidth(325)
raerrordfsdfsdfjy4:Show()
raerrordfsdfsdfjy4:SetScript("onescapepressed", function(self) raerrordfsdfsdfjy4:ClearFocus() end )
raerrordfsdfsdfjy4:SetScript("OnTextChanged", function(self) raerrordfsdfsdfjy4:SetText("http://www.phoenixstyle.com/downloads") end )


raerrordfdfdpsdonatefr2:SetScrollChild(raerrordfsdfsdfjy4)
raerrordfdfdpsdonatefr2:Show()

end

if nr==1 then
  raerrorframe1:SetText(raerroraddoninst.." |cffff0000RaidAchievement_OldModules|r")
elseif nr==2 then
  raerrorframe1:SetText(raerroraddoninst.." |cffff0000AchievementsReminder|r")
end


PSFeaerrorgeneral:Show()
end

function raGetUnitID(guid)
if guid==nil or guid==false then
	return 0
end
if (guid.find(guid,"Creature") or guid.find(guid,"Pet-") or guid.find(guid,"GameObject") or guid.find(guid,"Vehicle")) then
	--Creature-0-3061-1136-29274-71979-00003EDC2C
	local t1,_,_,_,_,id,g = guid:match("([^,]+)-([^,]+)-([^,]+)-([^,]+)-([^,]+)-([^,]+)-([^,]+)")
	if id and tonumber(id) ~= nil then
		return tonumber(id)
	else
		return tonumber(id)
	end
else
	return 0
end
end


function racheckzoneId(_zoneList, _zoneId)

if (type(_zoneList) == "number") then
	if _zoneList==_zoneId then
		return true
	else
		return false
	end
else
	for iz=1,#_zoneList do
		if _zoneList[iz]==_zoneId then
			return true
		end
	end
end
return false

end
function checkBuff(unit,spellName)
for i=1,40 do
    local aura = C_UnitAuras.GetDebuffDataByIndex(unit,i)
    if aura and aura.name == spellName then
		return true
    end
end
return false
end
function checkDeBuff(unit,spellName)
for i=1,40 do
    local aura = C_UnitAuras.GetDebuffDataByIndex(unit, i)
	if aura and aura.name == spellName then
		return true
    end
end
return false
end