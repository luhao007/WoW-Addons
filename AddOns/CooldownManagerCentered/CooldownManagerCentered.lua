local _, ns = ...
local L = ns.L
local addon = ns.Addon

local AddOnFrame = CreateFrame("Frame")
AddOnFrame:RegisterEvent("ADDON_LOADED")

function addon:OpenSettings()
    if InCombatLockdown() then
        ns.Addon:Print(L["Cannot open settings panel while in combat."])
        return
    end
    if ns.AddonSettings then
        local id = ns.AddonSettings.SettingsLayout.rootCategory:GetID()
        Settings.OpenToCategory(id)
    end
end

function addon:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("CooldownManagerCenteredDB", ns.DEFAULT_SETTINGS, true)
    ns.db = self.db

    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
    self.db.RegisterCallback(self, "OnNewProfile", "OnNewProfile")
    self.db.RegisterCallback(self, "OnProfileDeleted", "OnProfileDeleted")
end

local openCooldownViewerSettings = function()
    if InCombatLockdown() then
        CooldownViewerSettings:Show()
        if not tContains(UISpecialFrames, "CooldownViewerSettings") then
            tinsert(UISpecialFrames, "CooldownViewerSettings")
        end
    else
        CooldownViewerSettings:ShowUIPanel(false)
    end
end

SLASH_CMC_CVS1 = "/cds"
SLASH_CMC_CVS2 = "/cdm"
SlashCmdList["CMC_CVS"] = openCooldownViewerSettings
SLASH_CMC_COMMAND1 = "/cmc"
SlashCmdList["CMC_COMMAND"] = function(msg)
    if not msg or msg == "" then
        addon:OpenSettings()
        return
    end
    local chunks = {}
    for substring in msg:gmatch("%S+") do
        table.insert(chunks, substring)
    end
    local command = chunks[1] and chunks[1]:lower()
    local arg = chunks[2] and chunks[2]:lower()
    local state = chunks[3] and chunks[3]:lower()
    if command == "track" and (arg == "spell" or arg == "item") and chunks[3] then
        local ok, error = ns.API:AddToTracking(arg, chunks[3])
        if not ok then
            ns.Addon:Print(error)
        end
        return
    end

    if command == "debug" then
        if arg == "list" and not state then
            local mode = ns.API:IsDebugModuleMode() and L["per-module"] or L["all modules"]
            ns.Addon:Print(string.format(L["Debug logging mode: %s."], mode))
            for _, moduleName in ipairs(ns.API:GetDebugModuleNames()) do
                local status = ns.API:IsDebugLoggingEnabled(moduleName) and L["enabled"] or L["disabled"]
                print(string.format("[CMC|DEBUG] %s: %s", moduleName, status))
            end
        elseif (arg == "on" or arg == "off") and not state then
            ns.API:SetDebugLogging("all", arg == "on")
            local status = arg == "on" and L["enabled"] or L["disabled"]
            ns.Addon:Print(string.format(L["Debug logging for all modules %s."], status))
        elseif arg == "all" and (state == "on" or state == "off") then
            ns.API:SetDebugLogging("all", state == "on")
            local status = state == "on" and L["enabled"] or L["disabled"]
            ns.Addon:Print(string.format(L["Debug logging for all modules %s."], status))
        elseif (state == "on" or state == "off") and arg then
            local moduleName = ns.API:ResolveDebugModuleName(arg)
            if not moduleName then
                ns.Addon:Print(string.format(L["Unknown debug module: %s."], arg))
                return
            end
            ns.API:SetDebugLogging(moduleName, state == "on")
            local status = state == "on" and L["enabled"] or L["disabled"]
            ns.Addon:Print(string.format(L["Debug logging for %s %s."], moduleName, status))
        else
            ns.Addon:Print(L["Usage: /cmc debug on|off, /cmc debug <module> on|off, or /cmc debug list"])
        end
        return
    end

    ns.Addon:Print(L["Available commands:"])
    print(L["/cmc - Open the settings panel"])
    print(L["/cmc track spell {id} - Add a spell to the custom tracked list"])
    print(L["/cmc track item {id} - Add an item to the custom tracked list"])
    print(L["/cmc debug on|off - Toggle debug logging for all modules"])
    print(L["/cmc debug <module> on|off - Toggle debug logging for one module"])
    print(L["/cmc debug list - Show debug module status"])
end

local _cleanup

