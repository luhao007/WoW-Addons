local addonName, addonTable = ...;
local L=addonTable.locale
local Create = addonTable.Create
local FontUrl=Create.FontUrl
local PIGSetFont=Create.PIGSetFont
-------------------
function Create.PIGScrollFrame_old(fujik,Point,WH,BarW)
	local BarW=BarW or 16
	local Point_1,Point_2,Point_3,Point_4=0,0,0,0
	if Point then
		Point_1,Point_2,Point_3,Point_4=Point[1],Point[2],Point[3],Point[4]
	end
	local Scroll = CreateFrame("ScrollFrame",nil,fujik); 
	if WH then
		Scroll:SetSize(WH[1],WH[2] or WH[1])
	else
		Scroll:SetPoint("TOPLEFT",fujik,"TOPLEFT",Point_1,Point_2);
		Scroll:SetPoint("BOTTOMRIGHT",fujik,"BOTTOMRIGHT",Point_3-BarW,Point_4);
	end
	Scroll.ScrollChildFrame = CreateFrame("Frame", nil, Scroll);
	Scroll.ScrollChildFrame:SetSize(Scroll:GetWidth(), 10)
	Scroll:SetScrollChild(Scroll.ScrollChildFrame)
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
	Scroll.ScrollBar.ThumbTexture:SetPoint("TOP",Scroll.ScrollBar,"TOP",0,0);
	Scroll.ScrollBar.ThumbTexture:SetSize(BarW,Scroll:GetHeight()*0.28);
	Scroll.ScrollBar:SetThumbTexture(Scroll.ScrollBar.ThumbTexture);
	local thumbtop = Scroll.ScrollBar:CreateTexture(nil, "BORDER");
	thumbtop:SetAtlas("minimal-scrollbar-small-thumb-top", true);
	thumbtop:SetPoint("TOP",Scroll.ScrollBar.ThumbTexture,"TOP",0,0);
	local thumbtopHIGHLIGHT = Scroll.ScrollBar:CreateTexture(nil, "HIGHLIGHT");
	thumbtopHIGHLIGHT:SetAtlas("minimal-scrollbar-small-thumb-top-over", true);
	thumbtopHIGHLIGHT:SetPoint("TOP",Scroll.ScrollBar.ThumbTexture,"TOP",0,0);
	local thumbbottom = Scroll.ScrollBar:CreateTexture(nil, "BORDER");
	thumbbottom:SetAtlas("minimal-scrollbar-small-thumb-bottom", true);
	thumbbottom:SetPoint("BOTTOM",Scroll.ScrollBar.ThumbTexture,"BOTTOM",0,0);
	local thumbbottomHIGHLIGHT = Scroll.ScrollBar:CreateTexture(nil, "HIGHLIGHT");
	thumbbottomHIGHLIGHT:SetAtlas("minimal-scrollbar-small-thumb-bottom-over", true);
	thumbbottomHIGHLIGHT:SetPoint("BOTTOM",Scroll.ScrollBar.ThumbTexture,"BOTTOM",0,0);
	local thumbmiddle = Scroll.ScrollBar:CreateTexture(nil, "BORDER");
	thumbmiddle:SetAtlas("minimal-scrollbar-small-thumb-middle", true);
	thumbmiddle:SetPoint("TOPLEFT", thumbtop, "BOTTOMLEFT");
	thumbmiddle:SetPoint("BOTTOMRIGHT", thumbbottom, "TOPRIGHT");
	local thumbmiddleHIGHLIGHT = Scroll.ScrollBar:CreateTexture(nil, "HIGHLIGHT");
	thumbmiddleHIGHLIGHT:SetAtlas("minimal-scrollbar-small-thumb-middle-over", true);
	thumbmiddleHIGHLIGHT:SetPoint("TOPLEFT", thumbtop, "BOTTOMLEFT");
	thumbmiddleHIGHLIGHT:SetPoint("BOTTOMRIGHT", thumbbottom, "TOPRIGHT");

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
		self:GetParent():SetVerticalScroll(value);
	end)
	Scroll:SetScript("OnMouseWheel", function(self, delta)
		ScrollFrameTemplate_OnMouseWheel(self, delta);
	end)
	Scroll:SetScript("OnVerticalScroll", function(self, offset)
		self:UpdateShowList(offset)
	end)
	local function UpdataThumbTexture(max)
		Scroll.ScrollBar.ThumbTexture:SetShown(max>0)
		thumbtop:SetShown(max>0)
		thumbtopHIGHLIGHT:SetShown(max>0)
		thumbbottom:SetShown(max>0)
		thumbbottomHIGHLIGHT:SetShown(max>0)
		thumbmiddle:SetShown(max>0)
		thumbmiddleHIGHLIGHT:SetShown(max>0)
	end
	UpdataThumbTexture(0)
	function Scroll:UpdateThumbTexture(numItems, numToDisplay, buttonHeight)
	    local scrollBar = self.ScrollBar or self.scrollBar
	    if not scrollBar then return end
	    local thumb = scrollBar.ThumbTexture
	    if not thumb then return end
	    local trackHeight = self:GetHeight() - (scrollBar.ScrollUpButton and scrollBar.ScrollUpButton:GetHeight() or 0) - 
	                                      (scrollBar.ScrollDownButton and scrollBar.ScrollDownButton:GetHeight() or 0)
	    local contentHeight = numItems * buttonHeight
	    local viewHeight = numToDisplay * buttonHeight
	    local thumbHeight
	    if contentHeight > viewHeight then
	        thumbHeight = math.max(24, (viewHeight / contentHeight) * trackHeight)
	    else
	        thumbHeight = trackHeight
	    end
	    thumb:SetHeight(thumbHeight)
	end
	function Scroll:GetScrollFrameOffset(TotalNum, hangmaxnum, hangeH)
	    FauxScrollFrame_Update(self, TotalNum, hangmaxnum, hangeH)
	    self:UpdateThumbTexture(TotalNum, hangmaxnum, hangeH)
	    local min, max = self.ScrollBar:GetMinMaxValues();
	    local offset=self.ScrollBar:GetValue()
		self.offset = math.floor((offset / hangeH) + 0.5);
	    return self.offset or 0;
	end
	--非等高行处理
	function Scroll:GetScrollNR()
		self.UpdateThumbTexture = nil
   		self.GetScrollFrameOffset = nil
   	 	local scrollBar = self.ScrollBar
	    self:SetScript("OnVerticalScroll", function(self, offset)
	        local min, max = scrollBar:GetMinMaxValues()
	        scrollBar.ScrollUpButton:SetEnabled(offset > 0.5) 
	        scrollBar.ScrollDownButton:SetEnabled(offset < (max - 0.5)) 
	        UpdataThumbTexture(max)
	    end)
	    self:SetScript("OnScrollRangeChanged", function(self, xrange, yrange)
	        local maxScroll = math.max(0, yrange)
	        scrollBar:SetMinMaxValues(0, maxScroll)
	        local currentVal = scrollBar:GetValue()
	        if currentVal > maxScroll then
	            scrollBar:SetValue(maxScroll)
	        end
	        self:GetScript("OnVerticalScroll")(self, scrollBar:GetValue())
	    end)    
	    return self.ScrollChildFrame
	end
	UIPanelScrollFrame_OnLoad(Scroll)
	return Scroll
