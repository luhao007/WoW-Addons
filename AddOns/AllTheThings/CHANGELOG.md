# AllTheThings

## [4.6.5](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.5) (2025-08-24)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.4...4.6.5) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [DB] Mists - Inscription: alphabetically fix MoP technique items up to Hand of Sacrifice  
- MOP: Moved The Anglers to its own Expansion Features file.  
- Removed 'Restored Artifact' from expansions where you can't get it.  
- [DB] Sourcing Zangar Trout and WotLK Scrolls.  
- MOP: Added the MOP\_BEFORE\_SOO preprocessor flag. Added coordinates specify to this flag to prevent post 5.4 coordinates from being plotted when the flag is available and pre-5.4 coordinates from being plotted when absent.  
- Fixed The War Within typo in folder structure  
- [DB] Update Class Trials & Boosts  
    Add level 70 Boost.  
    Update 60, 50, 48, 120, 110, 100 Boost timeline.  
- [Misc.] Fix classic references.  
- Retail: notes for some hqts other seems to be wrong?  
- final df promo iotems are now unavailable via promo (still in shop tho!)  
- changed pandaria from 05 to 06 and maelstrom from 06 to 05 (it came with cata, so before pandaria)  
- m+ resil achievements now only produce up to 18 unobtainable "things" and not ~160 anymore  
- Added back Explorations which are used by Achievement Criterias and are causing parser warnings when missing.  
- Fix some reported errors, parse  
- I don't know why this got pushed too when it was not in the commit...  
- Fixed error report for instance explorations.  
- Added Explorations into the Harvester and harvested raw Explorations.  
- [DB] Deepwind Gorge was added in 5.3, not 5.2  
- [DB] Mists: Deepwind Gorge is already available  
- Revert "[DB] Mists: MSV Raid Finder caches didn't get timeline applied properly + omit unnecessary information in Classic to reduce db size"  
- [DB] Mists: MSV Raid Finder caches didn't get timeline applied properly + omit unnecessary information in Classic to reduce db size  
- [DB] Update header of Midnight pack.  
    Use temporary headers of Midnight.  
    Update timeline.  
- [DB] Update description for Midnight expansion.  
- [Locale] Update: expansion - Midnight.  
- Removed all NYI Explorations as most of these will be implemented.  
    NYI Explorations will be added back whenever we are done with sorting the obtainable ones.  
- Exploration should not report any coords when in instance.  
- Fix some minor errors  
- [PAT] Updated source file format based on current standards.  
- [Logic] Retail: Some general Filler performance improvements  
    * Fill module localizes a couple more functions and warns in chat if they don't exist  
    * Skip logic for filling under an unavailable Quest or parent Quest now uses the same logic from the Quest module  
- [DB] Moving remaining vanilla vendor reagents  
- [Logic] Fix possible Lua error when using ReverseOrder()  
- [DB] Cleaned up some duplication due to new versions of TWW Caches each patch being copy-pasta each time  
- [Logic] Retail: Fixed a logic issue where some valid Achievement Criteria names wouldn't be shown  
- [DB] Mists: The Peak of Serenity - Complete Your Training is not in the game  
- [DB] Inscription: readd preprocessors to omit glyphs in retail  
- [DB] Inscription: sort crafted glyphs based on original glyph names  
- [DB] Fixed a couple disappeared items from S2 in Mechagon  
- Legion Remix: Ensembles added to Unicus <Exclusive Ensembles>  
- MOP: Fixed the World Drops category. (added to the white list)  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- Cleaned up alot of Khaz  
- MOP: Straw Hats sold by Gina require Best Friend with Old Hillpaw.  
- Fix some reported errors  
- Adjust Midnight Dungeon Templates  
- the expansion specific m+ & m0 headers are now together as sometimes the files were split and sometimes now. now they all have the same design  
- created global delve achievement header. there are probably more universal (e.g. not limited to tww) but dont have to jump the gun. for now only moved the complete x amount of delves  
- delves now use \_TWW ending, so they dont cause issues with future delves  
- Some Prep for Midnight  
- [Logic] Retail: Added a GetFiller(name) to allow retrieval of a specific Filler function if needed  
    [Logic] Retail: FillGroups now accepts an options param to allow specifying a specific set of Fillers to be used for the Fill operation (as opposed to being determined solely by the context of the filled group)  
