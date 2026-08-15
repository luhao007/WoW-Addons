local _, ns = ...
local L = ns.L

-- Custom buff containers: movable Edit Mode frames that wrap the icons they own.
-- Blizzard-tracked buffs stay children of BuffIconCooldownViewer and are
-- re-anchored/centered here by cooldownManager.lua (LayoutIcons). Custom auras
-- live in one native AuraContainer per container, centered inside a footprint
-- sized from the assigned definitions (known values, so the frame geometry stays
-- readable). Blizzard lays out and auto-sizes the icon groups inside. Orientation,
-- icon direction, padding, size, and alignment are configured independently for
-- each container.
local BuffContainerViewer = {}
ns.BuffContainerViewer = BuffContainerViewer

local BuffData = ns.BuffData
local WilduUICore = ns.WilduUICore
local LEM = ns.LibEQOL.EditMode
local Pixel = ns.PixelPerfect

local DEFAULT_ICON_PADDING = 2
local DEFAULT_ICON_SIZE = 1
local MIN_EMPTY_SIZE = 30

local function GetConfigValue(configKey, key, default)
    local cfg = ns.db.profile.editMode and ns.db.profile.editMode[configKey] --[[@as CMCEditModeFrameConfig?]]
    if cfg and cfg[key] ~= nil then
        return cfg[key]
    end
    return default
end

local function NormalizeChoice(value, default, localized)
    if value == default or value == localized then
        return default
    end
    return value or default
end

local function SetFrameSizeIfChanged(frame, width, height)
    width = Pixel.Snap(width, frame, 1)
    height = Pixel.Snap(height, frame, 1)
    local currentWidth, currentHeight = frame:GetSize()
    if math.abs(currentWidth - width) > 0.001 or math.abs(currentHeight - height) > 0.001 then
        frame:SetSize(width, height)
    end
    Pixel.SyncContainer(frame)
end

local function PositionNativeFrame(frame, anchor, point, x, y, scale, width, height)
    frame:SetScale(scale)
    Pixel.SetSize(frame, width, height, 1, 1)
    Pixel.SyncContainer(frame)
    frame:ClearAllPoints()
    Pixel.SetPoint(frame, point, anchor, point, x, y)
end

local ContainerInstance = {}
ContainerInstance.__index = ContainerInstance

function ContainerInstance:New(index)
    return setmetatable({
        index = index,
        configKey = "buffContainer" .. index,
        frameName = "CMCBuffContainer" .. index,
        editModeName = ns.API.GradientText("CMC Buffs " .. index),
        active = false,
        hasVisibleEntries = false,
        anchor = nil,
        pixelRoot = nil,
    }, ContainerInstance)
end

function ContainerInstance:GetLayoutFrame()
    if not self.anchor then
        return nil
    end
    self.pixelRoot = Pixel.SyncContainer(self.anchor)
    return self.pixelRoot or self.anchor
end

function ContainerInstance:SetHasVisibleEntries(hasVisibleEntries)
    local hadVisibleEntries = self.hasVisibleEntries
    self.hasVisibleEntries = hasVisibleEntries == true
    if not self.anchor then
        return
    end

    local shouldShow = self.active and self.hasVisibleEntries
    if LEM.SetFrameOverlayToggleEnabled then
        LEM:SetFrameOverlayToggleEnabled(self.anchor, shouldShow)
    end

    -- Edit Mode moves unavailable frames off-screen. Restore the saved position if
    -- this container gains visible contents while Edit Mode is still open.
    if shouldShow and not hadVisibleEntries then
        self.anchor._wt_hideOnEditModeExit = nil
        WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    end
    self.anchor:SetShown(shouldShow)
end

function ContainerInstance:GetOrientation()
    local value = GetConfigValue(self.configKey, "orientation", "Horizontal")
    local normalized = NormalizeChoice(value, "Horizontal", L["Horizontal"])
    if value ~= normalized then
        ns.db.profile.editMode[self.configKey].orientation = normalized
    end
    return normalized