function addon:RefreshConfig()
    _cleanup()
    if ns.StyledIcons then
        ns.StyledIcons:Initialize()
    end
    if ns.BuffBarStyle then
        ns.BuffBarStyle:Initialize()
    end
    if ns.CooldownManager then
        ns.CooldownManager.Initialize()
    end
    if ns.Stacks then
        ns.Stacks:Initialize()
    end
    if ns.Keybinds then
        ns.Keybinds:Initialize()
    end
    if ns.Assistant then
        ns.Assistant:Initialize()
    end
    if ns.CooldownFont then
        ns.CooldownFont:Initialize()
    end
    if ns.TrackerDB then
        ns.TrackerDB:InitializeDB()
    end
    if ns.TrackerItemViewer then
        if ns.db.profile.tracker_enabled then
            ns.TrackerItemViewer:Initialize()
            ns.TrackerItemViewer:ShowAll()
        else
            ns.TrackerItemViewer:HideAll()
        end
    end
    if ns.BuffContainerViewer then
        if ns.BuffData and ns.BuffData.IsEnabled() then
            ns.BuffContainerViewer:Initialize()
            ns.BuffContainerViewer:ShowAll()
        else
            ns.BuffContainerViewer:HideAll()
        end
    end
    if ns.CooldownStyle then
        ns.CooldownStyle:Initialize()
    end
    if ns.ReadyAlerts then
        ns.ReadyAlerts:RefreshNativeMonitor()
    end
    if ns.MasqueModule then
        ns.MasqueModule:Initialize()
    end

    if ns.ButtonPress then
        ns.ButtonPress:Initialize()
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:Initialize()
    end

    ns.API:RefreshCooldownManager()
    -- self:Print("Profile settings applied.")
end

function addon:OnNewProfile(event, db, profile)
    self:Print(string.format(L["Created new profile: %s"], profile))
end

function addon:OnProfileDeleted(event, db, profile)
    self:Print(string.format(L["Deleted profile: %s"], profile))
end

_cleanup = function()
    -- Bars-as-icons buff bar mode was removed; fold its two grow-direction values back
    -- to the default so the dropdown isn't left on a now-missing entry.
    local buffBarGrow = ns.db.profile.cooldownManager_alignBuffBars_growFromDirection
    if buffBarGrow == "ICONS_VERTICAL" or buffBarGrow == "ICONS_HORIZONTAL" then
        ns.db.profile.cooldownManager_alignBuffBars_growFromDirection = "BOTTOM"
    end

    -- "Anchor to Tracker X" chaining was replaced by the generic "Anchor To" system.
    if ns.TrackerItemViewer and ns.TrackerItemViewer.MigrateChainAnchoring then
        ns.TrackerItemViewer:MigrateChainAnchoring()
    end
    if ns.TrackerItemViewer and ns.TrackerItemViewer.MigrateSharedTrackerStyling then
        ns.TrackerItemViewer:MigrateSharedTrackerStyling()
    end

    ns.db.profile.cooldownManager_forceCenterX_BuffIcons = nil
    ns.db.profile.cooldownManager_forceCenterX_Essential = nil
    ns.db.profile.cooldownManager_forceCenterX_Utility = nil
    ns.db.profile.cooldownManager_forceCenterX_BuffIcons_lastY = nil
    ns.db.profile.cooldownManager_forceCenterX_Essential_lastY = nil
    ns.db.profile.cooldownManager_forceCenterX_Utility_lastY = nil

    ns.db.profile.cooldownManager_experimental_subsequentRowScaling = nil
    ns.db.profile.cooldownManager_experimental_subsequentRowScaling_Essential = nil
    ns.db.profile.cooldownManager_experimental_subsequentRowScaling_Utility = nil
    ns.db.profile.cooldownManager_experimental_hideAuras = nil
    if ns.db.profile.cooldownManager_experimental_trinketRacialTracker ~= nil then
        ns.db.profile.tracker_enabled = ns.db.profile.cooldownManager_experimental_trinketRacialTracker
        local oldTrackerPosition = ns.db.profile.editMode.trinketRacialTracker
        for k, v in pairs(oldTrackerPosition) do
            ns.db.profile.editMode.tracker1[k] = v
        end

        ns.db.profile.cooldownManager_experimental_trinketRacialTracker = nil
        ns.db.profile.editMode.trinketRacialTracker = nil
    end
    if
        ns.db.profile.trinketRacialTracker_position ~= nil
        or ns.db.profile.editMode.trinketRacialTracker ~= nil
        or ns.db.profile.trinketRacialTracker_ignoredRacials ~= nil
        or ns.db.profile.trinketRacialTracker_ignoredItems ~= nil
    then
        -- cleanup old settings... later
        ns.db.profile.editMode.trinketRacialTracker = nil
        ns.db.profile.trinketRacialTracker_position = nil
        ns.db.profile.trinketRacialTracker_ignoredRacials = nil
        ns.db.profile.trinketRacialTracker_ignoredItems = nil
    end

    if ns.db.profile.cooldownManager_experimental_buttonPress ~= nil then
        ns.db.profile.cooldownManager_buttonPress = ns.db.profile.cooldownManager_experimental_buttonPress
        ns.db.profile.cooldownManager_experimental_buttonPress = nil
    end

    if ns.db.profile.cooldownManager_experimental_enableRectangularIcons ~= nil then
        ns.db.profile.cooldownManager_experimental_enableRectangularIcons_essential = ns.db.profile.cooldownManager_experimental_enableRectangularIcons
        ns.db.profile.cooldownManager_experimental_enableRectangularIcons_utility = ns.db.profile.cooldownManager_experimental_enableRectangularIcons
        ns.db.profile.cooldownManager_experimental_enableRectangularIcons_buffIcons = ns.db.profile.cooldownManager_experimental_enableRectangularIcons
        ns.db.profile.cooldownManager_experimental_enableRectangularIcons = nil
    end

    ns.db.profile.cooldownManager_visibility_enabled = nil

    -- Migrate legacy "Smart Visibility" global rules → per-viewer rules
    if ns.CMCVisibility then
        ns.CMCVisibility:MigrateSettings()
    end

    ns.db.profile.cooldownManager_centerBuffIcons = nil
    ns.db.profile.cooldownManager_alignBuffBars = nil
    ns.db.profile.cooldownManager_centerEssential = nil
    ns.db.profile.cooldownManager_centerUtility = nil
    ns.db.profile.cmcSpellSettings = nil
    ns.db.profile.cmcMiscTracked = nil
    ns.db.profile.cooldownManager_experimental_miscTracker = nil
    ns.db.profile.cooldownManager_smallerSpacing = nil
    ns.db.profile.CooldownSkinning = nil
    ns.db.profile.cooldownManager_customActiveColor_enabled = nil
    ns.db.profile.miscTracker_squareIcons = nil
    -- ns.db.profile.cooldownManager_experimental_custom_glows = false,

    ns.db.profile.cooldownManager_experimental_disablePerSpellSettings = nil
