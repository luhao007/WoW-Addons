local _, ns = ...
local L = ns.L
local Affected = ns.API.Affected

local ItemsData = ns.TrackerItemsData
local ItemVisuals = ns.TrackerItemVisuals
local WilduUICore = ns.WilduUICore
local LEM = ns.LibEQOL.EditMode
local Pixel = ns.PixelPerfect

local ItemViewer = ns.TrackerItemViewer or {}
ns.TrackerItemViewer = ItemViewer

local UPDATE_THROTTLE_DELAY = 0.05
local DEFAULT_ICON_SIZE = 50
local DEFAULT_ICON_PADDING = 2
local TRACKER_FRAME_DEFAULT_CONFIG = {
    alpha = 1,
    point = "CENTER",
    x = 0,
    y = 200,
    scale = 1,
    strata = "MEDIUM",
    iconSize = DEFAULT_ICON_SIZE,
    iconPadding = DEFAULT_ICON_PADDING,
    orientation = "Horizontal Right",
    flowLimitEnabled = false,
    flowLimit = 10,
    flowReverse = false,
    hideAbilities = false,
    hideAbilitiesMode = "whenReady",
}
local BASE_SQUARE_MASK = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"
local DEFAULT_MASK_TEXTURE = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\CooldownManager"

-- Cooldown events arrive in bursts and are delivered to every active tracker.
-- Collect affected tracker instances and refresh them all from one delayed
-- callback instead of running several full icon passes in the same frame.
local pendingCooldownTrackers = {}
local cooldownUpdateScheduled = false

local function FlushPendingCooldownUpdates()
    cooldownUpdateScheduled = false
    local pending = pendingCooldownTrackers
    pendingCooldownTrackers = {}

    if not ns.db.profile.tracker_enabled then
        return
    end
    for tracker in pairs(pending) do
        for _, ivf in ipairs(tracker.iconFrames) do
            ivf:UpdateCooldown()
        end
        -- Hide-abilities changes the visible entry set whenever a cooldown state
        -- flips, so a full layout refresh is needed, not just a cooldown repaint.
        if tracker:GetHideAbilitiesMode() then
            tracker:RefreshEntries()
        end
    end
end

-- Events that drive a tracker's refreshes. Registered on the anchor while the
-- tracker is active and fully unregistered when it (or the whole custom tracker
-- system) is turned off, so a disabled tracker never reacts to game events or
-- re-shows itself — letting us toggle the feature live without a reload.
local TRACKER_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "BAG_UPDATE_COOLDOWN",
    "SPELL_UPDATE_COOLDOWN",
    "SPELL_UPDATE_CHARGES",
    "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW",
    "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE",
    "PLAYER_EQUIPMENT_CHANGED",
    "BAG_UPDATE_DELAYED",
    "TRAIT_CONFIG_UPDATED",
    "PLAYER_SPECIALIZATION_CHANGED",
    "SPELL_UPDATE_ICON",
}

local ORIENTATION_ANCHORS = {
    ["Horizontal Right"] = { primary = "LEFT", offsetX = 1, offsetY = 0 },
    ["Horizontal Center"] = { primary = "CENTER", offsetX = 1, offsetY = 0 },
    ["Horizontal Left"] = { primary = "RIGHT", offsetX = -1, offsetY = 0 },
    ["Vertical Down"] = { primary = "TOP", offsetX = 0, offsetY = -1 },
    ["Vertical Up"] = { primary = "BOTTOM", offsetX = 0, offsetY = 1 },
    ["Vertical Center"] = { primary = "CENTER", offsetX = 0, offsetY = -1 },
}

local ORIENTATION_LABELS = {
    ["Horizontal Right"] = L["Horizontal Right"],
    ["Horizontal Center"] = L["Horizontal Center"],
    ["Horizontal Left"] = L["Horizontal Left"],
    ["Vertical Down"] = L["Vertical Down"],
    ["Vertical Up"] = L["Vertical Up"],
    ["Vertical Center"] = L["Vertical Center"],
}

local function NormalizeOrientation(value)
    for canonical, localized in pairs(ORIENTATION_LABELS) do
        if value == canonical or value == localized then
            return canonical
        end
    end
    return value or "Horizontal Right"
end

local OPPOSITE_ANCHOR = {
    LEFT = "RIGHT",
    RIGHT = "LEFT",
    TOP = "BOTTOM",
    BOTTOM = "TOP",
    CENTER = "BOTTOM",
}