end

function ContainerInstance:GetIconDirection()
    local value = GetConfigValue(self.configKey, "iconDirection", "Normal")
    local normalized = NormalizeChoice(value, "Normal", L["Normal"])
    if value ~= normalized then
        ns.db.profile.editMode[self.configKey].iconDirection = normalized
    end
    return normalized
end

function ContainerInstance:GetIconPadding()
    return GetConfigValue(self.configKey, "iconPadding", DEFAULT_ICON_PADDING)
end

function ContainerInstance:GetIconSize()
    return GetConfigValue(self.configKey, "iconSize", DEFAULT_ICON_SIZE)
end

function ContainerInstance:GetAlignment()
    local alignment = GetConfigValue(self.configKey, "alignment", nil)
    if BuffData.ContainerHasCustomAura(self.index) then
        -- Custom containers: default is grow-from-center, no "Disable" centering.
        if alignment == "Disable" then
            return "CENTER"
        end
        return alignment or "CENTER"
    end
    if alignment == nil then
        alignment = ns.db.profile.cooldownManager_alignBuffIcons_growFromDirection
    end
    return alignment or "CENTER"
end

-- The anchor point that pins the row: horizontal START/CENTER/END -> LEFT/CENTER/
-- RIGHT; vertical START/CENTER/END -> BOTTOM/CENTER/TOP.
function ContainerInstance:GetAlignmentAnchor()
    local alignment = self:GetAlignment()
    if self:GetOrientation() == "Vertical" then
        if alignment == "START" then
            return "BOTTOM"
        elseif alignment == "END" then
            return "TOP"
        end
        return "CENTER"
    end
    if alignment == "START" then
        return "LEFT"
    elseif alignment == "END" then
        return "RIGHT"
    end
    return "CENTER"
end

-- Re-anchors the custom container to the alignment anchor point, converting the
-- stored position so the row does not jump when alignment changes. The marker
-- size is set by us (known values), so the reads stay safe.
function ContainerInstance:ApplyAlignmentPosition()
    if not BuffData.ContainerHasCustomAura(self.index) then
        return
    end
    if ns.Anchoring and ns.Anchoring:HasTarget(self.configKey) then
        return
    end
    local cfg = ns.db.profile.editMode[self.configKey]
    local point = self:GetAlignmentAnchor()
    if cfg.point == point then
        return
    end

    local frame = self.anchor
    local totalWidth, totalHeight = frame:GetSize()
    local centerX, centerY = frame:GetCenter()
    local uiCenterX, uiCenterY = UIParent:GetCenter()
    if not centerX or not centerY or not uiCenterX or not uiCenterY then
        return
    end

    local x, y
    if point == "LEFT" then
        x = centerX - totalWidth / 2 - (UIParent:GetLeft() or 0)
        y = centerY - uiCenterY
    elseif point == "RIGHT" then
        x = centerX + totalWidth / 2 - (UIParent:GetRight() or 0)
        y = centerY - uiCenterY
    elseif point == "BOTTOM" then
        x = centerX - uiCenterX
        y = centerY - totalHeight / 2 - (UIParent:GetBottom() or 0)
    elseif point == "TOP" then
        x = centerX - uiCenterX
        y = centerY + totalHeight / 2 - (UIParent:GetTop() or 0)
    else
        x = centerX - uiCenterX
        y = centerY - uiCenterY
    end

    cfg.point = point
    cfg.x = x
    cfg.y = y
    frame:ClearAllPoints()
    frame:SetPoint(point, UIParent, point, x, y)
    Pixel.SyncContainer(frame)
end

