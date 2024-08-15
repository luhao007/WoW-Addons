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
.. TitanUtils_GetGoldText("8.1.0 : 2024/08/06\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Updated TOC files to use *_Classic; single TOC file for Classic versions"
)
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Retail ONLY - Added Warband bank at bottom of list for totals.\n"
.. "- Better alignment when silver or copper are zero.\n"
.. "- Added space (' ') as a thousands separator option with comma and period.\n"
.. "- Show and Delete toon menus sort per user options.\n"
.. "- Shift + Left click will put the connected server list into Chat (also in Plugin Notes).\n"
)
.. TitanUtils_GetGreenText("Bags : \n")
.. TitanUtils_GetHighlightText(""
.. "- Retail ONLY : Added Reagent Bag slot.\n"
.. "- All : Removed profession count option.\n"
.. "- All : Profession counts are in Detailed Tooltip as grey - NOT added to free / used totals.\n"
)
.. TitanUtils_GetGreenText("Volume : \n")
.. TitanUtils_GetHighlightText(""
.. "- Fix double click Mute - it now toggles properly and icon changes.\n"
)
.. TitanUtils_GetGreenText("Regen : \n")
.. TitanUtils_GetHighlightText(""
.. "- Cleanup documentation (comments); made some routines local.\n"
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.0.16 : 2024/07/22\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Updated Retail version to 11.0.0."
)
.. TitanUtils_GetGreenText("Gold, Repair, XP : \n")
.. TitanUtils_GetHighlightText(""
.. "- Gold : Fix gold display when user selects . (period) as thousands separator.\n"
.. "- Added TitanUtils_NumToString for use in all 3.\n"
.. "- Added TitanUtils_CashToString for use in Gold and Repair for common look of gold/silver/copper.\n"
)
.. TitanUtils_GetGreenText("Regen : \n")
.. TitanUtils_GetHighlightText(""
.. "- Cleanup documentation (comments); made some routines local.\n"
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.0.15 : 2024/07/14\n")
.. TitanUtils_GetGreenText("Location : \n")
.. TitanUtils_GetHighlightText(""
.. "- Fix error shown when in instances.\n"
.. "- Options same in all versions: Show Zone Text shows text or not; Show ONLY subzone removes zone text.\n"
)
.. TitanUtils_GetGreenText("Auto Hide (full bars) : \n")
.. TitanUtils_GetHighlightText(""
.. "- Fix error on clicking 'pin' to toggle auto hide.\n"
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.0.14 : 2024/07/12\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Updated Classic Era version to 1.15.3."
.. "- AutoHide : Fix tooltip error; shows Enabled / Disabled.\n"
.. "- Deprecated Titan Child template plugin code removed.\n"
.. "- Cleanup Titan tool tip code.\n"
.. "- Refactor Titan code to move color codes to Titan globals.\n"
.. "- Add debug to Titan startup code.\n"
)
.. TitanUtils_GetGreenText("Clock, Location, Performance, Repair, Volume, XP : \n")
.. TitanUtils_GetHighlightText(""
.. "- Refactor code for IDE, mostly comments; some code.\n"
.. "- Refactor code for Titan color code changes.\n"
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