local function BuildRows(count, limit)
    local rows = {}
    for i = 1, count do
        local rowIndex = math.floor((i - 1) / limit) + 1
        rows[rowIndex] = rows[rowIndex] or {}
        rows[rowIndex][#rows[rowIndex] + 1] = i
    end
    return rows
end

-- Edit-mode display name for a tracker config key ("tracker1" -> "CMC Tracker 1").
local function GetTrackerDisplayName(configKey)
    local index = tonumber(tostring(configKey):match("tracker(%d+)$"))
    if index then
        return ns.API.GradientText("CMC Tracker " .. index)
    end
    return configKey
end

-- Active number of trackers (contiguous 1..N), clamped to [1, MAX_TRACKERS].
local function GetTrackerCount()
    local count = (ns.db and ns.db.profile and ns.db.profile.tracker_count) or 2
    local maxTrackers = ns.CONSTANTS.MAX_TRACKERS or 10
    if count < 1 then
        count = 1
    elseif count > maxTrackers then
        count = maxTrackers
    end
    return count
end

local function GetTrackerStyleValue(configKey, key, default)
    local editMode = ns.db and ns.db.profile and ns.db.profile.editMode
    local config = editMode and editMode[configKey]
    if config and config[key] ~= nil then
        return config[key]
    end
    return default
end

local function GetIconHeight(iconSize, configKey)
    -- Masque skins square (1:1) icons; ignore the rectangular ratio entirely.
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return iconSize
    end
    if GetTrackerStyleValue(configKey, "rectangularIcons", false) then
        local percent = GetTrackerStyleValue(configKey, "rectangularIconsPercent", 0.8)
        return math.floor(iconSize * percent)
    end
    return iconSize
end

local function ApplyCooldownFontToFrame(frame)
    if not frame or not frame.Cooldown or not frame.Cooldown.GetCountdownFontString then
        return
    end
    local fontString = frame.Cooldown:GetCountdownFontString()
    if not fontString then
        return
    end

    if not fontString.defaults then
        local fp, fsz, ffl = fontString:GetFont()
        fontString.defaults = { fp, fsz, ffl or "" }
    end

    local configKey = frame.trackerConfigKey
    local enabled = GetTrackerStyleValue(configKey, "cooldownFontEnabled", false)

    -- Override off: restore the default font + centered position and stop
    -- overriding anything.
    if not enabled then
        if ns.API:GetIsAffected(frame, "cooldownfont") then
            fontString:SetFont(fontString.defaults[1], fontString.defaults[2], fontString.defaults[3])
            ns.API:UnsetAffected(frame, "cooldownfont")
        end
        if ns.API:GetIsAffected(frame, "cooldowntextpos") then
            fontString:ClearAllPoints()
            fontString:SetPoint("CENTER", frame.Cooldown, "CENTER", 0, 0)
            ns.API:UnsetAffected(frame, "cooldowntextpos")
        end
        return
    end

    fontString:SetAlpha(1)
    ns.API:SetAffected(frame, "cooldownfont")

    local size = GetTrackerStyleValue(configKey, "cooldownFontSize", "NIL")
    local numericSize = tonumber(size)
    if numericSize == 0 then
        fontString:SetFontHeight(0)
    else
        if size == "NIL" or size == nil then
            numericSize = fontString.defaults[2] or select(2, fontString:GetFont()) or 16
        else
            numericSize = numericSize or 16
        end
        local fontName = GetTrackerStyleValue(configKey, "cooldownFontName", "NIL")
        local fontPath = ns.API:GetFontPath(fontName) or fontString.defaults[1] or ns.CONSTANTS.DEFAULT_FONT[1]
        local fontFlagTable = GetTrackerStyleValue(configKey, "cooldownFontFlags", { OUTLINE = true })
        fontString:SetFont(fontPath, numericSize, ns.API:GetFontFlags(fontFlagTable))
    end

    -- This tracker's countdown text offset. 0/0 keeps the default centered position.
    local ox = GetTrackerStyleValue(configKey, "cooldownTextOffsetX", 0)
    local oy = GetTrackerStyleValue(configKey, "cooldownTextOffsetY", 0)
    if ox ~= 0 or oy ~= 0 then
        fontString:ClearAllPoints()
        fontString:SetPoint("CENTER", frame.Cooldown, "CENTER", ox, oy)
        ns.API:SetAffected(frame, "cooldowntextpos")
    elseif ns.API:GetIsAffected(frame, "cooldowntextpos") then
        fontString:ClearAllPoints()
        fontString:SetPoint("CENTER", frame.Cooldown, "CENTER", 0, 0)
        ns.API:UnsetAffected(frame, "cooldowntextpos")
    end
end

local function ApplySquareStyle(frame)
    local configKey = frame.trackerConfigKey
    local borderPixels = GetTrackerStyleValue(configKey, "borderThickness", 1)
    local surface = Pixel.SyncContainer(frame)
    local borderThickness = borderPixels > 0 and Pixel.SizeFromPixels(surface, borderPixels, 1) or 0
    local zoom = GetTrackerStyleValue(configKey, "iconZoom", 0.3)
    local crop = zoom * 0.5

    if frame.Icon and frame.Icon.SetTexCoord then
        local width, height = frame:GetSize()
        if width > 0 and height > 0 and width > height + 0.5 then
            -- Wider than tall: crop top/bottom proportionally to maintain zoom feel
            local horizontalSpan = 1 - (2 * crop)
            local verticalSpan = horizontalSpan * (height / width)
            local clampedSpan = math.max(0, math.min(1, verticalSpan))
            local verticalCrop = (1 - clampedSpan) * 0.5
            frame.Icon:SetTexCoord(crop, 1 - crop, verticalCrop, 1 - verticalCrop)
        elseif width > 0 and height > 0 and height > width + 0.5 then
            -- Taller than wide: crop left/right proportionally
            local verticalSpan = 1 - (2 * crop)
            local horizontalSpan = verticalSpan * (width / height)
            local clampedSpan = math.max(0, math.min(1, horizontalSpan))
            local horizontalCrop = (1 - clampedSpan) * 0.5
            frame.Icon:SetTexCoord(horizontalCrop, 1 - horizontalCrop, crop, 1 - crop)
        else
            frame.Icon:SetTexCoord(crop, 1 - crop, crop, 1 - crop)
        end
    end

    if frame.Cooldown then
        frame.Cooldown:SetSwipeTexture(BASE_SQUARE_MASK)
        frame.Cooldown:ClearAllPoints()
        frame.Cooldown:SetPoint("TOPLEFT", surface, "TOPLEFT", borderThickness, -borderThickness)
        frame.Cooldown:SetPoint("BOTTOMRIGHT", surface, "BOTTOMRIGHT", -borderThickness, borderThickness)
    end

    if frame.mask then
        frame.mask:SetTexture(BASE_SQUARE_MASK)
        frame.mask:Show()
    else
        local mask = frame:CreateMaskTexture()
        mask:SetAllPoints(frame.Icon)
        mask:SetTexture(BASE_SQUARE_MASK)
        frame.Icon:AddMaskTexture(mask)
        frame.mask = mask
    end

    if not Affected(frame).border then
        Affected(frame).border = CreateFrame("Frame", nil, frame)
        Affected(frame).border:SetFrameLevel(frame:GetFrameLevel() + 1)
    end
    if borderPixels <= 0 then
        ns.API:HidePixelBorder(Affected(frame).border)
    else
        ns.API:ApplyPixelBorder(Affected(frame).border, surface, borderPixels)
    end
    ns.API:SetAffected(frame, "squareStyle")
end

local function RestoreDefaultStyle(frame)
    if not ns.API:GetIsAffected(frame, "squareStyle") then
        return
    end
    if frame.Icon and frame.Icon.SetTexCoord then
        frame.Icon:SetTexCoord(0, 1, 0, 1)
    end

    if frame.Cooldown then
        frame.Cooldown:SetSwipeTexture(DEFAULT_MASK_TEXTURE)
        frame.Cooldown:ClearAllPoints()
        frame.Cooldown:SetAllPoints(frame)
    end

    if frame.mask then
        frame.mask:SetTexture(DEFAULT_MASK_TEXTURE)
        frame.mask:Show()
    end
    if Affected(frame).border then
        Affected(frame).border:Hide()
    end
    ns.API:UnsetAffected(frame, "squareStyle")
end

local function ApplyStyleToFrame(frame)
    -- When Masque integration is active it owns the icon styling; let it skin
    -- this frame and skip CMC's own square-icon / border styling.
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        ns.MasqueModule:SkinTrackerIcon(frame)
        return
    end

    local isSquare = GetTrackerStyleValue(frame.trackerConfigKey, "squareIcons", false)

    if isSquare then
        ApplySquareStyle(frame)
    else
        RestoreDefaultStyle(frame)
    end

    if frame.IconOverlay then
        if isSquare then
            frame.IconOverlay:Hide()
        else
            frame.IconOverlay:Show()
        end
    end
end

local function ApplyStackFontToFrame(frame)
    -- Masque positions the Count region itself; don't fight it.
    if ns.MasqueModule and ns.MasqueModule:IsActive() then
        return
    end
    local configKey = frame.trackerConfigKey
    local fontName = GetTrackerStyleValue(configKey, "stackFontName", "NIL")
    local fontPath = ns.API:GetFontPath(fontName) or ns.CONSTANTS.DEFAULT_NUMBER_FONT[1]
    local fontFlagTable = GetTrackerStyleValue(configKey, "stackFontFlags", { OUTLINE = true })
    local fontFlagStr = ns.API:GetFontFlags(fontFlagTable)
    local fontSize = GetTrackerStyleValue(configKey, "stackFontSize", 14)
    local anchor = GetTrackerStyleValue(configKey, "stackAnchor", "BOTTOMRIGHT")
    local offsetX = GetTrackerStyleValue(configKey, "stackOffsetX", -1)
    local offsetY = GetTrackerStyleValue(configKey, "stackOffsetY", 1)

    if frame.count then
        frame.count:SetFont(fontPath, fontSize, fontFlagStr)
        frame.count:ClearAllPoints()
        frame.count:SetPoint(anchor, frame, anchor, offsetX, offsetY)
    end
end

local GLOW_SIZE_BLOOM = 4

local function SizeItemFrame(frame, iconSize, iconHeight)
    Pixel.SetSize(frame, iconSize, iconHeight, 1, 1)
    Pixel.SyncContainer(frame)
    Pixel.SetSize(frame.IconOverlay, iconSize * 1.5, iconHeight * 1.5, 1, 1)
    if frame.Icon then
        Pixel.ApplyTexturePixelSnapping(frame.Icon)
    end
    Pixel.ApplyTexturePixelSnapping(frame.IconOverlay)
    Affected(frame).glowIconSizeW = iconSize + GLOW_SIZE_BLOOM
    Affected(frame).glowIconSizeH = iconHeight + GLOW_SIZE_BLOOM
end

local ItemViewerFrame = {}
ItemViewerFrame.__index = ItemViewerFrame

function ItemViewerFrame:New(parent, skipTrackerStyle, trackerConfigKey)
    local frame = CreateFrame("Frame", nil, parent)
    frame.skipTrackerStyle = skipTrackerStyle == true
    frame.trackerConfigKey = trackerConfigKey
    local obj = setmetatable({ frame = frame }, ItemViewerFrame)
    obj:Initialize()
    return obj
end

function ItemViewerFrame:Initialize()
    local frame = self.frame
    frame.showGCD = false
    frame:SetMouseClickEnabled(false)
    frame:SetScript("OnEnter", function(owner)
        local tooltip = GetAppropriateTooltip()
        GameTooltip_SetDefaultAnchor(tooltip, owner)
        if owner.itemID then
            tooltip:SetItemByID(owner.itemID)
        elseif owner.spellID then
            tooltip:SetSpellByID(owner.spellID)
        elseif owner.spellCategoryID then
            local kind = Affected(owner).trackerEntryKind
            local id = Affected(owner).trackerEntryId
            local title = ItemsData:GetEntryName(kind, id)
            if GameTooltip_SetTitle then
                GameTooltip_SetTitle(tooltip, title)
            else
                tooltip:SetText(title)
            end
            GameTooltip_AddNormalLine(tooltip, L["Wildcard"])
        else
            return
        end
        tooltip:Show()
    end)
    frame:SetScript("OnLeave", function(owner)
        local tooltip = GetAppropriateTooltip()
        if tooltip:IsOwned(owner) then
            tooltip:Hide()
        end
    end)
    if not frame.Icon then
        frame.Icon = frame:CreateTexture(nil, "ARTWORK")
        frame.Icon:SetAllPoints()
        frame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    local width, height = frame:GetSize()
    if not frame.IconOverlay and frame.Icon then
        frame.IconOverlay = frame:CreateTexture(nil, "OVERLAY", nil, 1)
        frame.IconOverlay:SetAtlas("UI-HUD-CoolDownManager-IconOverlay")
        frame.IconOverlay:SetSize(width * 1.5, height * 1.5)
        frame.IconOverlay:SetPoint("Center", frame.Icon, "CENTER")
        frame.IconOverlay:Hide()
    end
    if not frame.Cooldown then
        frame.Cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
        frame.Cooldown:SetAllPoints()
        frame.Cooldown:SetDrawEdge(false)
        frame.Cooldown:SetDrawBling(false)
        frame.Cooldown:SetSwipeTexture(DEFAULT_MASK_TEXTURE)
        frame.Cooldown:SetHideCountdownNumbers(false)
        frame.Cooldown:HookScript("OnCooldownDone", function()
            -- The callback can run just before the item API reaches exactly zero.
            -- Clear stale cooldown desaturation first; the refresh below restores
            -- it when the item is genuinely still unavailable (for example, zero count).
            frame.Icon:SetDesaturated(false)
            ItemVisuals:UpdateEntryCooldown(frame, Affected(frame).trackerEntryKind, Affected(frame).trackerEntryId)
            C_Timer.After(0, function()
                if frame:IsShown() then
                    ItemVisuals:UpdateEntryCooldown(frame, Affected(frame).trackerEntryKind, Affected(frame).trackerEntryId)
                end
                if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
                    ns.TrackerItemViewer:RefreshItemViewerFrames()
                end
            end)
        end)
    end
    if not frame.mask then
        local mask = frame:CreateMaskTexture()
        mask:SetAllPoints(frame.Icon)
        mask:SetTexture(DEFAULT_MASK_TEXTURE)
        frame.Icon:AddMaskTexture(mask)
        frame.mask = mask
    end

    if not frame.count then
        local overlay = CreateFrame("Frame", nil, frame)
        overlay:SetAllPoints(frame)
        overlay:SetFrameLevel(frame.Cooldown:GetFrameLevel() + 5)

        local count = overlay:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        count:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        count:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -1, 1)
        count:SetShadowOffset(1, -1)
        count:SetShadowColor(0, 0, 0, 1)
        frame.count = count
    end
    if not frame.skipTrackerStyle then
        ApplyStyleToFrame(frame)
        ApplyStackFontToFrame(frame)
        ApplyCooldownFontToFrame(frame)
    end
    frame:Hide()
