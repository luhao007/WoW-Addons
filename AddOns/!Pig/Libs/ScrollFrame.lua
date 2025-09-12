local addonName, addonTable = ...;
local L=addonTable.locale
local Create = addonTable.Create
local FontUrl=Create.FontUrl
local PIGSetFont=Create.PIGSetFont
-------------------
function Create.PIGScrollFrame(fujik,Point,WH,BarW)
	local BarW=BarW or 16
	local Scroll = CreateFrame("ScrollFrame",nil,fujik); 
	Scroll:SetPoint(unpack(Point));
	Scroll:SetSize(WH[1],WH[2] or WH[1])
	Scroll.ScrollBar = CreateFrame("Slider", nil, Scroll)
	Scroll.ScrollBar:SetPoint("TOPLEFT",Scroll,"TOPRIGHT",0,-BarW);
	Scroll.ScrollBar:SetPoint("BOTTOMLEFT",Scroll,"BOTTOMRIGHT",0,BarW);
	Scroll.ScrollBar:SetWidth(BarW)
	Scroll.ScrollBar.ScrollUpButton = CreateFrame("Button",nil,Scroll.ScrollBar,"UIPanelScrollUpButtonTemplate");
	Scroll.ScrollBar.ScrollUpButton:SetSize(BarW,BarW-2);
	Scroll.ScrollBar.ScrollUpButton:SetPoint("BOTTOM",Scroll.ScrollBar,"TOP",0,0);
	Scroll.ScrollBar.ScrollUpButton:SetNormalAtlas("NPE_ArrowUp")
	Scroll.ScrollBar.ScrollUpButton:SetPushedAtlas("NPE_ArrowUp")
	Scroll.ScrollBar.ScrollUpButton:SetDisabledAtlas("NPE_ArrowUp")
	Scroll.ScrollBar.ScrollUpButton:GetDisabledTexture():SetDesaturated(true)
	Scroll.ScrollBar.ScrollUpButton:SetHighlightAtlas("minimal-scrollbar-arrow-top-over")
	Scroll.ScrollBar.ScrollUpButton:GetNormalTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollUpButton:GetPushedTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollUpButton:GetDisabledTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollUpButton:GetHighlightTexture():SetTexCoord(0,1,0,1)
	Scroll.ScrollBar.ScrollUpButton:SetScript("OnClick",UIPanelScrollBarScrollUpButton_OnClick)

	Scroll.ScrollBar.ScrollDownButton = CreateFrame("Button",nil,Scroll.ScrollBar,"UIPanelScrollDownButtonTemplate");
	Scroll.ScrollBar.ScrollDownButton:SetSize(BarW,BarW-2);
	Scroll.ScrollBar.ScrollDownButton:SetPoint("TOP",Scroll.ScrollBar,"BOTTOM",0,0);
	Scroll.ScrollBar.ScrollDownButton:SetNormalAtlas("NPE_ArrowDown")
	Scroll.ScrollBar.ScrollDownButton:SetPushedAtlas("NPE_ArrowDown")
	Scroll.ScrollBar.ScrollDownButton:SetDisabledAtlas("NPE_ArrowDown")
	Scroll.ScrollBar.ScrollDownButton:GetDisabledTexture():SetDesaturated(true)
	Scroll.ScrollBar.ScrollDownButton:SetHighlightAtlas("minimal-scrollbar-arrow-bottom-over")
	Scroll.ScrollBar.ScrollDownButton:GetNormalTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollDownButton:GetPushedTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollDownButton:GetDisabledTexture():SetTexCoord(0,1,0.24,0.76)
	Scroll.ScrollBar.ScrollDownButton:GetHighlightTexture():SetTexCoord(0,1,0,1)
	Scroll.ScrollBar.ScrollDownButton:SetScript("OnClick",UIPanelScrollBarScrollDownButton_OnClick)

	Scroll.ScrollBar.ThumbTexture = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	Scroll.ScrollBar.ThumbTexture:SetSize(BarW, 24);
	Scroll.ScrollBar.ThumbTexture:SetPoint("TOP",Scroll.ScrollBar,"TOP",0,0);
	Scroll.ScrollBar:SetThumbTexture(Scroll.ScrollBar.ThumbTexture);
	local thumbtop = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	thumbtop:SetAtlas("minimal-scrollbar-small-thumb-top-over", true);
	thumbtop:SetPoint("TOP",Scroll.ScrollBar.ThumbTexture,"TOP",0,0);
	local thumbbottom = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	thumbbottom:SetAtlas("minimal-scrollbar-small-thumb-bottom-over", true);
	thumbbottom:SetPoint("BOTTOM",Scroll.ScrollBar.ThumbTexture,"BOTTOM",0,0);
	local thumbmiddle = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	thumbmiddle:SetAtlas("minimal-scrollbar-small-thumb-middle-over", true);
	thumbmiddle:SetPoint("TOPLEFT", thumbtop, "BOTTOMLEFT");
	thumbmiddle:SetPoint("BOTTOMRIGHT", thumbbottom, "TOPRIGHT");

	local beginTexture = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	beginTexture:SetAtlas("minimal-scrollbar-track-top", true);
	beginTexture:SetPoint("TOP");
	local endTexture = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	endTexture:SetAtlas("minimal-scrollbar-track-bottom", true);
	endTexture:SetPoint("BOTTOM");
	local middleTexture = Scroll.ScrollBar:CreateTexture(nil, "ARTWORK");
	middleTexture:SetAtlas("!minimal-scrollbar-track-middle", true);
	middleTexture:SetPoint("TOPLEFT", beginTexture, "BOTTOMLEFT");
	middleTexture:SetPoint("BOTTOMRIGHT", endTexture, "TOPRIGHT");
	Scroll.ScrollBar:SetScript("OnValueChanged", function(self, value)
		UIPanelScrollBar_OnValueChanged(self, value)
	end)
	UIPanelScrollFrame_OnLoad(Scroll)
	Scroll:SetScript("OnScrollRangeChanged", function(self, xrange, yrange)
		ScrollFrame_OnScrollRangeChanged(self, xrange, yrange)
	end)
	Scroll:SetScript("OnVerticalScroll", function(self, offset)
		ScrollFrame_OnVerticalScroll(self, offset)
	end)
	Scroll:SetScript("OnMouseWheel", function(self, delta)
		ScrollFrameTemplate_OnMouseWheel(self, delta);
	end)
	return Scroll
end