-- Anchors the given native buff icon frames into this container and sizes the
-- container to fit them. The footprint is sized to `total` (all buffs assigned to the
-- container, active or not). Dynamic alignments position the visible group within that
-- footprint; Disabled preserves every assigned buff's original slot. When nothing is
-- assigned the container keeps a minimal hidden footprint.
function ContainerInstance:LayoutIcons(iconFrames, total)
    if not self.anchor then
        return false
    end
    local count = iconFrames and #iconFrames or 0
    total = math.max(total or count, count)

    local iconScale = self:GetIconSize()

    if total == 0 then
        SetFrameSizeIfChanged(self.anchor, MIN_EMPTY_SIZE, MIN_EMPTY_SIZE)
        self:SetHasVisibleEntries(false)
        return false
    end

    -- Prefer a live icon's dimensions; fall back to the known buff-icon size so an
    -- all-hidden (but non-empty) container still keeps its stable total footprint.
    local w, h
    if count > 0 then
        local ref = iconFrames[1]
        w, h = ref:GetWidth(), ref:GetHeight()
    end
    if not w or w == 0 or not h or h == 0 then
        w, h = ns.Sizes.GetViewerIconSize("BuffIcons")
    end
    if not w or w == 0 or not h or h == 0 then
        SetFrameSizeIfChanged(self.anchor, MIN_EMPTY_SIZE, MIN_EMPTY_SIZE)
        self:SetHasVisibleEntries(count > 0)
        return count > 0
    end

    local paddingPixels = Pixel.Round(self:GetIconPadding())
    local orientation = self:GetOrientation()
    local reversed = self:GetIconDirection() == "Reversed"
    local alignment = self:GetAlignment()
    local layoutRoot = self:GetLayoutFrame()

    -- Native buff frames are scaled independently of this marker. Convert the
    -- configured pixel gap in both coordinate spaces: icon space for SetPoint,
    -- marker space for the stable Edit Mode footprint.
    for _, icon in ipairs(iconFrames) do
        icon:SetScale(iconScale)
        Pixel.SetSize(icon, w, h, 1, 1)
        Pixel.SyncContainer(icon)
    end
    local iconWidthPixels, iconHeightPixels
    if count > 0 then
        w, h = iconFrames[1]:GetSize()
        iconWidthPixels = Pixel.ToPixels(w, iconFrames[1], 1)
        iconHeightPixels = Pixel.ToPixels(h, iconFrames[1], 1)
    else
        local nativeViewer = BuffIconCooldownViewer or self.anchor
        iconWidthPixels = Pixel.ToPixels(w * iconScale, nativeViewer, 1)
        iconHeightPixels = Pixel.ToPixels(h * iconScale, nativeViewer, 1)
    end
    -- Offset the visible icons within the stable `total`-slot footprint. Disabled
    -- preserves gaps left by inactive assigned buffs rather than packing the group.
    local missing = total - count
    local function GetInsetPixels(stepPixels)
        if alignment == "END" then
            return missing * stepPixels
        elseif alignment == "CENTER" then
            return Pixel.Round((missing / 2) * stepPixels)
        end
        return 0
    end

    if orientation == "Vertical" then
        local stepPixels = iconHeightPixels + paddingPixels
        local insetPixels = GetInsetPixels(stepPixels)
        SetFrameSizeIfChanged(
            self.anchor,
            Pixel.SizeFromPixels(self.anchor, iconWidthPixels, 1),
            Pixel.SizeFromPixels(self.anchor, total * iconHeightPixels + (total - 1) * paddingPixels, 1)
        )
        for i, icon in ipairs(iconFrames) do
            local position = alignment == "Disable" and (ns.API.Affected(icon).buffContainerSlot or i) or i
            local offsetPixels = insetPixels + (position - 1) * stepPixels
            if reversed then
                PositionNativeFrame(
                    icon,
                    layoutRoot,
                    "BOTTOM",
                    0,
                    Pixel.SizeFromPixels(icon, offsetPixels),
                    iconScale,
                    w,
                    h
                )
            else
                PositionNativeFrame(
                    icon,
                    layoutRoot,
                    "TOP",
                    0,
                    Pixel.SizeFromPixels(icon, -offsetPixels),
                    iconScale,
                    w,
                    h
                )
            end
        end
    else
        local stepPixels = iconWidthPixels + paddingPixels
        local insetPixels = GetInsetPixels(stepPixels)
        SetFrameSizeIfChanged(
            self.anchor,
            Pixel.SizeFromPixels(self.anchor, total * iconWidthPixels + (total - 1) * paddingPixels, 1),
            Pixel.SizeFromPixels(self.anchor, iconHeightPixels, 1)
        )
        for i, icon in ipairs(iconFrames) do
            local position = alignment == "Disable" and (ns.API.Affected(icon).buffContainerSlot or i) or i
            local offsetPixels = insetPixels + (position - 1) * stepPixels
            if reversed then
                PositionNativeFrame(
                    icon,
                    layoutRoot,
                    "RIGHT",
                    Pixel.SizeFromPixels(icon, -offsetPixels),
                    0,
                    iconScale,
                    w,
                    h
                )
            else
                PositionNativeFrame(
                    icon,
                    layoutRoot,
                    "LEFT",
                    Pixel.SizeFromPixels(icon, offsetPixels),
                    0,
                    iconScale,
                    w,
                    h
                )
            end
        end
    end
    self:SetHasVisibleEntries(count > 0)
    return count > 0
