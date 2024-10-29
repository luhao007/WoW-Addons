# AllTheThings

## [4.1.2](https://github.com/DFortun81/AllTheThings/tree/4.1.2) (2024-10-27)
[Full Changelog](https://github.com/DFortun81/AllTheThings/compare/4.1.1...4.1.2) [Previous Releases](https://github.com/DFortun81/AllTheThings/releases)

- Reparse  
- Generate Missing Files  
- Some Unsorted  
- Harvest: 11.0.5.57212  
- Harvest: 11.0.5.57171  
- Harvest: 11.0.5.57147  
- Harvest: 4.4.1.57141  
- Harvest: 4.4.1.57103  
- Harvest: 4.4.1.56961  
- Harvest: 4.4.0.57244  
- Merge branch 'master' of https://github.com/DFortun81/AllTheThings  
- Harvest: 3.4.3.57269  
- Harvest: 3.4.3.57242  
- Educated guess but there's an npc called Ratts (former event coordinator!) at the anniversary so probably something to do with him  
- Harvest: 3.4.3.57135  
- Harvest: 3.4.3.57082  
- Harvest: 3.4.3.57027  
- Harvest: 1.15.4.57134  
- Fix a few reported errors  
- Fixed an id number that was wrong.  
- TWW: Next batch of Kaheti Excavations  
- Retail: bonus chance for mount from wbs if you don't have it  
- Fixed Chromie's Bag HQT.  
- Minor tweaks to some performance tracking  
- Manually merged over some non-conditionals to ObjectDB.  
- The 'Timerunning' setting is now forcibly toggled off for everyone (this improves some filtering functionality slightly) and cannot be toggled on  
- Removed the 'simplemeta' generation for Retail since this is not utilized in the way Costs work  
- Timerunning now has an internal toggle so it can be turned off when not active within the game  
- Gave a name to the 'Bronze Celebration Token' lockout HQTs (though many of them did not trigger for me...)  
- fixes  
- Fix a few reported errors  
- Fix mini-map error for coreway map missing  
- TWW: Next batch of Kaheti Excavations  
    Added Glyphs of Energetic, and Traditional Ascendance to a vendor  
- Warglaive probably isn't in  
- Fixed a Lua error where sometimes an Achievement doesn't return its link...? Maybe NYI Achievements? Idk...  
- Update Dagran Thaurissan ID in TW raid  
- Add BRD TW lockout tracking  
- Few more confirmed account-wide quests  
- Update anniversary rewards, fix some reported errors  
- Update Ambassador Flamelash ID in TW raid  
- Update General Angerforge ID  
- Update some BRD 20th Anniversary boss IDs  
- Added all the Timely Tourist items  
- Marked future removed shop items  
- Consolidated the DynamicObjectDB into ObjectDB and removed entries that matched their immediate fallback localization valuies. (cn/tw and es/mx, then any non-en matching the en localization)  
- Rebuilt all localizationDBs with latest ObjectDB. (I'm going to diff the next harvest very very carefully to try to diagnose what went wrong earlier.)  
- Parser: Updated the parser debug level to Full. Readded portions of the revert that were working correctly.... as far as I can tell.  
- Revert "Consolidated the DynamicObjectDB into ObjectDB and harvested missing localization data."  
- Consolidated the DynamicObjectDB into ObjectDB and harvested missing localization data.  
    Removed placeholder "[NAME]" entries from ObjectDB as well as entries comprised of the enUS localization that match.  
- TWW: First batch of Kaheti Excavations  
    TWW: Added Royal Sureki Strongbox  
    TWW: Added some rumor related coordinates  
    Secrets: Added a source for Water Stone to kill a debug warning  
- Fixed non-unique key errors on startup  
- Parser: When exporting the Debug ObjectDB, it now exports a dynamic and regular ObjectDB file to keep dynamic file modifications out of the primary ObjectDB.  
- ObjectDB now exports its dynamic object data to the same place for all game flavors.  
- Wars on Two Fronts no longer has a provider and a set of providers. (potentially fixing the reordering issue that causes Categories.lua to be dirty)  
- Add Brrrgl pet, update ensemble hqts backup, fix minor errors  
- Parser: Standarized how localization data is processed for exported data. Now also preventing inherited data from being exported twice if the value being replaced is identical for CN/TW and ES/MX locales.  
- Removed extraneous alliance/horde bonfire object data from ObjectDB.  
    Rebuilt all LocalizationDBs.  
- Parser: Adjusted how consolidated object data is exported.  
    Consolidated Horde Bonfire and Alliance Bonfire data for Midsummer.  
- Fixed a typo  
- Parser: Consolidated how Candy Bucket data is exported to prevent a ton of duplicated entries.  
- Updated the logic for Candy Buckets and moved them to the Hallow's End file.  
- Removed extraneous candy bucket object data from ObjectDB.  
- [Localization] Update zhTW.  
