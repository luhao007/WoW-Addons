# AllTheThings

## [4.5.7](https://github.com/ATTWoWAddon/AllTheThings/tree/4.5.7) (2025-07-04)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.5.6...4.5.7) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [DB] Found an Item in the Nighthold  
- Cleaned up some more "fill" in Retail.  
- Rin'wosho the Trader doesn't need to be in two places.  
- Classic: Reparsed all DBs to remove references to "fill". ("fill" is now exclusively used in Retail for the moment!)  
- [DB] Mist: Update Elwynn Forest.  
    Update objective of q 26913, 26915, 26916, 26918, 26919.  
    Update annotated.  
- Benthic tokens no longer use fill and make use of the new container functionality.  
- Converted Azeroth Mini Pack: Bondo's Yard to a container.  
- Converted Draconic Recipe in a Bottle to a container.  
- Baleful tokens no longer use fill and make use of the new container functionality.  
- Heirloom upgrade tokens no longer uses "fill". (Doesn't look any different without it. Let cost evaluation do its thing!)  
- Ancient Heirloom Scabbard no longer uses "fill". (Doesn't look any different without it.)  
- Ancient Heirloom Armor Casing no longer uses "fill". (Doesn't look any different without it.)  
- Fix the ID of Viceroy Nezhar in hero and mythic (#2075)  
- Introduced a helper function for item containers that are rewarded from various sources to help clean up the logic.  
- PET BATTLES: Moved The Longest Day to the Character Achievements section and automated the data. (This is to test what it will look like in that section.)  
- PET BATTLES: Moved all Pre-MOP Pet Tamer Daily Quests to the pet battles section and nested them within their respective pet tamer. This will provide context to the strategy without duplicating the necessary information as well as ensuring that the tamer itself remains visible while the player quests through the primary quest chain for Pet Battles.  
- Fixed a display issue that allowed criteria to be selected when looking at sourceAchievements.  
- Moved all Pet Battle Tamers to their respective zones for criteriaID mapping to work correctly rather than duplicate the entries.  
    Also added petBattleLvl to all of the pre-MOP Pet Battle Tamers.  
- Added "petBattleLvl" to parser and to tooltips.  
- [DB] Fix timeline for Bladed/Razor claws :)  
- [DB] Fix timeline for WoD mythic dungeon heirlooms  
- [DB] Fix timeline for SoO Garrosh heirlooms  
- [DB] Fix timeline for heirlooms added in Mists  
- [DB] Fix timeline for heirlooms added (or created) in Cata  
- [DB] Fix timeline for Wrath heirlooms  
- Refactored "PET\_BATTLE" to "PET\_BATTLES" to match the in-game localization.  
- 11.2.0.61787 hidden achievement triggers  
- Added more icons into the icon legend in Interface.  
- Moved NYI Dastardly Duos quests into NYI file.  
- Update CacheVersion for Greedy Emissary / MoP fix  
- Fix a few reported errors, fixes #2068  
- [Mists] New heirlooms are actually in the game, but they're ONLY buyable with JP  
- [DB] Missed applyclassicphase change on a file  
- [Mists] Seesaw toy isn't available until (probably) Escalation phase  
- [DB] We should use a bit of that applyclassicphase function  
- [Mists] Patch 5.2.0 heirlooms are not in the game yet  
- [DB] Classic: Update Elwynn Forest.  
    Mist: Update coord of q 26913, 26914, 26915, 26916, 26917, 26918, 26919.  
    Mist: Update objective of q 26914.  
    Mist: Remove dummy coord of q 26914.  
    Cata: Update coord of q 26914.  
    Cata: Remove dummy coord of q 26914.  
- Classic: Right clicking a difficulty now properly pops out the difficulty header itself rather than do a source lookup.  
- Moved the Scenaturday achieve criteria to their respective Scenarios.  
- Updated the ClassPresetsDB to use the constants provided by the ItemFilters library file. (Also confirmed that certain filters were not necessary to include)  
- [MoP/Retail] Cata head enchants have been removed from the game in MoP  
- [DB} Retail: Removed a couple duplicated Netherstorm PvP Vendors which get mapped from their PvP home  
- [Logic] Fixed Vignette reporting such that Unknown/Unsourced vignettes can still be reported without Include Completed (Completed are only Vignettes which actually have collectibles AND nothing left to collect)  
- Classic: Added the "Local List" (/attlocal), a Mini List alternative that behaves similarly to the Mini List, but shows all content related to the map in a search result container rather than a dynamic sorted list. This tool is more so to be used for debugging than anything else.  
- Refactor Dastardly Duos quest section by removing unused quests and adding comments for clarity  
- [DB] Cata: Update Teldrassil.  
    Update coord of q 28713.  
    Update coord of q 28714.  
    Update coord of q 28734.  
    Update providers of q 3116.  
    Update coord of q 26945.  
    Update providers of q 3117.  
    Update coord of q 26947.  
    Update providers of q 3118.  
    Update coord of q 26946.  
    Update providers of q 3119.  
    Update coord of q 26949.  
    Update providers of q 26841.  
    Update coord of q 26940.  
    Update providers of q 3120.  
