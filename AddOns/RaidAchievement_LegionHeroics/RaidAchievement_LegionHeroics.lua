local _
function legionhraonload()
	legionhraachdone1=true
	legionhracounter1=0
	_, legionhraenglishclass = UnitClass("player")
	legionhrahuntertime=0
	
	raLegionModVers="not yet used"

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==23 then
	RaidAchievement_legionhra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_legionhra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_legionhra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_legionhra:RegisterEvent("PLAYER_ALIVE")
end
	RaidAchievement_legionhra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_legionhra:RegisterEvent("PLAYER_REGEN_ENABLED")
	RaidAchievement_legionhra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_legionhra:RegisterEvent("ADDON_LOADED")







legionhraspisokach5={

10710,--http://www.wowhead.com/achievement=10710/black-rook-moan
10544,--http://www.wowhead.com/achievement=10544/stag-party
10875,--http://www.wowhead.com/achievement=10875/cant-eat-just-one

10456,--http://ru.wowhead.com/achievement=10456/but-you-say-hes-just-a-friend
10457,--http://ru.wowhead.com/achievement=10457/stay-salty
10458,--http://ru.wowhead.com/achievement=10458/ready-for-raiding-v

10766,--http://www.wowhead.com/achievement=10766/egg-cellent#comments
10769,--http://ru.wowhead.com/achievement=10769/burning-down-the-house#comments

10413, -- http://ru.wowhead.com/achievement=10413/instant-karma#english-comments

10543, -- http://www.wowhead.com/achievement=10543/surge-protector

10773, -- http://www.wowhead.com/achievement=10773/arcanic-cling
10776, -- http://www.wowhead.com/achievement=10776/no-time-to-waste

10680, -- http://www.wowhead.com/achievement=10680/whos-afraid-of-the-dark
}



if (legionhraspisokon==nil) then
legionhraspisokon={}
end


end


function legionhraonupdate()





if legionhracheckzonedelay and GetTime()>legionhracheckzonedelay then
legionhracheckzonedelay=nil

local _, a2 = GetInstanceInfo()
if select(3,GetInstanceInfo())==2 and a2=="party" then
	RaidAchievement_legionhra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_legionhra:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_legionhra:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_legionhra:RegisterEvent("PLAYER_ALIVE")
else
	RaidAchievement_legionhra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_legionhra:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
	RaidAchievement_legionhra:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
	RaidAchievement_legionhra:UnregisterEvent("PLAYER_ALIVE")
end

end



-- tracker for 12 achieve.
if rastarttrackingCrdana and GetTime()>rastarttrackingCrdana then
	rastarttrackingCrdana = rastarttrackingCrdana+1
	if legionhraspisokon[12]==1 and legionhraachdone1 then
		rastarttrackingCrdana=GetTime()+1
		local spbuf=GetSpellInfo(197941)
		if checkBuff("player", spbuf) or checkDeBuff("player", spbuf) then
			legionhrafailnoreason(12, UnitName("player"))
		end
		if checkBuff("party1", spbuf) or checkDeBuff("party1", spbuf) then
			legionhrafailnoreason(12, UnitName("party1"))
		end
		if checkBuff("party2", spbuf) or checkDeBuff("party2", spbuf) then
			legionhrafailnoreason(12, UnitName("party2"))
		end
		if checkBuff("party3", spbuf) or checkDeBuff("party3", spbuf) then
			legionhrafailnoreason(12, UnitName("party3"))
		end
		if checkBuff("party4", spbuf) or checkDeBuff("party4", spbuf) then
			legionhrafailnoreason(12, UnitName("party4"))
		end
	else
		rastarttrackingCrdana=nil
	end
end





end


function legionhraonevent(self,event,...)
local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_ALIVE" then
ralldelaycombatrezet=GetTime()+4
end



if event == "PLAYER_REGEN_DISABLED" then

if ralldelaycombatrezet==nil or (ralldelaycombatrezet and GetTime()>ralldelaycombatrezet) then

--ханты 3.5 сек проверка
if legionhraenglishclass=="HUNTER" and GetTime()>legionhrahuntertime then

--ТОЛЬКО ДЛЯ ХАНТОВ

legionhraachdone1=true
legionhracounter1=0


rawodonecounter1=nil
legionbosskilled=nil
legionspiderList=nil
legionspiderList2=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=raGetUnitID(id2)

else
rachtimerbossrecheck=GetTime()+3
end

elseif legionhraenglishclass=="HUNTER" then else

--ТУТ ОБНУЛЯТЬ ВСЕ

legionhraachdone1=true
legionhracounter1=0

