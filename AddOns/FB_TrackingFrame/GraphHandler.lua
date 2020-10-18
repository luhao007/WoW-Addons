-- Do graph stuff
-- This should be a separate addon someday

--[[
Name: GraphHandler-1.0
Author(s): Sutorix <sutorix@hotmail.com>
Description: A library with common graph routines used by FB_TrackingFrame.
--]]

local MAJOR_VERSION = "GraphHandler-1.0"
local MINOR_VERSION = 3

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end

local GraphHandler, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not GraphHandler then
	return
end

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local LG = LibStub("LibGraph-2.0");

GraphHandler.BAR = "BAR";
GraphHandler.LEGEND = "LEGEND";
GraphHandler.OVERLAY = "OVERLAY";
GraphHandler.LINE = "LINE";
GraphHandler.LABEL = "LABEL";
GraphHandler.TEXT = "TEXT";

function GraphHandler:OnClick()
   if ( self.ClickHandler ) then
       self.ClickHandler(self, button);
   end
end


local function MakeName(self, kind, idx)
   if ( not idx ) then
      idx = table.getn(self.elements[kind])+1;
   end
   return self:GetName().."_"..kind.."_"..idx;
end

GraphHandler.MakeElement = {};

local function Legend_OnEnter(self)
   if( self.item or self.tooltip ) then
      GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
      if (self.item and self.item ~= "") then
         GameTooltip:SetHyperlink("item:"..self.item);
      elseif (self.tooltip) then
         GameTooltip:SetText(self.tooltip);
      end
   end
end

local function Legend_OnLeave(self)
   if( self.item or self.tooltop ) then
      self.updateToolTip = nil;
      GameTooltip:Hide();
   end
end

local function Legend_OnClick(self, button)
   if ( button == "LeftButton" and IsShiftKeyDown() and self.item ) then
       FishingBuddy.ChatLink(self.item, self.name, self.color);
   elseif ( self.ClickHandler ) then
       self:ClickHandler(button);
   end
end

GraphHandler.MakeElement[GraphHandler.LEGEND] = function(self, texture, lcolor)
   local name = MakeName(self, GraphHandler.LEGEND);
   local legend = CreateFrame("Button", name, self);

   legend:SetScript("OnEnter", Legend_OnEnter);
   legend:SetScript("OnLeave", Legend_OnLeave);
   legend:SetScript("OnClick", Legend_OnClick);
   legend:SetHeight(18);
   legend:SetWidth(40);
   
   local bar = CreateFrame("Button", name.."Color", legend);
   local c = bar:CreateTexture(name.."ColorTexture", "OVERLAY");
   bar:SetWidth(10);
   bar:SetHeight(16);
   c:SetAllPoints();
   if (lcolor) then
      c:SetTexture(lcolor.r, lcolor.g, lcolor.b, 1.0);
   else
      c:SetTexture(1.0, 1.0, 1.0, 1.0);
   end
   c:Show();

   local icon = CreateFrame("Button", name.."Icon", legend);
   local tex = icon:CreateTexture(name.."IconTexture", "BORDER");
   icon:SetWidth(16);
   icon:SetHeight(16);
   tex:SetAllPoints();
   if (texture) then
      tex:SetTexture(texture);
   end
   tex:Show();

   local fl = self:GetFrameLevel();
   legend:SetFrameLevel(fl+1);
   bar:SetFrameLevel(fl);
   icon:SetFrameLevel(fl);

   icon:SetPoint("LEFT", legend, "LEFT", 5, 0);
   bar:SetPoint("LEFT", icon, "RIGHT", 2, 0);
   icon:Show();
   bar:Show();

   return legend;
end

GraphHandler.MakeElement[GraphHandler.BAR] = function(self, texture)
   local kind = GraphHandler.BAR;
   local name = MakeName(self, kind);
   local bar = CreateFrame("Button", name, self);
   local c = bar:CreateTexture(name.."Texture", "OVERLAY");
   if ( not texture ) then
      c:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ReputationBar");
   else
      c:SetTexture(texture);
   end
   c:SetAllPoints();
   return bar;
end

GraphHandler.MakeElement[GraphHandler.LINE] = function(self)
   local kind = GraphHandler.LINE;
   local name = MakeName(self, kind);
   local c = self:CreateTexture(name.."Texture", "OVERLAY");
   c:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Line");
   return c;
