# AllTheThings

## [4.8.5](https://github.com/ATTWoWAddon/AllTheThings/tree/4.8.5) (2025-12-14)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.8.4...4.8.5) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- [Logic] Fixed /attu not working due to deprecated use of 'creatureID'  
- Added 2 new Dragonflight quests between Zaralek Cavern and Emerald Dream story.  
- Fixing some stuff in Dye Crafting.  
- Added Dye Crafting profession.  
- [DB] Misc fixes  
- Parse  
- Finished Legion skinning.  
- Added skinning (only Legion is not done and probably a lot of crafted reagents).  
- Fix a few reported errors  
- [Locale] Update esES/esMX: TOC & headers. (#2241)  
    * Fixed translation of nightly builds in all TOC files to es and mx  
    * Memory of Scholomance in mx and tw  
    * Headers  
- Second part of NYI professions up to 11.2.5  
- Moved 'Delver's Dirigible Schematic: Template' to sourceless category.  
- Fixed Vault Patroller's Warboots in NYI.  
- Added Brann Bronzebeard faction to TWW delves.  
- First part of NYI professions up to 11.2.5  
- Added all recipes from supply shipments profession. They are all craftable (weekly rotation).  
- [Locale] Update zhCN/zhTW.  
    * Update zhCN: headers. (#2219)  
    ** cn update.  
    * Update zhCN/zhTW.  
- Sorted factions up to 11.2.5  
- Sorted all NYI factions by alphabet.  
- Making NYI factions alive after a long time. More work on them tomorrow.  
- [Logic] Certain Dynamic groups now no longer pull in Unsorted/NYI headers (Currency/Faction/Profession)  
- Fixed expansion headers in NYI herbalism.  
- [Logic] Retail: Created a QuestNested class for use within Nested Quest chain sequences to make it easier to fix some weird display issues and make the chain cleaner to follow  
    * In some cases there could be a visible quest at the bottom which would cause all completed quests to remain visible and lingering in the window. Now the Nested Quest chain sequence should always show properly based on the currently-available Quests remaining to be completed in the chain  
- Completed NYI cosmetics up to 11.2.5  
    Re-added 2 heirlooms - don't use preprocessors to remove something, timelines are the key in such case.  
- Twilight Ascension: Quest Placeholders  
- Some small cosmetic and ensemble items updates.  
- Fix a few reported errors  
- Add 12.0.1 TOC  
- Working on NYI cosmetics. Removed Trading Post NYI part as it was basically all duplicated already in NYI cosmetics.  
- Sorted toys up to 11.2.5  
- Sorted all titles up to 11.2.5  
- Sorted all maps up to 11.2.5  
- Fixed description of itemID 135539.  
- Sorted pets up to 11.2.5  
- Fix of 'Bonecleaver's Skullboar' NYI mount.  
- Sorted mounts up to 11.2.5  
- [Debug] Various Performance Tracking improvements and cleanup  
    [Debug] app.MetaTable.AutoTable now generates a unique metatable return when running with Performance Tracking mode  
    [Debug] ClassCache storage tables are no longer auto-captured for Performance Tracking (they never contain functions, so no point)  
    [Debug] Performance Tracking added for EventHandlers & Symlink Resolve Functions  
- Added all new Brawler's Guild quests.  
- Update Mount/Pet/ToyDB for 12.0.1.64889  
- Finished NYI illusions.  
    Added one more decor.  
- [Classic] HQT in the barrens to unlock brew repeatable quests Close #2163 (#2240)  
    [Classic] HQT in the barrens to unlock brew repeatable quests  
- Update Brawler's Guild for 11.2.7 as best as currently able, fix many reported errors  
- Some initial unsorted sorting  
- Bump build to 11.2.7.64877  
- New HQT of Blood elf Heritage armor quest chain (#2239)  
- Legion Remix: Remove description on 'Blank Doomsayer's Pamphlet'  
    - First one is part of the quest and quest itself directs you to Moratari. You can just burn subsequent Pamphlets as Moratari has no related gossip options.  
- Legion Remix: Achievement description typos  
- Generate Missing Files: SoD  
- Generating Missing Files: Retail  
- SOD: Fixed Season of Discovery parsing.  
- Generate Missing Files: SoD -- Still broken  
- Another broken parser commit  
- Breaking Parser  
- Sort Recipes  
- Harvest: 12.0.1.64889  
- Harvest: 12.0.0.64774  
- Harvest: 11.2.7.64877  
- Harvest: 11.2.7.64797  
- Harvest: 11.2.7.64772  
- Harvest: 5.5.3.64857  
- Harvest: 5.5.3.64802  
- Harvest: 5.5.3.64794  
- Harvest: 3.80.0.64859  
- Harvest: 2.5.5.64796  
- Harvest: 2.5.5.64776  
- Harvest: 1.15.8.64858  
- Added some dungeons  
- more SOD items  
- extra legion remix notes  
- added legion prelaunch acm  
- Working on NYI to catch up to 11.2.5.  
- [Timeline] Update TBC Ann. Classic.  
- [Timeline] Update MoP Classic.  
- Added quest from 'Master of the Turbulent Timeways IV' achievement.  
- More quests this patch.  
- Added 2 more new quests.  
- [DB] Scholomance: Miscellaneous fixes  
- Fixed ID of Trader Caerel.  
- Moved more NYI decors back to Unsorted.  
    Added timeline and campsites to 'This Old Hearth' quest.  
- All TWW item sources are done!  
- Finishing NYI of TWW item sources.  
- Some sorting of 11.2.5.  
- Re-added 2 more NYI Legion Remix Artifacts.  
- [DB] Added lock criteria to some HQTs to trigger warnings when they become available  
- [Logic] Retail: Minor performance pass on Symlink module for ipairs use  
- [Logic] Retail: Minor performance pass of tinsert and wipe in Symlink module  
- MISTS: Fixed Big Bag of Zandalari Supplies.  