rawodonecounter1=nil
legionbosskilled=nil
legionspiderList=nil
legionspiderList2=nil


if UnitGUID("boss1") and UnitName("boss1")~="" then
	local id2=UnitGUID("boss1")
	local id=raGetUnitID(id2)




end


end --хантер


end
end

if event == "PLAYER_REGEN_ENABLED" then

	legionhrahuntertime=GetTime()+3.5

end

if event == "ZONE_CHANGED_NEW_AREA" then

legionhracheckzonedelay=GetTime()+2
legionhracounter1=0

fsdfdsfsdfsdfer=nil


end


if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_LegionHeroics" then

for i=1,#legionhraspisokach5 do
if legionhraspisokon[i]==nil then legionhraspisokon[i]=1 end
end
	end
end


if event == "CHAT_MSG_MONSTER_YELL" or event=="CHAT_MSG_MONSTER_SAY" then



end


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2,arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14,arg15 = CombatLogGetCurrentEventInfo()




--проверка на возможный выход с боя
if arg5==UnitName("player") and arg2=="SPELL_AURA_REMOVED" and (arg10==58984 or arg10==66 or arg10==1856 or arg10==11327) then
ralldelaycombatrezet=GetTime()+4
end




--achieves tracker:


--Black Rook Hold
if racheckzoneId({793,751,752,753,754,755,756},C_Map.GetBestMapForUnit("player")) then

if arg2=="UNIT_DIED" and legionbosskilled==nil then
  if legionhraspisokon[1]==1 and legionhraachdone1 then
  local id=raGetUnitID(arg7)
  if id==99663 then
    legionhraachcompl(1)
  end
  end
end


end
--


if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==207753 and arg14>9 then
	if legionhraspisokon[2]==1 and legionhraachdone1 then
		legionhraachcompl(2)
	end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==199246 and arg14>5 then
	if legionhraspisokon[3]==1 and legionhraachdone1 then
		legionhraachcompl(3)
	end
end



if arg2=="UNIT_DIED" and legionbosskilled==nil then
  if legionhraspisokon[4]==1 and legionhraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==97264 then
    legionhrafailnoreason(4)
  end
  end
end



if arg2=="UNIT_DIED" and legionbosskilled==nil then
  if legionhraspisokon[5]==1 and legionhraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==98293 then
	if (ratimerResetCount==nil) then
		ratimerResetCount=GetTime()
	end
	if GetTime()-ratimerResetCount>3 then
		ratimerResetCount=GetTime()
		legionhracounter1=0
	end
	legionhracounter1=legionhracounter1+1
  end
  if legionhracounter1>10 then
    legionhraachcompl(5)
  end
  end
end




if (arg2=="SPELL_AURA_APPLIED" and arg10==196665) or (arg2=="SPELL_DAMAGE" and arg10==196665) then
	if legionhraspisokon[6]==1 and legionhraachdone1 and UnitGUID("boss1") then
		legionhramyfail(6)
	end
end
if (arg2=="SPELL_AURA_APPLIED" and arg10==196666) or (arg2=="SPELL_DAMAGE" and arg10==196666) then
	if legionhraspisokon[6]==1 and legionhraachdone1 and UnitGUID("boss1") then
		legionhramyfail(6)
	end
end



if arg2=="UNIT_DIED" and legionbosskilled==nil then
  if legionhraspisokon[7]==1 and legionhraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==111008 then
    legionhraachcompl(7)
  end
  end
end

if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==199246 and arg14==10 then
	if legionhraspisokon[8]==1 and legionhraachdone1 then
		legionhraachcompl(8)
	end
end


-- овердамаг, проверяю что убили моба
if arg2=="SPELL_DAMAGE" and (arg10==195033 or arg10==195036) and arg14>=0 then
  if legionhraspisokon[9]==1 and legionhraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==98246 then
	legionhracounter1=legionhracounter1+1
  end
  if legionhracounter1>5 then
    legionhraachcompl(9)
  end
  end
end

if arg2=="SPELL_CAST_SUCCESS" and arg10==198750 then
	if legionhraspisokon[10]==1 and legionhraachdone1 then
		legionhrafailnoreason(10)
	end
end

if (arg2=="SPELL_DAMAGE" and (arg10==220581 or arg10==220597 or arg10==220569)) then
	if legionhraspisokon[11]==1 and legionhraachdone1 and UnitGUID("boss1") then
		legionhramyfail(11)
	end
end


if arg2=="UNIT_DIED" and legionbosskilled==nil then
  if legionhraspisokon[12]==1 and legionhraachdone1 and fsdfdsfsdfsdfer==nil then
  local id=raGetUnitID(arg7)
  if id==103130 then
    legionhrafailnoreason(12)
	fsdfdsfsdfsdfer=1
  end
  end