end

GraphHandler.MakeElement[GraphHandler.TEXT] = function(self)
   local name = MakeName(self, GraphHandler.TEXT);
   local text = CreateFrame("Button", name, self);
   _ = text:CreateFontString(name.."T", "OVERLAY", "GameFontNormalSmall");
   return text;
end

GraphHandler.MakeElement[GraphHandler.OVERLAY] = function(self)
   local name = MakeName(self, GraphHandler.OVERLAY);
   local over = CreateFrame("Button", name, self);
   over:SetAllPoints(self);
   over:SetFrameLevel(self:GetFrameLevel()+2);
   over:SetScript("OnClick", GraphHandler.OnClick);
   return over;
end

function GraphHandler:GetElement(kind, idx, ...)
   local n = table.getn(self.elements[kind]);
   if ( idx <= n ) then
      return self.elements[kind][idx];
   else
      local e;
      while (n < idx) do
         e = GraphHandler.MakeElement[kind](self, ...);
         tinsert(self.elements[kind], e);
         n = n + 1;
      end
      return e;
   end
end

local function InitElements(self)
   if ( not self.elements ) then
      self.elements = {};
   end
   self.elements[GraphHandler.BAR] = {};
   self.elements[GraphHandler.LINE] = {};
   self.elements[GraphHandler.LEGEND] = {};
   self.elements[GraphHandler.OVERLAY] = {};
   self.elements[GraphHandler.LABEL] = {};
   self.elements[GraphHandler.TEXT] = {};
end

-- Registration functions

function GraphHandler:ClearPlot()
   self.plot:ResetData();
   self.data = {};
   self.color = {};
   self.label = nil;
   InitElements(self);
end

function GraphHandler:UpdateOverlay()
   self.lwidth = 0;
   local ol = self:GetElement(GraphHandler.OVERLAY, 1);
   if ( ol ) then
      local legends = self.elements[GraphHandler.LEGEND];
      local bottom = 0;
      local width = 0;
      ol:Hide();
      for idx=1,table.getn(legends),1 do
         local legend = legends[idx];
         legend:ClearAllPoints();
         legend:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, -(idx-1)*21);
         bottom = bottom + 21;
         if ( width < legend:GetWidth() ) then
            width = legend:GetWidth();
         end
         legend:SetFrameLevel(ol:GetFrameLevel()+1);
         legend:Show();
      end
      if ( bottom > 0) then
         ol:SetHeight(bottom);
      end
      ol:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0);
      ol:Show();
      self.lwidth = width;
   end
end

function GraphHandler:_init_plot()
   if ( not self.plot ) then
      local g = LG:CreateGraphLine(self:GetName().."Plot",self,"TOPLEFT","TOPLEFT",0,0,self:GetWidth(),self:GetHeight());
      g:SetXAxis(-0.05,1)
      g:SetYAxis(-0.05,1)
      g:SetGridColor({0.5,0.5,0.5,0.5})
      g:SetAxisDrawing(true,true)
      g:SetAxisColor({1.0,1.0,1.0,1.0})
--      g:SetAutoScale(true)
      self.plot = g;
      self.plot:Show();
      self.xg = 0.25;
      self.yg = 0.25;
      self.lwidth = 0;
   end
end

-- function DrawRouteLine(T, C, sx, sy, ex, ey, w, relPoint)

