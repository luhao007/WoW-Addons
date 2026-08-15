local _, ns = ...
local L = ns.L
local LibEditModeOverride = LibStub("LibEditModeOverride-1.0", true)

local EditModeHelp = {}
ns.EditModeHelp = EditModeHelp

local nativeLayoutWriteInProgress = false
local ignoreNextNativeLayoutHide = false
local nativePreviewInProgress = false
local nativeVisibilityNormalizationPending = false
local nativeVisibilityNormalizationQueued = false

local function IsEditModeHelperEnabled()
    -- return ns.db.profile.editMode_helper_enabled ~= false
    return false -- remove it for now, seems bugged
end

local viewers = {
    {
        frame = BuffIconCooldownViewer,
        viewerName = "BuffIconCooldownViewer",
        native = true,
        nativeAnchorKey = "nativeBuffIcons",
        growthFrom = "cooldownManager_alignBuffIcons_growFromDirection",
        useAlignmentAnchor = true,
    },
    {
        frame = EssentialCooldownViewer,
        viewerName = "EssentialCooldownViewer",
        native = true,
        nativeAnchorKey = "nativeEssential",
        growthFrom = "cooldownManager_centerEssential_growFromDirection",
    },
    {
        frame = UtilityCooldownViewer,
        viewerName = "UtilityCooldownViewer",
        native = true,
        nativeAnchorKey = "nativeUtility",
        growthFrom = "cooldownManager_centerUtility_growFromDirection",
    },
    {
        frame = BuffBarCooldownViewer,
        viewerName = "BuffBarCooldownViewer",
        native = true,
        nativeAnchorKey = "nativeBuffBar",
        growthFrom = "cooldownManager_alignBuffBars_growFromDirection",
    },
}

local function GetAlignmentPoint(frame, growFromDirection)
    local isHorizontal = not frame.IsHorizontal or frame:IsHorizontal()
    if growFromDirection == "START" then
        return isHorizontal and "LEFT" or "BOTTOM"
    elseif growFromDirection == "END" then
        return isHorizontal and "RIGHT" or "TOP"
    end
    return "CENTER"
end

local function GetAlignmentPointAndOffset(frame, growFromDirection)
    local point = GetAlignmentPoint(frame, growFromDirection)
    local frameX, frameY = frame:GetCenter()
    local parentX, parentY = UIParent:GetCenter()

    if point == "LEFT" then
        frameX, parentX = frame:GetLeft(), UIParent:GetLeft()
    elseif point == "RIGHT" then
        frameX, parentX = frame:GetRight(), UIParent:GetRight()
    elseif point == "BOTTOM" then
        frameY, parentY = frame:GetBottom(), UIParent:GetBottom()
    elseif point == "TOP" then
        frameY, parentY = frame:GetTop(), UIParent:GetTop()
    end

    if not frameX or not frameY or not parentX or not parentY then
        return nil
    end
    return {
        point = point,
        relativeTo = UIParent,
        relativePoint = point,
        x = frameX - parentX,
        y = frameY - parentY,
    }
end

local function GetPointAndOffset(frame, growFromDirection, useAlignmentAnchor)
    local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint(1)
    if not point or not relativeTo then
        return nil
    end

    -- If Blizzard (or another valid frame) already owns the viewer's anchor,
    -- preserve that exact anchor. CMC only replaces the anchor fields.
    if relativeTo ~= UIParent then
        return {
            point = point,
            relativeTo = relativeTo,
            relativePoint = relativePoint,
            x = offsetX or 0,
            y = offsetY or 0,
        }
    end

    -- Match custom buff containers: pin the footprint to the edge it grows
    -- from, so changing the number of tracked buffs does not move that edge.
    if useAlignmentAnchor then
        return GetAlignmentPointAndOffset(frame, growFromDirection)
    end

    local y = nil
    point = nil

    if growFromDirection == "BOTTOM" then
        point = "BOTTOM"
    else
        point = "TOP"
    end
    if point == "BOTTOM" then
        y = frame:GetBottom()
    else
        y = frame:GetTop()
    end

    local x = frame:GetCenter()
    local pX = UIParent:GetCenter()
    return {
        point = point,
        relativeTo = UIParent,
        relativePoint = "BOTTOM",
        x = x - pX,
        y = y,
    }
