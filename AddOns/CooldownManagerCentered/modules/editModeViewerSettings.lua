local _, ns = ...

-- In-edit-mode viewer settings panel ----------------------------------------------
-- Anchors a CooldownManagerCentered settings window next to Blizzard's
-- EditModeSystemSettingsDialog while it is attached to one of the four Cooldown
-- Viewers, giving a quick way to tweak the selected viewer without leaving Edit
-- Mode. We only ANCHOR to EditModeSystemSettingsDialog (read its attached system);
-- we never modify it. Settings content comes from ns.EditModeViewerSettings.
local EditModeViewerPanel = {}
ns.EditModeViewerPanel = EditModeViewerPanel

local LEM = ns.LibEQOL.EditMode

-- LEM keeps ONE attached settings panel, keyed by the frame passed to Show/Hide. Its
-- hide/isShown guard is `getDialogFrame() == frame`, so we must pass our own token,
-- not the shared EditModeSystemSettingsDialog — otherwise another consumer of that
-- dialog (BPRD's PRD settings) becomes indistinguishable from us and our OnAttach's
-- HidePanel tears down theirs. The panel still ANCHORS to the dialog.
local PANEL_OWNER = CreateFrame("Frame")

-- The Blizzard dialog already shows the viewer name, so our panel just labels
-- itself with the addon name (which addon is creating these settings).
local PANEL_TITLE = "|cff008945Cool|r|cff1e9a4e|r|cff3faa4fdown Ma|r|cff5fb64anag|r|cff7ac243er Ce|r|cff8ccd00ntered|r"

local function GetEMVS()
    return ns.EditModeViewerSettings
end

-- The frame the panel is anchored to. Using the dialog itself keeps the panel
-- glued to the right edge of EditModeSystemSettingsDialog as it moves.
local function GetDialog()
    return _G.EditModeSystemSettingsDialog
end

-- The viewer the panel currently holds settings for. Used to detect when the
-- attached frame changes so we can rebuild the panel from scratch.
local currentViewer = nil

local function HidePanel()
    currentViewer = nil
    if LEM.HideAttachedSettingsPanel then
        LEM:HideAttachedSettingsPanel(PANEL_OWNER) -- no-ops unless we own the shared panel
    end
end

-- Public: hide the attached CMC panel (e.g. when entering combat).
function EditModeViewerPanel:Hide()
    HidePanel()
end

local PANEL_GAP = 6

-- Anchor our panel to the right of the dialog, but flip to the left when there
-- isn't room for its full width on the right. We decide from geometry (the
-- panel's width) rather than panel:GetRight(), because the dialog template is
-- SetClampedToScreen(true): once clamped, GetRight() reports the on-screen
-- (clamped) edge and never exceeds the screen, so an overflow can't be detected
-- that way. All measurements are converted to screen pixels so frame scale
-- differences don't skew the comparison.
local function AnchorPanel(panel, dialog)
    if not (panel and dialog and panel.ClearAllPoints) then
        return
    end
    local panelWidth = panel:GetWidth() or 0
    local dialogRight = dialog:GetRight()
    local screenRight = UIParent:GetRight()
    if not (dialogRight and screenRight and panelWidth > 0) then
        return
    end

    local dialogRightPx = dialogRight * dialog:GetEffectiveScale()
    local screenRightPx = screenRight * UIParent:GetEffectiveScale()
    local gapPx = PANEL_GAP * panel:GetEffectiveScale()
    local panelWidthPx = panelWidth * panel:GetEffectiveScale()

    panel:ClearAllPoints()
    if dialogRightPx + gapPx + panelWidthPx > screenRightPx then
        panel:SetPoint("TOPRIGHT", dialog, "TOPLEFT", -PANEL_GAP, 0)
    else
        panel:SetPoint("TOPLEFT", dialog, "TOPRIGHT", PANEL_GAP, 0)
    end
end

local function ShowPanelFor(frameName)
    -- Never open (or rebuild) the attached panel during combat. Edit Mode tweaks
    -- aren't meaningful mid-fight and we don't want our window popping up then.
    if InCombatLockdown() then
        HidePanel()
        return
    end

    local dialog = GetDialog()
    local EMVS = GetEMVS()
    if not (dialog and EMVS and LEM.ShowAttachedSettingsPanel) then
        return
    end

    local settings = EMVS:BuildForViewer(frameName)
    if not settings or #settings == 0 then
        HidePanel()
        return
    end

    -- When the attached viewer changes, rebuild the whole panel frame so no
    -- widgets/state from the previous viewer can bleed into this one.
    local recreate = frameName ~= currentViewer
    currentViewer = frameName

    local panel = LEM:ShowAttachedSettingsPanel(PANEL_OWNER, {
        title = PANEL_TITLE,
        settings = settings,
        recreate = recreate,
        showReset = false,
        showSettingsReset = false,
        settingsMaxHeight = 520,
        point = "TOPLEFT",
        relativePoint = "TOPRIGHT",
        relativeTo = dialog,
        x = PANEL_GAP,
        y = 0,
    })

    if panel then
        if panel.SetFrameStrata then
            -- Sit just above the dialog we are anchored to so the panel is readable.
            panel:SetFrameStrata(dialog:GetFrameStrata())
            panel:SetFrameLevel(dialog:GetFrameLevel() + 10)
        end
        -- Let us fully control the panel's position; otherwise clamping would
        -- pin it on-screen instead of letting us flip it to the other side.

        panel:SetClampedToScreen(false)

        AnchorPanel(panel, dialog)
        -- Decide the side on the next frame, once the panel has actually been
        -- rendered and its real width is known.
        C_Timer.After(0, function()
            if LEM:IsAttachedSettingsPanelShown(PANEL_OWNER) then
                AnchorPanel(panel, dialog)
                panel:SetClampedToScreen(true)
            end
        end)
    end
end

-- Resolve the viewer name the dialog is currently attached to (if any).
local function GetAttachedViewerName(systemFrame)
    local dialog = GetDialog()
    local target = systemFrame or (dialog and dialog.attachedToSystem)
    if not target then
        return nil
    end
    local name = target.GetName and target:GetName()
    local EMVS = GetEMVS()
    if name and EMVS and EMVS:IsViewer(name) then
        return name
    end
    return nil
end

local function OnAttach(_, systemFrame)
    local viewer = GetAttachedViewerName(systemFrame)
    if viewer then
        ShowPanelFor(viewer)
    else
        HidePanel()
    end
end

local initialized = false
local function Initialize()
    if initialized then
        return
    end
    local dialog = GetDialog()
    if not dialog then
        return
    end
    -- Feature-detect: the anchored-panel API only exists in the extended lib.
    if not (LEM and LEM.ShowAttachedSettingsPanel) then
        return
    end
    initialized = true

    if dialog.AttachToSystemFrame then
        hooksecurefunc(dialog, "AttachToSystemFrame", OnAttach)
    end

    -- Hide whenever the dialog closes (deselect / different non-viewer system).
    dialog:HookScript("OnHide", HidePanel)

    -- Safety net: drop the panel on Edit Mode exit even if OnHide didn't fire.
    hooksecurefunc(EditModeManagerFrame, "Hide", function()
        HidePanel()
    end)
end

if C_AddOns.IsAddOnLoaded("Blizzard_EditMode") then
    Initialize()
else
    EventUtil.ContinueOnAddOnLoaded("Blizzard_EditMode", Initialize)
end
