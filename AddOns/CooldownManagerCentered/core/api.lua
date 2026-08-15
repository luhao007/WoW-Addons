local _, ns = ...
local L = ns.L

local API = {}
ns.API = API

local LSM = LibStub("LibSharedMedia-3.0", true)
local Pixel = ns.PixelPerfect

-- Solid borders are four independent textures instead of Backdrop edgeSize. The
-- anchor's pixel container supplies exact corners; each edge then has an exact
-- physical-pixel thickness at the anchor's current effective scale.
local pixelBorders = setmetatable({}, { __mode = "k" })

local function EnsurePixelBorder(borderFrame)
    local pieces = pixelBorders[borderFrame]
    if pieces then
        return pieces
    end

    pieces = {
        top = borderFrame:CreateTexture(nil, "OVERLAY"),
        bottom = borderFrame:CreateTexture(nil, "OVERLAY"),
        left = borderFrame:CreateTexture(nil, "OVERLAY"),
        right = borderFrame:CreateTexture(nil, "OVERLAY"),
    }
    for _, texture in pairs(pieces) do
        texture:SetColorTexture(0, 0, 0, 1)
        Pixel.ApplyTexturePixelSnapping(texture)
    end
    pixelBorders[borderFrame] = pieces
    return pieces
end

function API:ApplyPixelBorder(borderFrame, anchor, thickness, color)
    if not borderFrame or not anchor then
        return 0
    end

    borderFrame:ClearAllPoints()
    borderFrame:SetAllPoints(anchor)

    local thicknessPixels = math.max(Pixel.Round(thickness or 0), 0)
    if thicknessPixels == 0 then
        borderFrame:Hide()
        return 0
    end

    local pieces = EnsurePixelBorder(borderFrame)
    local edgeSize = Pixel.SizeFromPixels(anchor, thicknessPixels, 1)
    local r, g, b, a = 0, 0, 0, 1
    if color then
        r, g, b, a = color[1] or r, color[2] or g, color[3] or b, color[4] or a
    end

    for _, texture in pairs(pieces) do
        texture:SetColorTexture(r, g, b, a)
        texture:ClearAllPoints()
        texture:Show()
    end

    pieces.top:SetPoint("TOPLEFT", borderFrame, "TOPLEFT")
    pieces.top:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT")
    pieces.top:SetHeight(edgeSize)

    pieces.bottom:SetPoint("BOTTOMLEFT", borderFrame, "BOTTOMLEFT")
    pieces.bottom:SetPoint("BOTTOMRIGHT", borderFrame, "BOTTOMRIGHT")
    pieces.bottom:SetHeight(edgeSize)

    pieces.left:SetPoint("TOPLEFT", borderFrame, "TOPLEFT")
    pieces.left:SetPoint("BOTTOMLEFT", borderFrame, "BOTTOMLEFT")
    pieces.left:SetWidth(edgeSize)

    pieces.right:SetPoint("TOPRIGHT", borderFrame, "TOPRIGHT")
    pieces.right:SetPoint("BOTTOMRIGHT", borderFrame, "BOTTOMRIGHT")
    pieces.right:SetWidth(edgeSize)

    borderFrame:Show()
    return edgeSize
end

function API:HidePixelBorder(borderFrame)
    if borderFrame then
        borderFrame:Hide()
    end
end

local debugModuleNames = {}
local debugModuleNamesByLower = {}

function API:RegisterDebugModule(moduleName)
    if type(moduleName) ~= "string" or moduleName == "" then
        return
    end
    local lowerName = moduleName:lower()
    debugModuleNames[moduleName] = true
    debugModuleNamesByLower[lowerName] = moduleName
end

function API:ResolveDebugModuleName(moduleName)
    if type(moduleName) ~= "string" or moduleName == "" then
        return nil
    end
    return debugModuleNamesByLower[moduleName:lower()]
end