end

local function LoadNativeLayouts()
    if not LibEditModeOverride or not LibEditModeOverride.IsReady or not LibEditModeOverride:IsReady() then
        return false
    end
    return pcall(LibEditModeOverride.LoadLayouts, LibEditModeOverride)
end

local function CanEditNativeLayout()
    if not LoadNativeLayouts() or not LibEditModeOverride.CanEditActiveLayout then
        return false
    end
    local ok, canEdit = pcall(LibEditModeOverride.CanEditActiveLayout, LibEditModeOverride)
    return ok and canEdit == true
end

local function GetNativeAnchorData(frame, viewerInfo)
    if ns.Anchoring and ns.Anchoring.GetNativeAnchorData then
        local configured = ns.Anchoring:GetNativeAnchorData(viewerInfo.viewerName)
        if configured then
            return configured
        end

        -- If an explicit CMC anchor exists but its target is currently
        -- unavailable, do not silently replace it with a UIParent anchor.
        if viewerInfo.nativeAnchorKey and ns.Anchoring:HasTarget(viewerInfo.nativeAnchorKey) then
            return nil
        end
    end

    local growthFrom = ns.db.profile[viewerInfo.growthFrom]
    if not viewerInfo.growthFrom or not growthFrom or growthFrom == "Disable" then
        return nil
    end
    return GetPointAndOffset(frame, growthFrom, viewerInfo.useAlignmentAnchor)
end

local function AddCMCOutOfCombatVisibility(viewerName)
    if not ns.db or not ns.db.profile then
        return false
    end

    local profile = ns.db.profile
    local perViewer = profile.cooldownManager_visibility_perViewer
    if not perViewer then
        perViewer = {}
        profile.cooldownManager_visibility_perViewer = perViewer
    end

    local rules = perViewer[viewerName]
    if type(rules) ~= "table" then
        rules = {}
        perViewer[viewerName] = rules
    end

    if rules.HIDE_OUT_OF_COMBAT then
        return false
    end

    -- Merge this rule into the existing CMC rules. The native Edit Mode
    -- visibility is only the source of this migration; it must not erase any
    -- user-selected CMC rules for the same viewer.
    rules.HIDE_OUT_OF_COMBAT = true
    return true
end

local function GetNativeVisibilitySettingValues()
    local cooldownViewerSetting = Enum and Enum.EditModeCooldownViewerSetting
    local visibleSetting = Enum and Enum.CooldownViewerVisibleSetting
    if not cooldownViewerSetting or not visibleSetting then
        return nil
    end
    return cooldownViewerSetting.VisibleSetting, visibleSetting.InCombat, visibleSetting.Always
end

