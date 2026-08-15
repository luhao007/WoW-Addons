--- ScrollFrame doesn't have a built-in horizontal support. It's a mirror of Blizzard's implementation of ScrollUtil.InitScrollFrameWithScrollBar to work with horizontal scrolling.
--- Should be called separately as ScrollUtil.InitScrollFrameWithScrollBar is called in ScrollFrame_OnLoad.
---@param scrollFrame ScrollFrame
---@param scrollBar EventFrame
function ScrollUtil.InitHorizontalScrollFrameWithScrollBar(scrollFrame, scrollBar)
    local onHorizontalScroll = function(scrollFrame, offset)
        local horizontalScrollRange = scrollFrame:GetHorizontalScrollRange()

        local scrollPercentage = 0
        if horizontalScrollRange > 0 then
            scrollPercentage = offset / horizontalScrollRange
        end

        scrollBar:SetScrollPercentage(scrollPercentage, ScrollBoxConstants.NoScrollInterpolation)
    end

    scrollFrame:SetScript("OnHorizontalScroll", onHorizontalScroll)
    scrollFrame:SetScript("OnVerticalScroll", nil) -- Remove vertical scrolling handler.

    scrollFrame.GetPanExtent = function(self)
        return self.panExtent
    end

    scrollFrame.SetPanExtent = function(self, panExtent)
        self.panExtent = panExtent
    end

    -- Same default as Blizzard.
    scrollFrame:SetPanExtent(30)

    local onScrollRangeChanged = function(scrollFrame, hScrollRange, vScrollRange)
        onHorizontalScroll(scrollFrame, scrollFrame:GetHorizontalScroll())

        local visibleExtentPercentage = 0
        local width = scrollFrame:GetWidth()
        if width > 0 then
            visibleExtentPercentage = width / (hScrollRange + width)
        end

        scrollBar:SetVisibleExtentPercentage(visibleExtentPercentage)

        local panExtentPercentage = 0
        local horizontalScrollRange = scrollFrame:GetHorizontalScrollRange()
        if horizontalScrollRange > 0 then
            panExtentPercentage = Saturate(scrollFrame:GetPanExtent() / horizontalScrollRange)
        end

        scrollBar:SetPanExtentPercentage(panExtentPercentage)
    end
    scrollFrame:SetScript("OnScrollRangeChanged", onScrollRangeChanged)

    scrollFrame:SetScript("OnMouseWheel", function(scrollFrame, value)
        scrollBar:ScrollStepInDirection(-value)
    end)

    local onScrollBarScroll = function(_, scrollPercentage)
        local scroll = scrollPercentage * scrollFrame:GetHorizontalScrollRange()
        scrollFrame:SetHorizontalScroll(scroll)
    end
    scrollBar:RegisterCallback(BaseScrollBoxEvents.OnScroll, onScrollBarScroll, scrollFrame)
end