end

function ItemViewerFrame:SetTooltipsShown(shown)
    local frame = self.frame
    frame:SetMouseClickEnabled(false)
    frame:SetMouseMotionEnabled(shown == true)
    if not shown then
        local tooltip = GetAppropriateTooltip()
        if tooltip:IsOwned(frame) then
            tooltip:Hide()
        end
    end
end

function ItemViewerFrame:Show()
    self.frame:Show()
end

function ItemViewerFrame:Hide()
    self.frame:Hide()
end

function ItemViewerFrame:UpdateEntry(entry)
    local frame = self.frame
    -- Reset identity first: these frames are pooled/reused, and the spellID/itemID
    -- below are only set when the new entry actually has them. Without clearing,
    -- a frame reused for an entry with no on-use spell keeps the previous entry's
    -- spellID, leaving its (now wrong) keybind text showing. Keybinds refresh off
    -- frame.spellID, so a nil here correctly clears the keybind for spell-less items.
    frame.spellID = nil
    frame.itemID = nil
    frame.spellCategoryID = nil
    if frame.categoryLabel then
        frame.categoryLabel:Hide()
    end
    if not entry then
        Affected(frame).readyAlertTrackerActive = nil
        ItemVisuals:ApplyEntryStackColor(frame)
        Affected(frame).trackerEntryKind = nil
        Affected(frame).trackerEntryId = nil
        Affected(frame).resolvedTrackerEntryKind = nil
        Affected(frame).resolvedTrackerEntryId = nil
        ns.CooldownStyle:HideFrameGlow(frame)
        if ns.AuraTracking then
            ns.AuraTracking:Detach(frame)
        end
        frame:Hide()
        return
    end

    Affected(frame).trackerEntryKind = entry.kind
    Affected(frame).trackerEntryId = entry.id
    Affected(frame).readyAlertTrackerActive = true

    if entry.kind == "item" then
        local _, spellID = C_Item.GetItemSpell(entry.id)
        frame.itemID = entry.id
        if spellID then
            frame.spellID = spellID
        end
    elseif entry.kind == "wildcardSlots" and ItemsData.IsSpellCategoryWildcard and ItemsData:IsSpellCategoryWildcard(entry.id) then
        frame.spellCategoryID = ItemsData:GetWildcardSlotSpellCategory(entry.id)
    elseif entry.kind == "wildcardSlots" then
        local itemID = ItemsData:GetWildcardSlotItemID(entry.id)
        if itemID then
            frame.itemID = itemID
            local _, spellID = C_Item.GetItemSpell(itemID)
            if spellID then
                frame.spellID = spellID
            end
        end
    elseif entry.kind == "spell" then
        frame.spellID = ItemsData:GetDisplaySpellID(entry.id) or entry.id
    end
    ItemVisuals:ApplyEntryIcon(frame, entry.kind, entry.id)
    ItemVisuals:UpdateEntryCooldown(frame, entry.kind, entry.id)
    if not frame.skipTrackerStyle then
        ApplyStyleToFrame(frame)
        ApplyStackFontToFrame(frame)
        ApplyCooldownFontToFrame(frame)
    end

    frame:Show()
end

function ItemViewerFrame:UpdateCooldown()
    if not ns.db.profile.tracker_enabled then
        return
    end
    local frame = self.frame
    if not frame:IsShown() or not Affected(frame).trackerEntryKind or not Affected(frame).trackerEntryId then
        return
    end
    ItemVisuals:ApplyEntryIcon(frame, Affected(frame).trackerEntryKind, Affected(frame).trackerEntryId)
    ItemVisuals:UpdateEntryCooldown(frame, Affected(frame).trackerEntryKind, Affected(frame).trackerEntryId)
end

local function GetConfigValue(configKey, key, default)
    if ns.db and ns.db.profile and ns.db.profile.editMode and ns.db.profile.editMode[configKey] then
        return ns.db.profile.editMode[configKey][key] or default
    end
    return default
end

local TrackerInstance = {}
TrackerInstance.__index = TrackerInstance

function TrackerInstance:New(configKey, frameName, getEntriesFn)
    local instance = setmetatable({
        configKey = configKey,
        frameName = frameName,
        index = tonumber(tostring(configKey):match("tracker(%d+)$")),
        editModeName = GetTrackerDisplayName(configKey),
        getEntriesFn = getEntriesFn,
        active = false,
        hasVisibleEntries = false,
        anchor = nil,
        pixelRoot = nil,
        iconFrames = {},
        lastUpdateTimes = {},
        pendingHide = {},
        shownKeys = {},
        shownOrder = {},
    }, TrackerInstance)
    return instance
end

