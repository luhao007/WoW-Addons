---@diagnostic disable
-- Preydator: enUS (English) localization reference.
-- English strings are the keys, so no assignments are strictly required here.
-- This file exists as the authoritative translation guide for other locales.
-- To create a new translation, copy this file, change the locale guard, and fill in values.

-- if GetLocale() ~= "enUS" then return end
-- local L = _G.PreydatorL

--[[  TRANSLATION GUIDE
     Fill in each value with the translated text. Remove the comment markers.
     Entries left empty or commented out will fall back to the English key.

---- Stage defaults (displayed in the progress bar; players can override in Options > Text)
  L["No Sign in These Fields"]   = ""
  L["AMBUSH"]                    = ""
  L["Scent in the Wind"]         = ""
  L["Blood in the Shadows"]      = ""
  L["Echoes of the Kill"]        = ""
  L["Feast of the Fang"]         = ""

---- Options panel tabs
  L["General"]    = ""
  L["Display"]    = ""
  L["Vertical"]   = ""
  L["Text"]       = ""
  L["Audio"]      = ""
  L["Currencies"] = ""
  L["Advanced"]   = ""

---- Section headers
  L["Visibility"]            = ""
  L["Behavior"]              = ""
  L["Hunt Table"]            = ""
  L["Currencies"]            = ""
  L["Bar Size"]              = ""
  L["Progress Display"]      = ""
  L["Visual Style"]          = ""
  L["Vertical Mode"]         = ""
  L["Vertical Dimensions"]   = ""
  L["Label Mode"]            = ""
  L["Prefix Labels"]         = ""
  L["Label Placement"]       = ""
  L["Suffix Labels"]         = ""
  L["Sound Selection"]       = ""
  L["Custom Files / Tests"]  = ""
  L["Restore / Reset"]       = ""
  L["Notes"]                 = ""

---- Checkboxes
  L["Lock Bar"]                          = ""
  L["Only show in prey zone"]            = ""
  L["Disable Default Prey Icon"]         = ""
  L["Show in Edit Mode preview"]         = ""
  L["Enable Hunt Table Tracker"]         = ""
  L["Enable sounds"]                     = ""
  L["Ambush sound alert"]                = ""
  L["Ambush visual alert"]               = ""
  L["Show tick marks"]                   = ""
  L["Display Spark Line"]                = ""
  L["Link border color to fill"]         = ""
  L["Show Percentage at Tick Marks"]     = ""
  L["Enable Debug"]                      = ""
  L["Currency Debug Events"]             = ""
  L["Show Minimap Button"]               = ""
  L["Show Affordable Hunts In Tracker"]  = ""
  L["Show Group By Realm In Warband"]    = ""
  L["Show bar during Edit Mode"]         = ""

---- Dropdown field titles
  L["Currency Theme"]           = ""
  L["Progress Segments"]        = ""
  L["Sound Channel"]            = ""
  L["Hunt Panel Side"]          = ""
  L["Bar Orientation"]          = ""
  L["Vertical Fill Direction"]  = ""
  L["Vertical Text Side"]       = ""
  L["Vertical Text Alignment"]  = ""
  L["Vertical Percent Display"] = ""
  L["Vertical Percent Tick Mark"] = ""
  L["Percent Display"]          = ""
  L["Text Display"]             = ""
  L["Texture"]                  = ""
  L["Title Font"]               = ""
  L["Percent Font"]             = ""
  L["Ambush Sound"]             = ""

---- Slider labels
  L["Scale"]                 = ""
  L["Width"]                 = ""
  L["Height"]                = ""
  L["Font Size"]             = ""
  L["Enhance Sounds"]        = ""
  L["Vertical Text Offset"]  = ""
  L["Vertical Percent Offset"] = ""

---- Sound dropdown labels (dynamic Stage N format)
  L["Stage %d Sound"] = ""   -- e.g. "Stage 1 Sound", "Stage 2 Sound"

---- Text input labels
  L["Stage %d"]              = ""   -- e.g. "Stage 1", "Stage 2"
  L["Out of Zone Prefix"]    = ""
  L["Ambush Prefix"]         = ""
  L["Out of Zone Label"]     = ""
  L["Ambush Override Text"]  = ""
  L["Custom Sound File"]     = ""

---- Color buttons
  L["Fill Color"]        = ""
  L["Background Color"]  = ""
  L["Title Color"]       = ""
  L["Percent Color"]     = ""
  L["Tick Mark Color"]   = ""
  L["Border Color"]      = ""

---- Action buttons
  L["Restore Default Names"]   = ""
  L["Restore Default Sounds"]  = ""
  L["Reset All Defaults"]      = ""
  L["Add File"]                = ""
  L["Remove File"]             = ""
  L["Test Stage %d"]           = ""   -- e.g. "Test Stage 1"
  L["Test Ambush"]             = ""
  L["Show What's New"]         = ""

---- Dropdown option values — Texture
  L["Default"]          = ""
  L["Flat"]             = ""
  L["Raid HP Fill"]     = ""
  L["Classic Skill Bar"] = ""

---- Dropdown option values — Font
  L["Friz Quadrata"]  = ""
  L["Arial Narrow"]   = ""
  L["Skurri"]         = ""
  L["Morpheus"]       = ""

---- Dropdown option values — Sound channel
  L["Master"]   = ""
  L["SFX"]      = ""
  L["Dialog"]   = ""
  L["Ambience"] = ""

---- Dropdown option values — Currency theme
  L["Light"]  = ""
  L["Brown"]  = ""
  L["Dark"]   = ""

---- Dropdown option values — Percent display
  L["In Bar"]      = ""
  L["Above Bar"]   = ""
  L["Above Ticks"] = ""
  L["Under Ticks"] = ""
  L["Below Bar"]   = ""
  L["Off"]         = ""

---- Dropdown option values — Tick layer
  L["Above Fill"] = ""
  L["Below Fill"] = ""

---- Dropdown option values — Progress segments
  L["Quarters (25/50/75/100)"] = ""
  L["Thirds (33/66/100)"]      = ""

---- Dropdown option values — Label mode
  L["Centered"]                 = ""
  L["Left (Prefix only)"]       = ""
  L["Left (Prefix + Suffix)"]   = ""
  L["Left (Suffix only)"]       = ""
  L["Right (Suffix only)"]      = ""
  L["Right (Prefix + Suffix)"]  = ""
  L["Right (Prefix only)"]      = ""
  L["Separate (Prefix + Suffix)"] = ""
  L["No Text"]                  = ""

---- Dropdown option values — Label row
  L["Above Bar"] = ""   -- shared key
  L["Below Bar"] = ""   -- shared key

---- Dropdown option values — Orientation
  L["Horizontal"] = ""
  L["Vertical"]   = ""

---- Dropdown option values — Vertical fill
  L["Fill Up"]   = ""
  L["Fill Down"] = ""

---- Dropdown option values — Sides
  L["Left"]   = ""
  L["Right"]  = ""
  L["Center"] = ""

---- Dropdown option values — Vertical text align
  L["Top Align"]           = ""
  L["Middle Align"]        = ""
  L["Bottom Align"]        = ""
  L["Top Prefix Only"]     = ""
  L["Top Suffix Only"]     = ""
  L["Bottom Prefix Only"]  = ""
  L["Bottom Suffix Only"]  = ""
  L["Separate Prefix/Suffix"] = ""

---- Dropdown option values — Vertical percent display (short form)
  L["Above"]  = ""
  L["Inside"] = ""
  L["Below"]  = ""

---- Hint/note blocks
  L["HINT_VERTICAL_PERCENT_OFFSET"] = "Vertical Percent Offset applies to vertical side/tick-mark side placements. Use tick marks to replace the single percent value."
  L["HINT_VERTICAL_LOCK"]           = "In Vertical mode, only Label Mode and Prefix/Suffix Row are locked here. Stage names and custom labels remain editable."
  L["HINT_AUDIO_SLIDER"]            = "Slider values can be dragged or typed directly. Custom sound input accepts bare names, .ogg, or full addon paths."
  L["HINT_ADVANCED_NOTES"]          = "Existing installs keep their current saved values. New settings are only applied when a key is missing in PreydatorDB. This panel replaces the old long-form options page but uses the same database. The Inspect feature is compatible with BugSack."
  L["HINT_PANEL_SUBTITLE"]          = "Tabbed options layout with two-column pages. Slider values can be dragged or typed directly."

---- Print / chat messages
  L["Preydator: Added sound file '%s'."]    = ""
  L["Preydator: Removed sound file '%s'."]  = ""
  L["Preydator: No stage %d sound configured."] = ""
  L["Preydator: Stage %d sound file failed to play. Ensure this file exists as .ogg: %s"] = ""

---- EditMode window
  L["Preydator Edit Mode"]       = ""
  L["HINT_EDITMODE_SUBTITLE"]    = "Quick layout controls while Blizzard Edit Mode is open. Full Options can be found in Options > Addons > Preydator."

---- Currency Tracker windows
  L["Preydator Currency"]        = ""
  L["Preydator Warband"]         = ""
  L["Currency Tracker"]          = ""
  L["Preydator Updates: New in 2.0.0"] = ""
  L["WHATS_NEW_BODY"]            = "Preydator 2.0.0 is live.\n\n- New module system lets you disable Bar, Sounds, Currency, Hunt Table, and Warband paths independently\n- Module-aware settings now gray out automatically and require reload only when changed\n- Currency and Warband windows now force-close when their modules are disabled\n- Bar-only routing improved: prey zone fallback now uses quest map presence when zone IDs are unavailable\n- CPU optimizations tighten zone caching and skip unnecessary refresh routes\n\nFirst load starts with the bar unlocked so you can place it quickly. Use Lock Frame in Options when you are done positioning."
  L["Got It"]                    = ""
  L["Open Settings"]             = ""
  L["Toggle Tracker"]            = ""
  L["Toggle Warband"]            = ""
  L["Open Tracker"]              = ""
  L["Close Tracker"]             = ""
  L["Open Warband"]              = ""
  L["Close Warband"]             = ""
  L["Gain Color"]                = ""
  L["Spend Color"]               = ""

---- Hunt Table companion panel
  L["Preydator Hunt Tracker"]                          = ""
  L["Available Hunts"]                                 = ""
  L["Rewards unknown"]                                 = ""
  L["Reward data pending"]                             = ""
  L["No available hunts"]                              = ""
  L["Use /pd huntdebug at a hunt table to print payload data."] = ""

---- Currency config page labels
  L["Currencies to Track"]          = ""
  L["Random Hunt Cost (Anguish)"]   = ""
  L["Panel Layout"]                 = ""
  L["Adjust"]                       = ""
  L["Delta Preview"]                = ""
  L["Normal"]                       = ""
  L["Hard"]                         = ""
  L["Nightmare"]                    = ""
  L["Currency Window"]              = ""
  L["Warband Window"]               = ""

---- Warband column headers
  L["Realm"]     = ""
  L["Character"] = ""
  L["Anguish"]   = ""
  L["Voidlight"] = ""
  L["Adv"]       = ""
  L["Vet"]       = ""
  L["Champ"]     = ""
  L["N/H/Ni"]    = ""   -- Difficulty abbreviation (Normal/Hard/Nightmare); translators may provide their own

---- Warband dynamic row labels
  L["Total"]     = ""
  L["All Realms"] = ""
  L["Totals"]    = ""
  L["Subtotal"]  = ""

---- Currency tracker summary format
  L["Normal %d | Hard %d | Nightmare %s"] = ""

---- Modules page
  L["Module Status"]                                                                                    = ""
  L["Bar Module"]                                                                                       = ""
  L["Controls the main prey progress bar display and behavior."]                                       = ""
  L["Sounds Module"]                                                                                    = ""
  L["Controls stage sounds and ambush audio settings."]                                                = ""
  L["Currency Module"]                                                                                  = ""
  L["Controls the currency tracker panel and currency displays."]                                      = ""
  L["Hunt Table Module"]                                                                               = ""
  L["Controls hunt table data, sorting, and panel features."]                                          = ""
  L["Warband Module"]                                                                                   = ""
  L["Controls the warband currency panel and roster view."]                                            = ""
  L["Achievement Module"]                                                                              = ""
  L["Coming soon: achievement tracking is not available yet."]                                         = ""
  L["Reload"]                                                                                           = ""
  L["Module changes require a reload to fully apply. Achievement module remains disabled until it is released."] = ""

---- Minimap / LDB tooltip
  L["Left Click: Toggle Currency Window"]  = ""
  L["Right Click: Toggle Warband Window"]  = ""
  L["Shift + Right Click: Open Options"]   = ""
  L["Preydator Currency Tracker"]          = ""
--]]