local function ApplyNativeLayoutChanges(applyAnchors, applyVisibility)
    if not IsEditModeHelperEnabled() then
        return false, "disabled"
    end
    if nativeLayoutWriteInProgress or ignoreNextNativeLayoutHide then
        return false, "busy"
    end
    if EditModeManagerFrame and EditModeManagerFrame:IsShown() then
        return false, "deferred"
    end
    -- ApplyChanges() briefly shows EditModeManagerFrame. If Blizzard's
    -- CooldownViewerSettings is already open, that center panel would close
    -- the settings panel through CloseWindows(). Wait until it is closed.
    if _G.CooldownViewerSettings and _G.CooldownViewerSettings:IsShown() then
        return false, "deferred"
    end
    if InCombatLockdown() then
        return false, "deferred"
    end

    local pending = {}
    if applyAnchors then
        -- With all four viewers set to alignment=Disable and anchor=None this
        -- remains empty, so the visibility-only migration never creates an
        -- anchor or changes any anchor-related Edit Mode property.
        for _, viewerInfo in ipairs(viewers) do
            if viewerInfo.native then
                local frame = viewerInfo.frame
                if frame and frame.IsInitialized and frame:IsInitialized() then
                    local data = GetNativeAnchorData(frame, viewerInfo)
                    if data then
                        pending[#pending + 1] = { frame = frame, data = data }
                    end
                end
            end
        end
    end

    local visibleSetting, inCombatValue, alwaysValue = GetNativeVisibilitySettingValues()
    if applyVisibility and (not visibleSetting or inCombatValue == nil or alwaysValue == nil) then
        return false, "not_ready"
    end
    if not applyVisibility and #pending == 0 then
        return false, "done"
    end

    -- LoadLayouts() is deliberately called after Edit Mode has closed. This
    -- refreshes the current Blizzard layout first, so CMC can replace only
    -- the requested anchor/visibility fields and preserve icon sizes, padding,
    -- spacing, and all other Edit Mode settings the user just saved.
    if not LibEditModeOverride or not LibEditModeOverride.IsReady or not LibEditModeOverride:IsReady() then
        return false, "not_ready"
    end
    if not CanEditNativeLayout() then
        return false, "not_editable"
    end

    local changed = false
    local visibilityChanged = {}

    if applyVisibility then
        for _, viewerInfo in ipairs(viewers) do
            if viewerInfo.native and viewerInfo.frame then
                local ok, currentValue = pcall(LibEditModeOverride.GetFrameSetting, LibEditModeOverride, viewerInfo.frame, visibleSetting)
                if ok and currentValue == inCombatValue then
                    local setOK = pcall(LibEditModeOverride.SetFrameSetting, LibEditModeOverride, viewerInfo.frame, visibleSetting, alwaysValue)
                    if setOK then
                        changed = true
                        visibilityChanged[#visibilityChanged + 1] = viewerInfo.viewerName
                    end
                end
            end
        end
    end

    for _, item in ipairs(pending) do
        local data = item.data
        local ok = pcall(LibEditModeOverride.ReanchorFrame, LibEditModeOverride, item.frame, data.point, data.relativeTo, data.relativePoint, data.x, data.y)
        changed = ok or changed
    end

    if #visibilityChanged > 0 then
        local forceViewers = {}
        for _, viewerName in ipairs(visibilityChanged) do
            AddCMCOutOfCombatVisibility(viewerName)
            forceViewers[viewerName] = true
        end
        if ns.CMCVisibility then
            ns.CMCVisibility:Initialize(forceViewers)
        end
    end

    if not changed then
        return false, "done"
    end

    nativeLayoutWriteInProgress = true
    ignoreNextNativeLayoutHide = true
    local ok = pcall(LibEditModeOverride.ApplyChanges, LibEditModeOverride)
    nativeLayoutWriteInProgress = false
    if not ok then
        ignoreNextNativeLayoutHide = false
        return false, "failed"
    end
    return true, "done"
end

local function ApplyConfiguredNativeAnchors()
    -- A normal Edit Mode exit applies both CMC anchors and the native
    -- visibility normalization in one freshly-loaded layout snapshot and one
    -- ApplyChanges() call.
    return ApplyNativeLayoutChanges(true, true)
end

function EditModeHelp:NormalizeNativeCombatVisibility()
    return ApplyNativeLayoutChanges(false, true)
end

local function QueueNativeVisibilityNormalization(delay)
    nativeVisibilityNormalizationPending = true

    -- Never write the Edit Mode layout while its editor is open. The Hide hook
    -- below will fold this pending check into the same save as any CMC anchors.
    if EditModeManagerFrame and EditModeManagerFrame:IsShown() then
        return
    end
    if nativeVisibilityNormalizationQueued then
        return
    end

    nativeVisibilityNormalizationQueued = true
    C_Timer.After(delay or 0.1, function()
        nativeVisibilityNormalizationQueued = false
        if not nativeVisibilityNormalizationPending then
            return
        end

        local _, status = EditModeHelp:NormalizeNativeCombatVisibility()
        if status == "done" or status == "not_editable" or status == "disabled" then
            nativeVisibilityNormalizationPending = false
        elseif status == "not_ready" or status == "failed" then
            -- The Blizzard Edit Mode data can finish loading a little after
            -- PLAYER_LOGIN. Retry once the library becomes ready; no layout
            -- mutation is attempted until then.
            QueueNativeVisibilityNormalization(1)
        end
    end)
end

EventRegistry:RegisterCallback("CooldownViewerSettings.OnHide", function()
    if nativeVisibilityNormalizationPending then
        QueueNativeVisibilityNormalization()
    end
end)

local nativeVisibilityEventFrame = CreateFrame("Frame")
nativeVisibilityEventFrame:RegisterEvent("PLAYER_LOGIN")
nativeVisibilityEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
nativeVisibilityEventFrame:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
nativeVisibilityEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
nativeVisibilityEventFrame:SetScript("OnEvent", function(_, event)
    if nativeLayoutWriteInProgress or ignoreNextNativeLayoutHide then
        return
    end

    nativeVisibilityNormalizationPending = true
    if event == "EDIT_MODE_LAYOUTS_UPDATED" and EditModeManagerFrame and EditModeManagerFrame:IsShown() then
        return
    end
    QueueNativeVisibilityNormalization()
end)

local helpText = nil
local function GetHelpText()
    if not EditModeManagerFrame:GetAccountSettingValueBool(Enum.EditModeAccountSetting.SettingsExpanded) then
        return L['To edit Cooldown Manager\nclick "Expand options", and\nenable "Cooldown Manager" above']
    end
    return L['To edit Cooldown Manager\nenable "Cooldown Manager" above']
end
local function CreateHelpText()
    if not EditModeManagerFrame then
        return
    end
    if helpText then
        if not EditModeManagerFrame:GetAccountSettingValueBool(Enum.EditModeAccountSetting.ShowCooldownViewer) then
            helpText.text:SetText(GetHelpText())
        else
            helpText.text:SetText("")
        end
        return
    end
    helpText = CreateFrame("Frame", nil, EditModeManagerFrame)
    helpText:SetSize(400, 50)
    helpText:SetPoint("TOP", EditModeManagerFrame, "BOTTOM", 0, 20)
    helpText.text = helpText:CreateFontString(nil, "OVERLAY", "GameFontNormalLargeOutline")
    helpText.text:ClearAllPoints()
    helpText.text:SetAllPoints()
    helpText.text:SetText("")
    if not EditModeManagerFrame:GetAccountSettingValueBool(Enum.EditModeAccountSetting.ShowCooldownViewer) then
        helpText.text:SetText(GetHelpText())
    end
end
local arrowsForViewers = {}

for _, viewerInfo in ipairs(viewers) do
    local viewerName = viewerInfo.viewerName
    local newArrows = {
        top = {
            frame = CreateFrame("Frame", nil, UIParent),
            anchor = "BOTTOM",
        },
        left = {
            frame = CreateFrame("Frame", nil, UIParent),
            anchor = "RIGHT",
        },
        right = {
            frame = CreateFrame("Frame", nil, UIParent),
            anchor = "LEFT",
        },
        bottom = {
            frame = CreateFrame("Frame", nil, UIParent),
            anchor = "TOP",
        },
    }
    arrowsForViewers[viewerName] = newArrows
    for _, info in pairs(newArrows) do
        local frame = info.frame
        frame:SetParent(viewerInfo.frame)
    end
end
for _, viewerInfo in ipairs(viewers) do
    local viewerName = viewerInfo.viewerName
    local arrowFrames = arrowsForViewers[viewerName]
    for name, info in pairs(arrowFrames) do
        local frame = info.frame
        frame:SetSize(10, 14)
        frame:SetScale(1)
        frame.background = frame:CreateTexture(nil, "BACKGROUND")
        frame.background:ClearAllPoints()
        frame.background:SetAllPoints()
        frame.background:SetAtlas("bags-greenarrow", false)
        frame.background:SetRotation(name == "left" and math.pi / 2 or (name == "right" and -math.pi / 2 or (name == "bottom" and math.pi or 0)))
        frame:SetFrameStrata("HIGH")
        frame:Hide()
    end
end

local function UpdateFrameArrowsAnchors(forceHide)
    for _, viewerInfo in ipairs(viewers) do
        local point = viewerInfo.frame:GetPoint(1)

        local viewerName = viewerInfo.viewerName
        local arrowFrames = arrowsForViewers[viewerName]
        for name, info in pairs(arrowFrames) do
            info.frame:SetPoint(info.anchor, viewerInfo.frame, point, 0, 0)
            info.frame:SetScale(1)

            info.frame:SetSize(10, 14)
            info.frame.background:SetScale(1)
            if info.frame.BCDMBorders then
                local regions = { info.frame:GetRegions() }
                for _, region in ipairs(regions) do
                    if region ~= info.frame.background then
                        region:Hide()
                    else
                        region:SetScale(1)
                        region:SetSize(10, 14)
                    end
                end
            end
            local pointLower = string.lower(point)
            if forceHide or not ns.Runtime.isInEditMode or pointLower:find(name) or viewerInfo.frame.isDragging then
                info.frame:Hide()
            else
                info.frame:Show()
                info.frame:SetFrameStrata("HIGH")
            end
        end
    end
end

-- Live preview is intentionally a real frame SetPoint only. It keeps the
-- helper arrows in the right place while Edit Mode is open, but it does not
-- notify Blizzard's Edit Mode manager and therefore cannot change the saved
-- Edit Mode properties. Persistence is handled once from the Hide hook below.
local function UpdateViewerAnchor(frame, viewerInfo)
    if not EditModeManagerFrame or not EditModeManagerFrame:IsShown() then
        return false
    end
    if InCombatLockdown() or not frame or not frame.IsInitialized or not frame:IsInitialized() then
        return false
    end
    if frame.layoutApplyInProgress or (frame.CanBeMoved and not frame:CanBeMoved()) then
        return false
    end

    local data = GetNativeAnchorData(frame, viewerInfo)
    if not data then
        return false
    end

    local point, relativeTo, relativePoint, offsetX, offsetY = frame:GetPoint(1)
    if
        point == data.point
        and relativeTo == data.relativeTo
        and relativePoint == data.relativePoint
        and math.abs((offsetX or 0) - data.x) <= 0.01
        and math.abs((offsetY or 0) - data.y) <= 0.01
    then
        return false
    end

    nativePreviewInProgress = true
    frame:ClearAllPoints()
    frame:SetPoint(data.point, data.relativeTo, data.relativePoint, data.x, data.y)
    nativePreviewInProgress = false
    return true
end

function EditModeHelp:PreviewNativeViewerAnchors()
    if not EditModeManagerFrame or not EditModeManagerFrame:IsShown() then
        return false
    end

    local moved = false
    for _, viewerInfo in ipairs(viewers) do
        if viewerInfo.native and UpdateViewerAnchor(viewerInfo.frame, viewerInfo) then
            moved = true
        end
    end
    UpdateFrameArrowsAnchors()
    return moved
end

for _, viewerInfo in ipairs(viewers) do
    local frame = viewerInfo.frame
    hooksecurefunc(frame, "SetPoint", function()
        if nativePreviewInProgress or not EditModeManagerFrame or not EditModeManagerFrame:IsShown() then
            return
        end
        C_Timer.After(0, function()
            if not nativePreviewInProgress then
                UpdateViewerAnchor(frame, viewerInfo)
                UpdateFrameArrowsAnchors()
            end
        end)
    end)
end

local function AddArrowsToTrinketRacialTracker()
    local count = (ns.TrackerItemViewer and ns.TrackerItemViewer:GetTrackerCount()) or (ns.db and ns.db.profile and ns.db.profile.tracker_count) or 2
    for i = 1, count do
        local viewerName = "CMCTracker" .. i
        -- Skip (rather than return) so a missing/absent tracker doesn't block
        -- arrow setup for the remaining trackers.
        if not arrowsForViewers[viewerName] and _G[viewerName] then
            local arrowFrames = {
                top = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "BOTTOM",
                },
                left = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "RIGHT",
                },
                right = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "LEFT",
                },
                bottom = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "TOP",
                },
            }
            for name, info in pairs(arrowFrames) do
                local frame = info.frame
                frame:SetSize(10, 14)
                frame:SetScale(1)
                frame.background = frame:CreateTexture(nil, "BACKGROUND")
                frame.background:ClearAllPoints()
                frame.background:SetAllPoints()
                frame.background:SetAtlas("bags-greenarrow", false)
                frame.background:SetRotation(name == "left" and math.pi / 2 or (name == "right" and -math.pi / 2 or (name == "bottom" and math.pi or 0)))
                frame:SetFrameStrata("HIGH")
                frame:Hide()
            end
            arrowsForViewers[viewerName] = arrowFrames
            table.insert(viewers, {
                frame = _G[viewerName],
                viewerName = viewerName,
            })
        end
    end