function API:GetDebugModuleNames()
    local names = {}
    for moduleName in pairs(debugModuleNames) do
        names[#names + 1] = moduleName
    end
    table.sort(names)
    return names
end

function API.GradientText(text, r1, g1, b1, r2, g2, b2)
    r1, g1, b1 = r1 or 0, g1 or 137, b1 or 69 -- CreateColor(0, 0.54, 0.27)
    r2, g2, b2 = r2 or 140, g2 or 205, b2 or 0 -- CreateColor(0.55, 0.8, 0)

    local n = #text
    if n <= 1 then
        return text
    end

    local out = {}
    for i = 1, n do
        local t = (i - 1) / (n - 1)
        local r = math.min(255, math.floor(r1 + (r2 - r1) * t + 0.5))
        local g = math.min(255, math.floor(g1 + (g2 - g1) * t + 0.5))
        local b = math.min(255, math.floor(b1 + (b2 - b1) * t + 0.5))
        out[i] = string.format("|cff%02x%02x%02x%s|r", r, g, b, text:sub(i, i))
    end
    return table.concat(out)
end

local SliceFrameMixin = {}

function SliceFrameMixin:CreatePieces(n)
    if self.pieces then
        return
    end
    self.pieces = {}
    self.numSlices = n

    for i = 1, n do
        self.pieces[i] = self:CreateTexture(nil, "BORDER")
        self.pieces[i]:ClearAllPoints()
    end

    self:SetCornerSize(16)

    if n == 3 then
        self.pieces[1]:SetPoint("CENTER", self, "LEFT", 0, 0)
        self.pieces[3]:SetPoint("CENTER", self, "RIGHT", 0, 0)
        self.pieces[2]:SetPoint("TOPLEFT", self.pieces[1], "TOPRIGHT", 0, 0)
        self.pieces[2]:SetPoint("BOTTOMRIGHT", self.pieces[3], "BOTTOMLEFT", 0, 0)

        self.pieces[1]:SetTexCoord(0, 0.25, 0, 1)
        self.pieces[2]:SetTexCoord(0.25, 0.75, 0, 1)
        self.pieces[3]:SetTexCoord(0.75, 1, 0, 1)
    elseif n == 9 then
        self.pieces[1]:SetPoint("CENTER", self, "TOPLEFT", 0, 0)
        self.pieces[3]:SetPoint("CENTER", self, "TOPRIGHT", 0, 0)
        self.pieces[7]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, 0)
        self.pieces[9]:SetPoint("CENTER", self, "BOTTOMRIGHT", 0, 0)
        self.pieces[2]:SetPoint("TOPLEFT", self.pieces[1], "TOPRIGHT", 0, 0)
        self.pieces[2]:SetPoint("BOTTOMRIGHT", self.pieces[3], "BOTTOMLEFT", 0, 0)
        self.pieces[4]:SetPoint("TOPLEFT", self.pieces[1], "BOTTOMLEFT", 0, 0)
        self.pieces[4]:SetPoint("BOTTOMRIGHT", self.pieces[7], "TOPRIGHT", 0, 0)
        self.pieces[5]:SetPoint("TOPLEFT", self.pieces[1], "BOTTOMRIGHT", 0, 0)
        self.pieces[5]:SetPoint("BOTTOMRIGHT", self.pieces[9], "TOPLEFT", 0, 0)
        self.pieces[6]:SetPoint("TOPLEFT", self.pieces[3], "BOTTOMLEFT", 0, 0)
        self.pieces[6]:SetPoint("BOTTOMRIGHT", self.pieces[9], "TOPRIGHT", 0, 0)
        self.pieces[8]:SetPoint("TOPLEFT", self.pieces[7], "TOPRIGHT", 0, 0)
        self.pieces[8]:SetPoint("BOTTOMRIGHT", self.pieces[9], "BOTTOMLEFT", 0, 0)

        self.pieces[1]:SetTexCoord(0, 0.25, 0, 0.25)
        self.pieces[2]:SetTexCoord(0.25, 0.75, 0, 0.25)
        self.pieces[3]:SetTexCoord(0.75, 1, 0, 0.25)
        self.pieces[4]:SetTexCoord(0, 0.25, 0.25, 0.75)
        self.pieces[5]:SetTexCoord(0.25, 0.75, 0.25, 0.75)
        self.pieces[6]:SetTexCoord(0.75, 1, 0.25, 0.75)
        self.pieces[7]:SetTexCoord(0, 0.25, 0.75, 1)
        self.pieces[8]:SetTexCoord(0.25, 0.75, 0.75, 1)
        self.pieces[9]:SetTexCoord(0.75, 1, 0.75, 1)
    end