end


if arg2=="SPELL_AURA_APPLIED" and arg10==197422 then
	if legionhraspisokon[13]==1 and legionhraachdone1 then
		rastarttrackingCrdana=GetTime()+1
		local spbuf=GetSpellInfo(197941)
		if checkBuff("player", spbuf) or checkDeBuff("player", spbuf) then
			legionhrafailnoreason(13, UnitName("player"))
		end
		if checkBuff("party1", spbuf) or checkDeBuff("party1", spbuf) then
			legionhrafailnoreason(13, UnitName("party1"))
		end
		if checkBuff("party2", spbuf) or checkDeBuff("party2", spbuf) then
			legionhrafailnoreason(13, UnitName("party2"))
		end
		if checkBuff("party3", spbuf) or checkDeBuff("party3", spbuf) then
			legionhrafailnoreason(13, UnitName("party3"))
		end
		if checkBuff("party4", spbuf) or checkDeBuff("party4", spbuf) then
			legionhrafailnoreason(13, UnitName("party4"))
		end
	end
end
if arg2=="SPELL_AURA_REMOVED" and arg10==197422 then
	rastarttrackingCrdana=nil
end
if arg2=="SPELL_DAMAGE" and arg10==197506 then
	if legionhraspisokon[13]==1 and legionhraachdone1 then
		raunitisplayer(arg7,arg8)
		if raunitplayertrue then
			legionhrafailnoreason(13, arg8)
		end
	end
end







end

end --КОНЕЦ ОНЕВЕНТ

function legionhra_closeallpr()
legionhramain6:Hide()
end


function legionhra_button2()
PSFea_closeallpr()
legionhramain6:Show()
openmenureportlegionhra()



if (legionhranespamit==nil) then

legionhraspislun= # legionhraspisokach5
legionhracbset={}
for i=1,legionhraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(legionhraspisokach5[i]) then

local _, legionhraName, _, completed, _, _, _, Description, _, legionhraImage = GetAchievementInfo(legionhraspisokach5[i])


--текст
local f = CreateFrame("Frame",nil,legionhramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)
f:SetScript("OnEnter", function(self) Rawhershowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Rawhershowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(legionhraspisokach5[i])) else ChatFrame_OpenChat(GetAchievementLink(legionhraspisokach5[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(legionhraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
if completed then
t:SetText("|cff00ff00"..legionhraName.."|r")
else
--no more red
t:SetText(legionhraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, legionhramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) legionhragalka(i) end )
table.insert(legionhracbset, c)

end --for i
legionhranespamit=1
end --nespam

legionhragalochki()



end --конец бутон2

function Rawhershowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Rawhershowtxt2(i)
GameTooltip:Hide()
end


function legionhragalochki()
for i=1,#legionhraspisokach5 do
if legionhracbset[i] then
if(legionhraspisokon[i]==1)then legionhracbset[i]:SetChecked(true) else legionhracbset[i]:SetChecked(false) end
end
end
end

function legionhragalka(nomersmeni)
if legionhraspisokon[nomersmeni]==1 then legionhraspisokon[nomersmeni]=0 else legionhraspisokon[nomersmeni]=1 end
end

function legionhra_buttonchangeyn(yesno)
legionhraspislun= # legionhraspisokach5
for i=1,legionhraspislun do
legionhraspisokon[i]=yesno
end
legionhragalochki()
end

function legionhra_button1()
legionhraspislun= # legionhraspisokach5
for i=1,legionhraspislun do
if legionhraspisokon[i]==1 then legionhraspisokon[i]=0 else legionhraspisokon[i]=1 end
end
legionhragalochki()
end


function openmenureportlegionhra()
if not DropDownMenureportlegionhra then
CreateFrame("Frame", "DropDownMenureportlegionhra", legionhramain6, "UIDropDownMenuTemplate")
end

DropDownMenureportlegionhra:ClearAllPoints()
DropDownMenureportlegionhra:SetPoint("BOTTOMLEFT", 5, 7)
DropDownMenureportlegionhra:Show()

local items = lowmenuchatlistea

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenureportlegionhra, self:GetID())

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

UIDropDownMenu_Initialize(DropDownMenureportlegionhra, initialize)
UIDropDownMenu_SetWidth(DropDownMenureportlegionhra, 90);
UIDropDownMenu_SetButtonWidth(DropDownMenureportlegionhra, 105)
UIDropDownMenu_SetSelectedID(DropDownMenureportlegionhra,bigma2num)
UIDropDownMenu_JustifyText(DropDownMenureportlegionhra, "LEFT")
end