end

-- Custom-only containers chain one AuraContainer per entrypoint (own unit,
-- parented to UIParent, independent of the marker). The marker is a "fake"
-- footprint sized for all theoretical icons, showing 1:1 look-alike previews
-- in Edit Mode.
function ContainerInstance:LayoutCustomAuras()
    if not ns.CustomAuraProvider:IsContainerActive(self) then
        SetFrameSizeIfChanged(self.anchor, MIN_EMPTY_SIZE, MIN_EMPTY_SIZE)
        self:SetHasVisibleEntries(false)
        return
    end

    local count = ns.CustomAuraProvider:GetDefinitionCount(self)
    local width, height = ns.Sizes.GetViewerIconSize("BuffIcons")
    width = width or 40
    height = height or 40
    local iconScale = self:GetIconSize() or 1

    local totalWidth, totalHeight
    if count > 0 then
        if self:GetOrientation() == "Vertical" then
            totalWidth = width * iconScale
            totalHeight = count * height * iconScale
        else
            totalWidth = count * width * iconScale
            totalHeight = height * iconScale
        end
    else
        totalWidth = MIN_EMPTY_SIZE
        totalHeight = MIN_EMPTY_SIZE
    end
    SetFrameSizeIfChanged(self.anchor, totalWidth, totalHeight)

    if not InCombatLockdown() then
        -- The real chain is a UIParent child, so the marker must render at scale 1
        -- (iconScale handles sizing) or the chain would not line up with previews.
        self.anchor:SetScale(1)
        self:ApplyAlignmentPosition()
        ns.CustomAuraProvider:ApplyGroupLayout(self)
    end
    -- ChainContainers re-anchors the protected controllers only out of combat;
    -- in combat it still re-wraps the host around auras that appeared mid-fight.
    ns.CustomAuraProvider:ChainContainers(self)
    ns.CustomAuraProvider:UpdateContainerPreviews(self)
    self:SetHasVisibleEntries(true)
end

