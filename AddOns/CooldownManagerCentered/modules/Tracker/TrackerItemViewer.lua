local _, ns = ...

local DB = ns.TrackerDB
local ItemsData = ns.TrackerItemsData
local ItemVisuals = ns.TrackerItemVisuals
local WilduUICore = ns.WilduUICore
local LSM = LibStub("LibSharedMedia-3.0", true)
local LEM = LibStub("LibEQOLEditMode-1.0")

local ItemViewer = ns.TrackerItemViewer or {}
ns.TrackerItemViewer = ItemViewer

local UPDATE_THROTTLE_DELAY = 0.25
local DEFAULT_ICON_SIZE = 50
local DEFAULT_ICON_PADDING = 2
local BASE_SQUARE_MASK = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\Square"
local DEFAULT_MASK_TEXTURE = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Art\\CooldownManager"
local DEFAULT_FONT_PATH = "Fonts\\FRIZQT__.TTF"

local ORIENTATION_ANCHORS = {
    ["Horizontal Right"] = { primary = "LEFT", offsetX = 1, offsetY = 0 },
    ["Horizontal Center"] = { primary = "CENTER", offsetX = 1, offsetY = 0 },
    ["Horizontal Left"] = { primary = "RIGHT", offsetX = -1, offsetY = 0 },
    ["Vertical Down"] = { primary = "TOP", offsetX = 0, offsetY = -1 },
    ["Vertical Up"] = { primary = "BOTTOM", offsetX = 0, offsetY = 1 },
}

local OPPOSITE_ANCHOR = {
    LEFT = "RIGHT",
    RIGHT = "LEFT",
    TOP = "BOTTOM",
    BOTTOM = "TOP",
    CENTER = "BOTTOM",
}

local CONFIG_KEY_TO_NAME = {
    ["tracker1"] = "|cff008945Cool|r|cff1e9a4e|r|cff3faa4fdown Ma|r|cff5fb64anag|r|cff7ac243er Ce|r|cff8ccd00ntered|r 1",
    ["tracker2"] = "|cff008945Cool|r|cff1e9a4e|r|cff3faa4fdown Ma|r|cff5fb64anag|r|cff7ac243er Ce|r|cff8ccd00ntered|r 2",
}

local function IsSquareIconsEnabled()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_squareIcons) or false
end

local function GetBorderThickness()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_borderThickness) or 1
end

local function GetIconZoom()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_iconZoom) or 0.3
end

local function GetFontPath(fontName)
    if not fontName or fontName == "" then
        return DEFAULT_FONT_PATH
    end
    if LSM then
        local fontPath = LSM:Fetch("font", fontName)
        if fontPath then
            return fontPath
        end
    end
    return DEFAULT_FONT_PATH
end

local function GetStackFontName()
    if ns.db and ns.db.profile and ns.db.profile.cooldownManager_stackFontName then
        return ns.db.profile.cooldownManager_stackFontName
    end
    return "Friz Quadrata TT"
end

local function GetStackFontFlags()
    local fontFlags = ns.db.profile.cooldownManager_stackFontFlags or {}
    local fontFlag = ""
    for n, v in pairs(fontFlags) do
        if v == true then
            fontFlag = fontFlag .. n .. ","
        end
    end
    return fontFlag
end

local function GetStackAnchor()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_stackAnchor) or "BOTTOMRIGHT"
end

local function GetStackFontSize()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_stackFontSize) or 14
end

local function GetStackOffsetX()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_stackOffsetX) or -1
end

local function GetStackOffsetY()
    return (ns.db and ns.db.profile and ns.db.profile.trinketRacialTracker_stackOffsetY) or 1
end

local function GetCooldownSwipeColor()
    return {
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_r)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[1],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_g)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[2],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_b)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[3],
        (ns.db and ns.db.profile and ns.db.profile.cooldownManager_customCDSwipeColor_a)
            or DB.DEFAULT_COOLDOWN_SWIPE_COLOR[4],
    }
end

local function GetCooldownFontFlags()
    local fontFlags = ns.db.profile.cooldownManager_cooldownFontFlags or {}
    local fontFlag = {}
    for n, v in pairs(fontFlags) do
        if v == true then
            table.insert(fontFlag, n)
        end
    end
    return table.concat(fontFlag, ",")
