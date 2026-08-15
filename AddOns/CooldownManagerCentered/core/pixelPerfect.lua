local _, ns = ...

local PixelPerfect = {}
ns.PixelPerfect = PixelPerfect

local abs = math.abs
local ceil = math.ceil
local floor = math.floor

local FALLBACK_PHYSICAL_HEIGHT = 768
local ALIGN_EPSILON = 0.001

local lastPhysicalHeight = FALLBACK_PHYSICAL_HEIGHT
local containers = setmetatable({}, { __mode = "k" })
local containerGeometry = setmetatable({}, { __mode = "k" })
local syncQueued = setmetatable({}, { __mode = "k" })
local syncing = setmetatable({}, { __mode = "k" })
local refreshCallbacks = {}
local queueRefresh
local containerTicker

local function round(value)
    value = tonumber(value) or 0
    if value >= 0 then
        return floor(value + 0.5)
    end
    return ceil(value - 0.5)
end

local function isSecret(value)
    return issecretvalue and issecretvalue(value)
end

local function effectiveScale(region)
    local scale
    if region and region.GetEffectiveScale then
        scale = region:GetEffectiveScale()
    elseif UIParent and UIParent.GetEffectiveScale then
        scale = UIParent:GetEffectiveScale()
    end
    scale = tonumber(scale) or 1
    return scale > 0 and scale or 1
end

function PixelPerfect.RefreshPhysical()
    local physicalHeight
    if GetPhysicalScreenSize then
        local _, height = GetPhysicalScreenSize()
        physicalHeight = tonumber(height)
    end
    if physicalHeight and physicalHeight > 0 then
        lastPhysicalHeight = physicalHeight
    end
end

function PixelPerfect.GetPixelToUIUnitFactor()
    return 768 / lastPhysicalHeight
end

function PixelPerfect.GetPixelScale(region)
    return effectiveScale(region), PixelPerfect.GetPixelToUIUnitFactor()
end

function PixelPerfect.Round(value)
    return round(value)
end

-- Exact physical-pixel conversion. Blizzard's PixelUtil.GetNearestPixelSize instead preserves a
-- UI-unit request and rounds its rendered size; border thicknesses and separators need the inverse:
-- an explicit number of physical pixels converted into the target region's coordinate space.
function PixelPerfect.PixelsToUI(pixels, scale, factor)
    scale = tonumber(scale) or 1
    factor = tonumber(factor) or PixelPerfect.GetPixelToUIUnitFactor()
    if scale <= 0 then
        scale = 1
    end
    if factor <= 0 then
        factor = 1
    end
    return (tonumber(pixels) or 0) * factor / scale
end

function PixelPerfect.SizeFromPixels(region, pixels, minPixels)
    pixels = round(pixels)
    minPixels = tonumber(minPixels) or 0
    if pixels > 0 and pixels < minPixels then
        pixels = minPixels
    elseif pixels < 0 and pixels > -minPixels then
        pixels = -minPixels
    end
    local scale, factor = PixelPerfect.GetPixelScale(region)
    return PixelPerfect.PixelsToUI(pixels, scale, factor)
end

function PixelPerfect.ToPixels(value, region, minPixels)
    local scale, factor = PixelPerfect.GetPixelScale(region)
    local pixels = round(((tonumber(value) or 0) * scale) / factor)
    minPixels = tonumber(minPixels) or 0
    if pixels > 0 and pixels < minPixels then
        pixels = minPixels
    elseif pixels < 0 and pixels > -minPixels then
        pixels = -minPixels
    end
    return pixels
end

function PixelPerfect.OnePixel(region)
    return PixelPerfect.SizeFromPixels(region, 1)
end

-- Preserve the requested UI-unit size while moving it to the nearest physical-pixel boundary.
function PixelPerfect.Snap(value, region, minPixels)
    local pixels = PixelPerfect.ToPixels(value, region, minPixels)
    return PixelPerfect.SizeFromPixels(region, pixels)
end

function PixelPerfect.SetWidth(region, width, minPixels)
    region:SetWidth(PixelPerfect.Snap(width, region, minPixels))
end

function PixelPerfect.SetHeight(region, height, minPixels)
    region:SetHeight(PixelPerfect.Snap(height, region, minPixels))
end

function PixelPerfect.SetSize(region, width, height, minWidthPixels, minHeightPixels)
    PixelPerfect.SetWidth(region, width, minWidthPixels)
    PixelPerfect.SetHeight(region, height, minHeightPixels)
end

function PixelPerfect.SetPoint(
    region,
    point,
    relativeTo,
    relativePoint,
    offsetX,
    offsetY,
    minOffsetXPixels,
    minOffsetYPixels
)
    region:SetPoint(
        point,
        relativeTo,
        relativePoint,
        PixelPerfect.Snap(offsetX or 0, region, minOffsetXPixels),
        PixelPerfect.Snap(offsetY or 0, region, minOffsetYPixels)
    )
end

