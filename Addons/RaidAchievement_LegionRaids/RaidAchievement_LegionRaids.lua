function legionrraonload()
	legionrraachdone1=true
	legionrracounter1=0
	legionrratimerfurnace=nil
	legionrratimerkromog=nil
	rscupdhpcheckhr=GetTime()

--SetMapToCurrentZone()
--if C_Map.GetBestMapForUnit("player")==1094 or C_Map.GetBestMapForUnit("player")==1088 or C_Map.GetBestMapForUnit("player")==1147 then
if racheckzoneId({777,778,779,780,781,782,783,784,785,786,787,788,789,764,765,766,767,768,769,770,771,772,850,851,852,853,854,855,856},C_Map.GetBestMapForUnit("player")) then
	RaidAchievement_legionrra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_legionrra:RegisterEvent("UNIT_POWER_UPDATE")
	RaidAchievement_legionrra:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end
	RaidAchievement_legionrra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_legionrra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_legionrra:RegisterEvent("ADDON_LOADED")
	
	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==17 then
		lfrenable=1
  else
    lfrenable=nil
  end


legionrraspisokach25={

10753, -- http://www.wowhead.com/achievement=10753/scare-bear

10851, -- http://www.wowhead.com/achievement=10851/elementalry
10704, -- http://www.wowhead.com/achievement=10704/not-for-you

--11724, -- http://www.wowhead.com/achievement=11724/fel-turkey
11699, -- http://www.wowhead.com/achievement=11699/grand-fin-ale
11773, -- http://www.wowhead.com/achievement=11773/wax-on-wax-off
11770, -- http://www.wowhead.com/achievement=11770/dark-souls
}



if (legionrraspisokon==nil) then
legionrraspisokon={}
end


end


function legionrra_OnUpdate(curtime)










end


function legionrraonevent(self,event,...)

local arg1, arg2, arg3,arg4,arg5,arg6 = ...



if event == "PLAYER_REGEN_DISABLED" then
if (rabilresnut and GetTime()<rabilresnut+3) or racheckbossincombat then
else
--обнулять все данные при начале боя тут:
legionrraachdone1=true
legionrracounter1=0
legionrratimerfurnace=nil
legionrratimerkromog=nil
raramapwidth=nil
raramapheight=nil
psranormgolong=nil

rababahcount=nil

ramariotrack=nil
ramariotableguid=nil
ratableforgaroshach1=nil
ratableforgaroshach2=nil

rsprotossdb1=nil
rsprotossdb2=nil
rsprotossdb3=nil


	if UnitGUID("boss1") and UnitName("boss1")~="" then
		local id2=UnitGUID("boss1")
		local id=raGetUnitID(id2)

	else
		racrtimerbossrecheck=GetTime()+3
	end
end

end


if event == "CHAT_MSG_RAID_BOSS_EMOTE" then



end


if event == "ZONE_CHANGED_NEW_AREA" then

rpradelayzonech=GetTime()+2

	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==17 then
		lfrenable=1
  else
    lfrenable=nil
  end

end

if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_LegionRaids" then

for i=1,#legionrraspisokach25 do
if legionrraspisokon[i]==nil then legionrraspisokon[i]=1 end
end
	end
end


if event == "UNIT_POWER_UPDATE" then
if UnitName("boss1") and UnitName("boss1")~="" then



end
end




if event == "COMBAT_LOG_EVENT_UNFILTERED" and lfrenable==nil then

local arg1, arg2, arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14, arg15,arg16,arg17,arg18,arg19 = CombatLogGetCurrentEventInfo()


--ТУТ АЧИВЫ

if arg2=="UNIT_DIED" then
  if legionrraspisokon[1]==1 and legionrraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==111263 then
      legionrrafailnoreason(1)
    end
  end
end


if arg2=="UNIT_DIED" then
  if legionrraspisokon[2]==1 and legionrraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==111595 then
      legionrraachcompl(2)
    end
  end
end

if (arg2=="SPELL_DAMAGE" and arg10==213531) and arg4 and arg8 then
   raunitisplayer(arg7,arg8)
   if raunitplayertrue then
      if legionrraspisokon[3]==1 and legionrraachdone1 then
         legionrrafailnoreason(3,arg8)
      end
   end