- MOP: Adjusted the phase requirements for upcoming phase one releases.  
- [Parser] Now supports "release" on Phases.  
- MOP: Added a note to Lobstmourne.  
- visual cleanup for note in mechagon  
- ["description"] = "Requires the 4th Upgrade unlocked from the Reshii Wraps.  
- finished my manual slave work  
- MOP: Added the Halberd of the Unscathed for Stay Klaxxi.  
- better formating  
- only 1 bag per week can contain special loot  
- phase diving tresures requires r4  
- added Recipe: Venerable Potion of Invisibility  
- added argus header to legion remix zones to fit with "retail"  
- parsing error  
- moving folder into broken isles (split into 2 commits to see errors)  
- argus is now under broken isles  
- some karesh treasure fixes  
- Legion Remix: Pets and Toys added to Horos <Rare Collections>  
- [DB] Fixing erroneous capitalisation in header  
- [DB] Fixed the Lock Criteria check for Spells to actually use the proper function instead of cached ATT Spell data  
- [DB] Pet Grooming Kit, Cata Cooking recipes rewarded from ach,  
- Fix some reported errors  
- Added Manaforge Omega's savedInstanceID.  
- Parser test.  
- [Parser] Now exporting Categories list in Invariant Culture order.  
- 12.0 tendies trackers  
- Fixed a delve weapon to not be under cosmetics.  
- Fix some reported errors  
- [DB] MFO: Another Renown 3 quest  
    [DB] Found a delve item  
    Parsed  
- [DB] MFO Renown 3 quest  
- [DB] MFO: HQTs  
- Add new Midnight collector items (missing itemids, ensemble)  
- Legion Remix: More 'Infinite Research' Quests and more Achievements  
- Setup preorder items pending ids  
- Boralus world quest edit  
- [DB] Mists: update Wago build files to build 5.5.0.62655  
- [DB] Add timeline to ensembles that were added to Brawler's Guild vendors in BfA  
- [DB] Classic: fix redundant "maps" assignment warning  
- Add Contributor tooltip for Wouter (:  
- Fix many reported quest and object errors  
- Added the new Goblin quest.  
- [PAT] Updated source file format based on current standards.  
- [DB] MFO: M HQT  
    [DB] Tazavesh HQT & timeline fix  
    [DB] Delve seasonal quest description & crests hax  
- s3  
- Revert "m+ resi achievements are real (lul)"  
- m+ resi achievements are real (lul)  
- Legion Remix: Create a separate header for Remix quests so that they can be separated from "Regular" Legion quests  
- Exploration: Add some (Legion) Dalaran points  
- Legion Remix: Achievement Categories  
    - Thanks @Myrhial and @gbrage  
- Fixed items from 'K'areshi Voidstone'.  
- Legion Remix: Dungeons  
    - Enable "Class Achievements"  
    - 1 more "Infinite Research" quest  
    - Reputation Insignias  
- [DB] Mists: complete Celestial dungeon end boss loot tables  
- [DB] Mists: split up Celestial daily quests into Alliance and Horde versions  
- [DB] Mists: change quest ID for Celestial Challenge: Sha of Doubt  
- Updated Midnight icon  
    Tweaked to match the newlogo blizzard put out e.g more blue void  
- [DB] Moves some vendor reagents to Crafted Items/Common Vendor Items  
- [DB] Couple Isle of Dorn boxes  
- Fix a few minor errors  
- [DB] 91179/91180 appear to be the first two Pinnacle caches of the week  
- Legion Remix: MOUNTS!!!  
- [Parser] Split Categories.lua into several category files to fix a table constant overflow issue occuring on Retail PTR builds of the database.  
