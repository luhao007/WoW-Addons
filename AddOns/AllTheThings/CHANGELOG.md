# AllTheThings

## [4.0.10](https://github.com/DFortun81/AllTheThings/tree/4.0.10) (2024-09-01)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.9...4.0.10) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- added snuffing & severed icons  
- These were still obtainable during 11.0.2. before season 4 ended.  
- Various Errors  
- Merge pull request #1756 from LvWind/master  
    update zhCN  
- Removed unused HQT root.  
- Merge pull request #1762 from QartemisT/patch-3  
    "Attention-Getter" request actually requires renown 10, not 8.  
- Renown quests 'A Small Bundle of Goods' were swapped.  
- Moved 'Dragonflight Keystone Master: Season Two' achievementID 18542 out from NYI. Blizzard made 2 versions and both are visible in achievements ingame.  
- Hide this HQT from users.  
- Fixes  
- Sweep retail errors  
- Changed "Talk with" quests into HQT format, so we can find them easier when adding HQT filter.  
- Added items to summon Deathtide rare.  
- DmF: Spawn of Jubjub  
- Fixed Bountiful The Underkeep Delve HQT.  
- Added HQTs for 'Light's Gambit Champion' achievement.  
- Removed empty HQT section.  
- 'No Harm Ever Came From Reading A Book' needs to be listed as achievement somewhere still.  
- "Attention-Getter" request actually requires renown 10, not 8.  
- First pass at expanding 'No Harm Ever Came From Reading A Book', sort rare drop  
- Fix parsing error  
- Adjust Cache of Storms as it wasn't removed  
- TWW/Dornogal: Add coordinates and comment for the achievement Flat Earthen  
    Fix a typo for the Horror of the Shallows rare in Hallowfall  
    Convert some spaces to tabs  
