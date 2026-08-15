local addonName, addonTable = ...;

local Create = addonTable.Create
-------------------
function Create.PIGEditBox(fuji,Point,Width)
	local Width=Width or 80
	local E = CreateFrame('EditBox', nil, fuji,"InputBoxInstructionsTemplate");
	E:SetSize(Width,24);
	if Point then
		E:SetPoint(Point[1], Point[2], Point[3], Point[4], Point[5]);
	end
	Create.PIGSetFont(E);
	E:SetAutoFocus(false);
	E:SetMaxLetters(10)
	E:SetTextColor(0.7, 0.7, 0.7, 1);
	E:SetScript("OnEditFocusGained", function(self)
		self:HighlightText()
		self:SetTextColor(1, 1, 1, 1);
		if self.Savetishi then self.Savetishi:Show(); end
	end);
	E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.7, 0.7, 0.7, 1);
		if self.Savetishi then self.Savetishi:Hide();end
	end);
	E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
		if self.Savetishi then self.Savetishi:Hide();end
	end);
	return E
end
--时空之门
function Create.InitializeEditBox(EditUI,ShowTXT)
	EditUI:SetTextColor(0.5, 0.5, 0.5, 1);
	EditUI:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	EditUI:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.5, 0.5, 0.5, 1);
	end);
	EditUI:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus()
	end);
	EditUI:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus()
	end);
	if ShowTXT then EditUI:SetText(ShowTXT) end
end
function Create.IsEditBoxNumber(famsg,msglen,TextNum,TextErr,extbut)
	if msglen>250 then
		if extbut then extbut:Disable() end
		TextNum:SetText("|cffFF0000"..msglen.."|r/|cffFFFFFF250|r")
		TextErr:SetText("|cffFF0000字符超限，无法保存!|r");
		return false,msglen
	else
		if extbut then extbut:Enable() end
		TextNum:SetText("|cffFFFF00"..msglen.."|r/|cffFFFFFF250|r")
		TextErr:SetText();
	end
	return true,msglen
end
function Create.Update_SaveTempF(peizhiD,eui,EditNr)
	eui.SaveBut:Disable()
	eui.error:SetText("")
	if EditNr and EditNr=="" then
		eui.error:SetText("内容不能为空")
		return
	end
	local tpname = eui.E:GetText():gsub(" ", "")
	if tpname=="" then
		eui.error:SetText("模版名不能为空")
		return
	end
	for ixx=1,#peizhiD do
		if peizhiD[ixx][1]==tpname then
			eui.error:SetText("已存在同名模版,将覆盖")
			break
		end
	end
	eui.SaveBut:Enable()
end