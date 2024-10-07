# AllTheThings

## [4.0.17](https://github.com/DFortun81/AllTheThings/tree/4.0.17) (2024-10-07)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.0.16...4.0.17) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- All the Parses for Releases  
- Add Council of Dornogal renown 24 quests  
- Added HQT for hidden herb, and it looks like a whole buncha stuff didn't get parsed earlier so that made it in too  
- Update harvest\_item\_patches.yml  
- TWW/Azj Kahet: No new rumors for me today. Got tired of being lied to anyhow...  
    Some updates to already established rumors  
    Confirmed that two different Thimble's Caches share questID  
- Fixed TWW headers to not show as 11.0.0 when their all content was not available until 11.0.2  
- Fix some various reported errors  
- Finished TWW First Crafts.  
- SOD: Updated ItemDB & SourceIDs.  
- Classic: Updated the max Item ID for the Item Harvester.  
- Migrate HEADER\_ICONS to the parser’s database Phase 1.  
- Replace the icon's path with iconID.  
- SOD: Added & Moved the updated Thunderfury quest chain to the Crystal Vale raid.  
- SOD: Removed a phantom print statement.  
- SOD: Added The Crystal Vale raid.  
- SOD: Updated phase data and excluded the non-SOD classic phases.  
- Classic: Now excluding phase data for phases not included in each expansion. (this will help a lot with debugging, particularly with future SODs)  
- Split up the TBC and WoW Classic Scourge Invasion phase IDs.  
- Fixed a Season of Discovery recipe from showing up in the profession list for Blacksmithing.  
- Rebuilt all LocalizationDBs with the new formatting standards for phases.  
- Modified the export order for classsic phases in LocalizationDB and also added the Phases.lua debugging file.  
- Classic: Removed explicit color assignments for classic phases.  
- Updated the colors of the 'Unobtainable Filters' in the Phases file.  
- Fixed a bug with GetUnobtainableTexture and removed from game textures not being red.  
- Moved processing for Phases and their associated localization to the DB.  
    Deprecated and removed the "AVAILABILITY\_CONDITIONS" table in favor of a more simplified PHASES table.  
- Refactor AssignAPIWrapper.  
- Deepholm: 'The Restless Brood' req Revered  
- DF/The Walking Shores: Swap Quest Giver and Target for the quest "Same as the Old Boss"  
    Aizir is the Quest Giver and Doventhal is the target  
- Reparsed all DBs to include updated zhCN localizations.  
- Fixed a preprocessor.  
- TWW/Azj-Kahet: More rumors? LIES!  
- Fix tabs  
- Add some classic rep bubbleDowns and fix Vizier emissary quest  
- Deepholm: Jadefang  
- Fixed a duplicate item reward on The Hunt Is On  
- Update zhCN locale.  
- Fixed tabs.  
- Add Assembly Renown 24 and reparse  
- Update some BC quartermasters with bubbleDown rep  
- TWW/Azj-Kahet: More rumors. Doubtful they are true...  
- TWW/Azj-Kahet: All Thimble's Caches are finally verified  
- Removed a few uses of achievement\_criteria from TWW content where it is redundant, and documented a case that is broken on Blizzard's end  
- Last batch of achraw auditing done. Remaining cases are all documented.  
- Rworked some more cases where achraw was used  
- Modify description of WoW API Wrapper.  
- Changed a tooltip for AWP. It's always for a single expansion currently.  
- Add diagnostic description for AssignApiWrapper.  
- Drop the  expensive Queen's Pheromones character items from tracking  
- Added /att awp expansion, which generates a window with all added things for every patch of the expansion.  
    Supported expansion shortcuts are: classic, tbc, wotlk, cata, mop, wod, legion, bfa, sl, df, tww  
- Updated some Hyjal quests again.  
- Update zhCN locale.  
- Disable deprecation warnings for known functions.  
- Cleaned up some Debug event coloring and formatting for easier reading  
- Fixed a couple things for patch/expansion handling  
- Fixed a bad header in Sourceless window  
- Converted raw patch values used in expansion() objects to utilize a consistent patch() function instead so that adjustments to patch logic can be performed in a single location  
    Adjusted Expansion groups to support 2 digits for Revision portion of a patch  
    Reparsed all versions for proper data  
- Added objective data for Diggin' For Worms.  
- Added a simpler/more readable implementation for assigning WOWAPI wrappers and applied it to Item wrappers as an example of use  
- Added the String of Fish object.  
- Add Crypt Lord's Severed Thread and new Queens Pheromones to cidb, add something different to Dornogal  
- The Avengers of Hyjal faction actually has absolutely nothing to do with the Molten Front. It's a trash killing faction only within the Firelands itself.  
- Moved some Molten Front dailies that got missed to the Molten Front file and added rewards.  
- Retail: Adjusted logic for BuildSearchResponse to properly account for the multiple windows which used to be confined to 'Unsorted' (Unsorted/NYI/etc. content is not expected in SearchResponse results)  
    Retail: BuildSearchResponse results are now captured into new containers on each search  
- Retail: Moved 'contribute' chat command to contributor module file using ChatCommands instead of manually checking  
- Classic: Removed some logging.  
- Classic: Fixed currency calculations, daily quests bug found.  
- Migrate GetTradeSkillTexture.  
    See comment.  
- Fixed cost.  
- re-added cost to the queen's pheromone (8888 final price)  
- Migrate GetSpellTexture.  
    The API is not fully equivalent, see comment.  
- Tailoring HQT.  
- Fix the description of GetSpellLink.  
- [API Change] GetSpellLink only return SpellLink.  
    See comment.  
