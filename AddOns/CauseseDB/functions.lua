CauseseAPI = {}
local SharedMedia = LibStub("LibSharedMedia-3.0")

function CauseseAPI:GetCastInfo(unit)
    local name, startC, endC, icon, notInterruptible, spellID, duration, expirationTime, _, castType
    if UnitCastingInfo(unit) then
        name, _, icon, startC, endC, _, _, notInterruptible, spellID = UnitCastingInfo(unit)
        castType = "cast"
    elseif UnitChannelInfo(unit) then
        name, _, icon, startC, endC, _, notInterruptible, spellID = UnitChannelInfo(unit)
        castType = "channel"
    end
    if startC and endC then
        duration = (endC - startC) / 1000
        expirationTime = endC / 1000
    end
    return name, duration, expirationTime, icon, notInterruptible, spellID, castType
end

local groupData = {}
local auraData = {}
local AuraSizeData = {}
local auranames = {
    ["Icons"] = "Causese - Regular Icons",
    ["Bars"] = "Causese - Regular Bars",
    ["Affix Bars"] = "Causese - Affix Cast Bars",
    ["Affix Timer Bars"] = "Causese - Affix Timers",
    ["Special Bars"] = "Causese - Special Bars",
    ["Trash Timer Bars"] = "Causese - M+ Trash Timers",
    ["M+ Tank Bars"] = "Causese - M+ Tank Bars",
    ["Mini Bars"] = "Causese - Mini Bars",
    ["CC Bars"] = "Causese - CC / Interrupt Bars",
    ["Bossmod Texts"] = "Causese - BW/DBM Timers",
    ["Mini Bossmod Texts"] = "Causese - Mini BW/DBM Timers",
    ["Special Texts"] = "Causese - Special Texts",
    ["Important Icons"] = "Causese - Important Icons",
}

function CauseseAPI:AnchorSettings(type)
    local auraname = auranames[type]
    local groupname = auraname.." Group"
    local gData = WeakAuras.GetData(groupname)
    local aData = WeakAuras.GetData(auraname)
    groupData[groupname] = gData
    auraData[auraname] = aData
end

function CauseseAPI:AuraPosition(type, pos, reg)
    local auraname = auranames[type].." Group"
    local anchorData = groupData[auraname] or WeakAuras.GetData(auraname)
    if anchorData then
        if type ~= "Circle" then
            local directionX = (anchorData.grow == "RIGHT" and 1) or (anchorData.grow == "LEFT" and -1) or 0
            local directionY = (anchorData.grow == "UP" and 1) or (anchorData.grow == "DOWN" and -1) or 0
            local space = anchorData.space
            local Xoffset = 0
            local Yoffset = 0
            local max = anchorData.limit
            max = #reg <= max and #reg or max
            for i = 1, max do
                local height
                if reg[i].region.regionType == "text" then
                    height = AuraSizeData[type] + space or reg[i].region.height + space
                else
                    height = reg[i].region.height + space
                end
                local width = reg[i].region.width + space
                pos[i] = {
                    Xoffset,
                    Yoffset,
                }
                Xoffset = Xoffset + (width * directionX)
                Yoffset = Yoffset + (height * directionY)
            end

        elseif type == "Circle" then
            for i, _ in ipairs(reg) do
                pos[i] = {0, 0}
            end
        end
    end
    return pos
end

