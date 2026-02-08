local _, ns = ...

local Scaling = {}
ns.Scaling = Scaling

local Round = Round or function(x)
    return floor(x + 0.5)
end

local physicalHeight = select(2, GetPhysicalScreenSize())

function Scaling:GetPixelSize(frame)
    local scale = (frame or UIParent):GetEffectiveScale()
    if scale == 0 then
        return 1
    end
    if physicalHeight == 0 then
        return 1
    end
    return 768 / (physicalHeight * scale)
end

function Scaling:RoundToPixelSize(value, frame)
    if value == 0 then
        return 0
    end
    local px = Scaling:GetPixelSize(frame)
    return Round(value / px) * px
end

function Scaling:FloorToPixelSize(value, frame)
    if value == 0 then
        return 0
    end
    local px = Scaling:GetPixelSize(frame)
    return floor(value / px) * px
end

function Scaling:CeilToPixelSize(value, frame)
    if value == 0 then
        return 0
    end
    local px = Scaling:GetPixelSize(frame)
    return ceil(value / px) * px
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UI_SCALE_CHANGED")
frame:SetScript("OnEvent", function()
    physicalHeight = select(2, GetPhysicalScreenSize())
end)