function ContainerInstance:Create()
    if self.anchor then
        return
    end

    local DEFAULT_CONFIG = {
        alpha = 1,
        point = "CENTER",
        x = 0,
        y = -150,
        scale = 1,
        strata = "MEDIUM",
        orientation = "Horizontal",
        iconDirection = "Normal",
        iconPadding = DEFAULT_ICON_PADDING,
        iconSize = DEFAULT_ICON_SIZE,
    }
    WilduUICore.LoadFrameConfig(self.configKey, DEFAULT_CONFIG)

    self.anchor = CreateFrame("Frame", self.frameName, UIParent, "BackdropTemplate")
    self.anchor.editModeName = self.editModeName
    Pixel.SetSize(self.anchor, MIN_EMPTY_SIZE, MIN_EMPTY_SIZE, 1, 1)
    self.anchor:SetClampedToScreen(true)
    self.pixelRoot = Pixel.EnsureContainer(self.anchor)

    WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    Pixel.SyncContainer(self.anchor)

    WilduUICore.RegisterEditModeCallbacks(self.anchor, self.configKey, function()
        return self.active and self.hasVisibleEntries
    end)

    local configKey = self.configKey
    local anchor = self.anchor
    local instance = self

    -- Custom containers store the position against their alignment anchor
    -- (LEFT/CENTER/RIGHT or BOTTOM/CENTER/TOP); Blizzard-buff containers keep
    -- the old fixed CENTER footprint.
    local function OnPositionChanged(frame, layoutName, _point, _x, _y)
        -- Anchored to another frame: its anchor governs position, so ignore the drag and
        -- re-snap to the target instead of storing a free position.
        if ns.Anchoring and ns.Anchoring:HasTarget(configKey) then
            WilduUICore.ApplyFramePosition(frame, configKey, false)
            Pixel.SyncContainer(frame)
            return
        end

        local cfg = ns.db.profile.editMode[configKey]
        local point = "CENTER"
        if BuffData.ContainerHasCustomAura(instance.index) then
            point = instance:GetAlignmentAnchor()
        end

        local centerX, centerY = frame:GetCenter()
        local uiCenterX, uiCenterY = UIParent:GetCenter()
        if not centerX or not centerY or not uiCenterX or not uiCenterY then
            return
        end

        local width, height = frame:GetSize()
        local x, y
        if point == "LEFT" then
            x = centerX - width / 2 - (UIParent:GetLeft() or 0)
            y = centerY - uiCenterY
        elseif point == "RIGHT" then
            x = centerX + width / 2 - (UIParent:GetRight() or 0)
            y = centerY - uiCenterY
        elseif point == "BOTTOM" then
            x = centerX - uiCenterX
            y = centerY - height / 2 - (UIParent:GetBottom() or 0)
        elseif point == "TOP" then
            x = centerX - uiCenterX
            y = centerY + height / 2 - (UIParent:GetTop() or 0)
        else
            x = centerX - uiCenterX
            y = centerY - uiCenterY
        end
        cfg.point = point
        cfg.x = x
        cfg.y = y
        WilduUICore.ApplyFramePosition(frame, configKey, false)
        Pixel.SyncContainer(frame)
    end

    local function RefreshLayout()
        if ns.CooldownManager then
            ns.CooldownManager.ForceRefresh({ icons = true })
        end
    end

    local additionalSettings = {
        {
            name = L["Alignment"],
            kind = LEM.SettingType.Dropdown,
            generator = function(_, rootDescription)
                local isCustom = BuffData.ContainerHasCustomAura(instance.index)
                local entries = {
        { text = L["Grow from the Start"], value = "START" },
        { text = L["Grow from Center"], value = "CENTER" },
        { text = L["Grow from the End"], value = "END" },
                }
                if not isCustom then
        table.insert(entries, 1, { text = L["Use Default"], value = "Default" })
        table.insert(entries, { text = L["Disable centering"], value = "Disable" })
                end
                local function Current()
                    return GetConfigValue(configKey, "alignment", nil) or (isCustom and "CENTER" or "Default")
                end
                for _, entry in ipairs(entries) do
                    rootDescription:CreateRadio(entry.text, function()
                        return Current() == entry.value
                    end, function()
                        ns.db.profile.editMode[configKey].alignment = entry.value ~= "Default" and entry.value or nil
                        OnPositionChanged(anchor, configKey)
                        RefreshLayout()
                    end)
                end
            end,
        },
        {
            name = L["Orientation"],
            kind = LEM.SettingType.Dropdown,
            default = "Horizontal",
            get = function()
                return instance:GetOrientation()
            end,
            set = function(_layoutName, value)
                ns.db.profile.editMode[configKey].orientation = value
                OnPositionChanged(anchor, configKey)
                RefreshLayout()
            end,
            values = {
            { value = "Horizontal", text = L["Horizontal"] },
            { value = "Vertical", text = L["Vertical"] },
            },
        },
        {
            name = L["Icon Direction"],
            kind = LEM.SettingType.Dropdown,
            default = "Normal",
            get = function()
                return instance:GetIconDirection()
            end,
            set = function(_layoutName, value)
                ns.db.profile.editMode[configKey].iconDirection = value
                OnPositionChanged(anchor, configKey)
                RefreshLayout()
            end,
            values = {
            { value = "Normal", text = L["Normal"] },
            { value = "Reversed", text = L["Reversed"] },
            },
        },
        {
            name = L["Icon Size"],
            kind = LEM.SettingType.Slider,
            default = DEFAULT_ICON_SIZE,
            get = function()
                return instance:GetIconSize()
            end,
            set = function(_layoutName, value)
                ns.db.profile.editMode[configKey].iconSize = value
                RefreshLayout()
            end,
            minValue = 0.5,
            maxValue = 2,
            valueStep = 0.05,
            formatter = function(value)
                return string.format("%.0f%%", value * 100)
            end,
        },
    }

    -- Icon padding only applies to Blizzard-buff containers; custom auras are
    -- laid out by the native AuraContainer with its own default spacing.
    if not BuffData.ContainerHasCustomAura(instance.index) then
        tinsert(additionalSettings, {
            name = L["Icon Padding"],
            kind = LEM.SettingType.Slider,
            default = DEFAULT_ICON_PADDING,
            get = function()
                return instance:GetIconPadding()
            end,
            set = function(_layoutName, value)
                ns.db.profile.editMode[configKey].iconPadding = value
                RefreshLayout()
            end,
            minValue = 0,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d px", value)
            end,
        })
    end

    -- Anchor-to-another-frame section (custom trackers, other buff containers, unit
    -- frames, native CDM viewers). Shared with the custom trackers.
    local anchorSettings = ns.Anchoring:BuildSettings(configKey, {
        selfFrameName = self.frameName,
        onChanged = function()
            WilduUICore.ApplyFramePosition(anchor, configKey, false)
            RefreshLayout()
        end,
    })
    for _, setting in ipairs(anchorSettings) do
        tinsert(additionalSettings, setting)
    end
    if ns.EditModeViewerSettings and ns.EditModeViewerSettings.BuildAdvancedSettingsButton then
        tinsert(additionalSettings, ns.EditModeViewerSettings:BuildAdvancedSettingsButton("buffs"))
    end
    -- skipGeneralSection: containers only anchor the native icons, so frame
    -- scale/strata wouldn't affect them — omit that section.
    WilduUICore.RegisterFrameWithLEM(self.anchor, self.configKey, additionalSettings, OnPositionChanged, true)
