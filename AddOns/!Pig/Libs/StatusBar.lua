local addonName, addonTable = ...;
local Create = addonTable.Create
----
local BarTexList = {
	{TEXTURES_SUBHEADER.."1","interface/buttons/greyscaleramp64.blp"},
	{TEXTURES_SUBHEADER.."2","interface/targetingframe/ui-statusbar.blp"},
	{TEXTURES_SUBHEADER.."3","interface/targetingframe/ui-statusbar-glow.blp"},
	{TEXTURES_SUBHEADER.."4","interface/chatframe/chatframebackground.blp"},
};
local BorderColorX = {0.65, 0.65, 0.65, 1}
local BGColorX = {0, 0, 0, 0.4}
function Create.add_Bar(fuji,ly,Point,WH)
	local BarHT
	if ly==4 or ly==6 or ly==11 then
		BarHT = CreateFrame("Frame", nil, fuji)
		BarHT:SetPoint("TOPLEFT",fuji,"TOPLEFT",0,0);
		BarHT:SetPoint("TOPRIGHT",fuji,"TOPRIGHT",0,0);
		function BarHT:PIGBackdropBorderColor(butlist)
			for ix=1,#butlist do
				butlist[ix]:SetBackdropBorderColor(unpack(BorderColorX))
			end
		end
		function BarHT:PIGBackdropColor(butlist,ColorX)
			for ix=1,#butlist do
				butlist[ix]:SetBackdropColor(unpack(ColorX or BGColorX))
			end
		end
		function BarHT:PIGStatusBarTexture(butlist,TexID)
			for ix=1,#butlist do
				if ly==4 or ly==11 then
					butlist[ix]:SetBackdrop({bgFile = BarTexList[TexID][2],edgeFile = Create.edgeFile, edgeSize = 8})
					butlist[ix]:SetBackdropColor(1, 0, 0, 0);
				elseif ly==6 then
					butlist[ix].bar:SetStatusBarTexture(BarTexList[TexID][2])
				end
			end
		end
		function BarHT:Set_BarFont() end
		if ly==6 then
			BarHT.bg = BarHT:CreateTexture(nil, "BACKGROUND");
			BarHT.bg:SetTexture("interface/chatframe/chatframebackground.blp");
			BarHT.bg:SetPoint("TOPLEFT",BarHT,"TOPLEFT",0,0);
			BarHT.bg:SetPoint("BOTTOMRIGHT",BarHT,"BOTTOMRIGHT",0,0);
			BarHT.bg:SetColorTexture(unpack(BGColorX))
		end
	else
		BarHT = CreateFrame("StatusBar", nil, fuji);
		BarHT:SetStatusBarTexture(BarTexList[PIGA["CombatPlus"]["HPMPBar"]["BarTex"]][2])
		if ly=="DIY" then
			BarHT:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
			BarHT:SetSize(WH[1],WH[2]);
		elseif fuji.next then
			BarHT:SetPoint("TOPLEFT",fuji.next,"BOTTOMLEFT",0,1);
			BarHT:SetPoint("TOPRIGHT",fuji.next,"BOTTOMRIGHT",0,1);
		else
			BarHT:SetPoint("TOPLEFT",fuji,"TOPLEFT",0,0);
			BarHT:SetPoint("TOPRIGHT",fuji,"TOPRIGHT",0,0);
		end
		BarHT.bg = BarHT:CreateTexture(nil, "BACKGROUND");
		BarHT.bg:SetTexture("interface/chatframe/chatframebackground.blp");
		BarHT.bg:SetPoint("TOPLEFT",BarHT,"TOPLEFT",0,0);
		BarHT.bg:SetPoint("BOTTOMRIGHT",BarHT,"BOTTOMRIGHT",0,0);
		BarHT.bg:SetColorTexture(unpack(BGColorX))
		BarHT.Border = CreateFrame("Frame", nil, BarHT,"BackdropTemplate")
		BarHT.Border:SetBackdrop({edgeFile = Create.edgeFile, edgeSize = 8})
		BarHT.Border:SetBackdropBorderColor(unpack(BorderColorX))
		BarHT.Border:SetPoint("TOPLEFT",BarHT,"TOPLEFT",0,0);
		BarHT.Border:SetPoint("BOTTOMRIGHT",BarHT,"BOTTOMRIGHT",0,0);
		BarHT.xiaxian = BarHT:CreateFontString();
		BarHT.V = BarHT:CreateFontString();
		BarHT.maxV = BarHT:CreateFontString();
		if ly=="DIY" then
			BarHT.V:SetPoint("BOTTOM",BarHT,"TOP",0,0);
			BarHT.maxV:SetPoint("TOP",BarHT,"BOTTOM",0,0);
		else
			BarHT.xiaxian:SetPoint("CENTER",BarHT,"CENTER",0,0.8);
			BarHT.V:SetPoint("RIGHT",BarHT.xiaxian,"LEFT",0,0);
			BarHT.maxV:SetPoint("LEFT",BarHT.xiaxian,"RIGHT",0,0);
		end
		function BarHT:PIGStatusBarColort(r,g,b,a)
			self:SetStatusBarColor(r,g,b,a);
		end
		function BarHT:Set_BarFont()
			local zitix=TextStatusBarText:GetFont()--ChatFontNormal:GetFont()
			self.xiaxian:SetFont(zitix, PIGA["CombatPlus"]["HPMPBar"]["FontSize"],"OUTLINE")
			self.V:SetFont(zitix, PIGA["CombatPlus"]["HPMPBar"]["FontSize"],"OUTLINE")
			self.maxV:SetFont(zitix, PIGA["CombatPlus"]["HPMPBar"]["FontSize"],"OUTLINE")
			if ly=="DIY" then
				self.xiaxian:Hide()
				self.maxV:Show()
				self.V:Show()
			else
				if fuji.Showshuzhi then
					self.xiaxian:Show()
					self.maxV:Show()
					self.V:Show()
				else
					self.xiaxian:Hide()
					self.maxV:Hide()
					self.V:Hide()
				end
			end
		end
		BarHT:Set_BarFont()
		BarHT.xiaxian:SetText("/")
		function BarHT:PIGStatusBarTexture(TexID)
			self:SetStatusBarTexture(BarTexList[TexID][2])
		end
		function BarHT:Update_MaxValues(HPMAX) 
			local HPMAX = HPMAX or 1
			self:SetMinMaxValues(0, HPMAX)
			if ly=="DIY" then
				self.maxV:SetText(HPMAX);
			else
				if fuji.Showshuzhi then
					self.maxV:SetText(HPMAX);
				end
			end
		end
		function BarHT:Update_Values(HP)
			local HP = HP or 1
			self:SetValue(HP);
			if ly=="DIY" then
				self.V:SetText(HP);
			else
				if fuji.Showshuzhi then
					self.V:SetText(HP);
				end
			end
		end
	end
	fuji.BarTexNum=#BarTexList
	return BarHT
end