end

function SliceFrameMixin:SetCornerSize(a)
    if self.numSlices == 3 then
        self.pieces[1]:SetSize(a, 2 * a)
        self.pieces[3]:SetSize(a, 2 * a)
    elseif self.numSlices == 9 then
        self.pieces[1]:SetSize(a, a)
        self.pieces[3]:SetSize(a, a)
        self.pieces[7]:SetSize(a, a)
        self.pieces[9]:SetSize(a, a)
    end
end

function SliceFrameMixin:SetCornerSizeByScale(scale)
    self:SetCornerSize(16 * scale)
end

function SliceFrameMixin:SetTexture(tex)
    for i = 1, #self.pieces do
        self.pieces[i]:SetTexture(tex)
    end
end

function SliceFrameMixin:SetDisableSharpening(state)
    for i = 1, #self.pieces do
        self.pieces[i]:SetSnapToPixelGrid(not state)
    end
end

function SliceFrameMixin:SetColor(r, g, b)
    for i = 1, #self.pieces do
        self.pieces[i]:SetVertexColor(r, g, b)
    end
end

function SliceFrameMixin:CoverParent(padding)
    padding = padding or 0
    local parent = self:GetParent()
    if parent then
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", parent, "TOPLEFT", -padding, padding)
        self:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", padding, -padding)
    end
end

function SliceFrameMixin:ShowBackground(state)
    for _, piece in ipairs(self.pieces) do
        piece:SetShown(state)
    end
end

---Available nine-slice layout styles
local NineSliceLayouts = {
    Dark = true,
}

---Create a nine-slice frame with custom border texture
---@param parent Frame Parent frame to attach the nine-slice to
---@param layoutName? string Layout name from NineSliceLayouts
---@return Frame nineSliceFrame Frame with SliceFrameMixin methods (SetCornerSize, CoverParent, etc.)
function API:CreateNineSliceFrame(parent, layoutName)
    if not (layoutName and NineSliceLayouts[layoutName]) then
        layoutName = "Dark"
    end
    local f = CreateFrame("Frame", nil, parent)
    Mixin(f, SliceFrameMixin)
    f:CreatePieces(9)
    f:SetTexture("Interface/AddOns/CooldownManagerCentered/Media/Art/" .. layoutName)
    f:ClearAllPoints()
    return f
end

-- Per-frame CMC state lives outside Blizzard-owned frames. Weak keys let pooled
-- frames disappear normally without adding addon fields to protected UI objects.
local affectedByFrame = setmetatable({}, { __mode = "k" })

function API:GetIsAffected(frame, key)
    local state = frame and affectedByFrame[frame]
    return (state and state[key]) or false
end

function API:SetAffected(frame, key, value)
    if not frame then
        return
    end
    if value == nil then
        value = true
    end
    local state = affectedByFrame[frame]
    if not state then
        state = {}
        affectedByFrame[frame] = state
    end
    state[key] = value
end

function API:UnsetAffected(frame, key)
    local state = frame and affectedByFrame[frame]
    if state then
        state[key] = nil
    end
end