function GraphHandler:PlotLabels()
   local tdx=1;
   self.hmargin = 0;
   self.vmargin = 0;
   if ( self.label ) then
      local button = self:GetElement(GraphHandler.TEXT, tdx);
      if ( button ) then
         local text = _G[button:GetName().."T"];
         if (self.graphLabel) then
            text:SetText(self.graphLabel..": "..self.label);
         else
            text:SetText(self.label);
         end
         text:SetPoint("BOTTOM", self, "BOTTOM", 0, 2);
         text:SetVertexColor(1.0, 1.0, 1.0);
         text:Show();
         tdx = tdx + 1;
         local th = text:GetHeight();
         self.vmargin = self.vmargin + th;
      end
   end
   -- figure out how big the labels are going to be
   if ( self.ylabels ) then
      local ytext = self.ylabels;
      local maxwid = 0;
      for idx,label in pairs(ytext) do
         local button = self:GetElement(GraphHandler.TEXT, tdx);
         if ( button ) then
            local text = _G[button:GetName().."T"];
            if ( type(label) ~= "string" ) then
               label = string.format("%3d", label);
            end
            text:SetText(label);
            local wid = text:GetWidth();
            if ( maxwid < wid ) then
               maxwid = wid;
            end
         end
      end
      self.hmargin = maxwid + 4;
      self.yg = 1/(#ytext-1);
   end
   if ( self.xlabels) then
      local button = self:GetElement(GraphHandler.TEXT, tdx);
      if ( button ) then
         local label = self.xlabels[1];
         local text = _G[button:GetName().."T"];
         if ( type(label) ~= "string" ) then
            label = string.format("%3d", label);
         end
         text:SetText(label);
         local th = text:GetHeight();
         self.vmargin = self.vmargin + th + 4;
      end
      self.xg = 1/(#self.xlabels-1);
  end
   -- Actually draw them
   if ( self.ylabels ) then
      local ytext = self.ylabels;
      local height = self:GetHeight() - self.vmargin;
      local step = height/(#ytext-1);
      for idx,label in pairs(ytext) do
         local button = self:GetElement(GraphHandler.TEXT, tdx);
         if ( button ) then
            local text = _G[button:GetName().."T"];
            if ( type(label) ~= "string" ) then
               label = string.format("%3d", label);
            end
            text:SetText(label);
            local th = text:GetHeight();
            text:ClearAllPoints();
            text:SetPoint("LEFT", self, "LEFT", 2, 0);
            text:SetPoint("BOTTOM", self, "BOTTOM", 0, (idx-1)*step+self.vmargin-th/2);
            tdx = tdx + 1;
         end
      end
   end
   if ( self.xlabels) then
      local xtext = self.xlabels;
      local width = self:GetWidth() - self.hmargin - self.lwidth;
      local offset = width/(#xtext-1);
      for tick,label in pairs(xtext) do
         local button = self:GetElement(GraphHandler.TEXT, tdx);
         if ( button ) then
            local text = _G[button:GetName().."T"];
            if ( type(label) ~= "string" ) then
               label = string.format("%3d", label);
            end
            text:SetText(label);
            local xpos = (tick-1)*offset;
            local wid = text:GetWidth();
            text:SetPoint("BOTTOM", self, "BOTTOM", 0, self.vmargin-text:GetHeight());
            if ( xpos < wid ) then
               text:SetPoint("LEFT", self, "LEFT", self.hmargin, 0); 
            elseif ( xpos > (width - wid) ) then
               text:SetPoint("RIGHT", self, "RIGHT", -self.lwidth, 0); 
            else
               text:SetPoint("LEFT", self, "LEFT", self.hmargin+xpos-wid/2, 0);
            end
            text:Show();
            tdx = tdx + 1;
         end
      end
   end
end

function GraphHandler:DrawPlot()
   if (self.dirty) then
      self:UpdateOverlay();
      self:PlotLabels();
      self:_init_plot();
      self.plot:SetGridSpacing(self.xg, self.yg);
      self.plot:SetWidth(self:GetWidth() - self.hmargin - self.lwidth);
      self.plot:ClearAllPoints();
      self.plot:SetPoint("TOP", self, "TOP", 0, 0);
      self.plot:SetPoint("LEFT", self, "LEFT", self.hmargin, 0);
      self.plot:SetHeight(self:GetHeight() - self.vmargin);
      self.plot:ResetData();
      local maxval = self.maxval;
      for ddx,info in ipairs(self.data) do
         local data = {};
         local n = table.getn(info);
         for idx=1,n do
            tinsert(data, {(idx-1)/n, info[idx]/maxval});
         end
         -- wrap around, make the ends match
         tinsert(data, {1.0, data[1][2]});
         local color = self.color[ddx];
         if ( type(color) == "string") then
            local a = tonumber(string.sub(info.color,1,2),16);
            local r = tonumber(string.sub(info.color,3,4),16);
            local g = tonumber(string.sub(info.color,5,6),16);
            local b = tonumber(string.sub(info.color,7,8),16);
            color = { a = a/255, r = r/255, g = g/255, b = b/255 };
         end
         local ran = math.random;
         if ( not color ) then
            local col = 255 - 10*ddx;
            color = { a = 1.0, r = col/255, g = col/255, b = col/255};
         end
         self.plot:AddDataSeries(data,{color.r, color.g, color.b, 1.0});
         self.color[ddx] = color;
      end
      self.plot:RefreshGraph();
   end
end

function GraphHandler:SetOverlayClick(onclick)
   local ol = self:GetElement(GraphHandler.OVERLAY, 1);
   if ( ol ) then
      ol.ClickHandler = onclick;
      return true;
   end
-- return nil;
end

function GraphHandler:SetLegendClick(onclick)
   local legends = self.elements[GraphHandler.LEGEND];
   if ( legends ) then
      local n = table.getn(legends);
      if ( n > 0 ) then
         for idx=1,n,1 do
            local legend = legends[idx];
            legend.OnClickHandler = onclick; 
         end
         return true;
      end
   end
-- return nil;
end

-- graph label, horizontal axis labels
function GraphHandler:SetLabels(label, xlabels)
   self.graphLabel = label;
   self.xlabels = xlabels;
   self.dirty = true;
end

-- add legend and data points, return an index (for use with UpdatePlotData)
function GraphHandler:AddPlotData(litem, lname, ltexture, lcolor, data)
   self:_init_plot();
   local ndx = #self.data + 1;
   local legend = self:GetElement(GraphHandler.LEGEND, ndx, ltexture, lcolor);
   if ( legend ) then
      legend.item = litem;
      legend.name = lname;
      tinsert(self.data, data);

      local color = lcolor;
      if ( type(color) == "string") then
         local a = tonumber(string.sub(info.color,1,2),16);
         local r = tonumber(string.sub(info.color,3,4),16);
         local g = tonumber(string.sub(info.color,5,6),16);
         local b = tonumber(string.sub(info.color,7,8),16);
         color = { a = a/255, r = r/255, g = g/255, b = b/255 };
      end
      local ran = math.random(1,100);
      if ( not color ) then
         local col = 255 - 10*ddx;
         color = { a = 1.0, r = col/255, g = col/255, b = col/255};
      end
      tinsert(self.color, color);
 
      local maxval = 1;
      for idx,info in ipairs(self.data) do
         local n = table.getn(info);
         for idx=1,n do
            if ( info[idx] > maxval ) then
               maxval = info[idx];
            end
         end
      end
      maxval = math.floor((maxval+4)/5)*5;
      self.maxval = maxval;

      local ytext = { };
      for idx=0,maxval,5 do
         tinsert(ytext, idx);
      end
      self.ylabels = ytext;

      if ( self.label ) then
         self.label = self.label.." / "..lname;
      else
         self.label = lname;
      end

      self.dirty = true;
   end
   return ndx;
end

function GraphHandler:UpdatePlotData(index, data)
   if ( index <= #self.data ) then
      self.data[index] = data;
   end
   self.dirty = true;
end

function GraphHandler:RefreshPlot()
   self.dirty = true;
   self:DrawPlot();
end

function GraphHandler:NewGraph(name, setPoint, parent, relativePoint, relx, rely)
   local graph = CreateFrame("Frame", name, parent);
   graph:SetPoint(setPoint, parent, relativePoint, relx, rely);
   InitElements(graph);
   graph.ClearPlot = GraphHandler.ClearPlot;
   graph.GetElement = GraphHandler.GetElement;
   graph.UpdateOverlay = GraphHandler.UpdateOverlay;
   graph.SetLegendClick = GraphHandler.SetLegendClick;
   graph.SetOverlayClick = GraphHandler.SetOverlayClick;
   graph.PlotLabels = GraphHandler.PlotLabels;
   graph.PlotLegend = GraphHandler.PlotLegend;
   graph.PlotGrid = GraphHandler.PlotGrid;
   graph.SetLabels = GraphHandler.SetLabels;
   graph.AddPlotData = GraphHandler.AddPlotData;
   graph.UpdatePlotData = GraphHandler.UpdatePlotData;
   graph.DrawPlot = GraphHandler.DrawPlot;
   graph.RefreshPlot = GraphHandler.DrawPlot;
   graph._init_plot = GraphHandler._init_plot;
   
   graph.data = {};
   graph.color = {};
   graph.label = nil;
   
   return graph;
end