end

-- Re-applies the saved CENTER position (Create() positions only once) after profile
-- switches / count changes.
function ContainerInstance:ReapplyPosition()
    if not self.anchor then
        return
    end
    WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)
    Pixel.SyncContainer(self.anchor)
end

function ContainerInstance:SetActive(active)
    self.active = active
    if not self.anchor then
        return
    end
    if LEM.SetFrameOverlayToggleEnabled then
        LEM:SetFrameOverlayToggleEnabled(self.anchor, active and self.hasVisibleEntries)
    end
    self.anchor:SetShown(active and self.hasVisibleEntries)
end

-- Pool of container instances, indexed 1..N; created lazily and reused (deactivated,
-- not destroyed) when the count shrinks, mirroring the custom-tracker pool.
local containers = {}
BuffContainerViewer.containers = containers

-- Creates/activates containers 1..count and deactivates any beyond it. Idempotent.
function BuffContainerViewer:EnsureContainers()
    if not BuffData.IsEnabled() then
        return
    end
    BuffData.MigrateMixedContainers()
    local count = BuffData.GetContainerCount()
    for i = 1, count do
        if not containers[i] then
            containers[i] = ContainerInstance:New(i)
        end
        containers[i]:Create()
        containers[i]:SetActive(true)
    end
    for i = 1, count do
        if containers[i] then
            containers[i]:ReapplyPosition()
        end
    end
    for i = count + 1, #containers do
        if containers[i] then
            containers[i]:SetActive(false)
        end
    end
