--общий для фейлов с 1 удара
function legionrrafailnoreason(legionrranrach, prichina, quant,failsecond)
if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
raquantrepdone=raquantrepdone+1
else
	if failsecond then
		legionrraachdone2=false
	else
		legionrraachdone1=false
	end
if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
raquantrepdone=raquantrepdone+1
end
end
raplaysound(1,legionrraspisokach25[legionrranrach])
pseareportfailnoreason(prichina, quant)
end


--общий для выполненого с 1 события
function legionrraachcompl(icranrach)
legionrraachdone1=nil
raplaysound(2,legionrraspisokach25[icranrach])
pseareportallok()
end


function legionrratronpartfail(arg6,ktofail,lnn,lwhat,nrachieve)
raunitisplayer(arg6,ktofail)
if raunitplayertrue then

	if ramanyachon and raquantrepeatachtm==0 and raquantrepeatach>=raquantrepdone then
		raquantrepdone=raquantrepdone+1
	else
		if lnn==1 then
			legionrraachdone1=false
		end
		if lnn==2 then
			legionrraachdone2=false
		end
		if lnn==3 then
			legionrraachdone3=false
		end
		if lnn==4 then
			legionrraachdone4=false
		end
		if lnn==5 then
      legionrraachdone5=false
    end
		if raquantrepeatach==raquantrepdone-1 and raquantrepeatachtm==0 then
			raquantrepdone=raquantrepdone+1
		end
	end
	raplaysound(1,legionrraspisokach25[nrachieve],lnn)
	legionrrareportfailatron(lwhat, ktofail)
end
end


function legionrrareportfailatron(pseaotdamag, ktofail2)
local ratemp=""

if ramanyachon and raquantrepeatachtm==0 and raquantrepdone>2 then
ratemp=" #"..(raquantrepdone-1)
end

if ramanyachon and raquantrepeatachtm>0 and raquantrepdone>1 then
ratemp=" #"..raquantrepdone
end

if (wherereportraidach=="sebe") then
out("- "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
	if pseashowfailreas==true then
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc.." ("..ktofail2..")."..ratemp)
end
	else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
else
razapuskanonsa(wherereportraidach, "RA: {rt8} "..pseaotdamag.." "..achlinnk.." "..pseapartfailedloc..ratemp)
end
	end
end
end