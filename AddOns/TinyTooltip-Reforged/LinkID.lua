local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()
local addon = TinyTooltipReforged
local L = addon.L or {}

local function ParseHyperLink(link)
    local name, value = string.match(link or "", "|?H(%a+):(%d+):")
    if (name and value) then
        return name:gsub("^([a-z])", strupper), value
    end
end

local function SafeCall(fn, ...)
    local ok, a, b, c, d, e, f, g, h, i, j = pcall(fn, ...)
    if ok then return a, b, c, d, e, f, g, h, i, j end
end
local function SafeBool(fn, ...)
    local ok, value = pcall(fn, ...)
    if (not ok) then
        return false
    end
    local okEval, result = pcall(function()
        return value == true
    end)
    if (okEval) then
        return result
    end
    return false
end

local function GetSpellIconId(spellId)
    if (not spellId or not C_Spell or not C_Spell.GetSpellTexture) then return end
    local icon = C_Spell.GetSpellTexture(spellId)
    if (type(icon) == "number") then
        return icon
    end
end

local function GetItemIconId(linkOrId)
    if (not linkOrId) then return end
    local _, _, _, _, _, _, _, maxStack, _, icon = GetItemInfo(linkOrId)
    if (type(icon) == "number") then
        return icon
    end
end

local function ShowId(tooltip, name, value, noBlankLine)
    if (not name or not value) then return end
    if (tooltip.IsForbidden and tooltip:IsForbidden()) then return end
    local name = format("%s%s", name, " ID")
    if ((addon.db.general.showIdInfo == "always") or (addon.db.general.showIdInfo == "Shift / Ctrl / Alt" and (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()))) then
        local line = addon:FindLine(tooltip, name) 
        local idLine = format("%s: |cffffffff%s|r", name, value)
        if (not line) then
            if (not noBlankLine) then tooltip:AddLine(" ") end
            tooltip:AddLine(format(idLine, name, value), 0, 1, 0.8)
            tooltip:Show()
        else
            line:SetText(idLine)
        end
        LibEvent:trigger("tooltip.linkid", tooltip, name, value, noBlankLine)     
    end
end

local function ShowSpellInfo(tooltip, spellId)
    if (not spellId) then return end
    ShowId(tooltip, addon.L["id.spell"] or "Spell ID", spellId)
    local iconId = GetSpellIconId(spellId)
    if (iconId) then
        ShowId(tooltip, addon.L["id.icon"] or "Icon ID", iconId, true)
    end
end

local function ShowLinkIdInfo(tooltip, data) 
    if (data.type == Enum.TooltipDataType.Item) then
        local itemName, itemLink, itemID = TooltipUtil.GetDisplayedItem(tooltip)
        ShowId(tooltip, ParseHyperLink(itemLink))
        -- icon ID
        ShowId(tooltip, addon.L["id.icon"] or "Icon ID", GetItemIconId(itemID), 1)
    end
end

local function GetSpellIdFromTooltip(tip)
    if (not tip or not tip.GetSpell) then return end
    local check, _, spellId = pcall(tip.GetSpell, tip)
    if (check and type(spellId) == "number") then
        return spellId
    end
end

local function GetAuraSpellCaster(unit, index, filter)
    if (C_UnitAuras and C_UnitAuras.GetAuraDataByIndex) then
        local aura = C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
        if (aura and aura.caster) then
            return aura.caster
        end
    end
end

local function GetAuraSpellId(unit, index, filter)
    if (C_UnitAuras and C_UnitAuras.GetAuraDataByIndex) then
        local aura = C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
        -- caster
        local caster = aura and aura.sourceUnit or nil
        if (caster and SafeCall(UnitExists, caster)) then
            GameTooltip:AddLine(addon.L["Caster"]..": "..UnitName(caster), .65, .85, 1, 1)
            GameTooltip:Show()
        end
        if (aura and aura.spellId) then
            return aura.spellId
        end
    end
end

local function GetAuraSpellIdByInstance(unit, auraInstanceID)
    if (C_UnitAuras and C_UnitAuras.GetAuraDataByAuraInstanceID) then
        local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
        if (aura and aura.spellId) then
            return aura.spellId
        end
    end
end

-- Item
hooksecurefunc(GameTooltip, "SetHyperlink", ShowLinkIdInfo)
hooksecurefunc(ItemRefTooltip, "SetHyperlink", ShowLinkIdInfo)
hooksecurefunc("SetItemRef", function(link) ShowLinkIdInfo(ItemRefTooltip, link) end)
if (clientToc>=100002) then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, ShowLinkIdInfo)
else
    GameTooltip:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefTooltip:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ShoppingTooltip1:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ShoppingTooltip2:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
end

-- Spell
if (clientToc>=100002) then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self)
       if not pcall(function() ShowSpellInfo(self, (select(2,self:GetSpell()))) end) then
         return 
       end
    end)
else
    GameTooltip:HookScript("OnTooltipSetSpell", function(self) ShowId(self, "Spell", (select(2,self:GetSpell()))) end)
end
if (GameTooltip.SetArtifactPowerByID) then
    hooksecurefunc(GameTooltip, "SetArtifactPowerByID", function(self, powerID)
        ShowId(self, "Power", powerID)
        ShowId(self, "Spell", C_ArtifactUI.GetPowerInfo(powerID).spellID, 1)
    end)
end

-- Aura
LibEvent:attachTrigger("tooltip:aura", function(self, tip, args)
    local spellId = (args and args[2] and args[2].intVal) or GetSpellIdFromTooltip(tip)
    ShowSpellInfo(tip, spellId)
end)

local function HookAuraSetter(fnName, resolver)
    if (GameTooltip and GameTooltip[fnName]) then
        hooksecurefunc(GameTooltip, fnName, function(tip, ...)
            local spellId = resolver(...)
            ShowSpellInfo(tip, spellId)
        end)
    end
end

HookAuraSetter("SetUnitAura", function(unit, index, filter) 
    return GetAuraSpellId(unit, index, filter)
end)

HookAuraSetter("SetUnitBuff", function(unit, index, filter)
    return GetAuraSpellId(unit, index, filter)
end)

HookAuraSetter("SetUnitDebuff", function(unit, index, filter)
    return GetAuraSpellId(unit, index, filter)
end)

HookAuraSetter("SetUnitAuraByAuraInstanceID", function(unit, auraInstanceID)
    return GetAuraSpellIdByInstance(unit, auraInstanceID)
end)

HookAuraSetter("SetUnitBuffByAuraInstanceID", function(unit, auraInstanceID)
    return GetAuraSpellIdByInstance(unit, auraInstanceID)
end)

HookAuraSetter("SetUnitDebuffByAuraInstanceID", function(unit, auraInstanceID)
    return GetAuraSpellIdByInstance(unit, auraInstanceID)
end)

-- Quest
if (QuestMapLogTitleButton_OnEnter) then
    hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(self)
        if (self.questID) then ShowId(GameTooltip, "Quest", self.questID) end
    end)
end

-- Achievement UI
local function ShowAchievementId(self)
    if ((IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) and self.id) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, -32)
        GameTooltip:SetText("|cffffdd22Achievement:|r " .. self.id, 0, 1, 0.8)
        GameTooltip:Show()
    end
end

if (HybridScrollFrame_CreateButtons) then
    hooksecurefunc("HybridScrollFrame_CreateButtons", function(self, buttonTemplate)
        if (buttonTemplate == "StatTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
            end
        elseif (buttonTemplate == "AchievementTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
                button:HookScript("OnLeave", GameTooltip_Hide)
            end
        end
    end)
end
