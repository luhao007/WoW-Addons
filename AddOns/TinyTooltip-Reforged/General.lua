
local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local DEAD = DEAD
local CopyTable = CopyTable

TinyTooltipReforgedDB = {}
TinyTooltipReforgedCharacterDB = {}

local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()
local addon = TinyTooltipReforged

local function ColorStatusBar(self, value)
    if (addon.db.general.statusbarColor == "auto") then        
        local unit = "mouseover"
        if (clientToc < 110000) then
            local focus = GetMouseFocus()
        else
            local focus = GetMouseFoci()
        end
        if (focus and focus.unit) then
            unit = focus.unit
        end
        local r, g, b
        if (UnitIsPlayer(unit)) then    
            if (CUSTOM_CLASS_COLORS) then
                local color = CUSTOM_CLASS_COLORS[select(2,UnitClass(unit))]
 		self:SetStatusBarColor(color.r, color.g, color.b)
            else      
                r, g, b = GetClassColor(select(2,UnitClass(unit)))
                self:SetStatusBarColor(r, g, b)
            end
        else
            r, g, b = GameTooltip_UnitColor(unit)
            if (g == 0.6) then g = 0.9 end
            if (r==1 and g==1 and b==1) then r, g, b = 0, 0.9, 0.1 end
            self:SetStatusBarColor(r, g, b)
        end
    elseif (value and addon.db.general.statusbarColor == "smooth") then
        HealthBar_OnValueChanged(self, value, true)
    end
end

local function IsTableEmpty(table)
    return (next(table) == nil)
end

local function UpdateHealthBar(self, hp)
    if (not addon.db.general.statusbarText) then 
        GameTooltipStatusBar.TextString:Hide() 
    else
        GameTooltipStatusBar.TextString:Show() 
    end
    local unit = "mouseover"
    if (clientToc < 110000) then
        local focus = GetMouseFocus()
    else
        local focus = GetMouseFoci()
    end
    if (focus and focus.unit) then
        unit = focus.unit
    end
    local hp = UnitHealth(unit) or 1
    local maxhp = UnitHealthMax(unit) or 1
    if (UnitIsDeadOrGhost(unit) or UnitIsGhost(unit)) then
        local percent = 0
	self.TextString:SetFormattedText("|cff999999%s|r |cffffcc33<%s>|r", AbbreviateLargeNumbers(maxhp), DEAD)
    else
        if (hp<=0) then
            local percent = 0
  	    self.TextString:SetFormattedText("|cff999999Out of Range|r")
        else
          local percent = ceil((hp*100)/maxhp)
          if (addon.db.general.statusbarTextFormat == "Health / Max (Percent)") then
              self.TextString:SetFormattedText("%s / %s (%d%%)", AbbreviateLargeNumbers(hp), AbbreviateLargeNumbers(maxhp), percent)
          elseif (addon.db.general.statusbarTextFormat == "Health / Max") then
              self.TextString:SetFormattedText("%s / %s", AbbreviateLargeNumbers(hp), AbbreviateLargeNumbers(maxhp))
          elseif (addon.db.general.statusbarTextFormat == "Percent") then
              self.TextString:SetFormattedText("%d%%", percent)
          elseif (addon.db.general.statusbarTextFormat == "Health") then
              self.TextString:SetFormattedText("%s", AbbreviateLargeNumbers(hp))
          elseif (addon.db.general.statusbarTextFormat == "Health (Percent)") then
              self.TextString:SetFormattedText("%s (%d%%)", AbbreviateLargeNumbers(hp), percent)
          else -- default
              self.TextString:SetFormattedText("%s / %s (%d%%)", AbbreviateLargeNumbers(hp), AbbreviateLargeNumbers(maxhp), percent)
          end
        end
    end
end

