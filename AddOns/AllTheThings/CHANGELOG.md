# AllTheThings

## [5.0.16](https://github.com/ATTWoWAddon/AllTheThings/tree/5.0.16) (2026-03-08)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/5.0.15...5.0.16) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Added more first skins.  
- PANDAREN\_NEUTRAL is no longer included in ALL\_RACES prior to MOP.  
- Fix yet MORE reported errors, mostly in Voidstorm  
- Finished Midnight herbalism recipes.  
- Fixed harbalism profession DB.  
- Blue Pearl does not drop from the murlocs at all, WoWHead's tool was detecting pearls looted while in combat with the murlocs as dropping from the murlocs.  
- Adjusted source location tooltips for Blue Pearl and Giant Clam (2744)  
- Fixed Kurzen's Head.  
- Properly added new shop mounts  
- Added herbalism recipes.  
- Added Glimmering Powder.  
- Updated coords for all Midnight Explorations.  
- Fix yet more reported errors, mostly in Zul'Aman  
- Update Quests.lua  
- Zul'Aman: Main campaign tweaks finished. More Sojourner updates  
- Update Quests.lua  
    Located Oaths and Heirlooms quest giver  
- MountDB: New Groveglider SpellIDs  
- Fix some more reported errors  
- [Classic] 16 variants of the "Salve via" quest requiring a profession level of 225 have been corrected. (#2339)  
- Added mining recipes.  
- Moved Undercoin currency to Midnight delves.  
- Added 'Wormhole Generator: Quel'Thalas' to ToyDB.  
- Added missing profession knowledge items to character unlocks.  
    Fixed price of the profession knowledge renown items.  
- Zul'Aman: More quest updates  
- Fixed some reported errors.  
- Twilight Ascension: Fix timelines for vendors  
    - This reverts commit 1e212393ac131d0dfa84708979f3710ea2eb9347.  
- Update Contributor.lua  
- Contrib errors  
- Fix a few minor errors  
- endeavours: attempt to add deed of patronage completion q criteria (#2336)  
    * endeavours: attempt to add deed of patronage completion q criteria  
    * remove decor header for hesta  
    * reinstating decor header, adding to corlen for consistency, sourceQuest is not eligible for item shared data?  
    * remove decor headers again lol  
    * ???  
    * fix formatting + undo duplicate n(decor) on hesta  
    * feedback from eremeir  
    * missing commas  
- Fixed the Head of Nagaz.  
- holiday fixes (#2328)  
    * Update Brewfest.lua  
    * Update Hallow's End.lua  
- Typos and Minor Corrections (#2322)  
    * fixed translations in es and mx  
    * [Classic] All of Cuely's quest that were assigned to his brother Fuely have been corrected.  
    * Hide TWW Cn only promos from trading post items  
    * [Classic] added Crown of the Earth 934 version  
- Update Battle Pets & Wild Pets.lua (#2337)  
- Updated the timeline for Delivery to the Sepulcher.  
- Some achievement shuffling and Legends of haranir header  
- Added all rewards to Stormarion Assault.  
- TABS  
- More tab tweaks  
- Tab tweaks  
- One more attempt to fix tabs, lord why have you forsaken me  
- Fixed timeline of Resilient Keystone achievements.  
- [DB] Example for cleaning up Dragonriding Cup file in future  
- [DB] Note to Uncollectible.lua.  
- [Logic] Added Quel'Thalas to /attwq  
- Fix some more reported errors  
- Update Contributor.lua  
- Added patient fishing treasure  
- Update Achievements.lua  
    oops, coord error  
- Delete Note.lua  
    Don't think this is needed anymore.  
- [DB] MID intro Bonus Objectives/Treasures get locked during Light's Last Stand (due to insta-cinematic teleport)  
- Bunch of objects  
- Update Achievements.lua  
    Added missing coord  
- Update Unsorted.lua  
    Remove things from unsorted when sourced :( lol  
- Update Tailoring.lua  
    Tailoring treasure questid  
- Special Assignment in Zul'Aman  
- [Parser] Tracked down a sequence issue that caused inconsistencies between contrib parses  
    * Containers are now always processed in order regardless of OS  
    * CaptureForSOURCED usage streamlined for data which passes the Process at each stage  
    * Migrated much 'removal' consolidation logic into a final Consolidation handler (this was the root cause as to why SOURCED data appeared differently depending on the parser stage, since it removed data from the SOURCED objects prior to usage of SOURCED being fully-completed)  
- Uncollectible Objects  
- More object's have names  
- Updated name of "glowing moth"  
- Update Enchanting.lua  
    Weekly Quests  
- [DB] Fix a bracket  
    [Parser] Few logging adjustments to compare with other contribs & reparse  
- [Parser] Remove unused Items.SOURCES merge handler  
- Zul'Aman: More Campaign and Sojourner updates  
- Zul'Aman: More Sojourner updates  
- [DB] Retail: Reparsed  
- [Parser] Some cleanup and adjustments for JSON/WAGO loading  
    * Consolidated load functionality  
    * Loaded filenames only printed in Debug parse again  
    * Non-Classic/IDE Debugging parses once again load these files in parallel, with any Localized loading taking place afterwards  
    * Ensure Export class is referenced prior to any DB merging (hardcoded ObjectData types need to exist prior to any 'g' fields getting merged (i.e. from questDB.json) or we get failed type matching when finding matching object data)  
    [Parser] Removed ambiguous merge method 'MergeFromDB'  
    [Parser] Added a premerge check when storing shared data from objects (this is also executed on the merge into step... might revise this again as there may still be possible sequences in which shared data could retain \_drop fields when merging into objects)  
- Some more improvements to these accursed tabs I insisted we should use  
- [Parser] Classic: Protect unsorted AW Quests from going into the referenceDB  
    [Logic] Classic: Total Cost header should have a valid icon  
- Added pickpocketing data for Syndicate Emblem.  
- Fix some reported errors, mostly Harandar  
- [Parser] Fix Safe Deposit icon in other locale files  
- [Parser] Fix a manual icon for Safe Deposit in itIT locale  
- Classic: The dynamic profession categories now contribute to their parent objects. This is force the recipe list to be visible in the profession.  
- Fixed skinning item.  
- [Logic] Classic: Another adjustment for Quest caching  
- Added skinning weekly profession knowledge.  
- Fixed mapID of Torment's Rise delve.  
- [DB] Some MoP and MN greys.  
- Fixed 2 recipes difficulty drop in Windrunner Spire.  
- Removed Zul'Aman coord for Harvester's Sickle.  
- Added objects for alchemy and enchanting treasures.  
- Herbalism treasure.  
- Added info for 3 more profession treasures (still need objectID)  
- [Logic] Adjusted how Quests are cached in non-Retail versions of ATT to prevent startup Quest completion chat spam  
- [DB] Saltheril's Soiree is maybe daily?  
    [Logic] Ignore another quartermaster vignette  
- Inscription treasures fixes.  
- Fix many more reported errors  
- Added Prey reward boxes with symlink.  
- Added Midnight Explorations from in-game harvested data.  
- Updated Exploration Mapping.  
- Skinning treasures fixes.  
- [DB] Added Teacher of Strong title  
- Twilight Ascension: Update cost for items after expansion launch  
- [DB] Couple Battle Pet coords  
    [DB] Endeavor Quest  
- Fix some reported errors  
- Moved FirstCraft of 'M0LL1, Atomic Anomaly' to NYI.  
- Added all Midnight Leatherworking FirstCrafts.  
- Added all Midnight Jewelcrafting FirstCrafts.  
- Added all Midnight Enchanting FirstCrafts.  
- Murder Row: Add a description and update cost on "Shu'halo Perspective" Painting  
- Added all Midnight Blacksmithing FirstCrafts.  
- Added all Midnight Alchemy FirstCrafts.  
- Parse for FirstCrafts.  
- Finished FirstCrafts logic changes.  
    Added all Midnight FirstCrafts with questID.  
- shortened harandar header so its not covering half the screen  
- Zul'Aman: Sojourner Updates  
- Stub new shop mounts/cosmetics  
- Update build to 12.0.1.66263  
- Added Vivacious Chlorocoers mount.  
- Regenerate Missing FIles  
- Change TWW to Midnight folder  
- Sort Recipes  
- Harvest: 12.0.1.66263  
- Harvest: 12.0.1.66220  
- Harvest: 12.0.1.66198  
- Harvest: 12.0.1.66192  
- Harvest: 12.0.1.66102  
- Harvest: 12.0.1.66066  
- Harvest: 12.0.1.66044  
- Harvest: 12.0.1.66017  
- Harvest: 12.0.1.66013  
- Harvest: 12.0.1.65940  
- Harvest: 5.5.3.66264  
- Harvest: 5.5.3.66128  
- Harvest: 5.5.3.65988  
- Harvest: 3.80.0.66130  
- Harvest: 3.80.0.65990  
- Harvest: 2.5.5.66265  
- Harvest: 2.5.5.66150  
- Harvest: 1.15.8.66129  
- Harvest: 1.15.8.65989  
- Merge branch 'master' of https://github.com/ATTWoWAddon/AllTheThings  
- Some misc things while playing  
- added fishing for midnight  
- fishing recipes  
- Fixed 2 mail aspirant items.  
- Add issecretvalue guards on UnitGUID + migrate deprecated merchant API (#2334)  
    * Add issecretvalue guards on UnitGUID returns + migrate deprecated merchant API  
    WoW 12.0 marks UnitGUID() returns as secret values. Calling string  
    operations (split, sub, match) on a secret value propagates taint  
    through the execution context, causing UI actions to break in combat.  
    Changes:  
    - Commands.lua: guard UnitGUID("target") before split in /att target  
    - Search.lua: guard UnitGUID("target") before split in /att search  
    - Social.lua: guard UnitGUID("target") before split in /attwho  
    - CharacterClass.lua: nil out secret UnitGUID(unit) in CreateUnit  
    - Raid Assistant.lua: nil out secret UnitGUID(name) in raid roster  
    - Debugger.lua: guard UnitGUID("npc") in GOSSIP\_SHOW, TAXIMAP\_OPENED,  
      LoadMerchant, QUEST\_DETAIL, and CHAT\_MSG\_LOOT handlers  
    - Debugger.lua: GetMerchantNumItems() → C\_MerchantFrame.GetNumItems(),  
      GetMerchantItemLink() → C\_MerchantFrame.GetItemLink() (removed in 12.0)  
    Uses app.WOWAPI.issecretvalue (already used in Contributor.lua and  
    Debugger.lua CHAT\_MSG\_LOOT) for consistency.  
    * Move merchant API migration to WoW API Wrappers for cross-flavor compat  
    GetMerchantNumItems/GetMerchantItemLink wrappers use C\_MerchantFrame on  
    Retail with fallback to globals on Classic, matching ATT's existing pattern.  