-- Runtime defaults for semantic keys. These are not English-as-key labels,
-- so they must be explicitly assigned to avoid showing raw key names.
local L = _G.PreydatorL
if not L then
    return
end

L["HINT_VERTICAL_PERCENT_OFFSET"] = "Vertical Percent Offset applies to vertical side/tick-mark side placements. Use tick marks to replace the single percent value."
L["HINT_VERTICAL_LOCK"] = "In Vertical mode, only Label Mode and Prefix/Suffix Row are locked here. Stage names and custom labels remain editable."
L["HINT_AUDIO_SLIDER"] = "Slider values can be dragged or typed directly. Custom sound input accepts bare names, .ogg, or full addon paths."
L["HINT_ADVANCED_NOTES"] = "Existing installs keep their current saved values. New settings are only applied when a key is missing in PreydatorDB. This panel replaces the old long-form options page but uses the same database. The Inspect feature is compatible with BugSack."
L["HINT_PANEL_SUBTITLE"] = "Tabbed options layout with two-column pages. Slider values can be dragged or typed directly."
L["HINT_EDITMODE_SUBTITLE"] = "Quick layout controls while Blizzard Edit Mode is open. Full Options can be found in Options > Addons > Preydator."
L["WHATS_NEW_BODY"] = "Preydator 2.0.0 is live.\n\n- New module system lets you disable Bar, Sounds, Currency, Hunt Table, and Warband paths independently\n- Module-aware settings now gray out automatically and require reload only when changed\n- Currency and Warband windows now force-close when their modules are disabled\n- Bar-only routing improved: prey zone fallback now uses quest map presence when zone IDs are unavailable\n- CPU optimizations tighten zone caching and skip unnecessary refresh routes\n\nFirst load starts with the bar unlocked so you can place it quickly. Use Lock Frame in Options when you are done positioning."