- Revert Trolli description to show correct stores, fix some reported errors  
- Fixed Mark of Honor and Bronze filling in minilist/non-root popouts  
    Added a few more super-prevalent Holiday costs to only fill purchases when they are in tooltips  
- Added Pip's Mole Machine.  
- Updated objectives for Mount Hyjal.  
- Retail: Delves hqt confirmed  
- Mythic Bloodbound Horror HQT  
- Added Blaithe's Roost.  
- Added Aviana's Burial Circle.  
- Disabled fanfare for quests.  
- Fixed objective data for Free Your Mind, the Rest Follows.  
- Added objective for Incite the Elements.  
- Retail: fixes  
    - delves seasonal rewards hqts  
    - Cache of Delver's Spoils wasn't added in reward list from weekly quest  
    - random sl reports  
    - TODO: for one of treasures  
    - added missing skinning weekly quest  
    - added trade post quest  
    - added Sinkhole sub-map  
- Added the Dust Covered Chest to chess event in Karazhan.  
- 'The Key to Success' is account-wide  
- Migrate GetSpellLink.  
    The API is not fully equivalent, see comment.  
- Remove unused Local.  
- Migrate GetItemSpecInfo.  
- Migrate GetItemInfo.  
- Enduring the Heat's source quests are different each day.  
- Migrate GetItemID.  
- Migrate GetItemInfoInstant  
- Retail: Instead of accepting unknown additional parameters for searches (this is never used in any possible way currently, and was only accounted for by Azerite Essence Rank logic) we now accept an optional 'options' table to allow defining some adjustments to how the search is performed (this logic can likely migrate to Classic also, but haven't checked yet)  
    Retail: Popouts no longer perform their 'fill' operation within the synchronous context of the search operation or right-click operation which generate the popout, and instead are now delayed into the asynchronous context after being put into the resulting popout window  
    Mark of Honor no longer need special handling within the tooltip logic since it properly handles filling based on its search context (rather than externally needing inputs which drive skipped filling)  
    Fixed a logic issue where filled purchases of a popout would use the general skip check level and not fill necessary purchases  
- Fix tab  
- Migrate GetItemIcon.  
- Fix typo  
- Mirgate GetItemClassInfo  
- Added another renown quest.  
- Some commented code (Fill logic will be cleaned up when migrated to a Module eventually)  
- Added renown quest.  
- Some fixes.  
- Migrate GetItemCount to API Wrapper  
- profession knowledge only comes from treasures  
- Fixed TWW engineering timeline.  
- Fix some legacy reported errors  
- Moved the Search Results Lib to RetrievingData module. (TODO: Refactor the module file names)  
- Classic: group.working should refresh the tooltip a bit more often instead of showing retrieving data a bunch.  
- Classic: Now using the Collection module. Runaway rejoice!  
- ReloadSoundPack now gets called by OnReady.  
- Fixed a bug with the RefreshSavesCallback.  
- Fix some reported errors  
- Fixed questID 38931 - NYI version of Hero's Call: The Hinterlands!  
- Cleared remaining MoP Remix Ensemble questIDs (most likely to be Trading Post or Shop in the future).  
- Fixed shortcut for Mythic Keystone.  
    Fixed tabs.  
- TWW/Azj-Kahet: Even more work on rumors.  
- Add descriptions to WoW API Wrappers again.  
- Add more descriptions to WoW API Wrappers.  
- Fix logic leakage  
- Using the restructured API by default.  
- Fix some retail errors  
- Update World Quests.lua  
- ...  
- Cata: Added Shipyard Lumber.  
- Cata: Disabled the description on all grey transmoggle items if you are filtering out greys/whites.  
- TWW/Azj-Kahet: Verified 2 more Thimble's Caches. Continued work on rumors  
    SL: Added info about quest giver for The Necrotic Wake quest inside dungeon.  
- More NP flight paths (also none of them are really collectible since they reset each week/per current raid progress)  
- Fixed missing flightpaths Lua error  
- Revised which Classes implement 'trackable' and the specific logic to better represent content which is repeatable but can be 'completed' for some duration  
    Revised the wording of the 'Show All Trackable Things' checkbox to 'Show Repeatable/Trackable Things' to better reflect how the underlying logic now works  
- Flight paths are trackable  
    Fixed Retail doing a collection noise every time an alt character accesses a Flight path it hasn't seen before  
- Fix many tabs  
- Fix coords for Thaumaturge Vashreen (#1804)  
- Fix some quests and coords  
- Adjusted the Battle of the Crimson Watch rewards.  
- The flare guns in Shadowmoon Valley now show their associated quests on the tooltip.  
- Retail: bunch of fixes  
    - added Executor's Severed Thread questID  
    - q: 83587 (Our Chance to Strike) is not an breadcrumb, there no quest in chain if you did not finish it  
    - worldsoul memory repeatable flag  
    - random kun-lai summit monk report  
    - q: 79150 (Thespians at the Proscenium) added coords when event map is active  
    - q: 78350 & q: 78384 was off  
    - random sl reports  
    - Restored Coffer Keys from vendor questIDs  
- nothing happens if you rightclick the mount from stonevault, so I put it under the dungeon boss where it drops  
- parsing  
- a couple coords were missed  
- coords instead of coord  
- updated promo stuff  
- Deepholm battle pets  
- Missing coords/questgivers  
- Added lock criteria to some alt-only quests in Dornogal (haven't verified/tested if Party Syncable)  
- Fix some reported retail errors  
- Strip unneeded ensemble data, move old remix ensemble HQTs  
- Added the Rack of Rifles.  
- Cata: Added a helper function for Tol Barad Daily Quests.  
