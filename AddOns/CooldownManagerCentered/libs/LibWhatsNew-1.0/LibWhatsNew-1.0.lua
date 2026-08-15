local MAJOR, MINOR = "LibWhatsNew-1.0", 2
local Lib = LibStub:NewLibrary(MAJOR, MINOR)
if not Lib then
    return
end

Lib.queue = Lib.queue or {}

local DEFAULT_WIDTH = 560
local DEFAULT_PREVIEW_WIDTH = 440
local DEFAULT_PREVIEW_HEIGHT = 248

local function ParseVersion(version)
    local parts = {}
    for part in tostring(version or "0"):gmatch("%d+") do
        parts[#parts + 1] = tonumber(part)
    end
    return parts
end

local function CompareVersions(left, right)
    local leftParts = ParseVersion(left)
    local rightParts = ParseVersion(right)
    local partCount = math.max(#leftParts, #rightParts)

    for index = 1, partCount do
        local leftPart = leftParts[index] or 0
        local rightPart = rightParts[index] or 0
        if leftPart ~= rightPart then
            return leftPart < rightPart and -1 or 1
        end
    end

    return 0
end

local function GetPathValue(root, path)
    if type(path) == "string" then
        local value = root
        for key in path:gmatch("[^.]+") do
            if type(value) ~= "table" then
                return nil
            end
            value = value[key]
        end
        return value
    end

    local value = root
    for _, key in ipairs(path or {}) do
        if type(value) ~= "table" then
            return nil
        end
        value = value[key]
    end
    return value
end

local function SetPathValue(root, path, newValue)
    local keys = {}
    if type(path) == "string" then
        for key in path:gmatch("[^.]+") do
            keys[#keys + 1] = key
        end
    else
        keys = path or keys
    end

    local target = root
    for index = 1, #keys - 1 do
        local key = keys[index]
        if type(target[key]) ~= "table" then
            target[key] = {}
        end
        target = target[key]
    end

    if keys[#keys] then
        target[keys[#keys]] = newValue
    end
end

local function IsFeatureEnabled(options, feature)
    if feature.isEnabled then
        return feature.isEnabled(options.configRoot) == true
    end
    if not feature.configPath then
        return false
    end
    return GetPathValue(options.configRoot, feature.configPath) == true
end

local function CollectItems(options)
    local releases = {}
    for _, release in ipairs(options.versions or {}) do
        releases[#releases + 1] = release
    end
    table.sort(releases, function(left, right)
        return CompareVersions(left.version, right.version) < 0
    end)

    local lastSeen = options.savedVariables[options.lastSeenKey]
    local currentVersion = options.currentVersion or releases[#releases] and releases[#releases].version or "0"
    local newestVersion = lastSeen
    local items = {}

    for _, release in ipairs(releases) do
        local isUnseen = CompareVersions(release.version, lastSeen) > 0
        local isReleased = CompareVersions(release.version, currentVersion) <= 0
        if isUnseen and isReleased then
            newestVersion = release.version
            for _, feature in ipairs(release.features or {}) do
                if not IsFeatureEnabled(options, feature) then
                    items[#items + 1] = {
                        feature = feature,
                        version = release.version,
                    }
                end
            end
        end
    end

    return items, newestVersion
end

local function CreateDialog(options)
    local existing = _G[options.frameName]
    if existing then
        return existing
    end

    local frame = CreateFrame("Frame", options.frameName, UIParent, "BackdropTemplate")
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:SetToplevel(true)
    frame:EnableMouse(true)
    frame:SetPoint("CENTER")
    frame:SetWidth(options.width or DEFAULT_WIDTH)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })
    frame:SetBackdropColor(0.03, 0.03, 0.03, 0.98)
    frame:Hide()

    frame.Title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.Title:SetPoint("TOP", 0, -24)
    frame.Title:SetText(options.title or ("Whats new in " .. options.addonName))

    frame.Version = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    frame.Version:SetPoint("TOP", frame.Title, "BOTTOM", 0, -5)

    frame.FeatureTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalMed3")
    frame.FeatureTitle:SetPoint("TOP", frame.Version, "BOTTOM", 0, -18)
    frame.FeatureTitle:SetWidth((options.width or DEFAULT_WIDTH) - 64)
    frame.FeatureTitle:SetWordWrap(true)

    frame.Preview = frame:CreateTexture(nil, "ARTWORK")

    frame.Description = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.Description:SetWidth((options.width or DEFAULT_WIDTH) - 72)
    frame.Description:SetJustifyH("LEFT")
    frame.Description:SetJustifyV("TOP")
    frame.Description:SetWordWrap(true)

    frame.PrimaryButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.PrimaryButton:SetSize(150, 24)
    frame.PrimaryButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -6, 24)

    frame.SecondaryButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.SecondaryButton:SetSize(150, 24)
    frame.SecondaryButton:SetPoint("BOTTOMLEFT", frame, "BOTTOM", 6, 24)

    return frame
end

local function FinishRequest(self)
    local request = self.active
    if not request then
        return
    end

    request.options.savedVariables[request.options.lastSeenKey] = request.newestVersion
    if request.options.onFinished then
        request.options.onFinished()
    end

    request.frame:Hide()
    self.active = nil
    self:ShowNext()
end

local function ShowItem(self)
    local request = self.active
    local item = request.items[request.index]
    if not item then
        FinishRequest(self)
        return
    end

    local frame = request.frame
    local feature = item.feature
    local previewWidth = feature.previewWidth or request.options.previewWidth or DEFAULT_PREVIEW_WIDTH
    local previewHeight = feature.previewHeight or request.options.previewHeight or DEFAULT_PREVIEW_HEIGHT
    local dialogWidth = math.max(request.options.width or DEFAULT_WIDTH, previewWidth + 72)

    frame:SetWidth(dialogWidth)
    frame.FeatureTitle:SetWidth(dialogWidth - 64)
    frame.Description:SetWidth(dialogWidth - 72)
    frame.Version:SetFormattedText("Version %s  •  %d / %d", item.version, request.index, #request.items)
    frame.FeatureTitle:SetText(feature.title or "")
    frame.Preview:ClearAllPoints()
    frame.Description:ClearAllPoints()

    if feature.preview then
        frame.Preview:SetTexture(feature.preview)
        frame.Preview:SetSize(previewWidth, previewHeight)
        frame.Preview:SetPoint("TOP", frame.FeatureTitle, "BOTTOM", 0, -14)
        frame.Preview:Show()
        frame.Description:SetPoint("TOP", frame.Preview, "BOTTOM", 0, -14)
    else
        frame.Preview:Hide()
        frame.Description:SetPoint("TOP", frame.FeatureTitle, "BOTTOM", 0, -14)
    end

    frame.Description:SetText(feature.description or "")
    local descriptionHeight = math.max(frame.Description:GetStringHeight(), 18)
    local contentHeight = feature.preview and previewHeight or 0
    frame:SetHeight(174 + contentHeight + descriptionHeight)

    local function Advance(enableFeature)
        if enableFeature and feature.configPath then
            SetPathValue(request.options.configRoot, feature.configPath, true)
            if feature.onEnable then
                feature.onEnable(request.options.configRoot)
            end
        end
        request.index = request.index + 1
        ShowItem(self)
    end

    if feature.configPath then
        frame.PrimaryButton:ClearAllPoints()
        frame.PrimaryButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -6, 24)
        frame.PrimaryButton:SetText(feature.enableText or "Enable")
        frame.PrimaryButton:SetScript("OnClick", function()
            Advance(true)
        end)
        frame.SecondaryButton:SetText(feature.disabledText or "Leave Disabled")
        frame.SecondaryButton:SetScript("OnClick", function()
            Advance(false)
        end)
        frame.SecondaryButton:Show()
    else
        frame.PrimaryButton:ClearAllPoints()
        frame.PrimaryButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 24)
        frame.PrimaryButton:SetText(feature.okText or "OK")
        frame.PrimaryButton:SetScript("OnClick", function()
            Advance(false)
        end)
        frame.SecondaryButton:Hide()
    end

    frame:Show()
    frame:Raise()
end

function Lib:ShowNext()
    if self.active then
        return
    end

    local request = table.remove(self.queue, 1)
    if not request then
        return
    end

    self.active = request
    request.frame = CreateDialog(request.options)
    ShowItem(self)
end

---Queue unseen release features for display.
---@param options table
---@return boolean queued
function Lib:Show(options)
    assert(type(options) == "table", MAJOR .. ": options must be a table")
    assert(type(options.frameName) == "string", MAJOR .. ": frameName is required")
    assert(type(options.savedVariables) == "table", MAJOR .. ": savedVariables is required")
    assert(type(options.configRoot) == "table", MAJOR .. ": configRoot is required")

    options.lastSeenKey = options.lastSeenKey or "lastSeenWhatsNewVersion"
    local items, newestVersion = CollectItems(options)
    if not newestVersion then
        return false
    end

    if #items == 0 then
        options.savedVariables[options.lastSeenKey] = newestVersion
        return false
    end

    self.queue[#self.queue + 1] = {
        options = options,
        items = items,
        newestVersion = newestVersion,
        index = 1,
    }
    self:ShowNext()
    return true
end

Lib.CompareVersions = CompareVersions