end

local function ApplyCooldownFontToFrame(frame)
    if not frame or not frame.Cooldown or not frame.Cooldown.GetCountdownFontString then
        return
    end
    local fontString = frame.Cooldown:GetCountdownFontString()
    if not fontString then
        return
    end
    local size = ns.db.profile.cooldownManager_cooldownFontSizeTracker
    local enabled = ns.db.profile.cooldownManager_cooldownFontSizeTracker_enabled
    local numericSize = tonumber(size)
    if enabled and numericSize == 0 then
        fontString:SetFontHeight(0)
        return
    end
    fontString:SetAlpha(1)
    fontString:SetTextColor(1, 1, 1, 1)
    if not enabled or size == "NIL" or size == nil then
        numericSize = select(2, fontString:GetFont()) or 16
    else
        numericSize = numericSize or 16
    end

    local fontName = ns.db.profile.cooldownManager_cooldownFontName or "Friz Quadrata TT"
    local fontPath = GetFontPath(fontName)
    local fontFlags = GetCooldownFontFlags()
    fontString:SetFont(fontPath, numericSize, fontFlags or "")
end

local function ApplySquareStyle(frame)
    local borderThickness = GetBorderThickness()
    local zoom = GetIconZoom()
    local crop = zoom * 0.5

    if frame.Icon and frame.Icon.SetTexCoord then
        frame.Icon:SetTexCoord(crop, 1 - crop, crop, 1 - crop)
    end

    if frame.Cooldown then
        frame.Cooldown:SetSwipeTexture(BASE_SQUARE_MASK)
        frame.Cooldown:ClearAllPoints()
        frame.Cooldown:SetPoint("TOPLEFT", frame, "TOPLEFT", borderThickness, -borderThickness)
        frame.Cooldown:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -borderThickness, borderThickness)
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

    if not frame.cmcBorder then
        frame.cmcBorder = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        frame.cmcBorder:SetFrameLevel(frame:GetFrameLevel() + 1)
    end
    frame.cmcBorder:ClearAllPoints()
    frame.cmcBorder:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    frame.cmcBorder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    if borderThickness <= 0 then
        frame.cmcBorder:Hide()
    else
        frame.cmcBorder:SetBackdrop({
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            edgeSize = borderThickness,
        })
        frame.cmcBorder:SetBackdropBorderColor(0, 0, 0, 1)
        frame.cmcBorder:Show()
    end
    frame._CMC_SquareStyle = true
end

local function RestoreDefaultStyle(frame)
    if not frame._CMC_SquareStyle then
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

    if frame.cmcBorder then
        frame.cmcBorder:Hide()
    end
    frame._CMC_SquareStyle = nil
end

local function ApplyStyleToFrame(frame)
    local isSquare = IsSquareIconsEnabled()

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
    local fontName = GetStackFontName()
    local fontPath = GetFontPath(fontName)
    local fontFlags = GetStackFontFlags()
    local fontSize = GetStackFontSize()
    local anchor = GetStackAnchor()
    local offsetX = GetStackOffsetX()
    local offsetY = GetStackOffsetY()

    if frame.count then
        frame.count:SetFont(fontPath, fontSize, fontFlags)
        frame.count:ClearAllPoints()
        frame.count:SetPoint(anchor, frame, anchor, offsetX, offsetY)
    end
end

local ItemViewerFrame = {}
ItemViewerFrame.__index = ItemViewerFrame

