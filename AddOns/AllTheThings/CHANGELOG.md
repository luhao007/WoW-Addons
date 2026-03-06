# AllTheThings

## [5.0.15](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.15) (2026-03-05)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.14...5.0.15) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- 3 more removed TWW crest quests.  
- Fixed spellID for Wild Mana Lily first craft.  
- Fixed HQT for daily craft of Thaumaturgy.  
- Fix erroneous NPC mappings (#2333)  
    https://www.wowhead.com/npc=130622/squallshaper-auran  
    https://www.wowhead.com/npc=134271/sunwalker-ordel  
- [Contrib] Few ignored Delve objects  
- [Parser] Fixed a merge issue when running with DebugDBs defined which erroneously copied some object fields into the DebugDB, leading to contamination by matching sources of that object  
    [Parser] Fixed a merge issue for 'providers' where object references could become contaminated  
- [Parser] Some quality of life adjustments  
    * Removed a bunch of excess 'Press Enter once you have resolved the issue' messages when encountering re-attemptable errors  
    * Retry operations now actually remove the Error status  
    * Added an Error if Parser tries to load an unsupported Wago file (i.e. name does not match a known Wago Type)  
    * Added a Warn if Parser tries to import a repeated Wago Type (i.e. two Wago files of different versions)  
    * Added an Error if Parser tries to merge DB data which doesn't have the proper key by which is it merging  
- [Wago] Update scripts now call the localized update script automatically  
    [Wago] MOP now has same version for localized Wago files  
    [Wago] MID/MOP/PTR refreshed  
- Moved GetItemLinkByGUID to WOWAPI helpers. (NOTE: The fallback doesn't work yet.)  
- Ensembles are now fixed from Blizzard - removing part of the ensemble text.  
- Zul'Aman: Add headers for Treasure Achievements  
- Fixed the Debugger to handle instances correctly in Classic.  
- Classic Era/TBC: Fixed the mini list for Wailing Caverns.  
- Classic: The Debugger no longer captures quest index values instead of the questID for the QUEST\_ACCEPTED event.  
- Export Raw/Readable buttons are once again functional for the Debugger.  
- When Update is called on the Dynamic Category instance, it now also updates the window that the dynamic category references. (Previously this would trigger too much, but now that we cache \_\_lastTLUG it doesn't.)  
- [DB] Couple AW quests  
- [DB] Quick errors pass (Prey HQTs, prof drops)  
- [Contrib] LastQuests / Profs now included as part of common information on reports; ATT info condensed  
    [Logic] Fixed Tradeskills cached values  
- Preventing FIRST\_CRAFTS from being generated pre-Dragonflight.  
- [DB] Add new weekly quests and update existing ones in Saltheril's Soiree  
- Retail: wasn't removed from here  
- Preventing FIRST\_CRAFTS\_CHECKBOX from being generated pre-Dragonflight.  
- Retail: moth disaster  
    - added foods into uncollectible  
    - weird coords off from report in delve  
    - skinning reagents and treasures (some hqt for for skinning)  
    - fishing items  
    - Gift of the Cycle nesting under same one objects for better navigation in-game  
    - MOTH, MOTH, MOTH, MOTH, MOTH, MOTH (renown 9 incoming)  
- Hide the FIRST\_CRAFTS checkbox before Dragonflight.  
- Set the auto open AH/Prof modules to false for Retail, to prevent tab issues  
- Added an unimplemented class variant for "CreateFirstCraft".  
- Added some Zul'Aman quest rewards.  
- Moved and added rewards of 'Legendary Prosperity' quest.  
- Midnight rare drops corrections.  
- Perhaps we shouldn't make our tabs more than once  
- Misc stuff  
- [DB] Add weekly quest flag to Saltheril's Soiree and new quests in Abundance; update ignored vignette list  
- [Locale] Update zhCN. (#2332)  
    * cn update.  
- Sourced the Intact Elemental Bracer for the Elemental Bracers quest.  
- [Logic] Ignore a few Vignettes for permanent Vendors  
- Midnight: Arator's Journey, revision and updates  
- [Logic] Use IsComplete instead of .collected when checking if a group should skip filling Costs  
- Atalaman Treasures  
- Added new Discord promo pet  
- Marked pre-patch event/store items as removed  
- Update build to 12.0.1.66220  
- Test  
- Parsed retail so First Crafts don't lua error on git.  
- WIP: Added First Craft API implementation for Midnight and separate checkbox in settings.  
- [Locale] Update zhTW: Uniform terms.  
- [Locale] Update zhTW: Strings.  
- Saltheril's Soiree quests.  
- [DB] Note about 'The Last Push' auto-completion  
- [DB] Misc cleanup of structures & added q:95324  
    [DB] 'You Know This Evil?' seems to be part of Voidstorm instead of Harandar  
- Eversong Wood fixes and first skins.  
- [Parser] Now logging MERGE\_OBJECT\_FIELDS temporarily.  
- Moved 'Fool Me Once...' achievement to NYI.  
- Added all new TWW renown quests.  
- Removed duplicated 'Undermine Enforcer's Padding' on wrong quests.  
- TWW renown quests for valorstones, crests and delve keys are gone.  
- Pushing new baseline for Retail DB for comparisons.  
- Added new instanced battleground achievements.  
- Added a source for Gyromast's Key.  
- Fixed timeline of 'Prized Gladiator's Torchblade'.  
- Fixed expansion header for Midnight PvP rated achievements.  
- Eversong Woods: Minor tweaks  
- Moved the Book: The Powers Below to Zone Drops.  
- [Logic] Various hidden Windows now use a custom VisibilityFilter instead of toggling filters on and off for the Update pass  
- [Logic] Fixed some Object/NPC/HQT account-wide collection tracking  
- Removed the altQuests from The Apple Falls and associated breadcrumbs. (You can do all of them on the same character.)  
- [Contrib] Added secret GUID protection for PLAYER\_SOFT\_INTERACT\_CHANGED events  
- Added a source quest for "Report to Captain Stoutfist" in Wetlands.  
- [Logic] Lots of Auction House module improvements and fixes  
    * Now tracking the lowest price for each auction instead of just the last one received (Note: Commodities are still completely wrong and would need a revised implementation/AH search to handle properly)  
    * Changing gold limit no longer rebuilds the whole window  
    * Added an AuctionItem class to easily represent some Auction logic on a per Item basis without needing to use it within the update flow  
    * Auctions now include their typical completion icons for easier visual understanding  
    * Search result processing is now much cleaner and straight-forward  
    * Auction Window now has a custom VisibilityFilter which uses the Gold limit value to filter what Items should be visible  
- [Locale] Update zhTW: Objects.  
- Added Harandar flight path map.  
- Added Amani Warding Hex decor.  
- Comment update  
- Valeera’s maximum level is 45 until Midnight Season 1 starts.  
- Fix many more reported errors, mostly in Voidstorm  
- [Logic] Simplify ProcessGroup logic slightly  
    [UI] Windows can now define their own VisibilityFilter [This can be used by Windows to allow different visibility requirements for showing content in their lists, so that we don't need complicated  Update logic in windows just to ensure things are visible in strange situations using the default visibility handling]  
- Fixed the Cursed Eye of Paleth quest chain.  
- [Parser] Fixed a condition where an error in a source file isn't immediately recognized nor handled properly.  
- Fix many reported errors everywhere but Voidstorm, fixes #2330  
- Eversong Woods: Spellbook Scuffle source quest (#2331)  
    Fix breadcrumb sourcequest  
- Removed a weird DEBUG preprocessor from ObjectDB.  
- Reparsed all game flavors to remove the simplification from Git builds going forward. (Classic was already not simplifying content)  
- Retail Git parser no longer simplifies structures by default. This should produce a more consistent result for contributors.  
    Release builds still run the compression.  
- More fixes / objects  
- [Contrib] Hopefully fix Lua error due to secrets in instances when checking quest givers  
- Removed another suspicious parallel section.  
- Removed some parallelism that might be responsible for differences between parsing for other contributors  
- Forcing Wago files to load in alphabetical order like ANYCLASSIC flagged configurations do.  
- Move The Last Push  
- Updated Parser to log all of the files that are processed.  
    [DB] Rebuilt all DBs for Git users.  
- Additional coord for Tarhu the Ransacker.  
