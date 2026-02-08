local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Table containing internal variables, enums, etc.
---@class Definitions
local Definitions = {}
DelveCompanion.Definitions = Definitions

--- Game entity ID type used to retrieve its data from the Blizzard API. Primarly used for displaying tooltips of the corresponding type.
---@class (exact) CodeType
---@field Item string Alias for `item`.
---@field Spell string Alias for `spell`.
---@field Currency string Alias for `currency`.
---@field Achievement string Alias for `achievement`.
---@field Toy string Alias for `toy`.
Definitions.CodeType = {
    Item = "item",
    Spell = "spell",
    Currency = "currency",
    Achievement = "achievement",
    Toy = "toy"
}
setmetatable(Definitions.CodeType, {
    __tostring = function()
        return "CodeType"
    end
})

--- Table of Blizzard AddOns which are loaded on demand. Used to initialize addon modules.
---@class (exact) DependencyAddonName
---@field delvesDashboardUI string `Blizzard_DelvesDashboardUI`
---@field encounterJournal string `Blizzard_EncounterJournal`
---@field rio string `RaiderIO`
---@field tomtom string `TomTom`
---@field mpe string `MapPinEnhanced`
Definitions.DependencyAddonName = {
    delvesDashboardUI = "Blizzard_DelvesDashboardUI",
    encounterJournal = "Blizzard_EncounterJournal",
    rio = "RaiderIO",
    tomtom = "TomTom",
    mpe = "MapPinEnhanced"
}

---@class (exact) Link
---@field name string
---@field url string

---@class (exact) Links
---@field CurseForge Link
---@field Wago Link
---@field WoWInt Link
---@field GitHub Link
Definitions.Links = {
    CurseForge = {
        name = "CurseForge",
        url = "https://www.curseforge.com/wow/addons/delve-companion"
    },
    Wago = {
        name = "Wago.io",
        url = "https://addons.wago.io/addons/delve-companion"
    },
    WoWInt = {
        name = "WoW Interface",
        url = "https://www.wowinterface.com/downloads/fileinfo.php?id=26915#info"
    },
    GitHub = {
        name = "GitHub",
        url = "https://github.com/FunDeliveryGames/wow-delve-companion"
    }
}

---@class ButtonAlias
Definitions.ButtonAlias = {
    leftClick = "LeftButton",
    rightClick = "RightButton"
}

---@class (exact) WaypointTrackingType
---@field superTrack number
---@field tomtom number
---@field mpe number
Definitions.WaypointTrackingType = {
    superTrack = 1,
    tomtom = 2,
    mpe = 3
}

---@class (exact) CompanionWidgetLayout
---@field horizontal number
---@field vertical number
Definitions.CompanionWidgetLayout = {
    horizontal = 1,
    vertical = 2
}

---@class (exact) InDelveWidgetDisplayRule Controls how [InDelveWidget](lua://InDelveWidget) is displayed.
---@field left number Widget is shown on the left side of Objective Tracker.
---@field right number Widget is shown on the right side of Objective Tracker.
Definitions.InDelveWidgetDisplayRule = {
    left = 1,
    right = 2
}

---@class AddonEvents
Definitions.Events = {
    SETTING_CHANGE = "DelveCompanion.SettingChange", -- Whenever any addon setting is changed.
    DELVE_INSTANCE_BUTTON_CLICK = "DelveCompanion.RequestDelveInfoFrame",
    PROGRESS_TRACKER = {
        DELVE_IN_PROGRESS = "DelveCompanion.DelveInProgress",             -- Delve has started or has been left.
        DELVE_RESPAWN_ACTIVATED = "DelveCompanion.DelveRespawnActivated", -- Respawn has been activated in the Delve.
        DELVE_COMPLETE = "DelveCompanion.DelveComplete",                  -- Delve has been completed.
    }
}