end

local function AddArrowsToBuffContainers()
    if not (ns.BuffData and ns.BuffData.IsEnabled()) then
        return
    end
    local count = ns.BuffData.GetContainerCount() or 0
    for i = 1, count do
        local viewerName = "CMCBuffContainer" .. i
        if not arrowsForViewers[viewerName] and _G[viewerName] then
            local arrowFrames = {
                top = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "BOTTOM",
                },
                left = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "RIGHT",
                },
                right = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "LEFT",
                },
                bottom = {
                    frame = CreateFrame("Frame", nil, UIParent),
                    anchor = "TOP",
                },
            }
            for name, info in pairs(arrowFrames) do
                local frame = info.frame
                frame:SetSize(10, 14)
                frame:SetScale(1)
                frame.background = frame:CreateTexture(nil, "BACKGROUND")
                frame.background:ClearAllPoints()
                frame.background:SetAllPoints()
                frame.background:SetAtlas("bags-greenarrow", false)
                frame.background:SetRotation(name == "left" and math.pi / 2 or (name == "right" and -math.pi / 2 or (name == "bottom" and math.pi or 0)))
                frame:SetFrameStrata("HIGH")
                frame:Hide()
            end
            arrowsForViewers[viewerName] = arrowFrames
            table.insert(viewers, {
                frame = _G[viewerName],
                viewerName = viewerName,
            })
        end
    end
end

local ticker = nil
hooksecurefunc(EditModeManagerFrame, "Show", function()
    CreateHelpText()
    AddArrowsToTrinketRacialTracker()
    AddArrowsToBuffContainers()
    if ticker then
        ticker:Cancel()
        ticker = nil
    end
    C_Timer.After(0, function()
        EditModeHelp:PreviewNativeViewerAnchors()
    end)
    ticker = C_Timer.NewTicker(0.5, function()
        CreateHelpText()
        EditModeHelp:PreviewNativeViewerAnchors()
    end)
end)

hooksecurefunc(EditModeManagerFrame, "Hide", function()
    C_Timer.After(0, function()
        UpdateFrameArrowsAnchors()
        if ticker then
            ticker:Cancel()
            ticker = nil
        end
        if ignoreNextNativeLayoutHide then
            ignoreNextNativeLayoutHide = false
        else
            nativeVisibilityNormalizationPending = false
            local _, status = ApplyConfiguredNativeAnchors()
            if status == "not_ready" or status == "failed" then
                nativeVisibilityNormalizationPending = true
                QueueNativeVisibilityNormalization(1)
            elseif status == "deferred" then
                nativeVisibilityNormalizationPending = true
            end
        end
    end)
end)