LibEvent:attachEvent("VARIABLES_LOADED", function()
    --CloseButton
    if (ItemRefCloseButton and not IsAddOnLoaded("ElvUI")) then
        ItemRefCloseButton:SetSize(14, 14)
        ItemRefCloseButton:SetPoint("TOPRIGHT", -4, -4)
        ItemRefCloseButton:SetNormalTexture("Interface\\\Buttons\\UI-StopButton")
        ItemRefCloseButton:SetPushedTexture("Interface\\\Buttons\\UI-StopButton")
        ItemRefCloseButton:GetNormalTexture():SetVertexColor(0.9, 0.6, 0)
    end
    --StatusBar
    local bar = GameTooltipStatusBar
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(1, 1, 1)
    bar.bg:SetVertexColor(0.2, 0.2, 0.2, 0.2)
    bar.TextString = bar:CreateFontString(nil, "OVERLAY")
    bar.TextString:SetPoint("CENTER")
    bar.TextString:SetFont(NumberFontNormal:GetFont(), 11, "THINOUTLINE")
    bar.capNumericDisplay = true
    bar.lockShow = 1
    if (not addon.db.general.statusbarEnabled) then GameTooltipStatusBar:Hide() end
    if (not addon.db.general.statusbarText) then GameTooltipStatusBar.TextString:Hide() end
    bar:HookScript("OnShow", function(self)
        ColorStatusBar(self)
    end)
    bar:HookScript("OnValueChanged", function(self, hp)
        UpdateHealthBar(self, hp)
        ColorStatusBar(self, hp)
    end)
    bar:HookScript("OnShow", function(self)
        if (addon.db.general.statusbarHeight == 0) then
            self:Hide()
        end        
    end)
    --Variables
    if (IsTableEmpty(TinyTooltipReforgedDB) or 
        (addon.db.general.SavedVariablesPerCharacter and IsTableEmpty(TinyTooltipReforgedCharacterDB)) ) then
        print("|cFF00FFFF[TinyTooltipReforged]|r |cffFFE4E1Settings have been reset|r")
        TinyTooltipReforgedDB = addon.db
        TinyTooltipReforgedCharacterDB = addon.db
    end    
    if (addon.db.general.SavedVariablesPerCharacter) then
        addon.db = TinyTooltipReforgedCharacterDB
    else
        addon.db = TinyTooltipReforgedDB
    end
    LibEvent:trigger("tooltip:variables:loaded")
    --Init
    LibEvent:trigger("TINYTOOLTIP_REFORGED_GENERAL_INIT")
    --ShadowText
    GameTooltipHeaderText:SetShadowOffset(1, -1)
    GameTooltipHeaderText:SetShadowColor(0, 0, 0, 0.9)
    GameTooltipText:SetShadowOffset(1, -1)
    GameTooltipText:SetShadowColor(0, 0, 0, 0.9)
    Tooltip_Small:SetShadowOffset(1, -1)
    Tooltip_Small:SetShadowColor(0, 0, 0, 0.9)
end)

LibEvent:attachTrigger("tooltip:cleared, tooltip:hide", function(self, tip)
    LibEvent:trigger("tooltip.style.border.color", tip, unpack(addon.db.general.borderColor))
    LibEvent:trigger("tooltip.style.background", tip, unpack(addon.db.general.background))
    if (tip.BigFactionIcon) then tip.BigFactionIcon:Hide() end
    if (tip.SetBackdrop) then tip:SetBackdrop(nil) end
    if (tip.NineSlice) then tip.NineSlice:Hide() end
end)

LibEvent:attachTrigger("tooltip:show", function(self, tip)
    if (tip ~= GameTooltip) then return end
    LibEvent:trigger("tooltip.statusbar.position", addon.db.general.statusbarPosition, addon.db.general.statusbarOffsetX, addon.db.general.statusbarOffsetY)
    local w = GameTooltipStatusBar.TextString:GetWidth() + 10  
    if (GameTooltipStatusBar:IsShown() and w > tip:GetWidth()) then
        tip:SetMinimumWidth(w+2)
        if (addon.db.general.statusbarEnabled) then
            tip:Show()
        end
    end
end)