-- Custom tracker icons live under pixelRoot rather than directly under the
-- named CMCTracker frame. Expose the same item-frame contract as Blizzard's
-- cooldown viewers so integrations do not fall back to GetChildren().
function TrackerInstance:GetItemFrames()
    local frames = {}
    for _, itemViewerFrame in ipairs(self.iconFrames) do
        if itemViewerFrame.frame:IsShown() then
            frames[#frames + 1] = itemViewerFrame.frame
        end
    end
    return frames
end

function TrackerInstance:GetIconSize()
    return GetConfigValue(self.configKey, "iconSize", DEFAULT_ICON_SIZE)
end

function TrackerInstance:GetIconPadding()
    return GetConfigValue(self.configKey, "iconPadding", DEFAULT_ICON_PADDING)
end

function TrackerInstance:GetOrientation()
    local value = GetConfigValue(self.configKey, "orientation", "Horizontal Right")
    local normalized = NormalizeOrientation(value)
    if value ~= normalized then
        ns.db.profile.editMode[self.configKey].orientation = normalized
    end
    return normalized
end

function TrackerInstance:GetShowGCD()
    return GetConfigValue(self.configKey, "showGCD", false)
end

function TrackerInstance:GetRangeIndicator()
    return GetConfigValue(self.configKey, "rangeIndicator", false)
end

function TrackerInstance:GetRequireResource()
    return GetConfigValue(self.configKey, "requireResource", false)
end

function TrackerInstance:GetShowTooltips()
    local config = ns.db and ns.db.profile and ns.db.profile.editMode and ns.db.profile.editMode[self.configKey]
    if config and config.showTooltips ~= nil then
        return config.showTooltips and true or false
    end
    return false
end

function TrackerInstance:GetShowStacks()
    -- Stacks/charge numbers are shown by default; only an explicit false hides them.
    if ns.db and ns.db.profile and ns.db.profile.editMode and ns.db.profile.editMode[self.configKey] then
        local v = ns.db.profile.editMode[self.configKey].showStacks
        if v ~= nil then
            return v and true or false
        end
    end
    return true
end

function TrackerInstance:GetFlowLimitEnabled()
    return GetConfigValue(self.configKey, "flowLimitEnabled", false) == true
end

function TrackerInstance:GetFlowLimit()
    local limit = tonumber(GetConfigValue(self.configKey, "flowLimit", TRACKER_FRAME_DEFAULT_CONFIG.flowLimit))
    limit = limit and math.floor(limit) or TRACKER_FRAME_DEFAULT_CONFIG.flowLimit
    if limit < 1 then
        return 1
    elseif limit > 20 then
        return 20
    end
    return limit
end

function TrackerInstance:GetFlowReverse()
    return GetConfigValue(self.configKey, "flowReverse", false) == true
end

-- nil = hide-abilities off, "whenReady" = hide ready icons (Utility 0% dim),
-- "onCooldown" = hide only while an ability is on its actual cooldown.
function TrackerInstance:GetHideAbilitiesMode()
    if GetConfigValue(self.configKey, "hideAbilities", false) ~= true then
        return nil
    end
    return GetConfigValue(self.configKey, "hideAbilitiesMode", TRACKER_FRAME_DEFAULT_CONFIG.hideAbilitiesMode)
end

-- Multi-row / multi-column layout modeled on the Essential/Utility viewer rows:
-- horizontal orientations flow into rows (new rows below, or above with reverse
-- flow), vertical orientations flow into columns (new columns right, or left
-- with reverse flow). Only Center orientations center shorter lines against the
-- widest/tallest line; left/right/down/up align every line to its flow edge.
function TrackerInstance:LayoutIconFrames(entries)
    local iconSize = self:GetIconSize()
    local iconHeight = GetIconHeight(iconSize, self.configKey)
    local paddingPixels = Pixel.Round(self:GetIconPadding())
    local iconWidthPixels = Pixel.ToPixels(iconSize, self.anchor, 1)
    local iconHeightPixels = Pixel.ToPixels(iconHeight, self.anchor, 1)
    local orientation = self:GetOrientation()
    local anchorData = ORIENTATION_ANCHORS[orientation] or ORIENTATION_ANCHORS["Horizontal Right"]
    local count = #entries

    if count == 0 then
        Pixel.SetSize(self.anchor, iconSize, iconHeight, 1, 1)
        self.pixelRoot = Pixel.SyncContainer(self.anchor)
        return
    end

    local limit = count
    if self:GetFlowLimitEnabled() then
        limit = self:GetFlowLimit()
    end
    local flowReverse = self:GetFlowReverse()
    local lines = BuildRows(count, limit)
    local isHorizontal = anchorData.offsetY == 0
    local isCentered = anchorData.primary == "CENTER"

    if isHorizontal then
        local maxRowCount = math.min(limit, count)
        local directionX = anchorData.offsetX
        local xAnchor = directionX > 0 and "LEFT" or "RIGHT"
        local yAnchor = flowReverse and "BOTTOM" or "TOP"
        local rowStepPixels = (iconHeightPixels + paddingPixels) * (flowReverse and 1 or -1)
        local width = Pixel.SizeFromPixels(
            self.anchor,
            maxRowCount * iconWidthPixels + (maxRowCount - 1) * paddingPixels,
            1
        )
        local height = Pixel.SizeFromPixels(
            self.anchor,
            #lines * iconHeightPixels + (#lines - 1) * paddingPixels,
            1
        )
        Pixel.SetSize(self.anchor, width, height, 1, 1)
        self.pixelRoot = Pixel.SyncContainer(self.anchor)

        for rowIndex, row in ipairs(lines) do
            local offsets
            if isCentered then
                offsets = ns.Sizes.BuildCenteredPixelOffsets(
                    self.anchor,
                    #row,
                    iconWidthPixels,
                    paddingPixels,
                    directionX,
                    maxRowCount
                )
            else
                offsets = ns.Sizes.BuildPixelOffsets(self.anchor, #row, iconWidthPixels, paddingPixels, directionX)
            end
            local y = Pixel.SizeFromPixels(self.anchor, (rowIndex - 1) * rowStepPixels)
            for i, entryIndex in ipairs(row) do
                local frame = self.iconFrames[entryIndex].frame
                frame:ClearAllPoints()
                Pixel.SetPoint(frame, xAnchor, self.pixelRoot, xAnchor, offsets[i], 0)
                Pixel.SetPoint(frame, yAnchor, self.pixelRoot, yAnchor, 0, y)
            end
        end
    else
        local maxColCount = math.min(limit, count)
        local directionY = anchorData.offsetY
        local yAnchor = directionY < 0 and "TOP" or "BOTTOM"
        local xAnchor = flowReverse and "RIGHT" or "LEFT"
        local colStepPixels = (iconWidthPixels + paddingPixels) * (flowReverse and -1 or 1)
        local width = Pixel.SizeFromPixels(
            self.anchor,
            #lines * iconWidthPixels + (#lines - 1) * paddingPixels,
            1
        )
        local height = Pixel.SizeFromPixels(
            self.anchor,
            maxColCount * iconHeightPixels + (maxColCount - 1) * paddingPixels,
            1
        )
        Pixel.SetSize(self.anchor, width, height, 1, 1)
        self.pixelRoot = Pixel.SyncContainer(self.anchor)

        for colIndex, col in ipairs(lines) do
            local offsets
            if isCentered then
                offsets = ns.Sizes.BuildCenteredPixelOffsets(
                    self.anchor,
                    #col,
                    iconHeightPixels,
                    paddingPixels,
                    directionY,
                    maxColCount
                )
            else
                offsets = ns.Sizes.BuildPixelOffsets(self.anchor, #col, iconHeightPixels, paddingPixels, directionY)
            end
            local x = Pixel.SizeFromPixels(self.anchor, (colIndex - 1) * colStepPixels)
            for i, entryIndex in ipairs(col) do
                local frame = self.iconFrames[entryIndex].frame
                frame:ClearAllPoints()
                Pixel.SetPoint(frame, yAnchor, self.pixelRoot, yAnchor, 0, offsets[i])
                Pixel.SetPoint(frame, xAnchor, self.pixelRoot, xAnchor, x, 0)
            end
        end
    end
end

function TrackerInstance:UpdateCooldown(spellId, baseSpellId, spellCategory)
    if not ns.db.profile.tracker_enabled or (not spellId and not spellCategory) then
        return
    end

    local updated = {}
    local function UpdateMatching(spellID)
        local frames = spellID and self.trackedSpellFrames and self.trackedSpellFrames[spellID]
        if not frames then
            return
        end
        for _, ivf in ipairs(frames) do
            if not updated[ivf] then
                updated[ivf] = true
                ivf:UpdateCooldown()
            end
        end
    end
    UpdateMatching(spellId)
    UpdateMatching(baseSpellId)

    local categoryFrames = spellCategory and self.trackedSpellCategoryFrames and self.trackedSpellCategoryFrames[spellCategory]
    if categoryFrames then
        for _, ivf in ipairs(categoryFrames) do
            if not updated[ivf] then
                updated[ivf] = true
                ivf:UpdateCooldown()
            end
        end
    end
end

function TrackerInstance:UpdateItemCooldown(itemID)
    if not ns.db.profile.tracker_enabled or not itemID then
        return
    end
    local frames = self.trackedItemFrames and self.trackedItemFrames[itemID]
    if not frames then
        return
    end
    for _, ivf in ipairs(frames) do
        ivf:UpdateCooldown()
    end
end

function TrackerInstance:UpdateCooldowns(_force)
    if not ns.db.profile.tracker_enabled then
        return
    end

    pendingCooldownTrackers[self] = true
    if cooldownUpdateScheduled then
        return
    end
    cooldownUpdateScheduled = true
    C_Timer.After(UPDATE_THROTTLE_DELAY, FlushPendingCooldownUpdates)
end

function TrackerInstance:ApplyStabilityGuard(newEntries)
    local prevPos = {}
    for i, key in ipairs(self.shownOrder) do
        prevPos[key] = i
    end

    local function entryKey(e)
        return e.kind .. ":" .. tostring(e.id)
    end

    table.sort(newEntries, function(a, b)
        local aOrder, bOrder = ItemsData:GetEntryOrder(a), ItemsData:GetEntryOrder(b)
        if aOrder ~= bOrder then
            if aOrder == nil then
                return false
            end
            if bOrder == nil then
                return true
            end
            return aOrder < bOrder
        end
        local aPrev, bPrev = prevPos[entryKey(a)], prevPos[entryKey(b)]
        if aPrev ~= bPrev then
            if aPrev == nil then
                return false
            end
            if bPrev == nil then
                return true
            end
            return aPrev < bPrev
        end
        local aName = ItemsData:GetEntryName(a.kind, a.id) or tostring(a.id)
        aName = aName == "" and tostring(a.id) or aName:lower()
        local bName = ItemsData:GetEntryName(b.kind, b.id) or tostring(b.id)
        bName = bName == "" and tostring(b.id) or bName:lower()
        if aName ~= bName then
            return aName < bName
        end
        if a.kind ~= b.kind then
            return a.kind < b.kind
        end
        return tostring(a.id) < tostring(b.id)
    end)

    self.shownOrder = {}
    for _, entry in ipairs(newEntries) do
        table.insert(self.shownOrder, entryKey(entry))
    end

    return newEntries
end

function TrackerInstance:RefreshEntries()
    if not self.anchor then
        return
    end
    if self.lastUpdateTimes.RefreshEntriesThrottle and (GetTime() - self.lastUpdateTimes.RefreshEntriesThrottle) < UPDATE_THROTTLE_DELAY then
        return
    end

    self:DoRefreshEntries()
end

function TrackerInstance:DoRefreshEntries()
    if not self.anchor then
        return
    end

    self.lastUpdateTimes.RefreshEntriesThrottle = GetTime()

    local owned = ItemsData:ScanOwnedItems()
    ItemsData:EnsureTrackedItems(owned)
    local rawEntries = self.getEntriesFn(owned)
    local entries = self:ApplyStabilityGuard(rawEntries)

    -- Hide-abilities layout filtering: "whenReady" mirrors Utility's 0% dim
    -- (charging counts as on cooldown, GCD does not), while "onCooldown" is the
    -- near-reverse and hides only real cooldowns (no GCD, no charging).
    local hideMode = self:GetHideAbilitiesMode()
    if hideMode and not (ns.Runtime and (ns.Runtime.isInEditMode or ns.Runtime.hasSettingsOpened)) then
        local filtered = {}
        for _, entry in ipairs(entries) do
            local onCooldown = entry.id and ItemVisuals.IsEntryOnActualCooldown and ItemVisuals:IsEntryOnActualCooldown(entry.kind, entry.id) or false
            local visible
            if hideMode == "onCooldown" then
                visible = not onCooldown
            else
                -- Hide when ready = Utility's 0% dim: charging is still shown,
                -- the GCD is not.
                visible = entry.id and ItemVisuals.IsUtilityActive and ItemVisuals:IsUtilityActive(entry.kind, entry.id) or false
            end
            if visible then
                filtered[#filtered + 1] = entry
            end
        end
        entries = filtered
    end

    local iconSize = self:GetIconSize()
    local iconHeight = GetIconHeight(iconSize, self.configKey)
    local showGCD = self:GetShowGCD()
    local showStacks = self:GetShowStacks()
    local rangeIndicator = self:GetRangeIndicator()
    local requireResource = self:GetRequireResource()
    local showTooltips = self:GetShowTooltips()
    local count = #entries
    local hadVisibleEntries = self.hasVisibleEntries
    self.hasVisibleEntries = count > 0

    local trackedSpellIds = {}
    local trackedSpellFrames = {}
    local trackedItemFrames = {}
    local trackedSpellCategoryFrames = {}
    local function TrackSpellFrame(spellID, ivf)
        if not spellID then
            return
        end
        trackedSpellIds[spellID] = true
        trackedSpellFrames[spellID] = trackedSpellFrames[spellID] or {}
        trackedSpellFrames[spellID][#trackedSpellFrames[spellID] + 1] = ivf
    end
    for i = 1, count do
        if not self.iconFrames[i] then
            self.iconFrames[i] = ItemViewerFrame:New(self.pixelRoot or self.anchor, false, self.configKey)
        end
        local ivf = self.iconFrames[i]
        SizeItemFrame(ivf.frame, iconSize, iconHeight)
        ivf.frame.showGCD = showGCD
        ivf.frame.showStacks = showStacks
        ivf.frame.rangeIndicator = rangeIndicator
        ivf.frame.requireResource = requireResource
        ivf:SetTooltipsShown(showTooltips)
        -- Hiding the count fontstring persists across SetText, so the stack/charge
        -- number stays hidden even as cooldown updates re-write its text.
        if ivf.frame.count then
            ivf.frame.count:SetShown(showStacks)
        end

        ivf:UpdateEntry(entries[i])

        if ivf.frame.spellID then
            TrackSpellFrame(ivf.frame.spellID, ivf)
            local baseSpellID = C_Spell.GetBaseSpell(ivf.frame.spellID) or ivf.frame.spellID
            if baseSpellID ~= ivf.frame.spellID then
                TrackSpellFrame(baseSpellID, ivf)
            end
        end
        if ivf.frame.itemID then
            trackedItemFrames[ivf.frame.itemID] = trackedItemFrames[ivf.frame.itemID] or {}
            trackedItemFrames[ivf.frame.itemID][#trackedItemFrames[ivf.frame.itemID] + 1] = ivf
        end
        if ivf.frame.spellCategoryID then
            trackedSpellCategoryFrames[ivf.frame.spellCategoryID] = trackedSpellCategoryFrames[ivf.frame.spellCategoryID] or {}
            trackedSpellCategoryFrames[ivf.frame.spellCategoryID][#trackedSpellCategoryFrames[ivf.frame.spellCategoryID] + 1] = ivf
        end
    end
    self.trackedSpellIds = trackedSpellIds
    self.trackedSpellFrames = trackedSpellFrames
    self.trackedItemFrames = trackedItemFrames
    self.trackedSpellCategoryFrames = trackedSpellCategoryFrames

    for i = count + 1, #self.iconFrames do
        self.iconFrames[i]:UpdateEntry(nil)
    end

    self:LayoutIconFrames(entries)

    local shouldShow = self.active and self.hasVisibleEntries
    if LEM.SetFrameOverlayToggleEnabled then
        LEM:SetFrameOverlayToggleEnabled(self.anchor, shouldShow)
    end

    -- Edit Mode moves unavailable frames off-screen. Restore the saved position when
    -- this tracker gains visible content again, and do not let its exit callback hide
    -- a tracker which became available while Edit Mode was open.
    if shouldShow and not hadVisibleEntries then
        self.anchor._wt_hideOnEditModeExit = nil
        WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    end

    -- Empty means no currently visible/usable entries, not merely no assignments.
    -- Keep those trackers out of Edit Mode as well so they cannot be moved by mistake.
    self.anchor:SetShown(shouldShow)
    ns.Keybinds:UpdateAllKeybinds()

    ItemViewer:RebuildUsabilityWanted()
end

function TrackerInstance:RefreshStyling()
    for _, ivf in ipairs(self.iconFrames) do
        if ivf.frame:IsShown() then
            ApplyStyleToFrame(ivf.frame)
            ApplyStackFontToFrame(ivf.frame)
            ApplyCooldownFontToFrame(ivf.frame)
            ivf:UpdateCooldown()
        end
    end
end

function TrackerInstance:RefreshTooltips()
    local shown = self:GetShowTooltips()
    for _, ivf in ipairs(self.iconFrames) do
        ivf:SetTooltipsShown(shown)
    end
end

function TrackerInstance:UpdateIconLayout()
    local iconSize = self:GetIconSize()
    local iconHeight = GetIconHeight(iconSize, self.configKey)
    for _, ivf in ipairs(self.iconFrames) do
        SizeItemFrame(ivf.frame, iconSize, iconHeight)
    end
    self:RefreshEntries()
end

-- (Re)registers the refresh-driving events on the anchor. Idempotent, so it's
-- safe to call on every activation.
function TrackerInstance:RegisterTrackerEvents()
    if not self.anchor then
        return
    end
    for _, event in ipairs(TRACKER_EVENTS) do
        self.anchor:RegisterEvent(event)
    end
end

-- Drops all event registrations on the anchor so a deactivated tracker stays
-- inert (and hidden). The OnEvent handler script is left intact for cheap reuse.
function TrackerInstance:UnregisterTrackerEvents()
    if self.anchor then
        self.anchor:UnregisterAllEvents()
    end
end

function TrackerInstance:Create()
    if self.anchor then
        return
    end

    WilduUICore.LoadFrameConfig(self.configKey, TRACKER_FRAME_DEFAULT_CONFIG)
    local iconSize = self:GetIconSize()

    self.anchor = CreateFrame("Frame", self.frameName, UIParent, "BackdropTemplate")
    self.anchor.GetItemFrames = function()
        return self:GetItemFrames()
    end

    self.anchor.editModeName = self.editModeName

    Pixel.SetSize(self.anchor, iconSize, iconSize, 1, 1)
    self.anchor:SetClampedToScreen(true)
    self.pixelRoot = Pixel.EnsureContainer(self.anchor)

    self:RegisterTrackerEvents()

    self.anchor:SetScript("OnEvent", function(_, event, arg1, arg2, arg3, _arg4, arg5)
        if event == "PLAYER_ENTERING_WORLD" then
            self:ReapplyPosition()
            self:RefreshEntries()
            C_Timer.After(3, function()
                self:ReapplyPosition()
                self:RefreshEntries()
            end)
        elseif event == "SPELL_UPDATE_COOLDOWN" then
            if arg3 and arg1 and ItemsData and ItemsData.SetSpellCategoryCooldownSource then
                ItemsData:SetSpellCategoryCooldownSource(arg3, arg1)
            end
            if self:GetHideAbilitiesMode() then
                self:RefreshEntries()
            elseif ns.db.profile.editMode and ns.db.profile.editMode[self.configKey] and ns.db.profile.editMode[self.configKey].showGCD then
                self:UpdateCooldowns()
            elseif arg1 or arg2 then
                self:UpdateCooldown(arg1, arg2, arg3)
            elseif arg5 then
                self:UpdateItemCooldown(arg5)
            else
                self:UpdateCooldowns()
            end
        elseif event == "SPELL_UPDATE_CHARGES" then
            if self:GetHideAbilitiesMode() then
                self:RefreshEntries()
            else
                self:UpdateCooldowns()
            end
        elseif event == "BAG_UPDATE_COOLDOWN" then
            if self:GetHideAbilitiesMode() then
                self:RefreshEntries()
            end
        elseif event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
            self:UpdateCooldown(arg1, C_Spell.GetBaseSpell(arg1) or arg1)
        elseif event == "PLAYER_EQUIPMENT_CHANGED" then
            if arg1 == 13 or arg1 == 14 then
                if ItemVisuals and ItemVisuals.InvalidateItemCastCache then
                    ItemVisuals:InvalidateItemCastCache()
                end
                C_Timer.After(0.3, function()
                    self:RefreshEntries()
                end)
            end
        elseif event == "BAG_UPDATE_DELAYED" then
            C_Timer.After(0.05, function()
                self:RefreshEntries()
            end)
        elseif event == "TRAIT_CONFIG_UPDATED" or event == "PLAYER_SPECIALIZATION_CHANGED" then
            if ItemsData and ItemsData.InvalidateSpellBookCache then
                ItemsData:InvalidateSpellBookCache()
            end
            C_Timer.After(0.1, function()
                self:RefreshEntries()
            end)
        elseif event == "SPELL_UPDATE_ICON" then
            if ItemsData and ItemsData.InvalidateSpellBookCache then
                ItemsData:InvalidateSpellBookCache()
                ItemsData:InvalidateOwnedItemsCache()
            end
            C_Timer.After(0.05, function()
                self:RefreshEntries()
            end)
        end
    end)

    WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    Pixel.SyncContainer(self.anchor)

    WilduUICore.RegisterEditModeCallbacks(self.anchor, self.configKey, function()
        return self.active and self.hasVisibleEntries
    end)

    local configKey = self.configKey
    local instance = self

    local RELATIVE_FACTORS = {
        LEFT = { x = 0, y = -0.5 },
        RIGHT = { x = -1, y = -0.5 },
        TOP = { x = -0.5, y = -1 },
        BOTTOM = { x = -0.5, y = 0 },
    }

    local function OnPositionChanged(frame, layoutName, _point, _x, _y)
        -- Anchored to another frame: its anchor governs position, so ignore the drag /
        -- centering math and re-snap to the target.
        if ns.Anchoring and ns.Anchoring:HasTarget(configKey) then
            WilduUICore.ApplyFramePosition(frame, configKey, false)
            return
        end

        local orientation = instance:GetOrientation()
        local anchorData = ORIENTATION_ANCHORS[orientation] or ORIENTATION_ANCHORS["Horizontal Right"]
        local anchorPrimary = (anchorData and anchorData.primary) or "RIGHT"

        local screenWidth, screenHeight = UIParent:GetSize()
        local frameWidth, frameHeight = frame:GetSize()
        local centerX, centerY = frame:GetCenter()

        if not centerX or not centerY or not frameWidth or not frameHeight then
            return
        end

        local frameScale = frame:GetEffectiveScale()
        local uiParentScale = UIParent:GetEffectiveScale()
        local scale = frameScale / uiParentScale

        screenWidth, screenHeight = screenWidth / scale, screenHeight / scale

        local newX, newY
        local factor = RELATIVE_FACTORS[anchorPrimary]

        if anchorPrimary == "LEFT" then
            newX = centerX - frameWidth / 2
            newY = centerY + (screenHeight * factor.y)
        elseif anchorPrimary == "RIGHT" then
            newX = centerX + frameWidth / 2 - screenWidth
            newY = centerY + (screenHeight * factor.y)
        elseif anchorPrimary == "TOP" then
            newX = centerX + (screenWidth * factor.x)
            newY = centerY + frameHeight / 2 - screenHeight
        elseif anchorPrimary == "BOTTOM" then
            newX = centerX + (screenWidth * factor.x)
            newY = centerY - frameHeight / 2
        elseif anchorPrimary == "CENTER" then
            newX = centerX - screenWidth / 2
            newY = centerY - screenHeight / 2
        end

        ns.db.profile.editMode[configKey].point = anchorPrimary
        ns.db.profile.editMode[configKey].x = newX
        ns.db.profile.editMode[configKey].y = newY

        WilduUICore.ApplyFramePosition(frame, configKey, false)
    end

    ns.TrackerItemSettings:Register(self, TRACKER_FRAME_DEFAULT_CONFIG, OnPositionChanged)

    self:RefreshEntries()
end

-- Re-applies this tracker's saved position to its (already-created) frame. Create()
-- applies the position exactly once and is idempotent, so a profile switch, a live
-- tracker-count change, or a fresh login would otherwise leave the frame at the
-- previous position (and re-asserts an "Anchor To" target via ApplyFramePosition).
-- Safe to call any time after Create(); does nothing before the frame exists.
function TrackerInstance:ReapplyPosition()
    if not self.anchor then
        return
    end
    WilduUICore.LoadFrameConfig(self.configKey, TRACKER_FRAME_DEFAULT_CONFIG)
    WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    Pixel.SyncContainer(self.anchor)
end

-- Activates or deactivates a tracker. Deactivated trackers are hidden and removed
-- from Edit Mode's overlay list (LibEQOL has no RemoveFrame, so we toggle the
-- overlay and visibility instead of destroying the frame, allowing cheap re-add).
function TrackerInstance:SetActive(active)
    self.active = active
    if not self.anchor then
        return
    end
    if LEM.SetFrameOverlayToggleEnabled then
        LEM:SetFrameOverlayToggleEnabled(self.anchor, active and self.hasVisibleEntries)
    end
    if active then
        self:RegisterTrackerEvents()
        self.anchor:SetShown(self.hasVisibleEntries)
        self:RefreshEntries()
    else
        self:UnregisterTrackerEvents()
        self.anchor:Hide()
        -- A hidden/deactivated tracker must not retain an armed ready alert while
        -- its pooled icon frames wait to be reused.
        for _, ivf in ipairs(self.iconFrames) do
            local state = Affected(ivf.frame)
            state.readyAlertTrackerActive = nil
            state.readyAlertTrackerIdentity = nil
            state.readyAlertTrackerWasOnActualCooldown = nil
        end
        -- Drop this tracker's spells from the range/resource union now that it's
        -- inactive, instead of waiting for another tracker to refresh.
        ItemViewer:RebuildUsabilityWanted()
    end
end

-- Pool of tracker instances, indexed 1..N. Instances are created lazily as the
-- active count grows and reused (deactivated, not destroyed) when it shrinks.
local trackers = {}
local spellCastEventFrame = nil

local function GetOrCreateTrackerInstance(index)
    if not trackers[index] then
        trackers[index] = TrackerInstance:New("tracker" .. index, "CMCTracker" .. index, function(owned)
            return ItemsData:GetTrackerEntries(index, owned)
        end)
    end
    return trackers[index]
end

-- Creates/activates frames for trackers 1..count and deactivates any beyond it.
-- Safe to call repeatedly; TrackerInstance:Create() is idempotent.
function ItemViewer:EnsureTrackers()
    if not ns.db.profile.tracker_enabled then
        return
    end
    local count = GetTrackerCount()
    for i = 1, count do
        local tracker = GetOrCreateTrackerInstance(i)
        tracker:Create()
        tracker:SetActive(true)
    end
    -- Second pass, after every active frame exists: re-apply each tracker's saved
    -- position. Create() only positions on first creation, so on a profile switch or
    -- live count change the existing frames would keep the old position and lose their
    -- "anchor to previous tracker" chaining without this. Ordered 1..count so an
    -- anchored tracker N resolves against an already-repositioned tracker N-1.
    for i = 1, count do
        if trackers[i] then
            trackers[i]:ReapplyPosition()
        end
    end
    -- Deactivate any previously-created instances above the active count.
    for i = count + 1, #trackers do
        if trackers[i] then
            trackers[i]:SetActive(false)
        end
    end
end

-- Reuse the tracker icon implementation for integrations that need cooldown
-- data/event behavior but deliberately do not own an Edit Mode frame.
function ItemViewer:CreateStandaloneFrame(parent)
    return ItemViewerFrame:New(parent, true)
end

-- Wires up visibility drivers and keybind text for the current tracker set after
-- the count changes at runtime, so a freshly added tracker works without a reload.
local function RefreshTrackerIntegrations()
    if ns.CMCVisibility and ns.CMCVisibility.Initialize then
        ns.CMCVisibility:Initialize()
    end
    if ns.Keybinds and ns.Keybinds.UpdateAllKeybinds then
        ns.Keybinds:UpdateAllKeybinds()
    end
end

-- Keeps the tracker count "magical": there is always exactly one empty trailing
-- tracker to drop new items into. Grows the count the moment the last tracker gains
-- an item, and trims any surplus trailing empties back down to a single spare.
-- Clamped to [1, MAX_TRACKERS]. Returns true if the count changed.
function ItemViewer:ReconcileTrackerCount()
    if not ns.db or not ns.db.profile then
        return false
    end
    local maxTrackers = ns.CONSTANTS.MAX_TRACKERS or 10

    local maxUsed = 0
    for i = 1, maxTrackers do
        if not ItemsData:IsTrackerEmpty(i) then
            maxUsed = i
        end
    end

    -- One spare empty tracker past the last used one, capped at the maximum.
    local desired = math.min(math.max(maxUsed + 1, 1), maxTrackers)
    if desired == GetTrackerCount() then
        return false
    end

    ns.db.profile.tracker_count = desired
    self:EnsureTrackers()
    RefreshTrackerIntegrations()
    return true
end

function ItemViewer:GetTrackerCount()
    return GetTrackerCount()
end

function ItemViewer:RefreshItemViewerFrames()
    for _, tracker in ipairs(trackers) do
        tracker:RefreshEntries()
    end
end

function ItemViewer:RefreshProcGlows()
    for _, tracker in ipairs(trackers) do
        if tracker.active then
            tracker:UpdateCooldowns(true)
        end
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.RefreshCooldowns then
        ns.EssentialCustomTracker:RefreshCooldowns()
    end
end

-- Scratch sets reused across rebuilds; UpdateWanted reads but never retains them,
-- so we avoid allocating two tables on every (combat-frequent) refresh.
local usabilityRangeScratch = {}
local usabilityPowerScratch = {}

function ItemViewer:RebuildUsabilityWanted()
    local rangeSet, powerSet = usabilityRangeScratch, usabilityPowerScratch
    wipe(rangeSet)
    wipe(powerSet)
    for _, tracker in ipairs(trackers) do
        if tracker.active and tracker.trackedSpellIds then
            local wantRange = tracker:GetRangeIndicator()
            local wantPower = tracker:GetRequireResource()
            if wantRange or wantPower then
                for spellID in pairs(tracker.trackedSpellIds) do
                    if wantRange then
                        rangeSet[spellID] = true
                    end
                    if wantPower then
                        powerSet[spellID] = true
                    end
                end
            end
        end
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.GetTrackedSpellIDs then
        for spellID in pairs(ns.EssentialCustomTracker:GetTrackedSpellIDs()) do
            rangeSet[spellID] = true
            powerSet[spellID] = true
        end
    end
    ns.TrackerUsability:UpdateWanted(rangeSet, powerSet)
end

function ItemViewer:RefreshUsabilityTints()
    for _, tracker in ipairs(trackers) do
        for _, ivf in ipairs(tracker.iconFrames) do
            if ivf.frame:IsShown() then
                ItemVisuals:ApplyUsabilityTint(ivf.frame)
                ItemVisuals:RefreshEntryUsabilityGlow(ivf.frame)
            end
        end
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.RefreshUsabilityTints then
        ns.EssentialCustomTracker:RefreshUsabilityTints()
    end
end

function ItemViewer:RefreshSuggestedGlows()
    for _, tracker in ipairs(trackers) do
        for _, ivf in ipairs(tracker.iconFrames) do
            if ivf.frame:IsShown() then
                ItemVisuals:RefreshEntrySuggestedGlow(ivf.frame)
            end
        end
    end
    if ns.EssentialCustomTracker and ns.EssentialCustomTracker.RefreshSuggestedGlows then
        ns.EssentialCustomTracker:RefreshSuggestedGlows()
    end
end

function ItemViewer:GetActiveItemFrames()
    local frames = {}
    for _, tracker in ipairs(trackers) do
        for _, ivf in ipairs(tracker.iconFrames) do
            if ivf.frame:IsShown() then
                frames[#frames + 1] = ivf.frame
            end
        end
    end
    return frames
end

function ItemViewer:RefreshStyling()
    for _, tracker in ipairs(trackers) do
        tracker:RefreshStyling()
    end
end

-- One-time per-profile migration. The legacy profile-level values intentionally
-- remain in place as a rollback fallback, but custom trackers no longer read them.
local TRACKER_STYLE_MIGRATION_VERSION = 1

function ItemViewer:MigrateSharedTrackerStyling()
    local profile = ns.db and ns.db.profile
    if not profile or (tonumber(profile._trackerStylePerTrackerMigrationVersion) or 0) >= TRACKER_STYLE_MIGRATION_VERSION then
        return
    end

    profile.editMode = profile.editMode or {}
    local count = GetTrackerCount()
    local values = {
        squareIcons = profile.trinketRacialTracker_squareIcons == true,
        borderThickness = profile.trinketRacialTracker_borderThickness or 1,
        iconZoom = profile.trinketRacialTracker_iconZoom or 0.3,
        rectangularIcons = profile.trinketRacialTracker_rectangularIcons == true,
        rectangularIconsPercent = profile.trinketRacialTracker_rectangularIcons_percent or 0.8,
        stackAnchor = profile.trinketRacialTracker_stackAnchor or "BOTTOMRIGHT",
        stackFontName = profile.cooldownManager_stackFontName or "NIL",
        stackFontFlags = profile.cooldownManager_stackFontFlags or { OUTLINE = true },
        stackFontSize = profile.trinketRacialTracker_stackFontSize or 14,
        stackOffsetX = profile.trinketRacialTracker_stackOffsetX or -1,
        stackOffsetY = profile.trinketRacialTracker_stackOffsetY or 1,
        cooldownFontEnabled = profile.cooldownManager_cooldownFontSizeTracker_enabled == true,
        cooldownFontName = profile.cooldownManager_cooldownFontName or "NIL",
        cooldownFontFlags = profile.cooldownManager_cooldownFontFlags or { OUTLINE = true },
        cooldownFontSize = profile.cooldownManager_cooldownFontSizeTracker or "NIL",
        cooldownTextOffsetX = profile.cooldownManager_cooldownTextTracker_offsetX or 0,
        cooldownTextOffsetY = profile.cooldownManager_cooldownTextTracker_offsetY or 0,
        showKeybinds = profile.cooldownManager_showKeybinds_CMCTracker == true,
        keybindFontName = profile.cooldownManager_keybindFontName or "NIL",
        keybindFontFlags = profile.cooldownManager_keybindFontFlags or { OUTLINE = true },
        keybindAnchor = profile.cooldownManager_keybindAnchor_CMCTracker or "TOPRIGHT",
        keybindFontSize = profile.cooldownManager_keybindFontSize_CMCTracker or 10,
        keybindOffsetX = profile.cooldownManager_keybindOffsetX_CMCTracker or -3,
        keybindOffsetY = profile.cooldownManager_keybindOffsetY_CMCTracker or -3,
    }
    for index = 1, (ns.CONSTANTS.MAX_TRACKERS or 10) do
        local configKey = "tracker" .. index
        if index <= count or type(profile.editMode[configKey]) == "table" then
            local config = profile.editMode[configKey] or {}
            profile.editMode[configKey] = config
            for key, value in pairs(values) do
                if config[key] == nil then
                    if type(value) == "table" then
                        config[key] = CopyTable(value)
                    else
                        config[key] = value
                    end
                end
            end
        end
    end
    profile._trackerStylePerTrackerMigrated = true
    profile._trackerStylePerTrackerMigrationVersion = TRACKER_STYLE_MIGRATION_VERSION
end

-- Migrates the removed "Anchor to Tracker X" chaining onto the generic "Anchor To"
-- system: a chained tracker N pinned its growth-primary point to the previous
-- tracker's opposite point with a spacing offset, which maps 1:1 onto an anchor
-- targeting CMCTracker(N-1). Runs on load and on every profile change (via _cleanup);
-- clears the legacy keys either way so it's a one-shot per profile.
function ItemViewer:MigrateChainAnchoring()
    local editMode = ns.db and ns.db.profile and ns.db.profile.editMode
    if not editMode then
        return
    end
    for key, cfg in pairs(editMode) do
        if type(key) == "string" and type(cfg) == "table" and cfg.anchoredToTracker1 ~= nil then
            local index = tonumber(key:match("^tracker(%d+)$"))
            if cfg.anchoredToTracker1 == true and index and index > 1 then
                local anchorData = ORIENTATION_ANCHORS[cfg.orientation or "Horizontal Right"] or ORIENTATION_ANCHORS["Horizontal Right"]
                local primary = anchorData.primary
                local spacing = cfg.anchoredToTracker1Spacing or DEFAULT_ICON_PADDING
                local x, y = 0, 0
                if primary == "LEFT" then
                    x = spacing
                elseif primary == "RIGHT" then
                    x = -spacing
                elseif primary == "TOP" then
                    y = -spacing
                else -- BOTTOM / CENTER, matching the old chaining's else branch
                    y = spacing
                end
                cfg.anchor = {
                    to = "CMCTracker" .. (index - 1),
                    point = primary,
                    relativePoint = OPPOSITE_ANCHOR[primary],
                    x = x,
                    y = y,
                }
            end
            cfg.anchoredToTracker1 = nil
            cfg.anchoredToTracker1Spacing = nil
        end
    end
end

function ItemViewer:Initialize()
    if not ns.db.profile.tracker_enabled then
        return
    end

    self:MigrateSharedTrackerStyling()
    ns.TrackerDB.InitializeDB()
    if ItemVisuals and ItemVisuals.InvalidateItemCastCache then
        ItemVisuals:InvalidateItemCastCache()
    end

    if not spellCastEventFrame then
        spellCastEventFrame = CreateFrame("Frame")
        spellCastEventFrame:SetScript("OnEvent", function(_, _event, unitTarget, _castGUID, spellID)
            if unitTarget ~= "player" or not spellID then
                return
            end

            local matched = false
            if ItemVisuals and ItemVisuals.MarkSpellCastActive and ItemVisuals:MarkSpellCastActive(spellID) then
                matched = true
            end
            if ItemVisuals and ItemVisuals.MarkItemCastActive and ItemVisuals:MarkItemCastActive(spellID) then
                matched = true
            end

            if matched then
                ItemViewer:RefreshItemViewerFrames()
            end
        end)
    end
    -- Registered every Initialize (not just on first creation) so re-enabling the
    -- feature after a HideAll() — which unregisters it — wires the watcher back up.
    spellCastEventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")

    self:EnsureTrackers()
    self:ReconcileTrackerCount()
end

-- Turns the whole custom tracker system off without a reload: stops the spell-cast
-- watcher, then deactivates every tracker — which hides its frame, unregisters its
-- refresh events (so nothing re-shows it), and disables its Edit Mode overlay so it
-- can't be selected or forced visible while disabled. LibEQOL has no
-- RemoveFrame/destroy, so the frames are kept (hidden) for cheap reuse on re-enable.
function ItemViewer:HideAll()
    if spellCastEventFrame then
        spellCastEventFrame:UnregisterAllEvents()
    end
    for _, tracker in ipairs(trackers) do
        tracker:SetActive(false)
    end
    ns.TrackerUsability:UpdateWanted({}, {})
    if ns.EssentialCustomTracker then
        ns.EssentialCustomTracker:Hide()
    end
end

function ItemViewer:ShowAll()
    if ns.EssentialCustomTracker then
        ns.EssentialCustomTracker:Initialize()
    end
    for _, tracker in ipairs(trackers) do
        if tracker.anchor and tracker.active then
            tracker:RefreshEntries()
        end
    end
end
