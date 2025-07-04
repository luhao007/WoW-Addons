--[===[ File
This file contains Config 'recent changes' and notes.
It should be updated for each Titan release!

These are in a seperate file to
1) Increase the chance these strings get updated
2) Decrease the chance of breaking the code :).
--]===]

--[[ Var Release Notes
Detail changes for last 4 - 5 releases.
Format :
Gold - version & date
Green - 'header' - Titan or plugin
Highlight - notes. tips. and details
--]]
Titan_Global.recent_changes = ""
.. TitanUtils_GetGoldText("8.3.0 : 2025/07/2\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "-  Major change : \n"
.. "-  - : Titan users will have their Titan options reset.\n"
.. "-  - : Titan plugin options should be the same after update.\n"
.. "-  - : Titan 3rd party plugins for Classic must be updated.\n"
.. "-  Internally : \n"
.. "-  - : TitanClassic is no longer an ID.\n"
.. "-  - : Titan Classic 3rd party plugins must use Titan as the dependency in TOC, not TitanClassic.\n"
.. "-  - : Saved variables will be in Titan.lua rather than TitanCLassic.lua.\n"
)
.. TitanUtils_GetGoldText("8.2.6 : 2025/06/23\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- TWW version to 11.1.7.\n"
)
.. TitanUtils_GetGoldText("8.2.5 : 2025/05/22\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "-  Updates to add timer for drop down menu (was not working in retail and Cata).\n"
.. "-  Change drop down menu wrappers (Utils) to use Blizz routines over Ace.\n"
)
.. TitanUtils_GetGoldText("8.2.4 : 2025/02/03\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- TWW version to 11.1.5.\n"
.. TitanUtils_GetGreenText("Repair : \n")
.. "- Updated color code parsing.  Thank you to Centias for finding this for us!\n"
)
.. TitanUtils_GetGoldText("8.2.3 : 2025/04/23\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- CE version to 1.15.6.\n"
.. "- Update TOC to use new Addon category tag.\n"
.. "- Update Config to use new AddonCompartment (retail only).\n"
.. TitanUtils_GetGreenText("Location : \n")
.. "- CE only, remove ShowLocOnMinimap.\n"
)
.. TitanUtils_GetGoldText("8.2.2 : 2025/02/05\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- TWW version to 11.1.0.\n"
)
.. TitanUtils_GetGoldText("8.2.1 : 2025/02/03\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- CE version to 1.15.6.\n"
.. "- Gray (disable) Hide if the bar is the only bar.\n"
)
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Another fix when logging into an 'old' toon.\n"
.. "- Fix error on 'reset database'.\n"
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.2.0 : 2025/01/03\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Internal fixes to prevent timing issues for built-in plugins on init - any splash screen .\n"
)
.. "\n\n"

--[[ Var Notes
Use for important notes in the Titan Config About
--]]
Titan_Global.config_notes = ""
    .. TitanUtils_GetGoldText("Notes:\n")
    .. TitanUtils_GetHighlightText(""
        ..
        "- Changing Titan Scaling : Short bars will move on screen. They should not go off screen. If Short bars move then drag to desired location. You may have to Reset the Short bar or temporarily disable top or bottom bars to drag the Short bar.\n"
    )
    .. "\n"
    .. TitanUtils_GetGoldText("Known Issues:\n")
    .. TitanUtils_GetHighlightText(""
    .. "- Cata : Titan right-click menu may stay visible even if click elsewhere. Hit Esc twice. Investigating...\n"
)
