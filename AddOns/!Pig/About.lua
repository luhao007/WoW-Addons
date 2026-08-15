local addonName, PD = ...;
function PD.addOptions_About()
	local gsub = _G.string.gsub
	local L=PD.locale
	local Fun=PD.Fun

	local Create = PD.Create
	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGButton=Create.PIGButton
	local PIGOptionsList=Create.PIGOptionsList
	local PIGFontString=Create.PIGFontString
	local PIGSetFont=Create.PIGSetFont
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGOptionsList_RF=Create.PIGOptionsList_RF
	local fuFrame = PIGOptionsList(L["ABOUT_TABNAME"],"BOT")
	local RTabFrame =Create.PIGOptionsList_RF(fuFrame)
	local aboutF,aboutBut =PIGOptionsList_R(RTabFrame,L["ABOUT_TABNAME"],90)
	aboutF:Show()
	aboutBut:Selected(true)

	aboutF:HookScript("OnShow", function (self)
		if self.addok then return end
		self.addok=true
		local Aboutdata={
			["Mail"] = "xdfxjf1004@hotmail.com",
			["Tutorial"] = "哔哩哔哩/抖音搜geligasi",
			["Disc"]="QQ群27397148,  2群117883385,  YY频道113213",
		}
		if GetLocale() ~= "zhCN" and GetLocale() ~= "zhTW" then
			Aboutdata.Tutorial = "YouTube@geligasi"
			Aboutdata.Disc="---"
		end
		local YY=-10
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},"xdfxjf1004@hotmail.com",L["ABOUT_MAIL"],nil,480)
		YY=YY-30
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},Aboutdata.Tutorial,L["ABOUT_TUTORIAL"],nil,480)
		YY=YY-30
		Create.extaddEditBox1(self,{"TOPLEFT",self,"TOPLEFT",20,YY},Aboutdata.Disc,L["ABOUT_DISC"],nil,480)
		YY=YY-31
		PIGLine(self,"TOP",YY)
	end);

	--扩展
	local extF,extBut =PIGOptionsList_R(RTabFrame,L["ABOUT_TABNAME2"],90)
	extF:HookScript("OnShow", function (self)
		if self.addok then return end
		self.addok=true
		local YY=-10
		for ExtID=1,#L.addnames do
			local addname=L.addnames[ExtID]
			local adddata=L.ExtList[addname]
			YY=ExtID>1 and YY-100 or YY
			Create.add_extLsitFrame("error",self,addname,adddata,YY)
		end
	end);
	--语音
	local audioF,audioBut =PIGOptionsList_R(RTabFrame,VOICE,90)
	audioF:HookScript("OnShow", function (self)
		if self.addok then return end
		self.addok=true
		local YY=-10
		for ExtID=1,#L.audioName do
			local addname=L.audioName[ExtID]
			local adddata=L.AudioList[addname]
			YY=ExtID>1 and YY-100 or YY
			Create.add_extLsitFrame("error",self,addname,adddata,YY)
		end
	end);
end