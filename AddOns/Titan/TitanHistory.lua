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
.. TitanUtils_GetGoldText("8.1.7 : 2024/12/22\n")
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Hopefully fix an error on character start ocurring on some systems."
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.1.6 : 2024/12/09\n")
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Warband gold updated properly in tooltip."
)
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Update ACE3 libs."
.. "- Bars - Config Color picker now works; changed in 10.2.5 (Jan 2024)."
.. "- Bars - Config when selecting Skin vs Color the 'other' controls are disabled."
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.1.5 : 2024/11/20\n")
.. TitanUtils_GetGreenText("Loot - Classic Era : \n")
.. TitanUtils_GetHighlightText(""
.. "- Code changes per change in API."
.. "- Code changes per change in XML parsing."
)
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Retail TOC to 11.0.5."
.. "- Cata TOC to 4.4.1."
.. "- Classic Era TOC to 1.15.5"
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.1.4 : 2024/10/24\n")
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Add display of Realm (optional)."
.. "- Add display of Connected Realms to tooltip."
)
.. TitanUtils_GetGreenText("Gold : \n")
.. TitanUtils_GetHighlightText(""
.. "- Hopefully fix error some see on start Ticket #1415."
.. "- Make show of Warbank bank gold optional."
)
.. TitanUtils_GetGreenText("Loot : \n")
.. TitanUtils_GetHighlightText(""
.. "- Additional comments; use # over deprecated table.getn."
)
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Additional comments."
)
.. "\n\n"
.. TitanUtils_GetGoldText("8.1.3 : 2024/09/27\n")
.. TitanUtils_GetGreenText("XP : \n")
.. TitanUtils_GetHighlightText(""
.. "- Update XP timer to update every 10 versus 30 sec."
)
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Modified TitanMovable to remove API hooks that Blizzard screwed up."
.. "- Classic Era TOC to 1.15.4."
)
.. "\n\n"
Titan_Global.recent_changes = ""
.. TitanUtils_GetGoldText("8.1.0 : 2024/08/06\n")
.. TitanUtils_GetGreenText("Titan : \n")
.. TitanUtils_GetHighlightText(""
.. "- Updated TOC files to use *_Classic; single TOC file for Classic versions"
.. "- Updated retail TOC files to 11.0.2"
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