end

function addon:OnEnable()
    _cleanup()
    C_CVar.SetCVar("cooldownViewerEnabled", "1")
    if ns.AddonSettings then
        ns.AddonSettings:RegisterSettings()
        ns.AddonSettings:InitializeSettings()
    end

    if ns.StyledIcons then
        ns.StyledIcons:Initialize()
    end
    if ns.BuffBarStyle then
        ns.BuffBarStyle:Initialize()
    end
    if ns.CooldownManager then
        ns.CooldownManager.Initialize()
    end
    if ns.Stacks then
        ns.Stacks:Initialize()
    end
    if ns.Keybinds then
        ns.Keybinds:Initialize()
    end
    if ns.Assistant then
        ns.Assistant:Initialize()
    end
    if ns.CooldownFont then
        ns.CooldownFont:Initialize()
    end
    if ns.TrackerDB then
        ns.TrackerDB:InitializeDB()
    end
    if ns.TrackerItemViewer then
        if ns.db.profile.tracker_enabled then
            ns.TrackerItemViewer:Initialize()
            ns.TrackerItemViewer:ShowAll()
        else
            ns.TrackerItemViewer:HideAll()
        end
    end
    if ns.BuffContainerViewer then
        if ns.BuffData and ns.BuffData.IsEnabled() then
            ns.BuffContainerViewer:Initialize()
            ns.BuffContainerViewer:ShowAll()
        else
            ns.BuffContainerViewer:HideAll()
        end
    end
    if ns.CooldownStyle then
        ns.CooldownStyle:Initialize()
    end
    if ns.MasqueModule then
        ns.MasqueModule:Initialize()
    end
    if ns.ButtonPress then
        ns.ButtonPress:Initialize()
    end
    if ns.CMCVisibility then
        ns.CMCVisibility:Initialize()
    end

    if ns.db.profile.cooldownManager_buttonPress then
        AddOnFrame:SetScript("OnEvent", function(_, event, argument)
            if not ns.db.profile.cooldownManager_buttonPress then
                return
            end
            if event == "ADDON_LOADED" and argument == "Dominos" then
                ns.ButtonPress:HookAllDominosButtons()
            end
            if event == "ADDON_LOADED" and argument == "ElvUI" then
                ns.ButtonPress:RegisterElvUICallbacks()
            end
        end)
        if C_AddOns.IsAddOnLoaded("Dominos") then
            ns.ButtonPress:HookAllDominosButtons()
        end
        if C_AddOns.IsAddOnLoaded("ElvUI") then
            ns.ButtonPress:RegisterElvUICallbacks()
        end
    end

    local LSM = LibStub("LibSharedMedia-3.0", true)
    if LSM and not self._lsmCallbackRegistered then
        self._lsmCallbackRegistered = true
        local refreshQueued = false
        LSM.RegisterCallback(self, "LibSharedMedia_Registered", function(_, mediaType)
            if mediaType ~= "font" then
                return
            end
            if refreshQueued then
                return
            end
            refreshQueued = true
            C_Timer.After(1, function()
                refreshQueued = false
                addon:RefreshConfig()
            end)
        end)
    end

    AddonCompartmentFrame:RegisterAddon({
        text = "|cff008945Cool|r|cff1e9a4e|r|cff3faa4fdown Ma|r|cff5fb64anag|r|cff7ac243er Ce|r|cff8ccd00ntered|r",
        icon = "Interface\\Addons\\CooldownManagerCentered\\Media\\CooldownManagerCenteredIcon",
        notCheckable = true,
        func = function()
            addon:OpenSettings()
        end,
        funcOnEnter = function(button)
            MenuUtil.ShowTooltip(button, function(tt)
                if tt and tt.AddLine then
                    tt:AddLine("Cooldown Manager Centered")
                    tt:AddLine(L["Left-click: Open settings"], 0.6, 0.8, 1)
                end
            end)
        end,
        funcOnLeave = function(button)
            MenuUtil.HideTooltip(button)
        end,
    })