end

-- 7.2 patch
if arg2=="UNIT_DIED" and 1==2 then
  if legionrraspisokon[4]==1 and legionrraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==116976 then
      legionrraachcompl(4)
    end
  end
end
if arg2=="UNIT_DIED" then
  if legionrraspisokon[4]==1 and legionrraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==116407 then
      legionrraachcompl(4)
    end
  end
end
if arg2=="UNIT_DIED" then
  if legionrraspisokon[5]==1 and legionrraachdone1 and UnitGUID("boss1") then
  local id=raGetUnitID(arg7)
  if id==121498 then
      legionrraachcompl(5)
    end
  end
end
if (arg2=="SPELL_CAST_SUCCESS" and arg10==241702) and UnitGUID("boss1") then
      if legionrraspisokon[6]==1 and legionrraachdone1 then
         legionrrafailnoreason(6)
      end
end







-- OLD
if (1==2) then
--BRF (2 dung)
if racheckzoneId({596,597,598,599,600},C_Map.GetBestMapForUnit("player")) then

if arg2=="UNIT_DIED" then
  if legionrraspisokon[1]==1 and legionrraachdone1 then
  local id=raGetUnitID(arg7)
  if id==77337 then
      legionrrafailnoreason(1)
    end
  end
end

-- Stamp Stamp Revolution

if (arg2=="SPELL_DAMAGE" and arg10==158140) and arg4 and arg8 then
   raunitisplayer(arg7,arg8)
   if raunitplayertrue then
      if legionrraspisokon[2]==1 and legionrraachdone1 then
         legionrrafailnoreason(2,arg8)
      end
   end
end

-- Ya, We've Got Time

if arg2=="UNIT_DIED" then
  if legionrraspisokon[3]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==76815 then
       legionrracounter1=legionrracounter1+1

       if legionrratimerfurnace==nil then -- start the timer if this was first kill
          legionrratimerfurnace=GetTime()+10
       end
       if legionrracounter1==4 then
          legionrratimerfurnace=nil -- reset timer since achievement is completed
          legionrraachcompl(3)
       end
     end
  end
end
-- Would you give me a hand
if arg2=="UNIT_DIED" then
  if legionrraspisokon[4]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==77893 then
       legionrracounter1=legionrracounter1+1

       if legionrratimerkromog==nil then -- start the timer if this was first kill
          legionrratimerkromog=GetTime()+5
       end
       if legionrracounter1>=10 then
          legionrratimerkromog=nil -- reset timer since achievement is completed
          legionrraachcompl(4)
       end
     end
  end
end
end
--
--

if racheckzoneId({661,662,663,664,665,666,667,668,669,670},C_Map.GetBestMapForUnit("player")) then
if arg2=="UNIT_DIED" then
  if legionrraspisokon[6]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==94808 then
       legionrracounter1=legionrracounter1+1

       if legionrracounter1==10 then
          legionrraachcompl(6)
       end
     end
  end
end

if arg2=="UNIT_DIED" then
  if legionrraspisokon[7]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==90980 then
          legionrrafailnoreason(7)
     end
  end
end

if arg2=="UNIT_DIED" then
  if legionrraspisokon[8]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==93145 then
          legionrraachcompl(8)
     end
  end
end