end

---
function Create.PIGScrollFrame(fujik,hangHeight,Point,WH,frameType)
	local hangHeight=hangHeight or 20
	local frameType=frameType or "Button"
	local Point_1,Point_2,Point_3,Point_4=0,0,0,0
	if Point then
		Point_1,Point_2,Point_3,Point_4=Point[1],Point[2],Point[3],Point[4]
	end
	local ScrollF = CreateFrame("Frame", nil, fujik);
	if WH then
		ScrollF:SetPoint(Point_1,Point_2,Point_3,Point_4);
		ScrollF:SetSize(WH[1],WH[2] or WH[1])
	else
		ScrollF:SetPoint("TOPLEFT",fujik,"TOPLEFT",Point_1,Point_2);
		ScrollF:SetPoint("BOTTOMRIGHT",fujik,"BOTTOMRIGHT",Point_3,Point_4);
	end
	ScrollF.ScrollBox = CreateFrame("Frame", nil, ScrollF, "WowScrollBoxList")
	ScrollF.ScrollBar = CreateFrame("EventFrame", nil, ScrollF, "MinimalScrollBar")
	ScrollF.ScrollBar:SetPoint("TOPLEFT", ScrollF.ScrollBox, "TOPRIGHT",4,0)
	ScrollF.ScrollBar:SetPoint("BOTTOMLEFT", ScrollF.ScrollBox, "BOTTOMRIGHT",4,0)
	local anchorsWithBar = {--出现ScrollBox的定位
	    CreateAnchor("TOPLEFT", ScrollF, "TOPLEFT", 1, -1),
	    CreateAnchor("BOTTOMRIGHT", ScrollF, "BOTTOMRIGHT", -16, 1),
	}
	local anchorsWithoutBar = {--没出现ScrollBox的定位
	    anchorsWithBar[1],
	    CreateAnchor("BOTTOMRIGHT", ScrollF, "BOTTOMRIGHT", -1, 1),
	} 
	ScrollUtil.AddManagedScrollBarVisibilityBehavior(ScrollF.ScrollBox, ScrollF.ScrollBar, anchorsWithBar, anchorsWithoutBar)
	
    local view = CreateScrollBoxListLinearView()
    ScrollUtil.InitScrollBoxListWithScrollBar(ScrollF.ScrollBox, ScrollF.ScrollBar, view)
    view:SetElementExtent(hangHeight)--行高度
    --动态计算每个元素的高度
    -- view:SetElementExtentCalculator(function(dataIndex, elementData)
    --     return 20;
    -- end);
    view:SetPadding(0,0,0,0,0)--行内边距/间距paddingT,paddingB,paddingL,paddingR,spacing
	view:SetElementInitializer(frameType, function(hang, elementData)
		ScrollF.Update_Hang(hang, elementData)
	end)
	return ScrollF
end