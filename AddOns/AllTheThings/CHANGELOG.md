# AllTheThings

## [4.6.8](https://github.com/ATTWoWAddon/AllTheThings/tree/4.6.8) (2025-09-07)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.6.7...4.6.8) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- missed ,,,  
- [Logic] Improved the Quest report events  
- MOP: A New Fate needs to have races on it.  
- weekly pod quests to track weekly pods are now used to track weely pods  
- [DB] Mists: Silkworm Cocoon and the pets it drops are supposedly available with Landfall  
- MOP: Updated Nomi's section in Cooking.  
- [DB] 'Ethereal Delves' 91780 is once per account, non-account-wide (because :clap: Blizzard :clap: logic)  
- Dropped some old unused code for timeline harvesting from Wowhead  
- [DB] Misc TBC/WotLK drops, duplicate Floating Wreckage  
- MOP: Fixed map assignments and coordinates for Widow's Wail quests.  
- [PAT] Updated source file format based on current standards.  
- MOP: Finished Darkshore objectives.  
- Fix some reported errors  
- MOP: Added some Darkshore objectives and some missing objectDB data.  
- Legion Remix + Retail Legion Quests  
    - More 'Infinite Research' 1-off quests  
    - Gear Drops for all zones  
    - Update quests (Coordinates, Providers)  
- MOP: Adjusted some Teldrassil quest objectives.  
- MOP: Added missing objective data for Mossy Tumors.  
- Whoops.  
- Classic: Disabled the "Incomplete" check for Quests.  
- MOP: The Deadmines is now "Deadmines" as of 5.0.1. Adjusted sort order based on this new truth.  
- Various ru locale updates  
- [PAT] Updated source file format based on current standards.  
- MOP: Jade Crane Chick is available from an item as well.  
- MOP: Seal of the Profane drops in Scarlet Halls.  
- MOP: Kri'tak, Imperial Scepter of the Swarm drops from Stormstout Brewery.  
- MOP: Vizier's Ruby Signet drops from Taran Zhu in Shado-Pan Monastery.  
- Retail: 92488 hqt, Phase Diver's Cache now exist and some delve qi  
- [DB] TBC - Zangarmarsh: Wicker Chest  
- Fix some reported errors  
- I forgot DF dungeons.  
- Sorted all DF explorations.  
- Finished sorting all TWW explorations.  
    Due to API limitations, I moved all instance explorations to NYI for now.  
- [DB] MFO: Added Warbound versions of Tokens so that tooltips display accurately  
- [PAT] Updated source file format based on current standards.  
- Legion Remix + Retail Legion Quests  
    - Move 'Infinite Research' repeatables from Bazaar to Quests  
    - Added quest items to a dozen quests  
    - Switch raw item rewards to Ensembles for some achievements  
- [DB] Cataclysm: Grim Batol is back to normal.  
- Found more Dragonflight explorations.  
- [Logic] Retail: Attempted to fix old TWW:S1 items from showing the wrong Catalyst outputs due to Blizzard changes in 11.2  
- MOP: The Forgotten Lockbox in the Veiled Stair is now marked as a Bounty as it has not been lootable all expansion so far.  
- Added report function to expand exploration report window as new areas are discovered.  
- Flying through Dragonflight and finding everything possible.  
- MOP: Sarkan made a new alt.  
- Legion Remix: Content Revision  
    - A few new Ensembles  
    - Updated Zone Icons  
    - Detach duplication of Argus related Achievements into separate header  
- Wago: PTR 11.2.5 build 62940  
- nyi  
- Fix some reported errors  
- sorted mountdb again  
- correct timeline  
- added new tourni toys  
- [Config] Update build.  
- [Timeline] Update 4.4.2 build.  
- [Timeline] Update 5.5.1 date & 5.5.0 build.  
- Format.  
- Temporarily disable Exploration reports until they are mostly sorted using mapping by zone.  
- [Locale]Update zhCN/chTW: Celestial Dungeons.  
- MOP: Painful Thorned Ring can drop from Raigonn.  
- MOP: Added Tier Tokens to Common Boss Drops and the Scimitar of Seven Stars to Scholomance.  
- Updated Sheepie.  
- Fix a few minor errors  
- [DB] Couple more MFO Renown quests/Spoils of Nexus-King  
- [Parser] InstanceHelper now supports 'BossObjects' to automatically assign object providers to Encounters (for situations where the Boss loot is contained in an Object instead of the Boss directly)  
- [DB] MFO: Renown 5 quest  
- Add new Cata Timewalking rewards, fix some reported errors, parse  
- Flawless Crystal Scale is a HQT  
- Removed temporary description fix.  
- Mardum: Revision of the revision  
    Ref. 415081b0ef868b88ac0e8ee7b49c5e1eb5e8d04d  
- Mardum: Content revision  
- [PAT] Updated source file format based on current standards.  
- [DB] More phase-diving  
    * Simplified Phase-diving Treasure descriptions using 'sharedDescription' and the implication of requiring Phase-diving due to Source structure  
- [Logic] 'description' and 'sharedDescription' can now be independently combined within tooltips  
- [Contrib] Identified another Opening spell to track for objects  
- [DB] More phase diving orbs  
- [Contrib] Added a Debugging-only method to attempt to identify object interact Spell casts which are not currently tracked  
- [DB] Did some phase diving & other minor fixes/adjustments  
- [Contrib] Fixed some potential issues with Object detection  
    * Now detecting on UNIT\_SPELLCAST\_SENT instead of \_START so we can capture Instant spells which open objects as well  
    * Added spell 6247 as an Opening spell detection  
    * Using the game-provided "destination" of the Opening spell cast if available so that non-tooltip driven Opening events can also display the object name in the report dialog  
- [DB] Added Dornogal info for 'The Eastern Kingdoms Cup Begins [H]'  
- [DB] 'The Long Hunt' is locked for non-loyalists  