function PixelPerfect.ApplyTexturePixelSnapping(texture, bias)
    if not texture then
        return nil
    end
    if isSecret(texture) or (issecrettable and issecrettable(texture)) then
        return texture
    end
    if texture.IsForbidden and texture:IsForbidden() then
        return texture
    end
    if texture.SetSnapToPixelGrid then
        texture:SetSnapToPixelGrid(false)
    end
    if texture.SetTexelSnappingBias then
        texture:SetTexelSnappingBias(bias or 0)
    end
    return texture
end

function PixelPerfect.ApplyStatusBarTexturePixelSnapping(bar, bias)
    if not bar or not bar.GetStatusBarTexture then
        return nil
    end
    local texture = PixelPerfect.ApplyTexturePixelSnapping(bar:GetStatusBarTexture(), bias)
    if texture then
        texture:ClearAllPoints()
        texture:SetPoint("TOPLEFT", bar, "TOPLEFT")
        texture:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT")
    end
    return texture
end

local function queueContainerSync(host)
    if not host or syncQueued[host] then
        return
    end
    syncQueued[host] = true
    C_Timer.After(0, function()
        syncQueued[host] = nil
        PixelPerfect.SyncContainer(host)
    end)
end

local function ensureContainerTicker()
    if containerTicker then
        return
    end
    containerTicker = C_Timer.NewTicker(0.1, function()
        for host in pairs(containers) do
            PixelPerfect.SyncContainer(host)
        end
    end)
end

function PixelPerfect.EnsureContainer(host)
    local container = host and containers[host]
    if container then
        return container
    end
    if not host then
        return nil
    end

    container = CreateFrame("Frame", nil, host)
    container:SetFrameLevel(host:GetFrameLevel())
    container:EnableMouse(false)
    containers[host] = container

    host:HookScript("OnSizeChanged", function()
        queueContainerSync(host)
    end)
    host:HookScript("OnShow", function()
        queueContainerSync(host)
    end)

    -- A relative anchor can move the host without firing OnSizeChanged or changing its own points.
    -- One shared 0.1s ticker checks every registered host; SyncContainer performs no frame writes
    -- when the snapped geometry did not change.
    ensureContainerTicker()

    PixelPerfect.SyncContainer(host)
    return container
end

function PixelPerfect.SyncContainer(host)
    if not host or syncing[host] then
        return containers[host]
    end
    local container = containers[host]
    if not container then
        return PixelPerfect.EnsureContainer(host)
    end

    local width, height = host:GetWidth(), host:GetHeight()
    if isSecret(width) or isSecret(height) then
        return container
    end
    width, height = tonumber(width) or 0, tonumber(height) or 0

    local left, top = host:GetLeft(), host:GetTop()
    if isSecret(left) or isSecret(top) then
        return container
    end

    local offsetX, offsetY = 0, 0
    if left ~= nil then
        offsetX = PixelPerfect.Snap(left, host) - left
    end
    if top ~= nil then
        offsetY = PixelPerfect.Snap(top, host) - top
    end

    local snappedWidth = PixelPerfect.Snap(width, container, width > 0 and 1 or nil)
    local snappedHeight = PixelPerfect.Snap(height, container, height > 0 and 1 or nil)
    local scale = effectiveScale(host)

    local geometry = containerGeometry[container]
    if geometry and abs((geometry.scale or scale) - scale) > ALIGN_EPSILON and queueRefresh then
        queueRefresh()
    end
    if geometry
        and abs(geometry.offsetX - offsetX) <= ALIGN_EPSILON
        and abs(geometry.offsetY - offsetY) <= ALIGN_EPSILON
        and abs(geometry.width - snappedWidth) <= ALIGN_EPSILON
        and abs(geometry.height - snappedHeight) <= ALIGN_EPSILON
        and abs((geometry.scale or scale) - scale) <= ALIGN_EPSILON
    then
        return container
    end
    if not geometry then
        geometry = {}
        containerGeometry[container] = geometry
    end
    geometry.offsetX, geometry.offsetY = offsetX, offsetY
    geometry.width, geometry.height = snappedWidth, snappedHeight
    geometry.scale = scale

    syncing[host] = true
    container:ClearAllPoints()
    container:SetPoint("TOPLEFT", host, "TOPLEFT", offsetX, offsetY)
    container:SetSize(snappedWidth, snappedHeight)
    syncing[host] = nil

    return container
end

function PixelPerfect.RegisterRefreshCallback(key, callback)
    if key and type(callback) == "function" then
        refreshCallbacks[key] = callback
    end
end

PixelPerfect.RefreshPhysical()

local refreshQueued = false
queueRefresh = function()
    if refreshQueued then
        return
    end
    refreshQueued = true
    C_Timer.After(0, function()
        refreshQueued = false
        for host in pairs(containers) do
            PixelPerfect.SyncContainer(host)
        end
        for _, callback in pairs(refreshCallbacks) do
            callback()
        end
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("UI_SCALE_CHANGED")
eventFrame:RegisterEvent("DISPLAY_SIZE_CHANGED")
eventFrame:SetScript("OnEvent", function()
    PixelPerfect.RefreshPhysical()
    queueRefresh()
end)
