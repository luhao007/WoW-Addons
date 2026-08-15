local _, ns = ...

-- Shared reorder drag for assignment panels (buffs + trackers).
-- Owns the cursor, insertion marker, panel wiring and the GLOBAL_MOUSE_UP
-- lifecycle. Panels supply dumb callbacks; this module never touches their data.
local DragDrop = {}
ns.DragDrop = DragDrop

local state = {}
local cursor
local marker

local function EnsureCursor(options)
    if cursor then
        return cursor
    end
    cursor = CreateFrame("Frame", nil, UIParent)
    cursor:SetFrameStrata("TOOLTIP")
    cursor:SetSize(options.cursorSize or 32, options.cursorSize or 32)
    cursor.tex = cursor:CreateTexture(nil, "OVERLAY")
    cursor.tex:SetAllPoints()
    cursor:Hide()
    return cursor
end

local function EnsureMarker(panel, options)
    if marker then
        return marker
    end
    marker = CreateFrame("Frame", nil, panel)
    local texture = marker:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints()
    texture:SetAtlas("cdm-vertical", true)
    marker:SetSize(options.markerSize or 8, options.markerHeight or 38)
    marker:Hide()
    return marker
end

local function Reset()
    local panel = state.panel
    local previousOnUpdate = state.previousOnUpdate
    local previousOnEvent = state.previousOnEvent
    local source = state.source
    local options = state.options
    if source and options and options.onCancel then
        options.onCancel(source)
    end
    wipe(state)
    if cursor then
        cursor:Hide()
    end
    if marker then
        marker:Hide()
    end
    if panel then
        panel:SetScript("OnUpdate", previousOnUpdate)
        panel:SetScript("OnEvent", previousOnEvent)
        panel:UnregisterEvent("GLOBAL_MOUSE_UP")
    end
end

local function UpdateMarker()
    local panel = state.panel
    local options = state.options
    if not panel or not options then
        return
    end

    local cursorX, cursorY = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    cursorX, cursorY = cursorX / scale, cursorY / scale

    local cursorFrame = EnsureCursor(options)
    cursorFrame:ClearAllPoints()
    cursorFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", cursorX, cursorY)
    cursorFrame.tex:SetVertexColor(1, 1, 1)

    local markerFrame = EnsureMarker(panel, options)
    local target = state.target
    if target and target.headerDropActive then
        state.targetButton = nil
        state.offset = 0
        markerFrame:Hide()
        return
    end

    markerFrame:SetShown(target ~= nil)
    if not target then
        return
    end

    local targetButton = options.getBestTarget and options.getBestTarget(target, cursorX, cursorY) or nil
    if targetButton and options.validateTarget and not options.validateTarget(targetButton) then
        targetButton = nil
        cursorFrame.tex:SetVertexColor(1, 0.25, 0.25)
    end
    state.targetButton = targetButton
    if not targetButton or not options.updateMarkerPosition then
        markerFrame:Hide()
        return
    end

    markerFrame:ClearAllPoints()
    state.offset = options.updateMarkerPosition(targetButton, markerFrame, cursorX, cursorY) and 1 or 0
end

local function Finish()
    local options = state.options
    local source = state.source
    local target = state.target
    local targetButton = state.targetButton
    local offset = state.offset
    PlaySound(SOUNDKIT.UI_CURSOR_DROP_OBJECT)
    if source and target and targetButton and options and options.onDrop then
        options.onDrop(source, target, targetButton, offset)
    end
    Reset()
end

function DragDrop:Begin(panel, source, options)
    if state.source or not panel or not source or not options then
        return
    end
    state.panel = panel
    state.source = source
    state.target = source
    state.targetButton = source
    state.offset = 0
    state.options = options
    state.eatNextGlobalMouseUp = options.eatNextGlobalMouseUp
    state.previousOnUpdate = panel:GetScript("OnUpdate")
    state.previousOnEvent = panel:GetScript("OnEvent")

    local cursorFrame = EnsureCursor(options)
    if options.cursorTexture then
        cursorFrame.tex:SetTexture(options.cursorTexture(source))
    end
    cursorFrame:Show()
    PlaySound(SOUNDKIT.UI_CURSOR_PICKUP_OBJECT)

    panel:SetScript("OnUpdate", UpdateMarker)
    panel:SetScript("OnEvent", function(_, event, ...)
        if event ~= "GLOBAL_MOUSE_UP" or not DragDrop:IsDragging() then
            return
        end
        local button = ...
        if state.eatNextGlobalMouseUp == button then
            state.eatNextGlobalMouseUp = nil
            return
        end
        if button == "LeftButton" then
            Finish()
        else
            Reset()
        end
    end)
    panel:RegisterEvent("GLOBAL_MOUSE_UP")
end

function DragDrop:SetTarget(target)
    if state.source then
        state.target = target
    end
end

function DragDrop:IsDragging()
    return state.source ~= nil
end

function DragDrop:Cancel()
    if state.source then
        Reset()
    end
end
