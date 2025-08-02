# AllTheThings

## [4.5.11](https://github.com/ATTWoWAddon/AllTheThings/tree/4.5.11) (2025-07-27)
[Full Changelog](https://github.com/ATTWoWAddon/AllTheThings/compare/4.5.10...4.5.11) [Previous Releases](https://github.com/ATTWoWAddon/AllTheThings/releases)

- Couple missing boss entries so that criteria can nest under them  
- Fix some reported errors  
- MOP: Fixed phaseID assignments for MOP\_PHASE\_LANDFALL / MOP\_PHASE\_ONE.  
- MOP: Fixed some incorrect timeline assignments for 5.1.0 that should have been 5.0.4.  
- Refactor Ny'alotha achievements and encounters for consistency and automation  
- [PAT] Ran the Provider Automation Tool against a couple Pandaria files. (some of them did not parse correctly and are excluded)  
- [Logic] Fixed ATT still attaching to tooltips that it should not and sometimes resulting in lag spikes due to other addons' hidden tooltip spam (fixes #2097)  
- Update Ny'alotha with InstanceHelper  
- PTR 11.2.0: Purple Peat Warrant  
    - One more "Bee" daily  
    - Add "Devourer Attack" mini-bosses to Rares  
    - The K'aresh Trust Renown 9 quests  
    - Two more World Quests  
- [Logic] Retail: Source lines should once again show Unobtainable even when the Source exists but the root of the tooltip is removed from that Source  
- MOP: Added the original Bottled Tornado itemID.  
- MOP: Mysterious Fruit Pile wasn't added until 6.2.3  
    Also began refactoring The Jade Forest and Valley of the Four Winds in order to add objectives.  
- [Parser] Quick fix for NYI species getting assigned real NPCs and showing NYI tooltips on real pet battles  
- [Logic] Moved the missing FP master check into the /att check-fps command for people on Git instead of it being tacked into every refresh  
- [DB] Adjusted the structure of TWW Engineering 'Invent'  
- Added a Flight Master debugger to Git. If there are missing flight masters it will now report that in a clickable popout.  
- Added a missing flight master for the Ruins of Gilneas.  
- Added missing flight masters to all Pandaria zones.  
- [Logic] Retail: Total Cost calculation switched back to a single, shared Runner  
    [Logic] Retail: Total Costs now ignore certain row types in situations where the Cost is not pertinent to the content of the window  
- Added flight masters to the Vale of Eternal Blossoms.  
- Mistfall Village, Vale of Eternal Blossoms wasn't added until 8.3.0  
- Added flight masters to the Jade Forest.  
- Moved The August Celestials to their own Expansion Features file rather than spread them through Pandaria.  
- [DB] Reparse so Trading Post filter matches the data  
    [Logic] It's now possible to turn off the Trading Post filter :smile:  
- Changed Trading Post filter ID to 7.  
- [Logic] Retail: Catalyst logic can now properly find SL:S4 Catalyst results  
    [DB] Cleaned up and refactored the SL:S4 catalyst data to properly work for Catalyst tooltips (tossed the PvP Catalyst listings since those are just duplicated from the PvP Sources anyway... Classic Shadowlands can deal with setting that up properly when it exists again, which surely it will, definitely)  
- [DB] Fix DH SL:S4 Tier Cloak disappearing  
- [DB] Fixed Vault of Incarnates off-piece Catalyst Items showing the wrong data in tooltips  
- PetDB and WagoData's BattlePetSpecies tables now merge into npcID rather than cr.  
- Added Trading Post filter.  
- Updated Battle Pets in Pandaria and added coordinates to some of the pets based on their localized spawn points if they had specific spawns rather than zone wide.  
    Also terminated the use of symlinking battle pets in Pandaria.  
- [Logic] Prep for Trading Post filter  
- Marked Folded Ghost Iron, Spiritguard Bracers, and Lightsteel Bracers as removed from game / not available in MOP.  
- Moved quests related to some of the scenarios to the scenarios themselves.  
- Updated the structure for Clawlord Kril'mandar and all of his associated makrura minions.  
- Fixed Coffer Key Shard cost assignment.  
- Fix not collected icon showing next to text string  
- [DB] Couple fixes  
- Removed a number of World Drops from The Jade Forest. There's no need to clog the tooltips in the zone with non-specific drops.  
    Classic: The Zone Drops header no longer shows at the top of the list due to a weird design choice for stolen rep tokens.  
- MOP: Moved the Zandalari Warbringers and Warscouts into the Zandalari Incursions Expansion Features file.  
    Added a short description for Jade Warrior Statue.  
- Added map constant for TOWNLONG\_STEPPES\_NIUZAO\_CATACOMBS.  
    Adjusted the coordinate for Huggalon the Heart Watcher in the Catacombs.  
- Added a note for Wodin's Mantid Shanker in the Jade Forest.  
- [Logic] Vignette logic improvements  
    * Fixed Vignettes initially scanning prior to Vignette Settings being cached  
    * Vignettes now only try to 'super track' one time per batch to reduce redundant API calls  
    * Vignettes now refresh in proper sequence when changing Vignette settings (prior it was refreshing then changing the setting, so it didn't take effect until another Vignette udpate happened)  
    * Added a /att reset-vignettes command in case the User wants previous reported Vignettes to allow reporting again  
    * Removed the Event 'OnReportNearbySettingsChanged' since it's no longer necessary  
- MOP: Added Cloud Serpent Riding and the BOA item you can use to learn it for your alts.  
- [Logic] Retail: Attempt to fix a rare, random Lua error from Mount refresh  
- [DB] Mists: update Ancient Guo-Lai Cache content  
- [DB] Mists: His Name Was... Stormstout was added in WoD  
- MOP: Based on feedback, adjusted the structure of the quests to show daily quests at the top of the list for Order of the Cloud Serpent. (this also allows us to remove shared source data)  
    Classic: Order of the Cloud Serpent dailies now specify a maximum, making daily quests collectible until you reach Exalted with the faction so that their objective data is visible in game.  
    Fixed a data entry bug for the quest The Secrets of Guo-Lai.  
- [DB] Mists: fix wording for Vale phase onupdate description  
- MOP: Updated the Order of the Cloud Serpent and moved it to the Expansion Features section of the addon to reduce the length of the tooltip and help distinguish between content related to The Jade Forest itself vs the Order's quest chain and dailies.  
- [DB] Mists: Vale of Eternal Blossoms quest sweep  
- Added a Function Template for dynamically updating the cost of a repeatable quest based on the number of turnins are required to reach the max reputation threshold. (GenerateOnUpdateForRepeatableQuestWithCost) (This will be used for the Onyx Egg in the Order of the Cloud Serpent file)  
- Added a reputation calculation helper function "CalculateRemainingTurnIns".  
- Added a checkbox for turning on/off the mini list's auto expand feature. (This might not work in Retail, but definitely does in Classic!)  
- Shrine of Fellowship is a place, not an object name.  
- MOP: Moved Restore Balance to the Broken Incense Burner treasure object.  
- [Logic] Retail: Cost collector now uses the respective ATT list's Runner instead of being shared between popouts. This seems to make the update sequence more reliable  
- [DB] Sort a few recipes better  
- [DB] Mists: add missing Inscription recipes  
- Fix a few reported quest and object errors, sort some items  
- Fixed the quest giver for Back in Yak.  
- [Parser] Added a Tier file for SL S4  
- [DB] Fixed 'What's Your Sign?' getting snapped during WoD dungeon cleanup  
- PTR: 11.2.0 build 62136 update (mostly profession stuff)  
- [DB] Mists/WoD: set timelines for level 90 class trials  
- Generate Missing Files: Retail  
- Splash Zone wrong ID  
- Harvest: 11.2.0.62136  
- [DB] Some extra info for cauldron LoU achieves  
- [DB] Fixed 'Cloth Scavenging' to properly use lockCriteria instead of being a fake weird breadcrumb  
- [Logic] Fixed a Lua error when trying to output a debug message about bad GetOwner calls on EmbeddedItemTooltip (blizzard made this tooltip weird...)  
- But with a real timeline  
- motes of harmory now show up as obtainable and as world drop from mop  
- removed 1 layer of skinning  
- [DB] Mists: WoD journal version of His Name Was... Stormstout is not available in MoP ofc  
- [DB] NYI: some MoP daggers  
- Update es and mx (#2111)  
- Fix comment typo  
- cn update. (#2109)  
- Update Tomb of Sargeras with InstanceHelper  
- [Parser] Added a bit more Criteria incorporation to remediate the remaining Achievements with lingering 'achievement\_criteria' symlinks  
    [DB] Adjusted 'Inspector Gagetzan' for proper automation  
    [Parser] Added a couple map merge mappings from weird Blizzard values  
- [DB] Cata+ Classic: Copper Vein bug  
- [Logic] Retail: Couple creatureID removals that weren't pushed  
- [Misc] Some commented testing/memory comments  
- [DB] TBC Tailoring reagents and vendors  
- [Logic] Retail: Fixed a few more cases of non-object rows in ATT lists  
- [Logic] Retail: Cleaned up the Sync window and now use proper object types for row data  
- [Parser] Fixed PetDB storing pointless data  
    [Parser] Added validation for crs/npcID fields now that they're cleaned up from containing custom headers  
- [DB] Refactored WoD CBD to no longer use fake NPCIDs as instance names via custom headers since those are now broken. Instead they now use 'maps\_disp' to indicate the related instances where certain slot pieces are available.  
    [DB] Fixed Garrison Inn WoD CBD symlinks  
- normal plus header too  
- violet hold bosses are now grouped  
- bubbledown ofc  
- voti lfr is removed  
- [Logic] Added handling of 'maps\_disp' to allow showing maps information in tooltips without also linking that data into those maps (similar to c\_disp and r\_disp)  
- [Parser] Added a PASS\_THRU\_FIELDS root config to quickly allow new fields through the Parser which don't require parser handling  
- [Locales] Moved some to their correct folders. Removed a duplicate locale file.  
- [DB] WoD: UBRS upgraded to InstanceHelper  
- [Locales] Added some more.  
- Missed Cata/MOP.  
- [Locales] Added locale template files for a bunch of the settings menu.  
- [DB] WoD: EB upgraded to InstanceHelper  
- [DB] WoD: SKY upgraded to InstanceHelper  
- [DB] WoD: SBG upgraded to InstanceHelper  
- [DB] WoD: ID upgraded to InstanceHelper  
- [DB] WoD: GRD upgraded to InstanceHelper  
- [DB] WoD: BSM upgraded to InstanceHelper  
- BMAH The Binding warning is useless in TWW with xmog restrictions lif… (#2107)  
    BMAH The Binding warning is useless in TWW with xmog restrictions lifted and coins transfers of DMF tickets  
- Retail: Headers!  
- MOP: There are two Master Chengs.  
- [Logic] Retail: Fixed a few base-level fields for Visual Headers  
- [Logic] More removals of unnecessary creatureID references  
- Classic: Added a referemce tp tje DEBIG\_LOGIN locale.  
- You can now turn on/off "Owned Pets" in the tooltip.  
- [DB] TBC Inscription + JC + LW + Mining  
- [Parser] Fix encounterHash when using custom header values  
    [DB] Fixed celestial tournament WBs criteria  
- [DB] Restructuring alchemy vials, TBC Enchanting + Inscription  
- MOP: Added the original Dread Pirate Ring to the STV Fishing Tournament quests.  
- PTR 11.2.0: Sojourner of K'aresh completed  
    - Manaforge Vandals Vendors have been moved  
    - Renown 8 quests for The K'aresh Trust  