function ItemViewerFrame:New(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetFrameStrata("MEDIUM")
    local obj = setmetatable({ frame = frame }, ItemViewerFrame)
    obj:Initialize()
    return obj
end

function ItemViewerFrame:Initialize()
    local frame = self.frame
    frame.showGCD = false
    if not frame.Icon then
        frame.Icon = frame:CreateTexture(nil, "ARTWORK")
        frame.Icon:SetAllPoints()
        frame.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    local width, height = frame:GetSize()
    if not frame.IconOverlay and frame.Icon then
        frame.IconOverlay = frame:CreateTexture(nil, "OVERLAY", nil, 1)
        frame.IconOverlay:SetAtlas("UI-HUD-CoolDownManager-IconOverlay")
        frame.IconOverlay:SetSize(width*1.5, height*1.5)
        frame.IconOverlay:SetPoint("Center", frame.Icon, "CENTER")

        frame.IconOverlay:Hide()
    end
    if not frame.Cooldown then
        frame.Cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
        frame.Cooldown:SetAllPoints()
        frame.Cooldown:SetDrawEdge(false)
        frame.Cooldown:SetSwipeTexture(DEFAULT_MASK_TEXTURE)
        frame.Cooldown:SetHideCountdownNumbers(false)
        frame.Cooldown:HookScript("OnCooldownDone", function()
            ItemVisuals:UpdateEntryCooldown(frame, frame._CMCTracker_EntryKind, frame._CMCTracker_EntryID)
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
    ApplyStyleToFrame(frame)
    ApplyStackFontToFrame(frame)
    ApplyCooldownFontToFrame(frame)
    frame:Hide()
end

function ItemViewerFrame:Show()
    self.frame:Show()
end

function ItemViewerFrame:Hide()
    self.frame:Hide()
end

function ItemViewerFrame:UpdateEntry(entry)
    local frame = self.frame
    if not entry then
        frame._CMCTracker_EntryKind = nil
        frame._CMCTracker_EntryID = nil
        frame:Hide()
        return
    end

    frame._CMCTracker_EntryKind = entry.kind
    frame._CMCTracker_EntryID = entry.id

    if entry.kind == "item" then
        local _spellName, spellID = C_Item.GetItemSpell(entry.id)
        frame.itemID = entry.id
        if spellID then
            frame.spellID = spellID
        end
    elseif entry.kind == "wildcardSlots" then
        local itemID = ItemsData:GetWildcardSlotItemID(entry.id)
        if itemID then
            frame.itemID = itemID
            local _spellName, spellID = C_Item.GetItemSpell(itemID)
            if spellID then
                frame.spellID = spellID
            end
        end
    elseif entry.kind == "spell" then
        frame.spellID = entry.id
    end
    ItemVisuals:ApplyEntryIcon(frame, entry.kind, entry.id)
    ItemVisuals:UpdateEntryCooldown(frame, entry.kind, entry.id)
    ApplyStyleToFrame(frame)
    ApplyStackFontToFrame(frame)
    ApplyCooldownFontToFrame(frame)

    frame:Show()
end

function ItemViewerFrame:UpdateCooldown()
    local frame = self.frame
    if not frame:IsShown() or not frame._CMCTracker_EntryKind or not frame._CMCTracker_EntryID then
        return
    end
    ItemVisuals:ApplyEntryIcon(frame, frame._CMCTracker_EntryKind, frame._CMCTracker_EntryID)
    ItemVisuals:UpdateEntryCooldown(frame, frame._CMCTracker_EntryKind, frame._CMCTracker_EntryID)
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
        editModeName = CONFIG_KEY_TO_NAME[configKey] or frameName,
        getEntriesFn = getEntriesFn,
        anchor = nil,
        iconFrames = {},
        lastUpdateTimes = {},
    }, TrackerInstance)
    return instance
end

function TrackerInstance:GetIconSize()
    return GetConfigValue(self.configKey, "iconSize", DEFAULT_ICON_SIZE)
end

function TrackerInstance:GetIconPadding()
    return GetConfigValue(self.configKey, "iconPadding", DEFAULT_ICON_PADDING)
end

function TrackerInstance:GetOrientation()
    return GetConfigValue(self.configKey, "orientation", "Horizontal Right")
end

function TrackerInstance:GetShowGCD()
    return GetConfigValue(self.configKey, "showGCD", false)
end

function TrackerInstance:UpdateIconPosition(frame, visibleIndex)
    local iconSize = self:GetIconSize()
    local padding = self:GetIconPadding()
    local orientation = self:GetOrientation()
    local anchorData = ORIENTATION_ANCHORS[orientation] or ORIENTATION_ANCHORS["Horizontal Right"]

    local anchorPoint = anchorData.primary
    if anchorPoint == "CENTER" then
        anchorPoint = "LEFT"
    end
    frame:ClearAllPoints()
    local offset = (visibleIndex - 1) * (iconSize + padding)
    frame:SetPoint(anchorPoint, self.anchor, anchorPoint, anchorData.offsetX * offset, anchorData.offsetY * offset)