function CauseseAPI:AuraResize(type, positions, regions)
    local auraname = auranames[type]
    local groupname = auraname.." Group"
    local gData = groupData[groupname] or WeakAuras.GetData(groupname)
    local aData = auraData[auraname] or WeakAuras.GetData(auraname)
    groupData[groupname] = gData
    auraData[auraname] = aData
    if not aData then return end

    for _, regionData in ipairs(regions) do
        local region = regionData.region

        if region.regionType == "icon" then
            region:SetRegionWidth(aData.width)
            region:SetRegionHeight(aData.height)
            region:SetZoom(aData.zoom)
            for i, subRegion in ipairs(region.subRegions) do
                if subRegion.type == "subborder" then
                    local data = aData.subRegions[i]
                    if not data then break end
                    if data.type == "subborder" then
                        local backdrop = subRegion:GetBackdrop()
                        local colors = data.border_color
                        if backdrop then
                            backdrop.edgeSize = data.border_size
                            subRegion:SetBackdrop(backdrop)
                        end
                        if colors then
                            subRegion:SetBorderColor(unpack(colors))
                        end
                        subRegion:SetVisible(data.border_visible)
                    end
                end
                if subRegion.type == "subtext" then
                    local data = aData.subRegions[i]
                    if not data then break end
                    if data.type == "subtext" then
                        subRegion:SetXOffset(data.text_anchorXOffset)
                        subRegion:SetYOffset(data.text_anchorYOffset)
                        subRegion.text:SetFont(SharedMedia:Fetch("font", data.text_font), data.text_fontSize, data.text_fontType)
                        subRegion.text:SetShadowColor(unpack(data.text_shadowColor))
                        subRegion.text:SetShadowOffset(data.text_shadowXOffset, data.text_shadowYOffset)
                    end
                end
            end

        elseif region.regionType == "aurabar" then
            region:SetRegionWidth(aData.width)
            region:SetRegionHeight(aData.height)
            region.texture = aData.texture
            region.textureInput = aData.textureInput
            region.textureSource = aData.textureSource
            region:UpdateStatusBarTexture()
            for i, subRegion in ipairs(region.subRegions) do
                if subRegion.type == "subborder" then
                    local data = aData.subRegions[i]
                    if not data then break end
                    if data.type == "subborder" then
                        local backdrop = subRegion:GetBackdrop()
                        local colors = data.border_color
                        if backdrop then
                            backdrop.edgeSize = data.border_size
                            subRegion:SetBackdrop(backdrop)
                        end
                        if colors then
                            subRegion:SetBorderColor(unpack(colors))
                        end
                        subRegion:SetVisible(data.border_visible)
                    end
                end
                if subRegion.type == "subtext" then
                    local data = aData.subRegions[i]
                    if not data then break end
                    if data.type == "subtext" then
                        subRegion:SetXOffset(data.text_anchorXOffset)
                        subRegion:SetYOffset(data.text_anchorYOffset)
                        subRegion.text:SetFont(SharedMedia:Fetch("font", data.text_font), data.text_fontSize, data.text_fontType)
                        subRegion.text:SetShadowColor(unpack(data.text_shadowColor))
                        subRegion.text:SetShadowOffset(data.text_shadowXOffset, data.text_shadowYOffset)
                    end
                elseif subRegion.type == "subtick" then
                    subRegion:SetAutomaticLength(false)
                    subRegion:SetTickLength(aData.height)
                    subRegion:SetTickPlacement(subRegion.tick_placements[1])
                end
            end

        elseif region.regionType == "text" then
            local data = aData
            region.text:SetFont(SharedMedia:Fetch("font", data.font), data.fontSize, data.outline)
            region.text:SetShadowColor(unpack(data.shadowColor))
            region.text:SetShadowOffset(data.shadowXOffset, data.shadowYOffset)
            AuraSizeData[type] = data.fontSize
            region:SetHeight(data.fontSize)
            region:SetWidth(region.text:GetWidth())
            region:Color(region.color_r, region.color_g, region.color_b, region.color_a)

        elseif region.regionType == "texture" or region.regionType == "progresstexture" then
            region:SetRegionWidth(aData.width)
            region:SetRegionHeight(aData.height)
            for i, subRegion in ipairs(region.subRegions) do
                if subRegion.type == "subtext" then
                    local data = aData.subRegions[i]
                    if not data then break end
                    if data.type == "subtext" then
                        subRegion:SetXOffset(data.text_anchorXOffset)
                        subRegion:SetYOffset(data.text_anchorYOffset)
                        subRegion.text:SetFont(SharedMedia:Fetch("font", data.text_font), data.text_fontSize, data.text_fontType)
                        subRegion.text:SetShadowColor(unpack(data.text_shadowColor))
                        subRegion.text:SetShadowOffset(data.text_shadowXOffset, data.text_shadowYOffset)
                    end
                end
            end
        end
    end
end