-- Returns the frames CMC should treat as belonging to a Blizzard viewer. The
-- Essential mirror keeps its custom icons parented to a private event host, so
-- Blizzard never sees them as layout children; CMC integrations opt into them
-- through this helper instead.
function API:GetViewerItemFrames(viewer)
    if not viewer or not viewer.GetItemFrames then
        return {}
    end

    local frames = viewer:GetItemFrames()
    if viewer == _G.EssentialCooldownViewer and ns.EssentialCustomTracker and ns.EssentialCustomTracker.GetItemFrames then
        for _, frame in ipairs(ns.EssentialCustomTracker:GetItemFrames()) do
            frames[#frames + 1] = frame
        end
    end
    return frames
end

-- Returns the side-table state for a frame, creating it on first use. Nil-safe:
-- callers that probe an absent frame still receive a throwaway table.
function API.Affected(frame)
    if not frame then
        return {}
    end
    local state = affectedByFrame[frame]
    if not state then
        state = {}
        affectedByFrame[frame] = state
    end
    return state
end

-- Returns frame:GetSize(), or nil when either dimension is unusable: zero (not laid
-- out yet) or a protected "secret" value. WoW 11.x can hand back tainted sizes for
-- reparented frames and arithmetic on those errors; issecretvalue itself may be
-- absent on older clients, so guard its existence. Callers should skip geometry math
-- and keep their last good size when this returns nil.
function API:GetSafeSize(frame)
    if not frame then
        return nil
    end
    local w, h = frame:GetSize()
    if issecretvalue and (issecretvalue(w) or issecretvalue(h)) then
        return nil
    end
    if not w or not h or w <= 0 or h <= 0 then
        return nil
    end
    return w, h
end

-- Builds a table.sort comparator: custom order first, then layout index, then
-- a stable tiebreaker key. Resolvers receive one item each; missing order or
-- layout values sort last.
function API:BuildOrderComparator(orderOf, layoutIndexOf, keyOf)
    return function(a, b)
        local aOrder = orderOf(a) or math.huge
        local bOrder = orderOf(b) or math.huge
        if aOrder ~= bOrder then
            return aOrder < bOrder
        end

        local aLayout = math.huge
        local bLayout = math.huge
        if layoutIndexOf then
            aLayout = layoutIndexOf(a) or math.huge
            bLayout = layoutIndexOf(b) or math.huge
        end
        if aLayout ~= bLayout then
            return aLayout < bLayout
        end

        return keyOf(a) < keyOf(b)
    end
end

function API:RefreshCooldownManager()
    C_Timer.After(0.01, function()
        ns.StyledIcons:RefreshAll()
        ns.CooldownManager.Initialize()
        if ns.CooldownStyle then
            ns.CooldownStyle:RefreshHooks()
        end
        if ns.EditModeHelp and ns.EditModeHelp.PreviewNativeViewerAnchors then
            -- Preview only: the Edit Mode layout is persisted from the Hide
            -- hook, after a fresh LibEditModeOverride:LoadLayouts() snapshot.
            ns.EditModeHelp:PreviewNativeViewerAnchors()
        end
    end)
end

function API:IsSomeAddOnRestrictionActive()
    if C_RestrictedActions and C_RestrictedActions.IsAddOnRestrictionActive then
        for i = 0, 4 do
            if C_RestrictedActions.IsAddOnRestrictionActive(i) then
                return true
            end
        end
    end
    return false
end

StaticPopupDialogs["CMC_RELOAD_UI_ASK"] = {
    text = L["Some settings won't take effect until you reload the UI. Reload now?"],
    button1 = L["Reload"],
    button2 = L["Not now"],
    OnAccept = function(self, profileName)
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

function API:ShowReloadUIConfirmation()
    StaticPopup_Show("CMC_RELOAD_UI_ASK")
end

function API:ToggleEditMode()
    if InCombatLockdown and InCombatLockdown() then
        ns.Addon:Print(L["Cannot toggle Edit Mode while in combat."])
        return
    end
    local frame = _G.EditModeManagerFrame
    if not frame then
        local loader = (C_AddOns and C_AddOns.LoadAddOn) or _G.LoadAddOnWithErrorHandling or _G.UIParentLoadAddOn
        if loader then
            loader("Blizzard_EditMode")
            frame = _G.EditModeManagerFrame
        end
    end
    if not frame then
        return
    end
    if frame.CanEnterEditMode and not frame:CanEnterEditMode() then
        ns.Addon:Print(L["Cannot enter Edit Mode right now."])
        return
    end
    if frame:IsShown() then
        if HideUIPanel then
            HideUIPanel(frame)
        else
            frame:Hide()
        end
    else
        if ShowUIPanel then
            ShowUIPanel(frame)
        else
            frame:Show()
        end
    end
end

StaticPopupDialogs["CMC_ELVUI_SKINNING_ASK"] = {
    text = L["ElvUI Cooldown Manager skinning is enabled. It will conflict with Cooldown Manager Centered styling. Disable ElvUI skinning?"],
    button1 = L["Yes, I will use CMC styling"],
    button2 = L["No\nI want to keep using ElvUI skinning"],
    OnAccept = function(self, profileName)
        API:DisableElvUICDMSkinning()
        ReloadUI()
    end,
    OnCancel = function(self)
        StaticPopup_Show("CMC_CMC_SKINNING_ASK")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

StaticPopupDialogs["CMC_CMC_SKINNING_ASK"] = {
    text = L["Disable CMC skinning then?"],
    button1 = L["Yes, disable CMC styling"],
    button2 = L["No, I want to keep both"],
    OnAccept = function(self, profileName)
        ns.db.profile.cooldownManager_normalizeUtilitySize = false
        ns.db.profile.cooldownManager_squareIcons_Essential = false
        ns.db.profile.cooldownManager_squareIcons_Utility = false
        ns.db.profile.cooldownManager_squareIcons_BuffIcons = false
        ns.db.profile.cooldownManager_stackAnchorEssential_enabled = false
        ns.db.profile.cooldownManager_stackAnchorUtility_enabled = false
        ns.db.profile.cooldownManager_stackAnchorBuffIcons_enabled = false

        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}
function API:IsElvUICDMSkinningEnabled()
    if C_AddOns and not C_AddOns.IsAddOnLoaded("ElvUI") then
        return false
    end

    local E = ElvUI and ElvUI[1]
    if not E or not E.private then
        return false
    end

    local skins = E.private.skins
    if not skins or not skins.blizzard then
        return false
    end

    return skins.blizzard.enable and skins.blizzard.cooldownManager
end

function API:DisableElvUICDMSkinning()
    if C_AddOns and not C_AddOns.IsAddOnLoaded("ElvUI") then
        return false
    end

    local E = ElvUI and ElvUI[1]
    if not E or not E.private then
        return false
    end

    local skins = E.private.skins
    if not skins or not skins.blizzard then
        return false
    end

    skins.blizzard.cooldownManager = false
    return true
end

function API:GetTableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- Resolves a spell to its base spell, but only behind the global alpha flag.
-- Used exclusively to widen custom aura matching (custom buffs, custom tracker
-- auras); saved stable keys and Blizzard tooltip-override matching are never
-- touched by this resolver.
function API:ResolveAuraSpellID(spellID)
    spellID = tonumber(spellID)
    if not spellID or spellID <= 0 then
        return spellID
    end
    if ns.AuraContainerRuntime and ns.AuraContainerRuntime:IsAvailable() then
        return C_Spell.GetBaseSpell(spellID) or spellID
    end
    return spellID
end

-- Stable error codes so failures are recognizable and searchable in chat logs.
API.Error = {
    AnchorWatchApplyPosition = 101,
    AnchorWatchDrop = 102,
    VisibilityUnregister = 103,
    VisibilityRegister = 104,
    EditModeUnregister = 105,
    BuffLayoutResize = 201,
    BuffLayoutResizeFallback = 202,
    AuraSoundRegister = 203,
    CustomAuraLoadContainer = 204,
    CustomAuraSortEnums = 205,
    AuraTrackingLoadContainer = 206,
    AuraTrackingMissingMethods = 207,
    SettingsOpenCommand = 301,
    SettingsOpenViewer = 302,
    SettingsDisplayModeViewer = 303,
    SettingsDisplayModeBuffPanel = 304,
    AssistantFlipbookShape = 401,
}

-- Internal diagnostics: always visible in chat so silent failures stay loud.
function API:LogWarn(code, message)
    assert(code ~= nil, "API:LogWarn requires an error code")
    print(string.format(L["[CMC error %s: %s]"], tostring(code), tostring(message)))
end

function API:IsDebugLoggingEnabled(moduleName)
    local global = ns.db and ns.db.global
    if not global then
        return false
    end

    local moduleSettings = global.debugModules
    if type(moduleSettings) == "table" and next(moduleSettings) ~= nil then
        return type(moduleName) == "string" and moduleSettings[moduleName] == true
    end

    return global.debugLogging == true
end

function API:SetDebugLogging(moduleName, enabled)
    if not ns.db or not ns.db.global then
        return
    end

    local global = ns.db.global
    if not moduleName or moduleName == "all" then
        global.debugLogging = enabled == true
        global.debugModules = {}
        return
    end

    global.debugLogging = false
    global.debugModules = global.debugModules or {}
    global.debugModules[moduleName] = enabled == true
end

function API:IsDebugModuleMode()
    local moduleSettings = ns.db and ns.db.global and ns.db.global.debugModules
    return type(moduleSettings) == "table" and next(moduleSettings) ~= nil
end

function API:LogDebug(moduleName, ...)
    local message
    if select("#", ...) == 0 then
        message = moduleName
        moduleName = nil
    else
        local parts = {}
        for index = 1, select("#", ...) do
            parts[index] = tostring(select(index, ...))
        end
        message = table.concat(parts, " ")
    end

    if API:IsDebugLoggingEnabled(moduleName) then
        local prefix = moduleName and ("[CMC|DEBUG|" .. moduleName .. "] ") or "[CMC|DEBUG] "
        print(prefix .. tostring(message))
    end
end

local function AddSpellToTracking(spellID, state)
    if InCombatLockdown() then
        return nil, L["Cannot add spell to tracking while in combat."]
    end

    -- local overrideSpell = C_Spell.GetOverrideSpell(spellID)
    local baseSpellID = C_Spell.GetBaseSpell(spellID)
    local isUsable = C_Spell.DoesSpellExist(baseSpellID)
    if not isUsable then
        return nil, L["Spell does not exist."]
    end

    local target = state or ns.TrackerItemsData.ITEM_STATE_TRACKER1
    ns.TrackerItemsData:SetEntryState("spell", baseSpellID, target)

    if ns.TrackerItemViewer and ns.TrackerItemViewer.ReconcileTrackerCount then
        ns.TrackerItemViewer:ReconcileTrackerCount()
    end
    if ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.RefreshTrackerPanel then
        ns.TrackerAssignmentPanel:RefreshTrackerPanel()
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
        ns.TrackerItemViewer:RefreshItemViewerFrames()
    end

    return true
end

local function AddItemToTracking(itemID, state)
    if InCombatLockdown() then
        return nil, L["Cannot add item to tracking while in combat."]
    end

    -- Passive proc trinkets have no on-use spell but are still trackable via proc
    -- data, so allow anything ItemsData considers trackable. The passive-trinket
    -- filter only gates wildcard slots, never items added by hand.
    if not ns.TrackerItemsData:IsTrackableItem(itemID) then
        return nil, L["Item is not usable."]
    end

    local target = state or ns.TrackerItemsData.ITEM_STATE_TRACKER1
    ns.TrackerItemsData:SetEntryState("item", itemID, target)

    if ns.TrackerItemViewer and ns.TrackerItemViewer.ReconcileTrackerCount then
        ns.TrackerItemViewer:ReconcileTrackerCount()
    end
    if ns.TrackerAssignmentPanel and ns.TrackerAssignmentPanel.RefreshTrackerPanel then
        ns.TrackerAssignmentPanel:RefreshTrackerPanel()
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.RefreshItemViewerFrames then
        ns.TrackerItemViewer:RefreshItemViewerFrames()
    end

    return true
end

function API:AddSpellToTracking(spellID)
    return AddSpellToTracking(spellID)
end

function API:AddItemToTracking(itemID)
    return AddItemToTracking(itemID)
end
function API:AddToTracking(kind, id, state)
    if kind == "spell" then
        return AddSpellToTracking(id, state)
    elseif kind == "item" then
        return AddItemToTracking(id, state)
    else
        return nil, L["Invalid kind. Must be 'spell' or 'item'."]
    end
end

function API:GetFontPath(fontName)
    if not fontName or fontName == "" or fontName == "NIL" then
        return nil
    end
    if LSM then
        local fontPath = LSM:Fetch("font", fontName)
        if fontPath then
            return fontPath
        end
    end
    return nil
end

function API:GetFontFlags(flagsTable)
    if not flagsTable then
        return ""
    end
    local parts = {}
    if flagsTable["MONOCHROME"] then
        table.insert(parts, "MONOCHROME")
    end
    if flagsTable["OUTLINE"] then
        table.insert(parts, "OUTLINE")
    end
    if flagsTable["THICKOUTLINE"] then
        table.insert(parts, "THICKOUTLINE")
    end
    if flagsTable["SLUG"] then
        table.insert(parts, "SLUG")
    end
    return table.concat(parts, ",")
end
