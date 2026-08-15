local _, ns = ...

-- Single source of truth for cooldown-viewer icon dimensions.
--
-- Square / normalize / rectangular features all derive their geometry from the
-- tables below, so styling, glow hosts and rotation highlights can size off the
-- same known numbers instead of calling :GetSize(). In 11.x a reparented frame's
-- :GetSize() can hand back protected "secret" values that taint arithmetic, and the
-- size is also wrong mid-relayout; since we already know exactly how big each icon
-- is, there is no reason to ask the frame.
local Sizes = {}
ns.Sizes = Sizes

-- Viewer frame name -> profile setting suffix.
local viewersSettingKey = {
    EssentialCooldownViewer = "Essential",
    UtilityCooldownViewer = "Utility",
    BuffIconCooldownViewer = "BuffIcons",
}
Sizes.viewersSettingKey = viewersSettingKey

local normalizedSizeConfig = {
    Utility = { width = 50, height = 50 },
}

local originalSizesConfig = {
    Essential = { width = 50, height = 50 },
    Utility = { width = 30, height = 30 },
    BuffIcons = { width = 40, height = 40 },
}

local function ProfileFlag(key)
    return ns.db.profile[key] or false
end

-- Pixel-domain layout math. Round the optional half-slot origin exactly once,
-- then advance by an integer pixel step. Converting independently rounded UI
-- offsets can otherwise alternate a requested 1 px gap between 0 and 2 px.
function Sizes.BuildPixelOffsets(region, count, sizePixels, paddingPixels, direction, leadingSlots)
    local Pixel = ns.PixelPerfect
    sizePixels = Pixel.Round(sizePixels)
    paddingPixels = Pixel.Round(paddingPixels)
    direction = direction < 0 and -1 or 1

    local offsets = {}
    local stepPixels = sizePixels + paddingPixels
    local startPixels = Pixel.Round((leadingSlots or 0) * stepPixels * direction)
    for i = 1, count do
        local offsetPixels = startPixels + (i - 1) * stepPixels * direction
        offsets[i] = Pixel.SizeFromPixels(region, offsetPixels)
    end
    return offsets
end

function Sizes.BuildCenteredPixelOffsets(region, count, sizePixels, paddingPixels, direction, limit)
    return Sizes.BuildPixelOffsets(region, count, sizePixels, paddingPixels, direction, (limit - count) / 2)
end

function Sizes.BuildRows(children, limit)
    local rows = {}
    for i = 1, #children do
        local rowIndex = math.floor((i - 1) / limit) + 1
        rows[rowIndex] = rows[rowIndex] or {}
        rows[rowIndex][#rows[rowIndex] + 1] = children[i]
    end
    return rows
end

function Sizes.SortByLayoutIndex(a, b)
    return (a.layoutIndex or 0) < (b.layoutIndex or 0)
end

function Sizes.IsNormalizedSizeEnabled()
    return ProfileFlag("cooldownManager_normalizeUtilitySize")
end

-- Returns the width, height a viewer's icons are styled to, accounting for the
-- normalized-utility and experimental rectangular options. Returns nil for unknown
-- viewer keys (e.g. buff bars, which are variable-width and not icon-sized here).
function Sizes.GetViewerIconSize(viewerSettingName)
    local data = originalSizesConfig[viewerSettingName]
    if not data then
        return nil
    end

    local isNormalizedUtility = viewerSettingName == "Utility" and ProfileFlag("cooldownManager_normalizeUtilitySize")
    if isNormalizedUtility then
        data = normalizedSizeConfig[viewerSettingName]
    end

    local rectKey = "cooldownManager_experimental_enableRectangularIcons_"
    if viewerSettingName == "Essential" and ProfileFlag(rectKey .. "essential") then
        return data.width, math.floor(data.height * (ProfileFlag(rectKey .. "essential_percent") or 0.8))
    elseif viewerSettingName == "Utility" and ProfileFlag(rectKey .. "utility") then
        return data.width, math.floor(data.height * (ProfileFlag(rectKey .. "utility_percent") or 0.8))
    elseif viewerSettingName == "BuffIcons" and ProfileFlag(rectKey .. "buffIcons") then
        return data.width, math.floor(data.height * (ProfileFlag(rectKey .. "buffIcons_percent") or 0.8))
    end
    return data.width, data.height
end

-- An icon's owning viewer never changes, so the resolved setting suffix is cached on
-- the child's Affected state (one walk per child, ever). Modules that already iterate
-- a viewer's children with the suffix in hand should call TagViewerChild so even that
-- first walk is skipped.
local VIEWER_SETTING_KEY = "viewerSettingName"

function Sizes.TagViewerChild(child, settingName)
    if child and settingName then
        ns.API:SetAffected(child, VIEWER_SETTING_KEY, settingName)
    end
end

-- Resolves an icon/cooldown frame to its viewer's setting suffix
-- (Essential / Utility / BuffIcons), or nil. Reads the cached tag first; otherwise
-- walks up to the owning viewer and caches the result on the frame.
function Sizes.GetViewerSettingName(frame)
    if not frame then
        return nil
    end

    local cached = ns.API.Affected(frame)[VIEWER_SETTING_KEY]
    if cached then
        return cached
    end

    local current = frame
    local guard = 0
    while current and current.GetParent and guard < 12 do
        for viewerName, settingName in pairs(viewersSettingKey) do
            if current == _G[viewerName] then
                ns.API:SetAffected(frame, VIEWER_SETTING_KEY, settingName)
                return settingName
            end
        end
        current = current:GetParent()
        guard = guard + 1
    end
    return nil
end

-- Convenience: resolve a frame to its viewer, then to its known icon size. Returns
-- nil when the frame doesn't belong to a sized icon viewer (callers may then fall
-- back to :GetSize for genuinely variable frames such as buff bars).
function Sizes.GetIconSize(frame)
    local settingName = Sizes.GetViewerSettingName(frame)
    if not settingName then
        return nil
    end
    return Sizes.GetViewerIconSize(settingName)
end