end

function TrackerInstance:UpdateCooldowns()
    if
        self.lastUpdateTimes.UpdateCooldownsThrottle
        and (GetTime() - self.lastUpdateTimes.UpdateCooldownsThrottle) < UPDATE_THROTTLE_DELAY
    then
        return
    end

    self.lastUpdateTimes.UpdateCooldownsThrottle = GetTime()
    for _, ivf in ipairs(self.iconFrames) do
        ivf:UpdateCooldown()
    end
end

function TrackerInstance:RefreshEntries()
    if not self.anchor then
        return
    end
    if
        self.lastUpdateTimes.RefreshEntriesThrottle
        and (GetTime() - self.lastUpdateTimes.RefreshEntriesThrottle) < UPDATE_THROTTLE_DELAY
    then
        return
    end

    self.lastUpdateTimes.RefreshEntriesThrottle = GetTime()

    local owned = ItemsData:ScanOwnedItems()
    ItemsData:EnsureTrackedItems(owned)
    local entries = self.getEntriesFn(owned)

    local iconSize = self:GetIconSize()
    local padding = self:GetIconPadding()
    local orientation = self:GetOrientation()
    local showGCD = self:GetShowGCD()
    local count = #entries

    for i = 1, count do
        if not self.iconFrames[i] then
            self.iconFrames[i] = ItemViewerFrame:New(self.anchor)
        end
        local ivf = self.iconFrames[i]
        ivf.frame:SetSize(iconSize, iconSize)
        ivf.frame.IconOverlay:SetSize(iconSize*1.5, iconSize*1.5)
        ivf.frame.showGCD = showGCD

        local db = DB.GetDB()

        ivf:UpdateEntry(entries[i])
        self:UpdateIconPosition(ivf.frame, i)
    end

    for i = count + 1, #self.iconFrames do
        self.iconFrames[i]:UpdateEntry(nil)
    end

    local isHorizontal = orientation == "Horizontal Right"
        or orientation == "Horizontal Left"
        or orientation == "Horizontal Center"
    local totalSize = count > 0 and (count * iconSize + (count - 1) * padding) or iconSize
    if isHorizontal then
        self.anchor:SetSize(totalSize, iconSize)
    else
        self.anchor:SetSize(iconSize, totalSize)
    end

    self.anchor:SetShown(count > 0 or self.anchor._CMCTracker_ForceShow)
    ns.Keybinds:UpdateAllKeybinds()
end

function TrackerInstance:RefreshStyling()
    for _, ivf in ipairs(self.iconFrames) do
        if ivf.frame:IsShown() then
            ApplyStyleToFrame(ivf.frame)
            ApplyStackFontToFrame(ivf.frame)
            ApplyCooldownFontToFrame(ivf.frame)
        end
    end
end

function TrackerInstance:UpdateIconLayout()
    local iconSize = self:GetIconSize()
    for _, ivf in ipairs(self.iconFrames) do
        ivf.frame:SetSize(iconSize, iconSize)
        ivf.frame.IconOverlay:SetSize(iconSize*1.5, iconSize*1.5)
    end
    self:RefreshEntries()
end