end

-- Rebuilds every custom container's native AuraContainer from the current
-- assignments. Safe to call on assignment/settings changes; the provider defers
-- the actual work when combat lockdown is active.
function BuffContainerViewer:RefreshCustomAuras()
    if not BuffData.IsEnabled() then
        return
    end
    self:EnsureContainers()

    if not BuffData.AreCustomAurasEnabled() then
        for _, container in ipairs(containers) do
            if container then
                ns.CustomAuraProvider:DisableContainer(container)
            end
        end
    else
        local count = BuffData.GetContainerCount()
        local assignments = BuffData.GetAssignments()
        local definitions = BuffData.GetAssignedAuraDefinitions()
        local byContainer = {}
        for stableKey, definition in pairs(definitions) do
            local index = assignments[stableKey]
            if index and index >= 1 and index <= count then
                byContainer[index] = byContainer[index] or {}
                byContainer[index][stableKey] = definition
            end
        end
        for i = 1, count do
            local container = containers[i]
            if container then
                local newDefinitions = byContainer[i]
                if not newDefinitions or not next(newDefinitions) then
                    ns.CustomAuraProvider:DisableContainer(container)
                else
                    ns.CustomAuraProvider:RefreshContainer(container, newDefinitions)
                end
            end
        end
        for i = count + 1, #containers do
            if containers[i] then
                ns.CustomAuraProvider:DisableContainer(containers[i])
            end
        end
    end

    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ icons = true })
    end
end

-- Grows/shrinks to keep one empty trailing container and rewires the layout after
-- an assignment change. Returns true if the active count changed.
function BuffContainerViewer:ReconcileContainerCount()
    local before = BuffData.GetContainerCount()
    local desired = BuffData.ReconcileContainerCount()
    self:EnsureContainers()
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ icons = true })
    end
    return desired ~= before
end

function BuffContainerViewer:HideAll()
    ns.CustomAuraProvider:SetEnabled(false)
    for _, container in ipairs(containers) do
        container:SetActive(false)
    end
    if ns.CooldownManager then
        ns.CooldownManager.ForceRefresh({ icons = true })
    end
end

function BuffContainerViewer:ShowAll()
    if not BuffData.IsEnabled() then
        return
    end
    BuffData.ReconcileContainerCount()
    self:RefreshCustomAuras()
end

function BuffContainerViewer:Initialize()
    if not BuffData.IsEnabled() then
        return
    end
    BuffData.ReconcileContainerCount()
    self:RefreshCustomAuras()
end

-- The cooldownID -> spellID mapping is spec/loadout dependent, so the cached buff
-- scan is dropped on these events; the layout + open settings panel then rebuild
-- against the fresh tracked-buff set.
local invalidationEvents = CreateFrame("Frame")
invalidationEvents:RegisterEvent("COOLDOWN_VIEWER_DATA_LOADED")
invalidationEvents:RegisterEvent("COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED")
invalidationEvents:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
invalidationEvents:RegisterEvent("TRAIT_CONFIG_UPDATED")
invalidationEvents:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
invalidationEvents:SetScript("OnEvent", function(_, event)
    BuffData.InvalidateScan()
    if event == "COOLDOWN_VIEWER_DATA_LOADED" then
        -- Startup migration only runs once Blizzard's CDM category sets are
        -- trustworthy. Spec changes are handled by the delayed migration in
        -- CooldownManagerCentered.lua so the new spec's data has settled.
        BuffData.OnBlizzardDataLoaded()
    end
    if not BuffData.IsEnabled() then
        return
    end
    BuffData.ReconcileContainerCount()
    BuffContainerViewer:RefreshCustomAuras()
    local settings = _G["CooldownViewerSettings"]
    if settings and settings:IsShown() then
        ns.BuffAssignmentPanel:RefreshPanel()
    end
end)
