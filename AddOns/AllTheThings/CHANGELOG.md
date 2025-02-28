# AllTheThings

## [4.3.1](https://github.com/ATTWoWAddon/AllTheThings/tree/4.3.1) (2025-02-27)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.3.0...4.3.1) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- put the parser into parser  
- Fix some reported errors  
- try nr2  
- Enterprising Hero: TWW S2 Tooltip fix for English Locale (Sorry other languages)  
- go away delves it's too early  
- double checked some stuff  
    tagged some s2 stuff as removed by s3 start  
- Revert Weapons of Conquest timeline  
- added correct header for delves  
    tagged s2 delves accordingly  
    found a pvp achievement we had tagged as removed the entire S1 (available for 6 more days)  
    corrected coffer key shards tag  
    corrected pvp vendor items  
- Sort some rare drops  
- updated things that only get removed with s2 start to the best of my knowledge  
    stuff like m+ acm mounts & portals are still available  
- Cata: Updated the Full Scan Button on the AH Module.  
- Fix some reported errors  
- Update Quests.lua  
- mounts returns invalid  
- ingame display info was wrong  
- Dedupe renown quests, mark accwide, add some notes and coords  
- [DB] Items with Quests can now be defined as 'HQT' such that they aren't collectible via Character Unlocks but rather by HQT  
    * In some situations we used Character Unlock to enable tracking certain Items which had a one-time QuestID trigger (e.g. Profession Knowledge books), but otherwise had no actual impact to gameplay (like other Character Unlocks)  
    [Logic] Now supporting ItemAsHQT type tracked via '+HQT' option  
- Sort Undermine quest chains into headers, fix minor errors  
- [Harvest] Updated Items/Quests BNet Harvest for 11.1  
    [Parser] Reparsed all versions  
- [Parser] Default timeline for Achievements is now only applied when parsing versions after WOTLK  
- [Harvester] Adjusted throttling calculations slightly since Blizzard seems to think 36,000 per hour is different than 100ms minimum delay between requests, maybe this will help it go faster (also Blizzard please add a batch API method for Item/Quest retrieval)  
- Added all new PvE Tier Sets: Raid + Catalyst.  
- Add delve chest coords  
- [Logic] Retail: Battle Pets collection logic adjusted again... ideally we can use the previously-existing logic to scan a user's known battle pets directly. Alternatively we get horribly inaccurate data from Blizzard and we have to manually scan all possible Battle Pets using ATT data. This method unfortunately means we are not able to detect when Battle Pets are caged. So stop caging your pets! ;)  
- [CI] Change the Parser trigger condition.  
    Change the trigger condition to Parser related data changes.  
- [CI] Add Parser flow to each push event.  
- [DB] Added Misprinted Draenic Coin to WoD rewards  
- Fix many minor errors  
- Fix G.E.T.A. quest chain  
- [Logic] Retail: Rewrote the Battle Pet collection logic to not rely on PetJournal API functions that don't return consistent or accurate values for some players. Thanks Blizzard  
- AchievementDB harvest and parse for Retail  
