# AllTheThings

## [4.8.8](https://github.com/ATTWoWAddon/AllTheThings/tree/4.8.8) (2026-01-01)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.8.7...4.8.8) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [Parser] Removed 'timelineSelf' overrides for now since they actually don't seem to function as expected upon further inspection  
- [Parser] 'bubbleDownSelf' used with only 'timeline' will now directly perform 'timelineSelf' instead to allow for proper timeline inheritance without worry of cross-contamination of shared headers between multiple files  
- [Parser] Slight adjustment and TODO notes for removed-only timeline handling  
- Timeline Trading Post  
- Remix Legion: Erus (The Golden NPC) also sells Fragmented Mementos, but for Flawless Threads  
    - Minor formatting fixes  
- Misc fixes  
    - Warcraft rumble mail quest are gone long time ago  
    - [Classic] The small eggs are not exclusive to Darkshore  
    - [Classic] Family deaths does not require The haunted mills. Both quests can be done together.  
    - [Classic] Fix Trial of the Sea Lion Horde version  
    - HQT for Brawler guild  
    - [Remix] Maps to lesser invasion achievements  
    - [Remix] Maps to Putting the Finite in Infinite  
    - Timeline all minor patchs of classic  
    - [Classic] Timeline Amongst the Ruins quest  
    - Power Unified (75641) and Dawn of the Infinite (76140) are removed, Closes #2251  
    - [Classic] MOP Enchant Weapon - Tyranny, Closes #2248  
- Fixed timeline of Midnight Collector's Edition.  
    Added 2 missing Diablo decor items.  
- Run thru of N'Zoth BFA Unlock Questline  
- [Parser] Retail: No one reparsed Retail for a while  
- Update Glimmerogg Racer.lua  
    Add lockcriteria to Glimmerogg rep increase quests  
- [DB] MoP: Pandaren starter quests to Wandering Isle  
- Fixed sourceQuest name.  
- Corrected timeline to many artifact achievements.  
    Removed description from itemID 119409 after 10.1.5.  
- Sorted NYI decor items.  
- Added all decor items to Second Chair Pawdo.  
- Added new decor quest.  
- Moved 2 SL PvP achievements under World PvP header.  
- Retail errors  
- [Logic] Fixed Lua error on tooltips for World Quests with no timeRemaining  
- Fix a few reported errors  
- [Logic] Classic: Revert a used appName  
- [Logic] Cleaned up tons of unused variables and unnecessary assignments to remove Lua syntax warnings  
- [Misc] Clean up some Lua linting warnings  
- [Logic] /attwq now includes more Events and POIs based on what is defined in AreaPOIDB rather than being hard-coded within the logic [WIP - as Events rotate in game]  
- Generate Missing Files  
- [Logic] Retail: Cleanup and fix some /attwq object handling  
- [Logic] Fixed 'GetColoredTimeRemaining' expecting minutes instead of seconds  
- Sort Recipes  
- Harvest: 12.0.1.64914  
- Harvest: 12.0.0.65028  
- Fix Exploration  
- editor config changes  
- Harvest: 12.0.0.64975  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- [DB] Added more Area POI IDs  
- [Parser] Cleaned up formatting of a function template to remove Lua syntax errors  
- Revert "Trying to add encoding fix for different system languages when harvesting."  
- Some data fixes  
- Harvest: 11.2.7.64978  
- Harvest: 2.5.5.65000  
- Harvest: 2.5.5.64912  
- Harvest: 1.15.8.64907  
- Update Flame's Radiance.lua  
    Fixed rep requirement for title  
- Some small quest fixes.  
- [Parser] Fix an issue where implied itemID 0 could merge unexpected data for Mounts which have no Item  
- Legion: Warrior Order Hall  
    - Minor formatting fixes and a couple of QIs  
- 7th Legion Supply Crate  
- Update Iskaara Fishing.lua  
- [Logic] Slight improvement to the 'InGame' Filter logic  
- [Parser] Prep for being able to manually hook 'AreaPOI' information to ATT data to allow displaying some currently-missing time-limited content in the /attwq list  
- [DB] Add some maps to Hunter BM scenario quest  
