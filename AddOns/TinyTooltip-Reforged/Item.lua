local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()

local addon = TinyTooltipReforged
local L = addon.L or {}

local function FindLine(tooltip, keyword)
    local line, text
    for i = 2, tooltip:NumLines() do
        line = _G[tooltip:GetName() .. "TextLeft" .. i]
        text = line:GetText() or ""
        if (string.find(text, keyword)) then
            return line, i, _G[tooltip:GetName() .. "TextRight" .. i]
        end
    end
end

local function GetItemInfoFromLink(linkOrId)
    if (linkOrId == nil or linkOrId == "") then
        return nil
    end
    local name, link, quality, _, _, _, _, stackCount, _, texture = GetItemInfo(linkOrId)
    if (not name) then return nil end
    return {
        itemLink = link,
        itemQuality = quality,
        itemStackCount = stackCount,
        itemTexture = texture,
    }
end

local function GetTooltipTitleColor(tip)
    if (not tip or not tip.GetName) then return end
    local left = _G[tip:GetName() .. "TextLeft1"]
    if (not left or not left.GetTextColor) then return end
    local ok, r, g, b = pcall(left.GetTextColor, left)
    if (not ok) then return end
    if (type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then
        return
    end
    return r, g, b
end

local function ColorBorder(tip, r, g, b)
    if (addon.db.item.coloredItemBorder) then
        LibEvent:trigger("tooltip.style.border.color", tip, r, g, b)
    else
        LibEvent:trigger("tooltip.style.border.color", tip, unpack(addon.db.general.borderColor))
    end
end

local function ItemIcon(tip, link)
    if (addon.db.item.showItemIcon) then
        local texture = select(10, C_Item.GetItemInfo(link))
        local text = addon:GetLine(tip,1):GetText()
        if (texture and not strfind(text, "^|T")) then
            addon:GetLine(tip,1):SetFormattedText("|T%s:16:16:0:0:32:32:2:30:2:30|t %s", texture, text)
        end
    end
end

local function ItemStackCount(tip, itemInfo)
    if (addon.db.item.showStackCount) then
        local stackCount = itemInfo and itemInfo.itemStackCount
        if (stackCount and stackCount > 1) then        
            local text = addon:GetLine(tip,1):GetText() .. format(" |cff00eeee/%s|r", stackCount)
            addon:GetLine(tip,1):SetText(text)
        end
    end
    if (addon.db.item.showStackCountAlt) then
        local stackCount = itemInfo and itemInfo.itemStackCount
        if (stack and stack > 1) then
            tip:AddLine(format("Stack Size: |cff00eeee%d|r",stack))
	    tip:Show()
        end 
    end
end

LibEvent:attachTrigger("tooltip:item", function(self, tip, link)
    local general = addon.db.general
    LibEvent:trigger("tooltip.style.bgfile", tip, general.bgfile)
    if (general.background) then
        LibEvent:trigger("tooltip.style.background", tip, unpack(general.background))
    end
    LibEvent:trigger("tooltip.style.border.corner", tip, general.borderCorner)
    if (general.borderCorner == "angular") then
        LibEvent:trigger("tooltip.style.border.size", tip, general.borderSize)
    end
    local itemInfo = GetItemInfoFromLink(link)
    local quality = (itemInfo and itemInfo.itemQuality) or 0
    local r, g, b = GetItemQualityColor(quality)
    local tr, tg, tb = GetTooltipTitleColor(tip)
    if (tr and tg and tb) then
        r, g, b = tr, tg, tb
    end
    ColorBorder(tip, r, g, b)
    ItemStackCount(tip, itemInfo)
    ItemIcon(tip, itemInfo)
end)

local function EmbeddedItemTooltip_OnTooltipSetItem(self, data)
    local tip = self:GetParent()
    if (not tip or tip:GetObjectType() ~= "GameTooltip") then return end
    local r, g, b = self.IconBorder:GetVertexColor()
    ColorBorder(self, r, g, b)
end