function TrackerInstance:Create()
    if self.anchor then
        return
    end

    local DEFAULT_CONFIG = {
        alpha = 1,
        point = "CENTER",
        x = 0,
        y = 200,
        scale = 1,
        strata = "MEDIUM",
        iconSize = DEFAULT_ICON_SIZE,
        iconPadding = DEFAULT_ICON_PADDING,
        orientation = "Horizontal Right",
        anchoredToTracker1 = false,
        anchoredToTracker1Spacing = DEFAULT_ICON_PADDING,
    }

    WilduUICore.LoadFrameConfig(self.configKey, DEFAULT_CONFIG)
    local iconSize = self:GetIconSize()

    self.anchor = CreateFrame("Frame", self.frameName, UIParent, "BackdropTemplate")

    self.anchor.editModeName = self.editModeName

    self.anchor:SetSize(iconSize, iconSize)
    self.anchor:SetClampedToScreen(true)

    self.anchor:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
    self.anchor:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    self.anchor:RegisterEvent("SPELL_UPDATE_CHARGES")
    self.anchor:RegisterEvent("ITEM_LOCKED")
    self.anchor:RegisterEvent("BAG_UPDATE_DELAYED")
    self.anchor:RegisterEvent("BAG_UPDATE_COOLDOWN")
    self.anchor:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.anchor:RegisterEvent("TRAIT_CONFIG_UPDATED")
    self.anchor:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

    self.anchor:SetScript("OnEvent", function(_, event, arg1)
        if event == "SPELL_UPDATE_COOLDOWN" or event == "SPELL_UPDATE_CHARGES" or event == "BAG_UPDATE_COOLDOWN" then
            self:UpdateCooldowns()
            C_Timer.After(UPDATE_THROTTLE_DELAY + 0.01, function()
                self:UpdateCooldowns()
            end)
        elseif event == "PLAYER_ENTERING_WORLD" then
            self:RefreshEntries()
            C_Timer.After(5, function()
                self:RefreshEntries()
            end)
        elseif event == "ITEM_LOCKED" then
            self:RefreshEntries()
            C_Timer.After(0.5, function()
                self:RefreshEntries()
            end)
        elseif event == "BAG_UPDATE_DELAYED" then
            C_Timer.After(0.2, function()
                self:RefreshEntries()
            end)
        elseif
            event == "TRAIT_CONFIG_UPDATED"
            or event == "PLAYER_SPECIALIZATION_CHANGED"
            or event == "PLAYER_TALENT_UPDATE"
            or event == "ACTIVE_TALENT_GROUP_CHANGED"
        then
            if ItemsData and ItemsData.InvalidateSpellBookCache then
                ItemsData:InvalidateSpellBookCache()
            end
            self:RefreshEntries()
            C_Timer.After(0.3, function()
                self:RefreshEntries()
            end)
        else
            self:RefreshEntries()
        end
    end)

    WilduUICore.ApplyFramePosition(self.anchor, self.configKey, false)

    WilduUICore.RegisterEditModeCallbacks(self.anchor, self.configKey, function()
        return true
    end, function()
        return not ns.db.profile.editMode[self.configKey].anchoredToTracker1
    end)

    local configKey = self.configKey
    local anchor = self.anchor
    local instance = self

    local RELATIVE_FACTORS = {
        LEFT = { x = 0, y = -0.5 },
        RIGHT = { x = -1, y = -0.5 },
        TOP = { x = -0.5, y = -1 },
        BOTTOM = { x = -0.5, y = 0 },
    }

    local function OnPositionChanged(frame, layoutName, _point, _x, _y)
        local orientation = instance:GetOrientation()
        local anchorData = ORIENTATION_ANCHORS[orientation] or ORIENTATION_ANCHORS["Horizontal Right"]
        local anchorPrimary = (anchorData and anchorData.primary) or "RIGHT"

        if ns.db.profile.editMode[configKey].anchoredToTracker1 then
            local x, y
            local spacing = ns.db.profile.editMode[configKey].anchoredToTracker1Spacing or DEFAULT_ICON_PADDING
            if anchorPrimary == "LEFT" then
                x = ns.db.profile.editMode[configKey].anchoredToTracker1Spacing
                y = 0
            elseif anchorPrimary == "RIGHT" then
                x = -ns.db.profile.editMode[configKey].anchoredToTracker1Spacing
                y = 0
            elseif anchorPrimary == "TOP" then
                x = 0
                y = -ns.db.profile.editMode[configKey].anchoredToTracker1Spacing
            else
                x = 0
                y = ns.db.profile.editMode[configKey].anchoredToTracker1Spacing
            end
            frame:SetClampedToScreen(true)
            frame:ClearAllPoints()
            frame:SetPoint(anchorPrimary, _G["CMCTracker1"], OPPOSITE_ANCHOR[anchorPrimary], x, y)
            return
        end
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

    local additionalSettings = {
        {
            name = "Icon Size",
            kind = LEM.SettingType.Slider,
            default = DEFAULT_ICON_SIZE,
            get = function()
                return ns.db.profile.editMode[configKey].iconSize or DEFAULT_ICON_SIZE
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].iconSize = value
                instance:UpdateIconLayout()
            end,
            minValue = 16,
            maxValue = 80,
            valueStep = 2,
            formatter = function(value)
                return string.format("%d px", value)
            end,
        },
        {
            name = "Icon Padding",
            kind = LEM.SettingType.Slider,
            default = DEFAULT_ICON_PADDING,
            get = function()
                return ns.db.profile.editMode[configKey].iconPadding or DEFAULT_ICON_PADDING
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].iconPadding = value
                instance:RefreshEntries()
            end,
            minValue = 0,
            maxValue = 20,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d px", value)
            end,
        },
        {
            name = "Orientation",
            kind = LEM.SettingType.Dropdown,
            default = DEFAULT_CONFIG.orientation,
            get = function()
                return ns.db.profile.editMode[configKey].orientation or DEFAULT_CONFIG.orientation
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].orientation = value
                OnPositionChanged(anchor, configKey)
                instance:RefreshEntries()
            end,
            values = {
                { text = "Horizontal Right" },
                { text = "Horizontal Center" },
                { text = "Horizontal Left" },
                { text = "Vertical Down" },
                { text = "Vertical Up" },
            },
        },
        {
            name = "Alpha",
            kind = LEM.SettingType.Slider,
            default = DEFAULT_CONFIG.alpha,
            get = function()
                return ns.db.profile.editMode[configKey].alpha or DEFAULT_CONFIG.alpha
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].alpha = value
                anchor:SetAlpha(value)
            end,
            minValue = 0.1,
            maxValue = 1,
            valueStep = 0.01,
            formatter = function(value)
                return string.format("%.2f", value)
            end,
        },
        {
            name = "Show GCD",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.editMode[configKey].showGCD or false
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].showGCD = value
                instance:RefreshEntries()
            end,
        },
        {
            name = "Styling",
            kind = LEM.SettingType.Divider,
        },
        {
            name = "Square Icons",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.trinketRacialTracker_squareIcons or false
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_squareIcons = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
        },
        {
            name = "Border Thickness",
            kind = LEM.SettingType.Slider,
            default = 1,
            get = function()
                return ns.db.profile.trinketRacialTracker_borderThickness or 1
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_borderThickness = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            minValue = 0,
            maxValue = 6,
            valueStep = 1,
            formatter = function(value)
                return string.format("%dpx", value)
            end,
        },
        {
            name = "Icon Zoom",
            kind = LEM.SettingType.Slider,
            default = 0.3,
            get = function()
                return ns.db.profile.trinketRacialTracker_iconZoom or 0.3
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_iconZoom = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            minValue = 0,
            maxValue = 0.5,
            valueStep = 0.01,
            formatter = function(value)
                return string.format("%.2f", value)
            end,
        },
        {
            name = "Stack Number",
            kind = LEM.SettingType.Divider,
        },
        {
            name = "Stack Anchor",
            kind = LEM.SettingType.Dropdown,
            default = "BOTTOMRIGHT",
            get = function()
                return ns.db.profile.trinketRacialTracker_stackAnchor or "BOTTOMRIGHT"
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_stackAnchor = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            values = {
                { text = "Top Left", value = "TOPLEFT" },
                { text = "Top", value = "TOP" },
                { text = "Top Right", value = "TOPRIGHT" },
                { text = "Left", value = "LEFT" },
                { text = "Center", value = "CENTER" },
                { text = "Right", value = "RIGHT" },
                { text = "Bottom Left", value = "BOTTOMLEFT" },
                { text = "Bottom", value = "BOTTOM" },
                { text = "Bottom Right", value = "BOTTOMRIGHT" },
            },
        },
        {
            name = "Stack Font Size",
            kind = LEM.SettingType.Slider,
            default = 14,
            get = function()
                return ns.db.profile.trinketRacialTracker_stackFontSize or 14
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_stackFontSize = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            minValue = 8,
            maxValue = 32,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = "Stack X Offset",
            kind = LEM.SettingType.Slider,
            default = -1,
            get = function()
                return ns.db.profile.trinketRacialTracker_stackOffsetX or -1
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_stackOffsetX = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            minValue = -40,
            maxValue = 40,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = "Stack Y Offset",
            kind = LEM.SettingType.Slider,
            default = 1,
            get = function()
                return ns.db.profile.trinketRacialTracker_stackOffsetY or 1
            end,
            set = function(layoutName, value)
                ns.db.profile.trinketRacialTracker_stackOffsetY = value
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            minValue = -40,
            maxValue = 40,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = "Cooldown Numbers",
            kind = LEM.SettingType.Divider,
        },
        {
            name = "Override Cooldown Number Size",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_cooldownFontSizeTracker_enabled
            end,
            set = function(layoutName, value)
                ns.db.profile.cooldownManager_cooldownFontSizeTracker_enabled = value
                if not value and ns.API and ns.API.ShowReloadUIConfirmation then
                    ns.API:ShowReloadUIConfirmation()
                end
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
        },
        {
            name = "Number Size",
            kind = LEM.SettingType.Dropdown,
            default = "NIL",
            get = function()
                return ns.db.profile.cooldownManager_cooldownFontSizeTracker ~= nil
                        and tostring(ns.db.profile.cooldownManager_cooldownFontSizeTracker)
                    or "NIL"
            end,
            set = function(layoutName, value)
                if value == "NIL" then
                    ns.db.profile.cooldownManager_cooldownFontSizeTracker = "NIL"
                else
                    local n = tonumber(value)
                    ns.db.profile.cooldownManager_cooldownFontSizeTracker = n
                end
                if ns.TrackerItemViewer then
                    ns.TrackerItemViewer:RefreshStyling()
                end
            end,
            values = {
                { text = "Default", value = "NIL" },
                { text = "Hide", value = "0" },
                { text = "10", value = "10" },
                { text = "12", value = "12" },
                { text = "14", value = "14" },
                { text = "16", value = "16" },
                { text = "18", value = "18" },
                { text = "20", value = "20" },
                { text = "22", value = "22" },
                { text = "24", value = "24" },
                { text = "26", value = "26" },
                { text = "28", value = "28" },
                { text = "30", value = "30" },
                { text = "32", value = "32" },
                { text = "34", value = "34" },
                { text = "36", value = "36" },
                { text = "38", value = "38" },
            },
        },
        {
            name = "Keybinds",
            kind = LEM.SettingType.Divider,
        },
        {
            name = "Show Keybinds",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.cooldownManager_showKeybinds_CMCTracker
            end,
            set = function(layoutName, value)
                ns.db.profile.cooldownManager_showKeybinds_CMCTracker = value
                if ns.Keybinds then
                    ns.Keybinds:OnSettingChanged("CMCTracker1")
                    ns.Keybinds:OnSettingChanged("CMCTracker2")
                end
                if not value and ns.API and ns.API.ShowReloadUIConfirmation then
                    ns.API:ShowReloadUIConfirmation()
                end
            end,
        },
        {
            name = "Keybind Anchor",
            kind = LEM.SettingType.Dropdown,
            default = "TOPRIGHT",
            get = function()
                return ns.db.profile.cooldownManager_keybindAnchor_CMCTracker or "TOPRIGHT"
            end,
            set = function(layoutName, value)
                ns.db.profile.cooldownManager_keybindAnchor_CMCTracker = value
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker1")
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker2")
                end
            end,
            values = {
                { text = "Top Left", value = "TOPLEFT" },
                { text = "Top", value = "TOP" },
                { text = "Top Right", value = "TOPRIGHT" },
                { text = "Left", value = "LEFT" },
                { text = "Center", value = "CENTER" },
                { text = "Right", value = "RIGHT" },
                { text = "Bottom Left", value = "BOTTOMLEFT" },
                { text = "Bottom", value = "BOTTOM" },
                { text = "Bottom Right", value = "BOTTOMRIGHT" },
            },
        },
        {
            name = "Keybind Font Size",
            kind = LEM.SettingType.Dropdown,
            default = "10",
            get = function()
                return tostring(ns.db.profile.cooldownManager_keybindFontSize_CMCTracker or 10)
            end,
            set = function(layoutName, value)
                local n = tonumber(value)
                ns.db.profile.cooldownManager_keybindFontSize_CMCTracker = n and math.floor(n + 0.5) or 14
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker1")
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker2")
                end
            end,
            values = {
                { text = "6", value = "6" },
                { text = "8", value = "8" },
                { text = "10", value = "10" },
                { text = "12", value = "12" },
                { text = "14", value = "14" },
                { text = "16", value = "16" },
                { text = "18", value = "18" },
                { text = "20", value = "20" },
                { text = "22", value = "22" },
                { text = "24", value = "24" },
                { text = "26", value = "26" },
                { text = "28", value = "28" },
                { text = "30", value = "30" },
                { text = "32", value = "32" },
            },
        },
        {
            name = "Keybind X Offset",
            kind = LEM.SettingType.Slider,
            default = -3,
            get = function()
                return ns.db.profile.cooldownManager_keybindOffsetX_CMCTracker or -3
            end,
            set = function(layoutName, value)
                local v = math.floor((value or 0) + 0.5)
                ns.db.profile.cooldownManager_keybindOffsetX_CMCTracker = v
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker1")
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker2")
                end
            end,
            minValue = -40,
            maxValue = 40,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
        {
            name = "Keybind Y Offset",
            kind = LEM.SettingType.Slider,
            default = -3,
            get = function()
                return ns.db.profile.cooldownManager_keybindOffsetY_CMCTracker or -3
            end,
            set = function(layoutName, value)
                local v = math.floor((value or 0) + 0.5)
                ns.db.profile.cooldownManager_keybindOffsetY_CMCTracker = v
                if ns.Keybinds then
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker1")
                    ns.Keybinds:ApplyKeybindSettings("CMCTracker2")
                end
            end,
            minValue = -40,
            maxValue = 40,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        },
    }
    if configKey == "tracker2" then
        tinsert(additionalSettings, {
            name = "Anchor to Tracker 1",
            kind = LEM.SettingType.Checkbox,
            default = false,
            get = function()
                return ns.db.profile.editMode[configKey].anchoredToTracker1 or false
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].anchoredToTracker1 = value
                OnPositionChanged(anchor, configKey)
                instance:RefreshEntries()
            end,
        })
        tinsert(additionalSettings, {
            name = "Spacing",
            kind = LEM.SettingType.Slider,
            default = DEFAULT_ICON_PADDING,
            get = function()
                return ns.db.profile.editMode[configKey].anchoredToTracker1Spacing or DEFAULT_ICON_PADDING
            end,
            set = function(layoutName, value)
                ns.db.profile.editMode[configKey].anchoredToTracker1Spacing = value
                OnPositionChanged(anchor, configKey)
                instance:RefreshEntries()
            end,
            minValue = 0,
            maxValue = 96,
            valueStep = 1,
            formatter = function(value)
                return string.format("%d", value)
            end,
        })
    end

    WilduUICore.RegisterFrameWithLEM(self.anchor, self.configKey, additionalSettings, OnPositionChanged)

    if ns.db.profile.editMode[configKey].anchoredToTracker1 then
        OnPositionChanged(self.anchor, self.configKey)
    end
    self:RefreshEntries()
end

local tracker1 = TrackerInstance:New("tracker1", "CMCTracker1", function(owned)
    return ItemsData:GetTracker1Entries(owned)
end)

local tracker2 = TrackerInstance:New("tracker2", "CMCTracker2", function(owned)
    return ItemsData:GetTracker2Entries(owned)
end)

local trackers = { tracker1, tracker2 }
local spellCastEventFrame = nil

local function EnsureSpellCastListener()
    if spellCastEventFrame then
        return
    end

    spellCastEventFrame = CreateFrame("Frame")
    spellCastEventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
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

function ItemViewer:RefreshItemViewerFrames()
    for _, tracker in ipairs(trackers) do
        tracker:RefreshEntries()
    end
end

function ItemViewer:RefreshStyling()
    for _, tracker in ipairs(trackers) do
        tracker:RefreshStyling()
    end
end

function ItemViewer:Initialize()
    if not ns.db.profile.tracker_enabled then
        return
    end

    EnsureSpellCastListener()

    for _, tracker in ipairs(trackers) do
        tracker:Create()
    end
end