end

-- Fill the per-spec buff assignment set after the specialization/loadout
-- settles. The delayed run lets Blizzard finish updating spec + CDM data; the
-- immediate invalidation events in BuffContainerViewer cover the scan.
local specMigrationQueued = false
local specMigrationFrame = CreateFrame("Frame")
specMigrationFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
specMigrationFrame:RegisterEvent("ACTIVE_PLAYER_SPECIALIZATION_CHANGED")
specMigrationFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
specMigrationFrame:SetScript("OnEvent", function()
    if specMigrationQueued then
        return
    end
    specMigrationQueued = true
    C_Timer.After(0.5, function()
        specMigrationQueued = false
        ns.BuffData.InvalidateScan()
        if ns.BuffContainerViewer then
            ns.BuffContainerViewer:ReconcileContainerCount()
            ns.BuffContainerViewer:RefreshCustomAuras()
        end
        if ns.CooldownManager then
            ns.CooldownManager.ForceRefresh({ icons = true })
        end
        if ns.BuffAssignmentPanel and ns.BuffAssignmentPanel.RefreshPanel then
            ns.BuffAssignmentPanel:RefreshPanel()
        end
    end)
end)

C_Timer.After(2, function()
    local time = C_DateAndTime.GetCurrentCalendarTime()
    local todaysDate = time.year * 10000 + time.month * 100 + time.monthDay

    if
        ns.API:IsElvUICDMSkinningEnabled()
        and (ns.StyledIcons:IsAnyStyledFeatureEnabled() or ns.Stacks:IsAnyStacksFeatureEnabled())
        and (not ns.db.profile._elvui_skinning_asked or (ns.db.profile._elvui_skinning_asked < todaysDate - 4 or ns.db.profile._elvui_skinning_asked < 10000))
    then
        StaticPopup_Show("CMC_ELVUI_SKINNING_ASK")
        ns.db.profile._elvui_skinning_asked = todaysDate
    end

    -- -- Hide it for now
    -- if not ns.db.profile._bug_warning_displayed or (ns.db.profile._bug_warning_displayed <= todaysDate - 1) then
    --     print(
    --         "|cff008945Cool|r|cff1e9a4e|r|cff3faa4fdown Ma|r|cff5fb64anag|r|cff7ac243er Ce|r|cff8ccd00ntered|r is rarely responsible for Cooldown Manager bugs. Through the beta cycle, Blizzard ignored and still did not resolve many issues related to disappearing/changing abilities, wrong or missing auras, and other bugs. If you encounter any of those, please report them to Blizzard as well, so they can prioritize fixing them."
    --     )
    --     ns.db.profile._bug_warning_displayed = todaysDate
    -- end
end)