- Micro-improvement for table concat (don't think this situation is in use anywhere currently though)  
- Add missing Fishing Derby catch HQTs and mark as warband wide  
- Added last Hallowfall Arathi renown 11 quest.  
- Update a STL note and Awoken Coelacanth FirstCraft  
- Timewalking is now global header.  
    Fixed cost of Recipe: Everything Stew.  
- Update Spreading The Light treasures and some FirstCraft HQTs  
- Objects meh  
- Class rows are now considered headers  
    Retail: Minilist is now a bit more inclusive of what is considered a 'header' when grouping mapped content, so hopefully this should help reduce the initial vertical scroll of the minilist in zones where there is a LOT of varied content all mapped into one place (i.e. main cities)  
- But with like the right ID this time  
- Sort some reported items and quests  
- Retail: more backlog clearup  
- Retail: Fixed some Header class conflicts  
- missed sorting in Uncollectible  
- Retail: clearup backlog  
- Moved the Commands page text a little bit so it aligns with other pages.  
- Added Commands page into the Features in Interface (retail only)  
- Added Hallowfall Fishing Derby HQTs.  
- Added HQTs of 'No Harm Ever Came From Reading A Book' achievement.  
- Fixed Battle Pet having a cache return in the wrong spot  
- Sweep errors and update Spreading The Light quests and treasures  
- Even better TWW HQTs sorting.  
    A little work on DF HQTs too.  
    Updated parser + Trading Post timelines.  
- Fixed a few profession object coords  
- Retail: Fixed an issue with automatic headers  
- Various noticed data fixes  
    One parser fix due to local header used in different file  
- Retail: should actually INCLUDE MY FILES  
- Retail: Migrated NPC/Header into separate Class files  
- CloneDictionary now supports cloning into an existing table  
- Maybe comitt so people dont duplicate efforts  
- Retail: Quest data retrieval now triggers OnRenderDirty instead of directly handling OnRefreshWindows  
- Reduced indentation of some Game Tooltip logic  
- Block bad displayID (Flamegard's Hope)  
- Removed a description about Loremaster for the 'Show All Trackable Things' option since that doesn't really make sense in context anymore for what this setting changes  
- Huge Dragonflight HQT consolidation - part 1 (dungeon & raids, outdoor zones, expansion features, some holidays)  
- Sweep retail errors, weep from retail terrors  
- Shop Ensembles are using the new tech now.  
    Moved shop HQTs into backup HQT file (found many of them in NYI too)  
    Moved and sorted some PvP HQTs.  
- Family battler header for previous expansions too (except BFA which follows a totally different structure)  
- Header for grouping family battler achievements under, and added those for TWW (previous expansions to be reviewed later)  
- tiny update to Smugglers Treasure to help find key  
- Weeping Ironclaw First Craft.  
- Fixed Herbalism specialization spells.  
    Added questID for Lurker of the Deeps rare.  
- Khaz Algar Lore Hunter has been temporarily disabled and looks like it will only return in a "future patch" (so likely no hotfix?)  
- Common reagents do not need treasure sourcing  
- Couple Spreading Light quests which reset for me since EA  
- Retail: Fixed an issue where Show Collected/Completed would not have effect on Trackable, non-collectible content which was currently saved  
- More Delves! Brann capped at 15  
    Assembly renown 9 fix  
    Random HQTs  
- Obsolete TODO removed  
- Retail: Confirmed ACHIEVEMENT\_EARNED event works as expected  
- Note some HQT reports, sort a rare drop  
- Best fixer  
    Algari Enchanter's Folio was showing missing quests  
- Retail: Adjusted some Achievement refresh logic to try and reduce some lag experienced by some players during force-refresh (probably not the full issue though)  
- Fixed weekly quests in Dornogal being double nested  
- Gloomfathom Hide  
- Added details and coords for rare Horror of the Shallows  
- Move Glubblurp again and add details to STL treasures  
- TWW/The Ringing Deeps: Fix wrong itemID  
- TWW/The Ringing Deeps: Forgotten Treasure followup  
- TWW/The Ringing Deeps: Add final Buried Treasure info  
- Added coords and descriptions for The Missing Lynx. Ref thread (duplicated lynx)  
- Add September 2024 Trading Post  
- Uncover the mystery behind checking on the Compiler  
- Expand weekly prof quests to other profs, move Gobblin' with Glubblurp  
- Retail: Exclude Khaz Algar from /attrandom Zone selection  
    Retail: /attrandom now clears its search cache when settings change (i.e. could select random Zone in Debug, then switch to a setting where many Zones have nothing collectible and the random function would show nothing upon selection since the cached results were based on Debug progress originally)  
- Add coords and providers to skyraces, fix stay awhile coords  
- Removed base crafting reagents from random treasure.  
- Added notes for ATT Debugging toggles  
- Missed some Skyriding renames  
- Fixed Ready for War not being collectible for alliance  
- This one header is actually still Drakewatcher Manuscripts  
- Renamed 'Drakewatcher Manuscripts' to 'Skyriding Manuscripts'  
- Couple quest adjustments  
- Thing  
- Fixed Nerubian Quilt  
- WotLK Dalaran: Bloodied Prison Shank  
- Adjust Severed Threads reward per hotfix, add Ally vendor for Sun Cured Boots, fixes #1757  
- More random TWW additions I ran into  
- HQT 82541 didn't become available until Titanic Failsafe completed  
    Some HQTs  
    Some Renown Quests  
- Fix wrong WQ id  
- Add some FirstCrafts, adjust some Dornogal coords  
- Adjust quests and loot in Hallowfall and Azj-Kahet  
- Drop Blizz class harvest data for certain Legion quests to not be misleading in minilist, fixes #1755  
- Added a blocked displayID for tooltips & comment to be able to track down displayIDs  
- Parser: Fixed check for sharedData being applied to nothing  
    Fixed some sharedData use being applied to nothing  
- Retail: Total Cost uses OnSetVisibility instead of OnUpdate  
    Retail: Added Total Cost to recalculate itself on a force refresh (was only when changing settings)  
- Retail: Removed IsReady check from Window Refresh since it's no longer called prior to OnReady event  
- Retail: Reduced indentation of GetWindow  
- Retail: Moved initial RefreshCollections to OnReady. This seems to give slightly better loading handling and prevents a couple niche event timing possibilities (Can't test Classic since update is broken so it remains on OnInit for now)  
- Retail: Fixed SkillIDToSpellID still being required by Shared modules  
- Retail: Moved more arbitrary Skill and Flightpath data to export DBs  
- Retail: ATT no longer has a not-updated-since-Shadowlands set of Skill information and now uses the contrib-updated Skill information as exported via Parser  
- Remove old questDB partial harvest  
- This does not work.  
- Adjust some quests and coords in Hallowfall and Azj-Kahet  
- Added Bountiful Delve HQT.  
- Add some first crafts and a Theater Troupe reward  
- Add Special Assignment: Rise of the Colossals quest trigger  
- update zhCN  
- Removed vendors from the zones when they are in the raids for a short duration.  
- More removed stuff from Dragonflight.  
- Moved 'For the Collective' and 'I Only Need One Trip' achievements to The Ringing Deeps zone.  
- Fix Stay awhile provider  
    Add Severed Threads Renown 7 info  
- Fix world quest id  
- Add more weekly knowledge items  
- Parsing  
- Added more unsorted 11.0.0 Rare Drops  
- FOR BRAGHE!  
- updatedss  
- Corrected loot location for Croakit and Cabbage  
- Some restructuring of Severed Pact based on small bits of completed content structure  
- Merge branch 'master' of https://github.com/DFortun81/AllTheThings  
- Sorted more rare 10.0.0 loot. Alphabetized more loot.  
- Automatic Headers support Factions now  
    Added shortcut function 'name' which allows putting an automatic name into a quest object (more object types can be supported if needed)  
    Used name() in some places to give HQTs better names for future organization  
    Moved Special Assignment quests, some into proper zones  
- Sort some rare loot, add a Faerin stay awhile and confirm some coords in Azj-Kahet  
- Test commit adding unsorted rare TWW loot  
- used same naming order (expansion x weekly) everywhere on profs  
- another parse an correct ed local note  
- added correct localID for skinning+parsing  
- Update Wailing Caverns.lua  
    #1753  
- moved skinning from exp fts to prof  
- updated all profession weekly points to use df or tww respectivly  
- renamed orders from inscrription from df to df inscription orders  