--Pro-toss // ОТКЛЮЧЕНО
if arg2=="SPELL_AURA_APPLIED" and arg10==1792029999 then
	if rsprotossdb1==nil then
		rsprotossdb1={}
		rsprotossdb2={}
		rsprotossdb3={}
	end
	local bil=0
	if (#rsprotossdb1>0) then
		for i=1,#rsprotossdb1 do
			if rsprotossdb1[i]==arg7 then
				rsprotossdb2[i]=GetTime()
				bil=1
			end
		end
	end
	if (bil==0) then
		table.insert(rsprotossdb1,arg7)
		table.insert(rsprotossdb2,GetTime())
		table.insert(rsprotossdb3,arg8)
		rastartprotosstimer=GetTime()
	end
end
if arg2=="SPELL_AURA_REMOVED" and arg10==1792029999 then
	if rsprotossdb1 and #rsprotossdb1>0 then
		for i=1,#rsprotossdb1 do
			if rsprotossdb1[i] then
				if rsprotossdb1[i]==arg7 then
					local ltime=GetTime()-rsprotossdb2[i]
					if ltime>5 then
						ltime=math.ceil(ltime*10)/10
						if legionrraspisokon[9]==1 and legionrraachdone1 then
							legionrrafailnoreason(9, arg8.." ("..ltime.." sec)")
							table.remove(rsprotossdb1,i)
							table.remove(rsprotossdb2,i)
							table.remove(rsprotossdb3,i)
						end
					end
				end
			end
		end
	end
end

if arg2=="UNIT_DIED" then
  if legionrraspisokon[9]==1 and legionrraachdone1 then
     local id=raGetUnitID(arg7)
     if id==90270 and UnitGUID("boss1") then
          legionrrafailnoreason(9)
     end
  end
end

if (arg2=="SPELL_AURA_APPLIED" and arg10==185656) and arg8 then
   raunitisplayer(arg7,arg8)
   if raunitplayertrue then
      if legionrraspisokon[10]==1 and legionrraachdone1 then
         legionrrafailnoreason(10,arg8)
      end
   end
end



end
--
end --OLD




end
end --КОНЕЦ ОНЕВЕНТ

function legionrra_closeallpr()
legionrramain6:Hide()
end


function legionrra_button2()
PSFea_closeallpr()
legionrramain6:Show()
openmenureportlegionrra()



if (legionrranespamit==nil) then

legionrraspislun= # legionrraspisokach25
legionrracbset={}

for i=1,legionrraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(legionrraspisokach25[i]) then

local _, legionrraName, _, completed, _, _, _, Description, _, legionrraImage = GetAchievementInfo(legionrraspisokach25[i])

if completed then
legionrraName="|cff00ff00"..legionrraName.."|r"
else
--no more red
end



--текст
local f = CreateFrame("Frame",nil,legionrramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)




f:SetScript("OnEnter", function(self) Raiccshowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Raiccshowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(legionrraspisokach25[i])) else ChatFrame_OpenChat(GetAchievementLink(legionrraspisokach25[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(legionrraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(548)
if i==3 then
  t:SetText(legionrraName)
else
  t:SetText(legionrraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, legionrramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) legionrragalka(i) end )
table.insert(legionrracbset, c)


end --for i
legionrranespamit=1
end --nespam


legionrragalochki()




end --конец бутон2

function Raiccshowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Raiccshowtxt2(i)
GameTooltip:Hide()
end


function legionrragalochki()
for i=1,#legionrraspisokach25 do
if(legionrraspisokon[i]==1)then legionrracbset[i]:SetChecked(true) else legionrracbset[i]:SetChecked(false) end
end
end

function legionrragalka(nomersmeni)
if legionrraspisokon[nomersmeni]==1 then legionrraspisokon[nomersmeni]=0 else legionrraspisokon[nomersmeni]=1 end
end

function legionrra_buttonchangeyn(yesno)
legionrraspislun= # legionrraspisokach25
for i=1,legionrraspislun do
legionrraspisokon[i]=yesno
end
legionrragalochki()
end

function legionrra_button1()
legionrraspislun= # legionrraspisokach25
for i=1,legionrraspislun do
if legionrraspisokon[i]==1 then legionrraspisokon[i]=0 else legionrraspisokon[i]=1 end
end
legionrragalochki()
end


function openmenureportlegionrra()
if not DropDownMenureportlegionrra then
CreateFrame("Frame", "DropDownMenureportlegionrra", legionrramain6, "UIDropDownMenuTemplate")
end
rachatdropm(DropDownMenureportlegionrra,5,7)
end



function raGetMapSize()
	-- try custom map size first
	local mapName = GetMapInfo()
	local floor, a1, b1, c1, d1 = GetCurrentMapDungeonLevel()

	--Blizzard's map size
	if not (a1 and b1 and c1 and d1) then
		local zoneIndex, a2, b2, c2, d2 = GetCurrentMapZone()
		a1, b1, c1, d1 = a2, b2, c2, d2
	end

	if not (a1 and b1 and c1 and d1) then return end
	return abs(c1-a1), abs(d1-b1)
end